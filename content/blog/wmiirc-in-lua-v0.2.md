+++
title = "wmiirc-lua v0.2 has suspend and raw modes"
date = "2007-10-13T20:53:36-04:00"
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

[wmiirc-lua]{tags/wmiirc-lua} is a replacement for sh-based wmiirc that ships with
the [wmii](http://www.suckless.org/wiki/wmii) window manager.

The big improvement in version 0.2 is the client tracking support; this enables
*raw* and *suspend* [modes](http://repo.or.cz/w/wmiirc-lua.git?a=blob;f=doc/client-modes;h=767ad744ef04bf5197348c45488038546764c07a;hb=4487bd2747261ff06cf0c65ceccff8e66fb411ee)...

  - in *raw* mode the wmii [key-bindings](http://repo.or.cz/w/wmiirc-lua.git?a=blob;f=doc/key-bindings;h=e8ca905130d0f4e283e0ab9eb968173f0fae0b6d;hb=4487bd2747261ff06cf0c65ceccff8e66fb411ee)
    are ignored and all input is passed to the application.

  - in *suspend* mode, the process that created a particular window will be sent the `STOP` signal when the window is not in focus.
    I wrote this with firefox in mind; even when idle and off-screen my firefox gets woken up 100 times per second.

There were also several bug fixes in this release.  You will still need to build libixp and wmii from hg [as detained here]{wmiirc-in-lua-v0.1.1}.

<!--more-->

To build you can then run:

        sudo apt-get install lua5.1 liblua5.1-0-dev liblua5.1-posix0 git-core
        
        git clone git://repo.or.cz/wmiirc-lua.git/
        
        cd wmiirc-lua
        make install-user

Also, visist `#wmiirc-lua` IRC channel on *oftc.net*.

<SCRIPT type='text/javascript' language='JavaScript' src='http://www.ohloh.net/projects/8254/badge_js'></SCRIPT>