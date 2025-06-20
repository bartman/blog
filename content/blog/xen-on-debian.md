+++
title = "xen on debian"
date = "2006-04-07T23:09:39-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['linux', 'xen-box-setup']
keywords = ['linux', 'xen-box-setup']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I decided to try out xen on my development / test box.  I will write a bit more about what I did, but first here are some links:

<!--more-->

From the [xensource.com](http://xensource.com) site:

- [Xen documentation links](http://www.xensource.com/xen/xen/documentation.html) - links to a whole lot of docs
- [Wen documentation wiki page](http://wiki.xensource.com/xenwiki/XenDocs) - even more docs
- [Xen 3.0 - Users' Manual](http://www.cl.cam.ac.uk/Research/SRG/netos/xen/readmes/user/user.html) - it's not _everything_ but it has a lot of good information

Some HOW-TOs:

- [Debian DomU HowTo](http://wiki.xensource.com/xenwiki/DebianDomU) - Sarge, xenU, LVM.
- [The Perfect Xen 3.0 Setup For Debian](http://www.howtoforge.com/perfect_setup_xen3_debian) - good for sarge/debian stuff
- [Xen on Ubuntu Hoary HowTo](http://wiki.xensource.com/xenwiki/UbuntuHoaryHowTo) - talks briefly about LVM with xen
- [Xen on Ubuntu Breezy HowTo](http://wiki.xensource.com/xenwiki/UbuntuBreezyHowTo) - very brief
- another [Xen on Ubuntu Breezy HowTo](https://wiki.ubuntu.com/XenVirtualMachine/XenOnUbuntuBreezy) - complete from source instructions
- [Xen Virtualization and Linux Clustering](http://www.linuxjournal.com/article/8812) - a mini-series at LinuxJournal
- a German [Xen-Installation](http://www.pug.org/index.php/Xen-Installation) document that revealed to me a fix for my console issues on *domU*'s.

Pre-installed operating system images.  *Not really xen intended, but man is it really handy.*

- [Free Operating ZOO](http://free.oszoo.org/download.html) - QEMU emulator images (should work with xen if you supply the xenU kernel)
- [Bochs Disk images](http://bochs.sourceforge.net/diskimages.html) - Bochs supplied disk images (tiny ones)

Other:

- [Debian Xen 2.0.6 Packages](http://www.option-c.com/xwiki/Debian_Xen_2.0.6_Packages) - some older xen debian packages
- [Xen 3 for Debian](http://julien.danjou.info/xen.html) - home network in one machine using xen

To see the rest of this write up, see the [xen box setup](/~bart/blog/rtag/xen-box-setup) "series".