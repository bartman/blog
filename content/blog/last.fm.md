+++
title = "last.fm"
date = "2006-03-08T12:33:02-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['lastfm']
keywords = ['lastfm']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

<p>I just *<b>heart</b>* <a href=http://www.last.fm/user/BartTrojanowski/>last.fm</a>.</p>

<p>It really is the LAST radio station you will need to tune into... well, unless you're in the car or on a bus or something silly like that.</p>

<p>Last.fm is a streaming internet radio station that learns to what you listen to.  It also allows you to listen to stations tailored to other people, or listen to particular types of music, or artists similar to the ones you like, etc, etc etc.</p>

<p>I've been using latfmproxy to be able to control the music w/o a gui... keyboard shortcuts for skipping songs are much nicer.  But, it turns out that lastfm player does listen to a local port 32213 (thanks to dave0 for reading the code).  You so you can do something like:</p>
<blockquote>
        $ echo "player/skip" | netcat localhost 32213
</blockquote>

<p>The commands are basically anything that looks like lastfm:// URL, but without the lastfm:// part.  Other things that do interesting things are:<p>
<ul>
<li>player/status
<li>player/currentlyPlaying
<li>player/currentCover
<li>player/userTags
<li>player/love
<li>player/skip
<li>player/ban
</ul>

<p>To listen to loved tracks, you can use this:</p>
<blockquote>
        $ echo "lastfm://user/BartTrojanowski/loved" | netcat localhost 32213
</blockquote>

<p>
---
</p>

<p>
Updates:
<ul>
<li>
Dave wrote up how to tag using XMLRPC: <a href=http://www.dmo.ca/blog/last-fm-api-hacking-1>http://www.dmo.ca/blog/last-fm-api-hacking-1</a>
</ul>
</p>