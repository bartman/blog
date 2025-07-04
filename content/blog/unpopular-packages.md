+++
title = "unpopular debian packages on my system"
date = "2007-06-18T22:06:49-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['debian', 'apt', 'dpkg']
keywords = ['debian', 'apt', 'dpkg']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

Using the [ept-cache](http://www.enricozini.org//2007/tips/conversation-starter.html) utility
advertised on [joey's blog](http://kitenet.net/~joey/blog/entry/night_venue__47__ept/) I was able to have a look
at some packages on my site that are likely not on your system.

To get packages of inverse popularity which you have installed run:

        ept-cache search -t clean -s t- | less

Of interest are the following.

<!--more-->

The main components of my desktop are:

 * rxvt-unicode - RXVT-like terminal emulator with Unicode support
 * zsh - A shell with lots of features
 * vim-full - Vi IMproved - enhanced vi editor - full fledged version
 * unclutter - hides the cursor in X after a period of inactivity
 * mpd - Music Player Daemon
 * ncmpc - text based audio player
 * akregator - RSS feed aggregator for KDE

My window manager is *wmii*, which is not on the list, but I use [wmii+ruby](http://www.jukie.net/~bart/blog/wmii-with-ruby)
which requires ruby:

 * ruby1.9 - Interpreter of object-oriented scripting language Ruby 1.9
 * ri1.9 - Ruby Interactive reference (for Ruby 1.9)
 * irb1.9 - Interactive Ruby (for Ruby 1.9)

Some utils I use often for quick conversion:

 * rpncalc - RPN calculator trying to emulate an HP28S
 * units - converts between different systems of units
 * hex - hexadecimal dumping tool for Japanese

I do mostly C development so *ccache* and *distcc* are an absolute must:

 * distcc - Simple distributed compiler client and server

Also, all my development is kept in git.  Here are some SCM packages on the list:

 * git-core - content addressable filesystem
 * gquilt - graphical wrapper for quilt and/or mercurial
 * git-load-dirs - Import upstream archives into git
 * commit-tool - GUI commit tool for various Source Control Management systems
 * quilt - Tool to work with series of patches
 * meld - graphical tool to diff and merge files
 * tailor - migrate changesets between version control systems

Here is a nice documentation system that is used by git internally:

 * asciidoc - Highly configurable text format for writing documentation

This is a sane replacement for *info*:

 * pinfo - An alternative info-file viewer

When I feel like torturing myself I play with lua.

 * lua5.1 - Simple, extensible, embeddable programming language

These are useful for building VMs:

 * uml-utilities - User-mode Linux (utility programs)
 * configure-debian - central configuration program for packages using debconf
 * dchroot - Execute commands in a chroot environment

There are tools on the list which I am surprised made it to the top:

 * e2tools - utilities for manipulating files in an ext2/ext3 filesystem
 * hddtemp - Utility to monitor the temperature of your hard drive
 * smartmontools - control and monitor storage systems using S.M.A.R.T.
 * mdadm - tool to administer Linux MD arrays (software RAID)
 * sg3-utils - Utilities for working with generic SCSI devices

Here are some things that I wouldn't have, but I was asked to work on projects that are somehow related:

 * pcscd - Middleware to access a smart card using PC/SC (daemon side)
 * lighttpd - A fast webserver with minimal memory footprint
 * tcpreplay - Tool to replay saved tcpdump files at arbitrary speeds

Here are some extras

 * moto4lin - file manager and seem editor for Motorola phones (like C380/C650)
 * gnupg-agent - GNU privacy guard - password agent
 * schedtool - Queries/alters process' scheduling policy and CPU affinity
 * elfutils - collection of utilities to handle ELF objects
 * ethtool - display or change ethernet card settings
 * nscd - GNU C Library: Name Service Cache Daemon
 * scrot - command line screen capture utility


