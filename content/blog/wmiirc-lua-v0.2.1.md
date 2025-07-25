+++
title = "wmiirc-lua v0.2.1 remembers a bit more"
date = "2007-12-04T23:42:32-05:00"
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

In version 0.2.1 wmii will remember the last few programs that have been ran and the last few actions
taken.  It will put those entries at the beginning of the completion list.  Frequent items can thus be selected
with arrow keys and pushing *enter*.

In this release selecting works spaces with `Mod4-[a-z]` will not select the *first* view that starts with 
that letter, but rather the *most recently used* view that starts with the letter.

There have also been a few bug fixes, notably the core will now look in `~/.wmii-3.5` for plugins and core libraries
before looking in system directories.  That will solve the problem of someone using `make install-user` while having 
an older *.deb* installed.

<!--more-->

To build you can then run:

        sudo apt-get install lua5.1 liblua5.1-0-dev liblua5.1-posix0 git-core
        
        git clone git://repo.or.cz/wmiirc-lua.git/
        
        cd wmiirc-lua
        make install-user

Also, visist `#wmiirc-lua` IRC channel on *oftc.net*.

<SCRIPT type='text/javascript' language='JavaScript' src='http://www.ohloh.net/projects/8254/badge_js'></SCRIPT>