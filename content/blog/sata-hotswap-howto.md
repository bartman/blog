+++
title = "sata hotswap pico-HOWTO"
date = "2010-03-02T16:07:43-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['sata', 'linux']
keywords = ['sata', 'linux']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I had been unpleasantly informed by mdadm that *sdc* has been failing.  *Yey, another one* -- I thought.
Not wanting to disrupt most of my day, I decided to try hot swapping the disk.

<!--more-->

<b>WARNING</b>: this will potentially eat your data, and cause you to fall pray to the
Nigerian email scam.  Proceed with caution.

Before starting, I removed the bad disk from my raid1 (mirror) volume:

    mdadm --del /dev/md0 /dev/sdc1

I [learned on the interweb](http://linux.derkeiler.com/Newsgroups/comp.os.linux.hardware/2006-11/msg00122.html)
about the *scsiadd* utility and installed it:

    apt-get install scsiadd

I then had to discover what *sdc* was on my system.  Fortunately `/sys` had that information:

    ls /sys/bus/scsi/devices/*\:0\:0\:0/block:* -d    

After discovering that `2:0:0:0` was really the same as *sdc* on my system, I took the drive off line:

    scsiadd -r 2 0 0 0

I then swapped the disk for a new one, and added it back in:

    scsiadd -a 2 0 0 0

NOTE: at this point I got a *sdf*, not a *sdc* as I would expect.

Next came the boring steps of `fdisk`ing the new disk, and running

    mdadm --add /dev/md0 /dev/sdf1

... to add it back to the array.

### LVM

If you're using LVM, you may want to look at *pvmove* which lets you migrate data from one PV to another.  I have not
tested this, but it could/should look like this:

    pvcreate /dev/sde9
    pvextend vg1 /dev/sde9
    pvmove /dev/sdc9 /dev/sde9
    pvreduce vg1 /dev/sdc9
    pvremove /dev/sdc9

... given that your bad disk is *sdc9* and your good one is *sde9*.