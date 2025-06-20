+++
title = "is my usb device connected to a fast port?"
date = "2008-05-10T08:38:28-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['usb', 'linux']
keywords = ['usb', 'linux']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I started a transfer last night to copy a 700M file to my USB key.  It's still going.  I figured that it might have been OHCI vs EHCI issue.
I had to remind myself how to check.

<!--more-->

USB debug info is relayed via `/proc/bus/usb/devices` so you have to mount `/proc/bus/usb` like this:

        $ sudo mount -t usbfs none /proc/bus/usb

or put this in your `/etc/fstab`:

        none  /proc/bus/usb  usbfs  defaults  0  0

First off, `lsusb` was of no use.  I couldn't grok the output.  Then I found this page: [Linux and USB 2.0](http://www.linux-usb.org/usb2.html), where I found
[usbtree](http://www.linux-usb.org/usbtree).

        $ usbtree
        /: Bus 05.Port 1: Dev 1, Class=root_hub, Drv=uhci_hcd/2p, 12M
        /: Bus 04.Port 1: Dev 1, Class=root_hub, Drv=uhci_hcd/2p, 12M
            |_ Port 2: Dev 2, If 0, Prod=Biometric Coprocessor, Class=vend., Drv=none, 12M
        /: Bus 03.Port 1: Dev 1, Class=root_hub, Drv=uhci_hcd/2p, 12M
            |_ Port 2: Dev 2, If 0, Prod=Generic USB Hub, Class=hub, Drv=hub/3p, 12M
                |_ Port 1: Dev 3, If 0, Prod=PFU-65 USB Keyboard, Class=HID, Drv=usbhid, 12M
                |_ Port 2: Dev 4, If 0, Prod=Trackball, Class=HID, Drv=usbhid, 1.5M
        /: Bus 02.Port 1: Dev 1, Class=root_hub, Drv=uhci_hcd/2p, 12M
        /: Bus 01.Port 1: Dev 1, Class=root_hub, Drv=ehci_hcd/8p, 480M
            |_ Port 3: Dev 4, If 0, Prod=RALLY2, Class=stor., Drv=usb-storage, 480M

Which does not explain my slow transfer rate... but it shows that my `RALLY2` usb key has lots of bandwidth.

**Update:** I figured it out.  I am using `usbmount` and the `sync` mount option
was making writes extremely slow.  After mounting it manually it was fine.  Now I
have to figure out if I want the comfort of `usbmount` or fast writes...