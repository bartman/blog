+++
title = "wmiirc-lua v0.1.1"
date = "2007-09-15T09:42:13-04:00"
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

Last night, just before midnight, I released v0.1 of [wmiirc-lua](http://repo.or.cz/w/wmiirc-lua.git).  And then a few
minutes later I had to release v0.1.1.  Let this be a lesson to me, midnight is way too late to make releases.

So what do you get in v0.1.1?

  - a very fast and lean implementation of an event loop for [wmii-3.5](http://www.suckless.org/wiki/wmii)
  - all keyboard shortcuts from the (shell) wmiirc that ships with wmii-3.5
  - some ideas taken from [wmii+ruby](http://eigenclass.org/hiki.rb?wmii+ruby) like more advanced keyboard shortcuts and plugins
  - a clock plugin, a load plugin
  - and most importantly a huge community of 3 users!

Why would you want to use wmiirc-lua over the default, or even over the fabulous wmii+ruby?

  - unlike wmii+ruby, wmiirc-lua can run with wmii-3.5
    - debian/testing no longer has wmii-3.1 and according to the wmii website: *wmii-3.1 is deprecated*
  - wmiirc-lua is faster then the shell version because it doesn't have to exec things on event processing
    - we communicate with wmii over an IXP socket directly
  - wmiirc-lua will not eat your laptop's battery life like ruby threading can
    - [powertop](http://www.linuxpowertop.org/) used to show ruby as the #1 source of CPU wakeups
    - **300 wakeups/s with wmii+ruby and 1 wakeup/s with wmiirc-lua**

<!--more-->

wmiirc-lua has only been tested against the latest wmii and libixp, to get them do this...

        mkdir wmii-lua-build
        cd wmii-build

        hg clone http://suckless.org/hg.rc/libixp
        cd libixp
        make 
        sudo make install
        cd ..

        hg clone http://suckless.org/hg.rc/wmii
        cd wmii
        make 
        sudo make install
        cd ..

To build and install wmiirc-lua do this...

        apt-get install lua5.1 liblua5.1-0-dev liblua5.1-posix0 git-core

        git clone git://repo.or.cz/wmiirc-lua.git/
        cd wmiirc-lua

        make install

This will put all the files in `~/.wmii-3.5/`.  You still have to make your .xsession execute wmii-3.5.

If you do decide to try it, I would like to hear from you.  Let me know what I should add to the TODO list to make your wmii experience even better.

There is now an `#wmiirc-lua` IRC channel on *oftc.net*.

<SCRIPT type='text/javascript' language='JavaScript' src='http://www.ohloh.net/projects/8254/badge_js'></SCRIPT>