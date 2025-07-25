+++
title = "USB2.0 enclosure benchmark"
date = "2008-07-05T15:06:51-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['usb', 'linux', 'disk']
keywords = ['usb', 'linux', 'disk']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I've noticed my laptop disk filling up...  particularly in `$HOME/work/*`.  Lots 
of little contracts, each involving at least the linux kernel tree of one
vintage of another, are to blame.

![CoolMax 2.5" Aluminim External Enclosure](/~bart/pic/coolmax-sata-2.5-enclosure.jpg)

To solve this, I decided to pickup an external drive.  I am using USB 2.0, because my laptop,
Thinkpad x41, has no eSATA or even firewire.  So I cannot compare the performance over another
connection, but I can have a look at which filesystem (xfs or ext3) will perform my workloads best.

<!--more-->

My work loads are:

 - clone the linux kernel git tree (from a local mirror)
 - configure the kernel
 - build the kernel
 - clean the tree
 - remove the tree

I don't really care about accuracy, but I ran the test (from start to finish) twice to make
sure that the numbers were in the ballpark and they were very similar in both cases.  

So first up is ext3.

    $ mkfs.ext3 /dev/sdb1                                0.43s user  20.04s system 17% cpu  1:56.24 total
    $ git clone quark.jukie.net:/scratch/linux-2.6/    106.27s user  15.66s system 78% cpu  2:34.51 total
    $ git checkout -f                                    0.84s user   0.19s system 91% cpu    1.136 total
    $ make defconfig                                     2.49s user   0.86s system 33% cpu   10.053 total
    $ make bzImage modules                             566.28s user  55.95s system 66% cpu 15:33.44 total
    $ make tags cscope                                  98.44s user  10.99s system 64% cpu  2:49.30 total
    $ git clean -d -x -f                                 0.15s user   0.52s system 10% cpu    6.047 total
    $ rm -i -rf linux-2.6                                0.08s user   1.39s system 23% cpu    6.152 total

And the other contender is xfs.

    $ mkfs.xfs -f /dev/sdb1                              0.00s user   0.02s system  0% cpu    3.33s total
    $ git clone quark.jukie.net:/scratch/linux-2.6/    105.44s user  16.21s system 56% cpu  3:36.56 total
    $ git checkout -f                                    0.32s user   0.14s system 55% cpu    0.826 total
    $ make defconfig                                     2.06s user   0.73s system 25% cpu   10.755 total
    $ make bzImage modules                             127.72s user  31.05s system 71% cpu  3:40.74 total
    $ make tags cscope                                 104.99s user  10.22s system 57% cpu  3:18.89 total
    $ git clean -d -x -f                                 0.14s user   0.72s system 21% cpu    4.087 total
    $ rm -i -rf linux-2.6                                0.06s user   3.46s system 26% cpu   13.405 total

I guess the only thing that's stunning is that xfs can build the kernel 4 times 
faster.  And because building is what I do most, I am sticking with xfs.