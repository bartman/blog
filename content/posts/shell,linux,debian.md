+++
title = "dd hex arguments"
date = "2007-05-04T12:41:24-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = []
keywords = []
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

It sure would be nice to to not have to convert hex numbers manually

when using dd...



        # dd bs=0x200

        dd: invalid number `0x200'



This was a really [easy fix](http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=422275).  Here is 

[the patch](http://www.jukie.net/~bart/patches/coreutils/20070504/0001-support-0x-prefix-on-number-arguments-passed-to-dd.patch).


