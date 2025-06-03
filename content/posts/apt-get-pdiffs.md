+++
title = "apt-get pdiffs"
date = "2006-08-28T12:47:13-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['debian']
keywords = ['debian']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

Debian/unstable apt-get has this feature called pdiff files (or pdiffs).  It downloads only the diffs between the previous day's Packages and Sources indexes,

which claims to improve downloads for regular use.



When you don't update often you will find that your updates could take 30 minutes, plus.



You can [disable use of pdiff files](http://nixdoc.net/files/forum/about167050-These-new-diffs-are-great--but.html) by running:



    apt-get update -o Acquire::PDiffs=false



<!--more-->



Oh, cute... [PDiffs=false is a feature](http://wiki.debian.org/NewInEtch) not a bug.


