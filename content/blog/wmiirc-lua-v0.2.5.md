+++
title = "wmiirc-lua v0.2.5 release"
date = "2008-10-02T21:51:21-04:00"
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

A kind [wmiirc-lua]{tag/wmiirc-lua} user, Sytse Wielinga (sytse on irc), had
debugged an old issue in luaixp code I had written for wmiirc-lua.

While this bug directly addresses *raw mode* (Mod4-space), I belive that this will fix
a bunch of weird issues so I released v0.2.5.  Since v0.2.4 there was also a small
bug in the battery plugin that was fixed.

<!--more-->

*What is it?*

Wmiirc-lua is an event loop manager for the [wmii](http://www.suckless.org/wiki/wmii)
tiling window manager.  As the name suggests it's written in Lua, and strives to
have a low system overhead.

*How to get it?*

The easiest way to get wmiirc-lua and its dependencies is to grab the 
[kitchen sink]{wmiirc-lua-kitchen-sink} repository.

If you prefer to get the bits yourself, here is the list of repositories you
will need to build:

  * libixp: `git://git.jukie.net/libixp.git/`
  * wmii: `git://git.jukie.net/wmii.git/`
  * wmiirc-lua: `git://git.jukie.net/wmiirc-lua.git/`
  * dmenu: `git://git.jukie.net/dmenu.git/`
  * slock: `git://git.jukie.net/slock.git/`

*Changes since v0.2.4*

  * fix bug in ixp.read() code and ixp.iread() (Sytse Wielinga)
  * fixed a resource leak in battery plugin (Bart Trojanowski)

Also the [kitchen sink]{wmiirc-lua-kitchen-sink} repository and submodules have been updated
to the most recent *wmii* and *libixp* with some fixes of their own.

*How to get help?*

Visist `#wmiirc-lua` IRC channel on *oftc.net*.

There is also a [mailing list](http://groups.google.ca/group/wmii-lua) for wmiirc-lua.
Subscribe by emailing *wmii-lua-subscribe@googlegroups.com*.

<SCRIPT type='text/javascript' language='JavaScript' src='http://www.ohloh.net/projects/8254/badge_js'></SCRIPT>