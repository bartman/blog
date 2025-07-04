+++
title = "wmiirc-lua moving to github"
date = "2009-05-09T11:31:25-04:00"
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

I had as surge of new interest in wmii-lua in the last couple of months.  I thought it
would be good to officially state here that
I've [been moving](http://groups.google.ca/group/wmii-lua/browse_thread/thread/aaaf9b23a5aa7c85)
the wmii-lua git repositories to github.

<!--more-->

Here are the links:

  - [libixp](http://github.com/bartman/libixp/tree/master) - imported from suckless.org hg repo on an hourly basis
  - [wmii](http://github.com/bartman/wmii/tree/master) - also from suckless.org hg repo
  - [wmii-lua](http://github.com/bartman/wmii-lua/tree/master) - this is the *wmiirc-lua* project with the above two as submodules

All new development and bug fixes will happen on the above trees.

The [kitchen sink]{wmiirc-lua-kitchen-sink} is now *deprecated* and will be removed
(*or at least disabled*) on the next release I make from the github tree.  Note
that I am no longer importing `dmenu` or `slock` because the former is now
replaced with `wimenu` and the latter will eventually be part of wmii-lua functionality.

*How to get it?*

To get the sources use git...

    git clone git://github.com/bartman/wmii-lua.git

To build and install wmii-lua you have several choices.  See the README.

Also note that there are two streams of development on wmii-lua.

1) the [master branch](http://github.com/bartman/wmii-lua/tree/master) will track
   upstream *libixp* and *wmii* source and will be the source of the next release.

2) the [wip-multihead branch](http://github.com/bartman/wmii-lua/tree/wip-multihead)
   (where *wip* stands for *work in progress* and it to be considered alpha software)
   will get my multihead hacks.  My main goal here is to have a tag span only
   a single screen, not multiple screens as with default wmii.  This work includes
   changes to *wmii-lua* and *wmii* ... run at your own risk.  Ask on IRC for details.

To switch to the `wip-multihead` branch use ...

    git checkout -b wip-multihead -t origin/wip-multihead

*How to get help?*

Visist `#wmiirc-lua` IRC channel on `oftc.net`.

There is also a [mailing list](http://groups.google.ca/group/wmii-lua) for wmiirc-lua.
Subscribe by emailing *wmii-lua-subscribe@googlegroups.com*.

<SCRIPT type='text/javascript' language='JavaScript' src='http://www.ohloh.net/projects/8254/badge_js'></SCRIPT>