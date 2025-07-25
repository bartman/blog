+++
title = "Debian on UBIFS upgrade on SheevaPlug"
date = "2010-02-15T08:37:25-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['sheeva', 'linux', 'debian', 'embedded']
keywords = ['sheeva', 'linux', 'debian', 'embedded']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I picked up a [SheevaPlug](http://en.wikipedia.org/wiki/SheevaPlug) recently.  In a few weeks
I'll try to use it as a *git server* in a classroom setting at [Flourish Conf](http://flourishconf.com/),
where I will be speaking about [Git]{tags/git}.

![marvell_sheevaplug_1](../../img/marvell_sheevaplug_1-240x213.jpg)

This platform consists of a 1.2 GHz ARM processor (*Feroceon 88FR131 rev 1 (v5l)*),
512M of SDRAM, 512M of NAND flash, 1Gbit ethernet, USB, SD card reader, and ... well, that's it.

<!--more-->

The software installed on the SheevaPlug leaves a bad taste in my mouth.  I am glad that
they picked Linux, and more over that they picked Debian/Ubuntu.  What I don't appreciate
is that there are a dozen things broken out of the box, and it seems like the system is a
hodgepodge of packages from Debian and Ubuntu.

The first thing I decided to do was to install Debian/sqeeze on it.  And since I was reinstalling, I
wanted to upgrade the on-board flash file system to [UBIFS](http://www.linux-mtd.infradead.org/doc/ubifs.html#L_overview).
The following is an account of things I needed to do to get Debian running on UBIFS on the SheevaPlug.

### SheevaPlug Installer...

Before I start, I'll mention the [SheevaPlug Installer](http://www.plugcomputer.org/plugwiki/index.php/SheevaPlug_Installer).

The installer asks me to...
- On Linux host run `sudo php runme.php`

I guess there are two types of people in the world: those that would have many questions about the above command, and those that woudl not.
You are welcome to draw your own conclusions as to which camp I am in.

### Prior work...

Fortunately, I didn't have to reinvent the wheel.  I read the very good [Installing Debian To Flash](http://www.plugcomputer.org/plugwiki/index.php/Installing_Debian_To_Flash) wiki page on [PlugWiki](http://www.plugcomputer.org/plugwiki).  It's a very precise, and well documented,
procedure.  I learned a lot about the internal setup.  However, the procedure fails around the 75% mark.

When you reach step 8, [Convert internal flash root partition to UBIFS](http://www.plugcomputer.org/plugwiki/index.php/Installing_Debian_To_Flash#Convert_internal_flash_root_partition_to_UBIFS), you will get errors like the ones reported
[here](http://plugcomputer.org/plugforum/index.php?topic=1279.msg8119#msg8119).  More specifically using `ubimkvol` to
create an empty volume will fail like this:

    # ubimkvol /dev/ubi0 -N rootfs -m
    Set volume size to 517386240
    [ 1286.379273] UBI error: ubi_io_write: error -5 while writing 512 bytes to PEB 0:512, written 0 bytes
    [ 1286.388397] UBI warning: ubi_eba_write_leb: failed to write VID header to LEB 2147479551:0, PEB 0
    [ 1286.398034] UBI: try another PEB
    [ 1286.401461] UBI: run torture test for PEB 0

... after a few failed attempts the kernel might also crash.  From what I can tell, this is a bug in the ubifs
driver in that kernel (`2.6.32-trunk-kirkwood`).

### A different way of creating an ubifs image...

Fortunately in the same thread as the error report above, [pingtoo outlines the off-line fs creation procedure](http://plugcomputer.org/plugforum/index.php?topic=1279.msg7879#msg7879).  While the procedure there crashes too, I was able to get it working after modifying it a bit.

### Finished off the last 25%...

You have followed the [Installing Debian To Flash](http://www.plugcomputer.org/plugwiki/index.php/Installing_Debian_To_Flash)
instructions and you have a SheevaPlug running uboot version 3.4.19, and you have installed Debian on a USB stick.

* boot the SheevaPlug from USB
  
  After running the Debian installer, this will be the default mode of booting.
  If not, try the following uboot commands, but you shouldn't need this.

        Marvell>> setenv bootargs_console=console=ttyS0,115200
        Marvell>> setenv bootcmd_usb=usb start; ext2load usb 0:1 0x0800000 /uInitrd; ext2load usb 0:1 0x400000 /uImage
        Marvell>> setenv bootcmd=setenv bootargs $(bootargs_console); run bootcmd_usb; bootm 0x400000 0x0800000
        Marvell>> boot

* create bind mount to avoid picking up other filesystems

        $ mkdir /tmp/root
        $ mount -o bind / /tmp/root

* backup your existing `fstab`

        $ cp /etc/fstab /etc/fstab.bak

* update `/etc/fstab` to look like this:
  
  *(we will restore it in a second)*

        /dev/root  /               ubifs   defaults,noatime,rw                      0 0
        tmpfs      /var/run        tmpfs   size=1M,rw,nosuid,mode=0755              0 0
        tmpfs      /var/lock       tmpfs   size=1M,rw,noexec,nosuid,nodev,mode=1777 0 0
        tmpfs      /tmp            tmpfs   defaults,nosuid,nodev                    0 0

* create the ubifs
  
  We will create this file in a ram disk (`tmpfs`) ...

        $ mkdir /tmp/work
        $ mount -t tmpfs none /tmp/work
        $ mkfs.ubifs -v -r /tmp/root -m 2048 -e 129024 -c 4096 -o /tmp/work/ubifs.img

* restore your `fstab`

        $ mv /etc/fstab.bak /etc/fstab

* create a `/tmp/ubi.cfg` to look like this:

        [rootfs-volume]
        mode=ubi
        image=/tmp/work/ubifs.img
        vol_id=0
        vol_size=400MiB
        vol_type=dynamic
        vol_name=rootfs
        vol_flags=autoresize

* create the UBI image

        $ ubinize -v -o /tmp/ubi.img -m 2048 -p 128KiB -s 512 /tmp/ubi.cfg

* burn it in
  
  *DISCLAIMER:* This step will erase the OS partition on the SheevaPlug.  While I can assure you that this
  procedure worked for me, it may not for you.  I am not responsible for broken hardware, lost data, etc.

        $ ubiformat /dev/mtd2 -s 512 -f /tmp/ubi.img

*WARNING:* at this point you'll be running the Debian kernel with version `2.6.32-trunk-kirkwood`, and if you
run `ubiattach` so you can mount it you will crash.  So, don't.

Since you already burned in the kernel in step 5, [Burn a New Kernel](http://www.plugcomputer.org/plugwiki/index.php/Installing_Debian_To_Flash#Burn_a_New_Kernel), the last step remaining is to fix up uboot to boot your new system.

As of this writing, the most recent [prebuilt kernel](http://sheeva.with-linux.com/sheeva/) for the sheeva is [2.6.32.8](http://sheeva.with-linux.com/sheeva/index.php?dir=2.6.32.8/).  This is the one I burned in earlier at offset `0x100000`.

* dry run...
  
  Before writing anything into the uboot config, let's just see if it boots.  Power up your SheevaPlug, and interrupt it to get the uboot prompt.  Then run:

        Marvell>> setenv bootargs 'console=ttyS0,115200 ubi.mtd=2 root=ubi0:rootfs rootfstype=ubifs'
        Marvell>> nand read 0x2000000 0x100000 0x400000
        Marvell>> bootm 0x2000000

  *(I am no uboot expert... is there a better way to boot from nand?)*

* write this config to flash
  
  If the above booted fine for you, then you may want to make the configuration persistent to avoid fiddling with uboot on each boot.
  
  The following procedure will set the above as the default boot:

        Marvell>> setenv bootargs_ubi console=ttyS0,115200 ubi.mtd=2 root=ubi0:rootfs rootfstype=ubifs
        Marvell>> setenv bootcmd_nand_read nand read 0x2000000 0x100000 0x400000
        Marvell>> setenv bootcmd 'setenv bootargs $(bootargs_ubi); run bootcmd_nand_read; bootm 0x2000000'
        Marvell>> saveenv
        Marvell>> boot

### Links

 - [SheevaPlug Installer](http://www.plugcomputer.org/plugwiki/index.php/SheevaPlug_Installer)

 - [Debian on the SheevaPlug](http://www.cyrius.com/debian/kirkwood/sheevaplug/)
   - [Installing Debian on the Marvell SheevaPlug](http://www.cyrius.com/debian/kirkwood/sheevaplug/install.html)

 - [Installing Debian To Flash](http://www.plugcomputer.org/plugwiki/index.php/Installing_Debian_To_Flash)

 - [Sheeva kernels](http://sheeva.with-linux.com/sheeva/index.php)

 - [ubimkvol fails](http://plugcomputer.org/plugforum/index.php?topic=1279.msg7873) - forum describing the failure of `ubimkvol`.

 - [UBIFS FAQ and HOWTO](http://www.linux-mtd.infradead.org/faq/ubifs.html)

 - [U-Boot Quick Reference](http://www.plugcomputer.org/plugwiki/index.php/U-Boot_Quick_Reference)
   - [uboot manual](http://www.denx.de/wiki/view/DULG/UBoot)
