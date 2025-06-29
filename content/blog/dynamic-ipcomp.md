+++
title = "dynamic IPcomp"
date = "2006-08-24T15:26:58-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['linux', 'net']
keywords = ['linux', 'net']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I just had a thought while reading over the KLIPS code and creating beautiful inkscape
diagrams from it ([see previous post]{20060824145428})...

Wouldn't it be great if we had IPcomp that worked for all connections?  Your cpu is always
faster then the internet connection -- or at least it has been my case for the last decade
and a bit.

So my idea was... why not have IPcomp on all the time.  Assume the other host you want
to talk to has IPcomp enabled for TCP and UDP.  On the first packet we send, if they
don't understand it, they will *hopefully* send back an ICMP error and then we retransmit
the packet uncompressed.  For TCP that would be pretty trival, because TCP already 
retransmits.  For UDP we would have to remember the IPs that we tried and have a way
to hold the packets before the verdict is known.

I think it could work... what do you think?

~~~

Actually while I am thinking of it, Val Henson has a [cool list of file-system projects](http://linuxfs.pbwiki.com/EasyFsProjects) available for anyone to tackle.