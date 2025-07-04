+++
title = "adding an external encrypted volume under Debian"
date = "2009-09-22T11:07:56-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['debian', 'linux', 'security']
keywords = ['debian', 'linux', 'security']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

One of my old(er) USB-connected disks started to make a noise.  So, it's time to replace it.

Here are the steps I took to create an encrypted USB volume that I can attach to my laptop.

<!--more-->

Below I avoid using direct device names (like `/dev/sdc1`) but instead use the ones provided
by *udev* (ie `/dev/disk/by-id` and `/dev/disk/by-uuid`).

Your device IDs will be different.  Check your `/dev/disk/...` hierarchy.

* format the media:

        # sudo luksformat -t xfs /dev/disk/by-id/usb-WDC_WD32_00BEVT-00ZCT0_XXXXXXXXXXXX-0:0-part1

* generate a key that will prevent me from tying in the pass phrase for this disk.
  
  This just adds convenience and my main disk is already encrypted so the keys are pretty secure.

        # mkdir ~/.luks
        # chmod og-a ~/.luks
        # head -c 1000 < /dev/urandom | uuencode -m - | grep -v begin | head -c 32 >| ~/.luks/mydisk
        # chmod 0400 ~/.luks/mydisk

* add the key to volume

        # sudo cryptsetup luksAddKey /dev/disk/by-id/usb-WDC_WD32_00BEVT-00ZCT0_XXXXXXXXXXXX-0:0-part1 /home/oxygen/bart/.luks/mydisk

* add the following line to `/etc/crypttab`

        mydisk /dev/disk/by-id/usb-WDC_WD32_00BEVT-00ZCT0_XXXXXXXXXXXX-0:0-part1 /home/me/.luks/mydisk luks,checkargs=xfs,tries=5

* start the volume

        # sudo cryptdisks_start mydisk

* add the following line to `/etc/fstab` (note that your disk UUID will differ)

        /dev/disk/by-uuid/68562de9-0c43-4ce9-91d6-4ea659c8e4e1  /media/mydisk  xfs  relatime,nodiratime  0  0

* create the directory to mount on

        # sudo mkdir /media/mydisk

* starting it

        # sudo cryptdisks_start mydisk

* mount it

        # sudo mount /media/mydisk