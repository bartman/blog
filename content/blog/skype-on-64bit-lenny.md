+++
title = "skype on Debian Linux (64bit)"
date = "2010-01-30T15:05:27-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['skype', 'linux']
keywords = ['skype', 'linux']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

My aunt asked that I get my mom hooked up on skype for my mom's B-day.  That involved getting a webcam and hooking it up on my parents' Ubuntu system.
Since I've never done anything with webcams, I didn't know where to start.  This blog entry is about trying skype and the webcam going on my Debian
Sqeeze laptop.

<!--more-->

Being a bit (positively) biased towards Logitech hardware, I googled for Linux support for Logitech webcams.  I came across [Linux UVC driver and tools](http://linux-uvc.berlios.de/),
which was a great start.  I soon bought the [Logitech Webcam C200](http://www.logitech.com/index.cfm/notebook_products/webcams/devices/5865&cl=us,en).

The webcam was a great deal for $40, and worked under linux out of the box.  To test it I used the [guvcview](http://guvcview.berlios.de/) utility.  Everything worked great.

Next I wet to get [the latest version of skype for Linux](http://www.skype.com/download/skype/linux/).  My first reaction was: *Oooh, they have a Debian package for Lenny*.  Unfortunately
it was a 32bit package.  They had a 64bit package for Ubuntu, so I grabbed that.  It was a bit disappointing as it was a 64bit package, with 32bit binaries.  Oh well.

Skype started fine, and I was able to create an account.  However as soon as I logged in, the app crashes.  I did some googling and found:

 - [Skype on amd64 debian testing](http://forums.debian.net/viewtopic.php?f=5&t=46715) - on debian.net
 - [Skype Client for Linux - Crash right after login](https://developer.skype.com/jira/browse/SCL-510) - on skype developer forums

From these I learned that removing `/usr/lib32/libpulse*` files does the trick.  Since I am not a pulse user, I didn't mind doing...

    sudo mkdir /usr/lib32-oldpulse/
    sudo mv /usr/lib32/libpulse* /usr/lib32-oldpulse/

Now I could start skype and make voice calls.  Video didn't work.  When I went to options to test my video configuration, I noticed that it failed to work there too.
After some further googling I [discovered](http://forum.skype.com/index.php?showtopic=411431&st=60&p=1932431&#entry1932431) that to fix this is to 
run `gstreamer-properties` and configure video output to use *X Window System (No Xv)*.

Now it all works.

*UPDATE*: my parents' system runs 32bit Ubuntu 8.10 (probably because that's what was recent when I set it up).  I had to remove the pulse library files there
too to get skype to work with the microphone on the webcam.