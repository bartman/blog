+++
title = "opteron 170, part 3"
date = "2006-08-05T10:19:41-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['hardware', 'opteron']
keywords = ['hardware', 'opteron']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

Over the last [few]{20060802210126} [days]{20060803233234}, I have been experiencing odd crashes.  I have been able to

narrow it down to network activity.  Most of the time this has been triggered with NFS access; I assume that 

it has something to do with large UDP fragments; my MTU is 1500.



The last couple of days I have had a serial console connected to the machine, and my laptop standing by waiting for 

another crash.  It occurred, but something really bad happened because on the console I only got:



    [   65.597418] [drm] writeback test succeeded in 1 usecs

    [  835.777136]

    [  835.777138] HARDWARE ER  



... and then the system was completely locked up.  I really wish I knew what that HARDWARE ERROR was :(



I guess this sounds familiar.  On day one, I was looking for answers and found [a windows user having the same 

problems](http://forums.amd.com/index.php?showtopic=80512).  I have ordered an e1000 NIC.



I put an old 3COM NIC into a PCI slot and have been using that.




