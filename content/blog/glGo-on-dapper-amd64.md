+++
title = "glGo on ubuntu/dapper amd64"
date = "2006-09-07T12:51:49-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['go', 'linux', 'debian']
keywords = ['go', 'linux', 'debian']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I started [playing go](http://www.pandanet.co.jp/English/).  I tried cgoban and gtkgo.  Both 
crashed a lot.  Then I tried [glGo](http://www.pandanet.co.jp/English/glgo/screenshots.html)... it's much better.

<!--more-->

First of all they only have a 32bit deb... we need to build a chroot:

        sudo apt-get install dchroot debootstrap
        sudo mkdir /32
        sudo debootstrap --arch i386 dapper /32
        sudo sh -c 'echo 32 >> /etc/dchroot.conf'

You will need to setup the dchroot to make it possible for a regular user to execute apps in 
it.  I don't really want to get into it here, you should have to do something along the lines of...

<blockquote>
<i>(need to be root to do all of this)</i>
</blockquote>

  - update `/etc/passwd`, and `/etc/group` *(chroot account's can be password-less)*
  - `mount -o bind /etc/resolv.conf /32/etc/resolv.conf`
  - `mount -t proc none  /32/proc`
  - `mount -o rbind /dev /32/dev`
  - `mount -o rbind /tmp /32/tmp` *(required for X to function)*
  - `mount -o rbind /home /32/home` *(optional)*

At this point your chroot is functional, enter it as root:

        sudo chroot /32 su

*glGo* needs some extra packages (their .deb has no `Depends:` line at all)...

<blockquote>
<i>(in the chroot)</i>
</blockquote>

        echo deb http://archive.ubuntu.com/ubuntu dapper universe >> /etc/apt/sources.list
        apt-get update
        apt-get install debconf-utils esound esound-clients hicolor-icon-theme \
                        libgl1-mesa libglib2.0-data libglu1-mesa libgtk2.0-bin \
                        libsdl-image1.2 libsdl-ttf2.0-0 libsdl1.2debian-all wget

And lastly install glGo:

<blockquote>
<i>(still in the chroot)</i>
</blockquote>

        wget http://www.pandanet.co.jp/English/glgo/downloads/glGo-1.4.deb
        dpkg -i glGo-1.4.deb

Then exit the chroot, and as a regular user you can run...

        dchroot -c 32 glGo