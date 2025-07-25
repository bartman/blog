+++
title = "wmiirc-lua v0.2.8 release"
date = "2009-05-09T21:26:48-04:00"
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

I've packaged up the recent changes made to [wmiirc-lua]{tag/wmiirc-lua}
and released a new version.

This release is mostly about bug fixes, and moving things around.  Particularly, I've 
[moved the project to github]{wmiirc-lua-github}, and also the new configuration
files live in `~/.wmii-lua` not `~/.wmii-3.5` (which clearly didn't make sense).

There are many fixes to the packaging and startup scripts to make things more robust.  I've
also revisited and fixed building Debian packages (at least for Debian/Lenny).

If you've used the [kitchen sink]{wmiirc-lua-kitchen-sink} repository you should note that
this repository is being deprecated in favour of storing the *wmii* and *libixp* repositories
as submodules of wmii-lua -- so no need for a container repo like the kitchen sink.

<!--more-->

*What is it?*

Wmiirc-lua is an event loop manager for the [wmii](http://www.suckless.org/wiki/wmii)
tiling window manager.  As the name suggests it's written in Lua, and strives to
have a low system overhead.

*How to get it?*

*wmii-lua* is developed and distributed via git.  You can obtain it from one of these git
repositories:

  * github: `git://github.com/bartman/wmii-lua.git` [browse](http://github.com/bartman/wmii-lua/)
  * jukie: `git://git.jukie.net/wmii-lua.git/` [browse](http://gitweb.jukie.net/wmii-lua.git)

You should read the 
[README](http://github.com/bartman/wmii-lua/blob/e81fa5104634551a8b87644663c92b15c6fd15b3/README)
file to get more information on how to get it and install it.

*Changes since v0.2.7*

  * move user configuration to `~/.wmii-lua`
  * switch to github for hosting
  * build changes for handling submodules in `ext` dir
  * less dependency on lua version
  * less dependency on wmii version (can run with Debian wmii-3.6)
  * improve installation and start scripts (don't need bash)
  * added view_workdir plugin (missing file in last release)
  * using wimenu if available (wimenu replaces dmenu)
  * many misc bugs fixed

*Debianization*

I've got things building with [git-buildpackage](http://honk.sigxcpu.org/projects/git-buildpackage/manual-html/gbp.building.html).
The only problem I ran into was that the Debian `libixp` is not built with `-fPIC`.  I'll
need to resolve that upstream.  For now you might need to rebuild your `libixp`:

        sudo apt-get build-dep libixp
        apt-get source libixp
        cd libixp-0.4
        sed -i -e 's/FLAGS = -g/FLAGS = -fPIC -g/' config.mk
        dpkg-buildpackage -b -nc
        sudo dpkg -i ../libixp_0.4-3_*.deb

Then you can build the wmiirc-lua package:

        git clone git://github.com/bartman/wmii-lua.git
        git checkout -b debian -t origin/debian
        git-buildpackage
        sudo dpkg -i ../build-area/wmiirc-lua_0.2.8-1_amd64.deb
        install-wmiirc-lua

Also, Rafael Laboissiere offered to sponsor wmiirc-lua to be an official package in Debian.
I hope you can let me know if the above works for you at all so I can follow up on that.

*How to get help?*

Visist `#wmiirc-lua` IRC channel on `oftc.net`.

There is also a [mailing list](http://groups.google.ca/group/wmii-lua) for wmiirc-lua.
Subscribe by emailing *wmii-lua-subscribe@googlegroups.com*.

<SCRIPT type='text/javascript' language='JavaScript' src='http://www.ohloh.net/projects/8254/badge_js'></SCRIPT>
