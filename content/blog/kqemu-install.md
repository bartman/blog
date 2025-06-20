+++
title = "my kqemu install"
date = "2007-02-07T20:54:27-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['qemu', 'kqemu']
keywords = ['qemu', 'kqemu']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I found out earlier today that [kqemu](http://fabrice.bellard.free.fr/qemu/) is now GPLed.  I think this has 
the potential of helping out the KVM team by (hopefully) taking some of the tricks that helps kqemu get almost 
as good performance (on some benchmarks) as KVM w/ the hardware vitualization extensions.

Here I am running Ubuntu (aside: next time I pave over I am going back to *Debian*), and I want to have kqemu
running WinXP and Suse 10.  But really... I just wanted to try kqemu on my poor desktop that lacks the virtualization 
extensions.

<!--more-->

**Installing QEMU**

First, I need to rebuild the qemu package, because the one in Ubuntu doesn't have kqemu support built in.

        $ sudo apt-get build-dep qemu
        $ wget http://fabrice.bellard.free.fr/qemu/qemu-0.9.0.tar.gz
        $ tar xzf qemu-0.9.0.tar.gz
        $ cd qemu-0.9.0
        $ ./configure --prefix=/usr --enable-alsa --enable-kqemu --cc=gcc-3.4
        $ make 
        $ sudo make install

**Installing KQEMU**

Next I need to grab the kernel part...

        $ wget http://fabrice.bellard.free.fr/qemu/kqemu-1.3.0pre11.tar.gz
        $ tar xzf kqemu-1.3.0pre11.tar.gz
        $ cd kqemu-1.3.0pre11
        $ ./configure
        $ make
        $ sudo make install
        $ sudo modprobe kqemu

**Installing Windows**

Then I create a new 4 gig image and install...

        $ dd of=winxp.img bs=1024 seek=4000000 count=0
        $ qemu-system-x86_64 -boot d -cdrom /dev/cdrom -hda winxp.img -m 512

Push enter a few times and you're done.

**Installing SUSE**

Next, I needed a SLES 10 install to test some work I am doing for a client.  Here are the steps for that

        $ dd of=sles10.iso bs=1024 seek=4000000 count=0
        $ qemu-system-x86_64 -boot d -cdrom sles-10.1-cd1.iso -hda sles10.img -m 512

Then when you are prompted for a new CD press **ctrl-alt-2** and run the following commands on the console:

        eject cdrom
        change cdrom sles-10.1-cd2.iso

Then press **ctrl-alt-1** to get back to the installer.  Repeat for subsequent CDs.

References:

 * [WindowsXP Under Qemu HowTo](https://help.ubuntu.com/community/WindowsXPUnderQemuHowTo)
 * [HOWTO: Setting up QEMU on Ubuntu with TUN/TAP and NAT](http://www.ubuntuforums.org/showthread.php?t=179472)

Notes:

 * *mort* mentioned that he used...

     `qemu -net nic,vlan=0 -net tap,vlan=0,ifname=tap0 -hda winxp.img`

     ... to get his setup working using a tap device (setting up using tunctl first)

     see [this guide](http://wiki.freaks-unidos.net/qemu-debian) for more details.
