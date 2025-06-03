+++
title = "automount mmcblk devices"
date = "2013-04-09T09:27:58-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['linux', 'usb', 'mmc', 'disk']
keywords = ['linux', 'usb', 'mmc', 'disk']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I put my camera SD/HC card into my laptop (running Debian/testing) and it

didn't mount.  Usually I would just run the `mount` command to get it going:



        dmesg | tail

        mount /dev/mmcblk0p1 /mnt



That unfortunately has some annoyances and I decided to solve this finally.



<!--more-->



First I installed usbmount:



        apt-get install usbmount



This is just a simple package that allows you to control how attachable

devices are mounted on your system.  You can control UID/GID ownership,

filesystem flags, etc.



Next I edited the `/lib/udev/rules.d/usbmount.rules` config file, adding the

following two lines at the bottom of the file:



        KERNEL=="mmcblk*", DRIVERS=="mmc_block", ACTION=="add",    RUN+="/usr/share/usbmount/usbmount add"

        KERNEL=="mmcblk*", SUBSYSTEMS=="mmc",    ACTION=="add",    RUN+="/usr/share/usbmount/usbmount add"

        KERNEL=="mmcblk*",                       ACTION=="remove", RUN+="/usr/share/usbmount/usbmount remove" 





And then I inserted my SD/HC card, and my `/dev/mmcblk0p1` was automatically

mounted under `/media/usb0`.


