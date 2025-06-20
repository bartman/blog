+++
title = "wmiirc-lua updates"
date = "2008-07-15T21:44:47-04:00"
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

I finally got around to [porting a few old features]{20070112131252} to [wmiirc-lua]{tag/wmiirc-lua}.

There is now a [mailing list](http://groups.google.ca/group/wmii-lua) for wmiirc-lua.
Subscribe by emailing *wmii-lua-subscribe@googlegroups.com*.

<!--more-->

I just pushed everything to git, and will probably roll out a new release if there
are no bugs.

The new features are:

  * I've updated the [kitchen sink repo]{wmiirc-lua-kitchen-sink} to track the latest wmii and libixp 
    code from the upstream repositories.  I've noticed that xrandr was now supported.  Aces!

  * Dave submitted a patch that implements a new load monitor.

  * view working directory tracking
    - sometimes I dedicate a view to a project and have several xterms all in the same directory.
    - you can now use `Mod1-apostrophe` to open an xterm on the same directory as the previous
    - the feature relies on having the shell (zsh or bash, maybe others) generate a `ShellChangeDir`
      event when the directory changes.

  * force a program to open on a view from the command line
    - originally from [Dave](http://www.dmo.ca/blog/20070111010218)
    - it was ~5 lines of new lua code :)

My zsh functions for wmii are here: [.zsh.d/S58_wmii](/~bart/conf/zsh.d/S58_wmii).