+++
title = "m4a to mp3"
date = "2010-07-23T19:22:59-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['music', 'mp3']
keywords = ['music', 'mp3']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I was at [Bridgehead](http://www.bridgehead.ca/) earlier today and heard a cool tune.  I asked the staff
what it was, and they told me that it was [Low Strung](http://www.last.fm/music/Low+Strung).  After coming home
I wanted to get the CD, but was unable to find it anywhere but [iTunes](http://itunes.apple.com/album/low-strung/id260115183?ign-mpt=uo%3D5).  I don't do iTunes, because Apple doesn't do Linux... but fortunately my wife
has a Mac.

So, after getting the album I had to convert it from `.m4a` to `.mp3`.  I figured I'd share my script...
[convert-m4a-to-mp3](http://git.jukie.net/snippets.git/tree/m4a-to-mp3/convert-m4a-to-mp3).  You'll need
to grab a few packages to use it: `apt-get install zsh faad id3v2 twolame toolame`.

     cd dir-with-m4a-files
     ./convert-m4a-mp3

Ta da!
