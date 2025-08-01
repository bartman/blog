+++
title = "wmiirc-lua debianization"
date = "2007-09-29T11:23:45-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['lua', 'wmii', 'desktop', 'wmiirc-lua', 'debian']
keywords = ['lua', 'wmii', 'desktop', 'wmiirc-lua', 'debian']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I just fixed the install scripts for [wmiirc-lua](http://repo.or.cz/w/wmiirc-lua.git).  It is now possible
to install wmiirc-lua in system directories and run from there.  There is also a *Wmii-lua* session for 
the display managers (kdm, gdm, etc).

The new and improved way to install wmiirc-lua is to [get libixp and wmii from hg]{wmiirc-in-lua-v0.1.1} and then...

        sudo apt-get install lua5.1 liblua5.1-0-dev liblua5.1-posix0 git-core
        
        git clone git://repo.or.cz/wmiirc-lua.git/
        
        cd wmiirc-lua
        git checkout debian
        make deb
        
        sudo debi
        
        install-wmiirc-lua

... restart X, and select *Wmii-lua* as your login session.

<!--more-->

I have changed the semantics for `make install`...

  - `make install` - install in DESTDIR/PREFIX (see `config.mk`).
  - `make install-user` - install in `~/.wmii-3.5/`.

If you chose to go with the *install in system directories* route, you should note that `alt-a wmiirc` does not work
properly unless you have a `~/.wmii-3.5/wmiirc`.  Running `install-wmiirc-lua` gets you just that.

...

If you do decide to try it, I would like to hear from you.  Let me know what I should add to the TODO list to make your wmii experience even better.

There is now an `#wmiirc-lua` IRC channel on *oftc.net*.

<SCRIPT type='text/javascript' language='JavaScript' src='http://www.ohloh.net/projects/8254/badge_js'></SCRIPT>