+++
title = "cool debian tools"
date = "2004-03-05T16:32:16-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['debian']
keywords = ['debian']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

<p>A few of us, Debian veterans, started naming off cool tools and tricks on IRC
for the benefit of a newbie.  One person suggested to put this list up 
somewhere...  so here goes:</p>

<ul>
<li>apt-file - APT package searching utility -- command-line interface
<li>auto-apt - package search by file and on-demand package installation tool
<li>apt-show-versions - Lists available package versions with distribution
<li>cron-apt - Automatic update of packages using apt
<li>deborphan - Find orphaned libraries
<li>apt-listchanges - Display new Debian changelog entries from .deb archives
<li>apt-spy - writes a sources.list file based on bandwidth tests
<li>dpkg-repack - generates a .deb from an installed package
</ul>

<p>Tools for keeners and developers:</p>

<ul>
<li>devscripts - Scripts to make the life of a Debian Package maintainer easier
<li>apt-build - Frontend to apt to build, optimize and install packages
<li>apt-src - manage Debian source packages
<li>kernel-package - A utility for building Linux kernel related Debian packages
<li>debconf-copydb (1)   - copy a debconf database (debconf package)
</ul>

<p>And here are some hidden trix:</p>

<ul>
<li>extending sources.list with <a href=http://apt-get.org>apt-get.org</a>
<li>apt-cache policy <i>package</i> - shows what versions of a <i>package</i> are available
<li>installing from multiple releases <a href=http://www.argon.org/~roderick/apt-pinning.html>apt-pinning</a>
</ul>

Have more? ...please let me know.