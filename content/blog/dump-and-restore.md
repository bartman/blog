+++
title = "dump and restore"
date = "2006-12-28T22:06:41-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['linux', 'fs', 'sbc']
keywords = ['linux', 'fs', 'sbc']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I've heard many people talk about backups via dump and restore.  I've never really tried it, although it looks like I should
have been using it all along.

I am rebuilding my firewall, which is based on a [WRAP](http://www.pcengines.ch/wrap.htm) 
[1C-2](http://www.pcengines.ch/pic/wrap1c2.jpg) [sbc]{tag/sbc}.  I want to use two such boxes, one to connect to 
my two ISPs (both cheap) and the other to create a DMZ network.

I just finished building one of them (similar as the steps in [this article]{sbc-bootstrap-with-debian}).  Now I want to clone 
the image, because the systems will be almost identical. So I stick in the CF card into my card reader, and run

        # sudo mount /dev/sdc1 /mnt/flash1
        # sudo dump -0f - /mnt/flash1/ | pv -Wbr | bzip2 -9 > /tmp/wrap2-`ymd-hms`.dump.bz2

This creates a wrap2-20061228-220157.dump.bz2 file.  I noticed that it was much smaller then the bzip2'ed dd-dump I usually 
would have ran.  That's a plus.

Now to restore, I remove the original, put in a new CF card, and run:

        # sudo mount /dev/sdc1 /mnt/flash1
        # cd /mnt/flash1
        # bunzip2 < /tmp/wrap2-20061228-220157.dump.bz2 | pv -Wbr | sudo restore rf -

Note that this is potentially dangerous.  Make sure you switch to the right directory first, and that it contains the file-system
you want to overwrite.  Look at the restore man page.

I've used [this page](http://wiki.grml.org/doku.php?id=cloning) as reference.  It happens to show how to clone a disk 
using various methods.