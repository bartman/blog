+++
title = "four steps to reproducible Debian installs"
date = "2008-07-13T14:34:29-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['debian', 'desktop', 'apt', 'dpkg']
keywords = ['debian', 'desktop', 'apt', 'dpkg']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

For *ever* now some friends and I have been talking about making *essential* packages,
which would pull in all the tools that we often use on Debian.  So here goes...

With the power of the *equivs* package, this is actually a very short procedure.

<!--more-->

We start off and install equivs...

        $ apt-get install equivs

Then we setup a place to build the packages...

        $ mkdir -p ~/essentials
        $ cd ~/essentials

And run *equivs-control* to start a `Debian/control` file:

        $ equivs-control bartman-control

The tool will create a template that you need to fill in, most lines can be ignored.  You will want to 
edit this file to your liking.

Here is [mine](/~bart/essential/bartman-essential); it includes packages that I end up installing
at some point on any desktop/workstation.

The next step is to build the deb...

        $ equivs-build bartman-essential
        ...
        dpkg-deb: building package `bartman-essential' in `../bartman-essential_1.0_all.deb'.

And that's it.  To install this on a new system you can run:

        dpkg -i bartman-essential_1.0_all.deb
        apt-get install -f

And you're done.