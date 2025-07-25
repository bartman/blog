+++
title = "wmiirc in lua"
date = "2007-09-02T00:07:36-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['lua', 'wmii', 'desktop', 'wmiirc-lua']
keywords = ['lua', 'wmii', 'desktop', 'wmiirc-lua']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I have been running [wmii](http://www.suckless.org/wiki/wmii) window manager for almost a 
year, and [since the beginning](http://www.jukie.net/~bart/blog/wmii-with-ruby) I have been
using the [ruby wmiirc](http://eigenclass.org/hiki.rb?wmii+ruby) script.

In wmii all events are handled by the *wmiirc* script, while wmii handles the display
of windows.  The *wmiirc* should thus do nothing until a user event (or a program
event) occurs.  Well, it turns out that updating the clock and status widgets requires
that a thread be ran to write the new text to the screen.

So far, that's not so bad.  We could schedule updates to occur infrequently.  The bad part
comes from the ruby implementation of threads.  Threads in ruby 1.x seem to require that
the interpreter do a busy wait at an interval of 10ms... this does not make me very happy 
as it chews up a ton of battery life according to [powertop](http://www.linuxpowertop.org/).

I wanted to rewrite a *wmiirc* in something else.  That something 
else, I decided, would be [lua]{tag/lua}.  I chose lua because of the small footprint, 
use of coroutines and iterators to avoid threading, and the fact that I can plug things 
in using C.

<!--more-->

The beginning of this can be seen in my [git]{tag/git} repository.

  - Git web interface provided by [repo.or.cz](http://repo.or.cz):

    [http://repo.or.cz/w/wmiirc-lua.git](http://repo.or.cz/w/wmiirc-lua.git)

  - clone from the mirror:

        git clone git://repo.or.cz/wmiirc-lua.git/

  - clone from my site:

        git clone git://www.jukie.net/wmiirc-lua.git/

It's had about 5 minutes of testing so far, so I wish you luck :)

**NOTES**

This requires that you have a pretty recent version of wmii.  I am running the tip of the 
wmii mercurial repository...

        hg clone http://suckless.org/hg.rc/libixp
        hg clone http://suckless.org/hg.rc/wmii

You will also need a bunch of lua packages; I installed them all ...

        apt-cache search lua5.1 | awk '/liblua5.1/ { print $1 }' | xargs sudo apt-get install -y

... to be safe.

<SCRIPT type='text/javascript' language='JavaScript' src='http://www.ohloh.net/projects/8254/badge_js'></SCRIPT>