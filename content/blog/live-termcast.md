+++
title = "live termcasting of your terminal over telnet"
date = "2010-02-21T18:41:26-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['shell', 'linux', 'screen']
keywords = ['shell', 'linux', 'screen']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I mentioned [earlier]{ubifs-on-sheeva} that I will be giving a talk 
at [Flourish Conf](http://flourishconf.com/) next month.  While preparing for the talk
I decided to I wanted to share my terminal with the participants of the Workshop
via telnet.  The more popular alternative would be to use [screen](http://en.wikipedia.org/wiki/GNU_Screen)
built in sharing, or maybe [vnc](http://en.wikipedia.org/wiki/Vnc), which would
require more memory and CPU overhead...  and additional accounts using the former method.
I only have a [SheevaPlug](http://en.wikipedia.org/wiki/SheevaPlug) to work with, so
I am trying to be as conservative as possible.

<!--more-->

I was pointed to a [blog post](http://joey.kitenet.net/blog/entry/started_termcasting/)
[on termcasting](http://joey.kitenet.net/termcast/) by [Joey Hess](http://joey.kitenet.net).
Joey uses a [modified version of ttyrec](http://git.kitenet.net/?p=ttyrec.git) for 
termcasting.  This will not work for me as I want people to watch the session live.  While
`ttyplay` seems to have some nice features, it exists as soon as it reaches the end of the
recording... Whereas I want something similar to `tail -f`.

I ended up with a combination of `script`, `tail -f` and `telnetd -L`.

### Here is the setup...

First let's start with capturing the session.  My script is a bit more complex, but essentially
it does the following:

    script -c "TERM=vt220 screen -S termcast" -f "/tmp/termcast"

This will start a screen session, under [script](http://en.wikipedia.org/wiki/Script_(Unix)), and record
all input and output to a file in `tmp/termcast` -- more specifically anything echoed to the screen,
so your passwords will not be *shared*.  I discovered that [vt220](http://en.wikipedia.org/wiki/VT220)
works best when connecting from a windows system.  This is one of the disadvantages of this method:
you're at the mercy of the terminal emulation capabilities of the client, and vt220 seems to be 
old enough that it's supported by Windows.

Next, I created a script in `/usr/local/bin/play-watch-log` that contains:

    #!/bin/sh
    exec tail -f /tmp/termcast

The final step is to make `telnetd` run this script as the login shell; in `/etc/inetd.conf`, I placed:

    telnet stream tcp nowait telnetd /usr/sbin/tcpd /usr/sbin/in.telnetd -L /usr/local/bin/play-watch-log

And we're done.  My students will connect to the session using telnet and be able to watch what I type... sweet!

### "What about socat?"

Shortly after I wrote this up, *Wisq* on the [#oclug](http://oclug.on.ca) irc channel suggested I use `socat`.

Here is the replcement for `inetd`/`telnetd` using socat:

    socat TCP-LISTEN:23,fork EXEC:"tail -f /home/watch/termcast/current"