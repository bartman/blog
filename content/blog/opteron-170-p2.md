+++
title = "opteron 170, part 2"
date = "2006-08-03T23:32:34-04:00"
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

[Yesterday]{20060802210126}, I wrote about how my Opteron 170 was crashing at random times.  Today I have a working 
system.

<!--more-->

Like a good boy, I went out and upgraded the Gigabyte GA-K8NF-9 (rev1) BIOS to the latest revision.  This was quite
the task since I don't run Windows and Gigabyte is nice enough to provide their BIOS files in self extracting 
executable archives.  The unzip utility that ships with Debian doesn't work on these anymore -- I think it used to
sometime ago.  Anyway, a few hours later, I had the files on a DOS boot disk.

After the BIOS upgrade the CPU was finally identified correctly on the splash screen as Opteron 170.  So I was 
(prematurely) relieved.  I ran memtest and everything checked out.  I booted my OS and the system hung after I got
into X -- just like before.

I was fortunate to have another AMD64 system with a slightly slower CPU acting as my file server.  The mother board
in this computer was an ASUS A8N5X.  Almost the same specs and features as the GA-K8NF-9, but a different manufacturer, 
different BIOS vendor, different coloured plugs... so naturally it was worth a try.

I swapped everything, rebooted and am running a combination of `stress` and `bzip2 -9` runs.  My load is at 40, but 
the system is surprisingly responsive.  I am in X and no crash yet.
