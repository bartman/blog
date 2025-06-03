+++
title = "growing a live LVM volume"
date = "2010-10-20T11:30:26-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['xfs', 'lvm', 'linux']
keywords = ['xfs', 'lvm', 'linux']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I have an LVM volume, with xfs on it, that is almost full:



    $ df /scratch -h

    Filesystem                Size  Used Avail Use% Mounted on

    /dev/mapper/vg-scratch    180G  175G  5.4G  98% /scratch



    $ sudo lvdisplay /dev/mapper/vg-scratch

    ...

      LV Size                180.00 GB

    ...



But I have some more space in the physical volume.  Let's grow the logical volume.



<!--more-->



First, let's grow the volume by 20G...



    $ sudo lvresize -L +20G /dev/mapper/vg-scratch

      Extending logical volume scratch to 200.00 GB

      Logical volume scratch successfully resized



    $ sudo lvdisplay /dev/mapper/vg-scratch

    ...

      LV Size                200.00 GB

    ...



Next, let's tell the XFS file system to fill in the space...



    $ sudo xfs_growfs /scratch

    ...

    data blocks changed from 47185920 to 52428800



    $ df /scratch -h

    Filesystem            Size  Used Avail Use% Mounted on

    /dev/mapper/vg-scratch

                          200G  175G   26G  88% /scratch


