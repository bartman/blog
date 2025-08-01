+++
title = "the dreaded process of rooting Rogers Dream"
date = "2009-09-05T11:25:29-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['android', 'rogers']
keywords = ['android', 'rogers']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

This is not as smooth as [rooting the G1]{rooting-g1}, and comes no where close as [my second attempt at rooting the G1]{simple-rooting-g1} (ie the easy way).

<b>WARNING:</b> I've said it before, but this time I want to stress it...  <font color=red>this may brick your phone!</font>  Until I figured things out and found the right pages I had a non-booting phone.

<!--more-->

### Some background info

 - Rogers Dream is a 32A phone, this means that the hardware is a bit different and you need a special kernel.
 - Rogers Dream has a different HBoot bootloader which needs to be replaced with a different process.
 - It comes down to this: <font color=red>Do not use Tmobile G1 files.</font>

Also... I assume you have the `fastboot` executable.  Having `adb` is handy, but not required.  Google for instructions if you don't.

### Installing CM recovery

In case you don't know Android phones have a bunch of boot modes (5, I think).  Anyway, one of them lets you upgrade
software using `update.zip` files.  This mode comes up when you boot with the *HOME* button held.  We will overwrite
the recovery partition with one that will do more for you, and you will need it to upgrade to community firmware in
the future.

 - I used the new 32a-aware [flashrec](http://zenthought.org/content/project/flashrec) to get a CM-recovery 1.4 image installs.
   
   This app will detect the CPU, download the right imag, use [CVE-2009-2692](http://web.nvd.nist.gov/view/vuln/detail?vulnId=CVE-2009-2692) exploit,
   and give you a recovery image.
   
   After this step you can always boot with `HOME` button and get the full featured recovery image.

 - Not part of the rooting procedure, but very important... use the recovery image to take a nandroid backup.
   
   It will make a `nandroid` directory on your SD-card and store all the images on it.  I was able to recover
   my phone with it.

### Preping for root

Next you need to download [Haykuro](http://forum.xda-developers.com/member.php?u=1363573)'s rooting files.  These were hard
to find, because the service he uploaded them to has a 10k download limit... and I came in too late.

I initially started with this write up: [Rogers, heres your real root](http://forum.xda-developers.com/showthread.php?p=4271500), but
it didn't work for me.  I ended up with a phone that booted to the ROGERS screen and never went further.  Sounds like the kernel
wasn't getting to init.  Maybe a timing issue or the kernel was just wrong.  Anyway...

I had previously found this write up: [All the technical details you'd like - Rooting the Rogers Dream](http://forum.xda-developers.com/showthread.php?t=532224),
but like I said, the link provided there -- *http://drop.io/ii4t2ax* -- had already expired it's download quota.

I will give you the new link I found for this file: [http://drop.io/081mnjs](http://drop.io/081mnjs), linked off 
[this forum post](http://forum.xda-developers.com/showthread.php?p=4423861).  In case it's gone again, you can always
google for "[rogers_root_unzipme.zip](http://www.google.com/search?q=rogers_root_unzipme.zip)" and maybe you'll get
another mirror.

 - so... download [http://drop.io/081mnjs](http://drop.io/081mnjs)

 - Unzip the file.
   
   Here are the files I got (for your verification):

        #  md5sum *
        85114a9f478c1ffba7105c1faacef980  boot.img
        b877cfd3959e65abd5559862994c4db0  instructions.txt
        fdb11cc50fc692584d49b1e22835131c  recovery.img
        2b1aaa9012dc28f88c482e1b21a46fdd  update.zip
 
 - `cat instructions.txt`.  I followed most of this procedure, except for flashing the recovery image since
   I already had *CM 1.4 + JF* installed from above.

### The steps

Here are the steps I took while the phone was in recovery mode:

 - copy the update.zip to the phone.
   
   You can do it the old fassioned way by dragging them onto your SD-card, or with `adb` run:

        # adb shell mount /sdcard
        # adb push update.zip /sdcard/update.zip
        # adb shell umount /sdcard

 - activate fastboot
   
   You could power down and boot up holding the *CAMERA* button, or if you have `adb` run:

        # adb reboot bootloader
   
   ... you may now have to push *SEND* to switch to `FASTBOOT` as opposed to `HBOOT` mode.

 - reboot with the fastboot iamge

        # fastboot boot recovery.img
   
   ... note, this does not flash the image, just reboots to it.  You will get a different looking
   screen (blue/black background).
   
   Select `apply update`.  And as [Haykuro](http://stevebristok.com) put it:
   
   *LET IT FINISH, DO NOT TOUCH ANYTHING UNTIL YOUR PHONE IS COMPLETELY IDLE. DO NOT TOUCH AFTER FIRST REBOOT (WHEN CHIP APPEARS) UNLESS YOU LIKE A BRICK. :)*
   
   When it completes, you will have the `1.33.2005` bootloader.  It lets you flash in unofficial firmware images.

 - It will then return to recovery mode.  Push *HOME* and *BACK* to reboot.  Then power off your phone.

 - Boot your phone up while holding the *CAMERA* button, this gets you to Hboot/fastboot.  Activate `FASTBOOT`.
   
   Alternatively, if your phone has already booted up from the previous step, you can just run this command to get to `FASTBOOT`:

        # adb reboot bootloader

 - flash in the boot image

        # fastboot flash boot boot.img
        # fastboot reboot

 - this should hopefully get you up to the Rogers firmware, but you now have root.

        # adb shell id
        uid=0(root) gid=0(root)

*Yey!*

### Resources

As always, here are the links that I found useful in my adventures...

- Rogers Dream pics:
  - [board pics](http://img26.imageshack.us/gal.php?g=1000387n.jpg)
  - [what's what](http://i.cmpnet.com/eetimes/news/online/2008/10/igoogle_2.jpg)

- rooting
  - [flashrec](http://zenthought.org/content/project/flashrec) -- the tool that installs the recovery image
  - [Haykuro's first rooting entry](http://forum.xda-developers.com/showthread.php?t=532224)
  - [Haykuro's second rooting entry](http://forum.xda-developers.com/showthread.php?p=4271500) -- didn't work for me
  - [repost of the rogers_root_unzipme.zip](http://forum.xda-developers.com/showthread.php?p=4423861)
  - [another writeup on rooting Rogers Dream](http://forum.xda-developers.com/showthread.php?p=4280573) -- never tried

- Kernel 2.6.27 for 32A (careful, these are for the Sapphire)
  - [32a GBO kernel. More designed to ROM cookers](http://forum.xda-developers.com/showthread.php?t=550558)
  - [Reverse Engineering a 32A Kernel](http://forum.xda-developers.com/showthread.php?t=548061)

- extracting images
  - [unyaffs - a program to extract files from a yaffs image](http://code.google.com/p/unyaffs/)
  - [How to extract contents of *.img](http://osdir.com/ml/android-porting/2009-09/msg00010.html)
  - [HOWTO: Unpack, Edit, and Re-Pack Boot Images](http://android-dls.com/wiki/index.php?title=HOWTO:_Unpack%2C_Edit%2C_and_Re-Pack_Boot_Images)

- CM 32a ROMs
  - [Cyanogen 4.0.4 & 4.1.2.1 32a](http://forum.xda-developers.com/showthread.php?t=544854&page=14) -- not tried yet
  - eventually [experimental](http://forum.xda-developers.com/showthread.php?t=539744) will support 32a, so I hear.
  - [TheOfficial Rogers (dream/sapphire-32B) - Enomther's MOD](http://forum.xda-developers.com/showthread.php?t=556933)

- tools
  - [installing SDK](http://developer.android.com/sdk/1.5_r3/installing.html)

- misc
  - [Dream forum](http://forum.xda-developers.com/forumdisplay.php?f=447)
  - [HTC MAGIC original ROM running on TIM, unbranded A6161, Rogers, ... by daldroid](http://forum.xda-developers.com/showthread.php?t=523680)
  - [why we can't root rogers andoirds?? YES U CAN!!!](http://forum.xda-developers.com/showthread.php?t=523873)
    - [Root your Rogers's Magic !!!](http://forum.xda-developers.com/showthread.php?t=530527)
    - [Alright, so here's what I've done so far.](http://forum.xda-developers.com/showpost.php?p=3948652&postcount=220)
  - [Rooting Rogers HTC Dream](http://forum.xda-developers.com/showthread.php?t=522127) -- nothing special
  - [Magic Rooting](http://android-dls.com/wiki/index.php?title=Magic_Rooting)

 