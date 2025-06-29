+++
title = "vmlinux on Ubuntu"
date = "2010-04-12T10:01:35-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['ubuntu', 'linux', 'kernel']
keywords = ['ubuntu', 'linux', 'kernel']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

If you're trying to do post-mortem analysis on a crashed river, or trying to find kernel-level
bottlenecks with oprofile, you need the decompressed kernel w/ debug symbols.  This comes in a
form of a `vmlinux` file.  Some distributions ship debuginfo packages, namely RHEL.  On Ubuntu
this seems lacking.

<!--more-->

I was able to find the procedure to build one from the archive source packages:

        apt-get source linux
        apt-get build-dep linux
        cd linux-2.6.31/
        fakeroot make -f debian/rules binary-generic skipdbg=false
        sudo dpkg -i ../linux-image-debug-2.6.31-19-generic_2.6.31-19.56_amd64.ddeb

The kernel version above is from Intrepid, but that procedure should work on other versions
also.

Credits to [Chris Conway's comment](https://bugs.launchpad.net/ubuntu/+source/linux/+bug/289087/comments/26) on [Ubuntu bug 289087](https://bugs.launchpad.net/ubuntu/+source/linux/+bug/289087).