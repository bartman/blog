+++
title = "lastfm artist and title to clipboard"
date = "2006-07-07T18:22:36-04:00"
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

Sharing your current [last.fm]{tag/lastfm} track on irc in realtime is very important.  :)  Here is a ion3 binding that will use `xclip` to 

copy the current track info into the X clipboard.



        defbindings("WScreen", {

                kpress("Mod4+grave", "ioncore.exec('echo player/currentlyPlaying | nc localhost 32213 | xclip -i')"),

        })



Put it in `~/.ion3/cfg_user.lua`.


