+++
title = "wmiirc-lua v0.2.4 release"
date = "2008-09-13T11:23:45-04:00"
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

I packaged up the latest modules and bug fixes of [wmiirc-lua]{tag/wmiirc-lua} and 
made a v0.2.4 release.

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

*Changes since v0.2.3*

  * new load plugin (Dave O'Neill)
  * battery plugin (Stefan Riegler and Dave O'Neill)
  * cpufreq plugin (Jan-David Quesel and Bart Trojanowski)
  * view_workdirs (Bart Trojanowski)
  * various fixes

Also the [kitchen sink]{wmiirc-lua-kitchen-sink} repository and submodules have been updated
to the most recent *wmii* and *libixp* which fix some resize issues.

*How to get help?*

Visist `#wmiirc-lua` IRC channel on *oftc.net*.

There is now a [mailing list](http://groups.google.ca/group/wmii-lua) for wmiirc-lua.
Subscribe by emailing *wmii-lua-subscribe@googlegroups.com*.

<SCRIPT type='text/javascript' language='JavaScript' src='http://www.ohloh.net/projects/8254/badge_js'></SCRIPT>