+++
title = "xen domain0 on debian"
date = "2006-04-12T19:44:23-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['linux', 'xen', 'xen-box-setup']
keywords = ['linux', 'xen', 'xen-box-setup']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

This is part of my [xen box setup]{rtag/xen-box-setup} "series".

Xen domain 0 (or *dom0*) is special. It starts up all the other xen hosts and, be it 
by a rule or simply by convention, it tends to run all the drivers.

I have already covered how I [partitioned my disk]{lvm2-on-raid1}.
Let's now start with this fresh install of debian/testing and get a xen *dom0* running
on top of it.  The following steps assume that the system:

- is a 32bit x86 box running debian/testing
- has RAID1 devices configured as per my [LVM2 on RAID1]{lvm2-on-raid1} writeup
- uses grub for a bootloader
- was booting a recent 2.6.x kernel

<!--more-->

Anyway, here goes...

1. You will need to get some packages before we begin

        $ apt-get install xen-tools ssh python python2.3-twisted iproute bridge-utils libcurl3-dev \
          libncurses5-dev debootstrap zlib1g-dev make gcc build-essential python python-dev \
          python-twisted bzip2 module-init-tools tetex-base transfig tgif python-pyopenssl \
          python-pam python-serial netpbm vim initrd-tools

    I am no longer sure which are absolutely required and for what part of the xen build.  Some were 
    listed in the documentation, and others in various howto's I've read.

    *`xen-tools` is just a package with scripts and support files (like tab completion), etc.  It can be
    skipped if you don't want it.*
    
2. You will need to get xen

    The easiest way to get xen is to fetch it via bittorrent.  Goto 
    [the xen download page](http://www.xensource.com/xen/downloads/) and follow the instructions.  You 
    want to get the most recent release.  At the time of this writing it was `xen-3.0.1-install-x86_32.tgz.torrent`.

    If you're lazy, run...

        $ apt-get install bittorrent
        $ btdownloadheadless --spew 1 --url \
          http://tx.downloads.xensource.com/torrents/xen-3.0.1-install-x86_32.tgz.torrent

    This contains the binaries for 32bit x86 host.  That includes:

    - xen kernel
    - linux kernel for *dom0*
    - linux kernel for *domU* (any other domain)
    - tools & script
    - sample configuration files
    - documentation

3. Installing xen software

    Installation is relatively easy:

        $ tar xzf xen-3.0.1-install-x86_32.tgz.torrent
        $ cd xen-3.0.1-install
        $ less README
    
    *(or at least come back here when things don't work)*

        $ ./install.sh

    The last step will build up an initrd image for the linux kernel to use to boot of raided SATA drives:

        $ depmod -a 2.6.12.6-xen0
        $ mkinitrd -o /boot/initrd.img-2.6.12.6-xen0 2.6.12.6-xen0
        $ depmod -a 2.6.12.6-xenU
        $ mkinitrd -o /boot/initrd.img-2.6.12.6-xenU 2.6.12.6-xenU


4. Make xen bootable

    Before xen, you would tell grub to boot your vmlinuz file from /boot.  Now grub will boot xen, and 
    xen will boot your dom0 linux kernel.  *dom0* will then start up your *domU* domains.

    The first step is to get xen booting.  Edit your `/boot/grub/menu.lst` file and just before the 
    *`### BEGIN AUTOMAGIC KERNELS LIST`* line insert a block that looks like this:

        title Xen 3.0 / XenLinux 2.6
        root   (hd0,0)
        kernel /boot/xen-3.0.gz console=vga
        module /boot/vmlinuz-2.6.12.6-xen root=/dev/md0 ro console=tty0
        module /boot/initrd.img-2.6.12.6-xen
        savedefault
        boot

    Note that the xen kernel will boot using the *kernel* directive, while the *dom0* kernel will boot 
    from the *module* directive.

After this you can `reboot` and your system should magically boot into...

    $ uname -a
    Linux phosphorus 2.6.12.6-xen #1 SMP Tue Jan 31 15:57:47 GMT 2006 i686 GNU/Linux

There will be more in the next installment.