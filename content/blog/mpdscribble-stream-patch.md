+++
title = "mpdscribble stream support"
date = "2006-09-08T22:36:13-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['mpd', 'lastfm', 'audio']
keywords = ['mpd', 'lastfm', 'audio']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I am using [gnump3d](http://www.gnump3d.org/) to get my tracks to my laptop, which is 
using [mpd](http://www.MusicPD.org) to play tracks. I noticed that none 
of the streamed tracks were [getting to last.fm](http://www.last.fm/user/BartTrojanowski/). I investigated and 
discovered that mpdscribble was not getting told of the track length by 
mpd -- understandably so -- and was not reporting it to last.fm. 

I [patched the mpdscribble](http://www.jukie.net/~bart/patches/mpdscribble-0.2.10+streamable.patch)
utility and [posted about it](http://www.last.fm/group/mpd/forum/16122/_/166600#f1928624).

**Updated...**

<!--more-->

Err... after writing some patches for [scmpc](http://www.jukie.net/~bart/patches/scmpc/) to support
my setup.  It has been brought to my attention that scrobling streaming tracks is BAD.

See: [http://www.audioscrobbler.net/wiki/Protocol1.1.merged](http://www.audioscrobbler.net/wiki/Protocol1.1.merged)

I understand the reasons.  But, these are real tracks on my server's harddisk, and I 
do have the CDs in a box in the basement...  so I don't feel wrong about doing it, 
but you may want to use this patch at your own disgression.