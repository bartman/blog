+++
title = "opteron 170, part 4"
date = "2006-08-05T13:15:57-04:00"
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

I am getting [sick]{20060805101941} [of]{20060803233234} [this]{20060802210126}.  It froze again.

So to date I have disabled swapped out the motherboard (but still have the same NForce4 chipset),
enabled all sorts of *debug* features in the kernek, removed the Nforce4 network card (based on 
a hint on a web forum), and put in a PCI NIC.  It's still unstable.

I had noticed that it never froze under console, just under X.  The next attempt is to disable 
*DRM*.  I did this through the xorg.conf... let's see what happens next.  I am no longer optimistic.

###Update

Not being optimistic pays off.  I've been running my Opteron 170 stable w/o *DRM* for almost a week.
