+++
title = "small fonts"
date = "2006-10-18T20:19:07-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['linux', 'desktop', 'font']
keywords = ['linux', 'desktop', 'font']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I don't use a lot of X applications.  The one that I use most often is `xterm`.

I like small fonts, and I find that I have no problem reading a small font on an LCD monitor.
Recently someone mentioned the *Terminus* font.  I tried it and it quickly became my favored 
`xterm` font... it's so tiny and clean!  Here are the important bits of my `.Xdefaults` file...

        XTerm*renderFont:        false
        XTerm*font:              -xos4-terminus-medium-r-normal-*-12-*-*-*-*-*-*-*

I also grabbed a few tiny fonts from [Proggy Fonts](http://www.proggyfonts.com) and my new `wmii` font is 
ProggyTiny.  Here is the bit from my `.wmii-3/wmiirc-config.rb` file...

        font        '-windows-proggytiny-medium-r-normal--10-80-96-96-c-60-iso8859-1'

The above font site also taught me how to import fonts into X font server w/o a restart and how to
keep fonts in my home directory.  Check out this [short HOWTO](http://www.proggyfonts.com/XWindowsFontInstall.txt).

<!--more-->

It all looks something like this...

![tiny font](/~bart/screenshots/tiny-fonts.png)

There is another tiny font [available here](http://www.timeguy.com/cradek/01128220822) if you need more.
I find this font only usable for the xterm tiny font.
