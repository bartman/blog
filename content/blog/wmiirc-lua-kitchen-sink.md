+++
title = "wmiirc-lua kitchen sink repository"
date = "2007-12-17T14:10:37-05:00"
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

[wmiirc-lua]{tag/wmiirc-lua} is a replacement for sh-based wmiirc that ships with
the [wmii](http://www.suckless.org/wiki/wmii) window manager.

I have had some issues with the *libixp* and *wmii* packages under Debian.  Particularly the problem is caused by
the fact that libixp (and wmii use of the library) changes often but do not have any way to detect subtle changes
in the API from the sources.

I decided to track everything in a *kitchen sink* repository that will include all the sources that need to be
versioned and released together.  That way what *you* try is the same thing I tried.  Currently this includes

 - libixp *imported from mercurial*
 - wmii *imported from mercurial*
 - wmiirc-lua

This of course uses magic [git]{tag/git} powers; or more specifically git submodules.  To follow along you will need
git 1.5.3 or newer.

<!--more-->

So unlike previous releases, you don't even need to install wmii or libixp.  Simply run these commands:

        apt-get install build-essential debhelper           \
                    libx11-dev libxext-dev libxt-dev        \
                    lua5.1 liblua5.1-0-dev liblua5.1-posix0 \
                    dwm-tools xclip dstat
        
        git clone git://git.jukie.net/wmiirc-lua-kitchen-sink.git/
        
        cd wmiirc-lua-kitchen-sink
        git submodule init
        git submodule update
        make install-user

The *libixp* and *wmii* files will be installed in `$HOME/usr/` and the *wmiirc-lua* files will go 
in `$HOME/.wmii-3.5`.  You can now exec `wmii-lua` from `~/.xsession`.

*NOTE* you have to add `$HOME/usr/bin` to your `PATH`.

*NOTE* that the kitchen-sink repository is not actually tagged with versions (yet), so you will get the head
of the development branch.



Also, visist `#wmiirc-lua` IRC channel on *oftc.net*.

<SCRIPT type='text/javascript' language='JavaScript' src='http://www.ohloh.net/projects/8254/badge_js'></SCRIPT>