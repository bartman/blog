+++
title = "debian install CDs"
date = "2004-03-15T20:41:42-05:00"
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

<p>I've just realized that I never have to burn another stinking Debian
installer CD.</p>

<p>Why bother, if I can just boot into Knoppix and run debootstrap.</p>

<p>Just look how easy the process is:</p>

<ol>
<li> boot into knoppix.
<li> mkdir /1
<li> mke2fs -j /dev/sda1
<li> mount /dev/sda1 /1
<li> debootstrap sarge /1 http://ftp.debian.org/debian
</ol>

<p>Of course this will not boot, so I will have to build the kernel.  But 
I would do that anyways right after I rebooted the first time into any 
install anyway.</p>

<p>I also would recommend that you glance over the 
<a href=http://trilldev.sourceforge.net/files/remotedeb.html
>HOWTO - Install Debian Onto a Remote Linux System</a>, which is 
relevant because it talks about <b>debootstrap</b>.</p>
