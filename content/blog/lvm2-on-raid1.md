+++
title = "LVM2 on RAID1 mirror"
date = "2006-04-10T22:05:25-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['linux', 'lvm', 'raid', 'xen-box-setup']
keywords = ['linux', 'lvm', 'raid', 'xen-box-setup']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

This is part of my [xen box setup]{rtag/xen-box-setup} "series". :)

I've installed debian on a RAID1 device, `/dev/md0`.  This takes up a fraction of the disk, 
and my plan is to create a large LVM2 group on another RAID1 that I can use to dynamically 
create devices for my xen domains.

<!--more-->

This box has 2 SATA drives so my disks are `sda` and `sdb`.  Here are the partitions:

    Device Boot      Start         End      Blocks   Id  System
    /dev/sda1               1        1217     9775521   fd  Linux raid autodetect
    /dev/sda2            1218        1340      987997+  82  Linux swap / Solaris
    /dev/sda3            1341       19929   149316142+  fd  Linux raid autodetect

*(sdb is identical)*

Here is the procedure

1. You will need to install some packages:

        $ apt-get install lvm2 mdadm

2. I have created my RAID1 using mdadm...

        $ mdadm --create /dev/md1 --level 1 -n 2 /dev/sda3 /dev/sdb3

3. Now I create an LVM physical volume on `md1`:

        $ pvcreate /dev/md1

4. Now I create a `xen` volume group:

        $ vgcreate xen /dev/md1

5. Now I have a volume group that I can use to create logical volumes (my partitions) in:

        $ lvcreate -n dom1 -L 10G xen
        $ lvcreate -n dom1.swap -L 512M xen

  You can see what you did with the handy LVM *display* functions:

        $ pvdisplay
        $ vgdisplay
        $ lvdisplay

6. You are now free to create a filesystem on `/dev/xen/dom1` and `/dev/xen/dom1.swap`:

        $ mkfs.favorite /dev/xen/dom1
        $ mkswap /dev/xen/dom1.swap

7. **Now, the very important step.**  

    As I learnt the hard way, the LVM 
    detection happens before RAID.  That's not the right order in this 
    case... we want RAID to happen first and then LVM.  But without intervention, 
    the LVM init script would detect the presence of the logical volume on `/dev/sda3`.  

    To modify what LVM can use for physical media, edit the `filter` setting in the 
    `/etc/lvm/lvm.conf` file.  My filter holds:

        filter = [ "r|/dev/cdrom|", "r|/dev/sd[ab][13]|", "a|/dev/md1|" ]

    Which means:

    - if `cdrom`, skip it
    - if `sda1`, `sda3`, `sdb1`, or `sdb3`, skip it
    - if `md1`, use it for LVM2

    *(btw, anything that falls through the filter is actually accepted, unless you specify a* `"r|.*|"` *filter at the end)*

And that's it.  If you have mdadm and lvm2 installed, everything will come up as you want.

### References

I've mainly consulted the lvm docs, but there are also these resources:

 - [Software RAID and LVM on Linux](http://www.trilug.org/talks/2005-10-raid/md-lvm-presentation/) - a slide show
 - [LVM howto](http://tldp.org/HOWTO/LVM-HOWTO/index.html) - oodles of info
 - [A simple introduction to working with LVM](http://www.debian-administration.org/articles/410) - some debian LVM stuff
