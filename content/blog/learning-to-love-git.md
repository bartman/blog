+++
title = "learning to love git"
date = "2006-05-25T23:41:48-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['git', 'scm']
keywords = ['git', 'scm']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I've been working for [Xelerance](http://www.xelerance.com/), [mcr](http://www.sandelman.ca/mcr/)'s company, for a couple of weeks now.  The project I am working on is mostly bringing KLIPS, [openswan](http://www.openswan.org/) ipsec kernel module, into the 21st centry.  Since KLIPS is a patch against the [Linux kernel](http://kernel.org/git/), it makes sense to keep it in [git](http://git.or.cz/).

<!--more-->

When Linus first said that he was working on GIT, I was very interested.  I knew that Linus liked [BitKeeper](http://bitkeeper.org), as I did, so anything that he came up with should be similar in design to BK, or at least take from the strengths of BK.  The GIT system quickly became very complex.  I liked bk because it was easy to do the simple things, GIT made it very hard to get into.  And, while I used git for fetching kernels, I've been avoiding it for personal SCM usage.

Now, I had to embrace it for work purposes :) ... and I must say that I am beginning to like it.  GIT has some very cool features, and it makes a good use of repository branches -- something I never understood the need for while using BK.  I still find GIT to be very "plumbing" friendly, but as I go it gets easier.  [Cogito](http://kernel.org/pub/software/scm/cogito/README) certainly helps a bit, but I've found some git-only commands (ie not wrapped in cogito interface) too powerful to make me use strictly cogito.

Anyway, here are some links I found useful on my recent git adventures:

 - [kernel.org/git](http://kernel.org/git/) has a lot of kernel branches, and links to documentation
   - [overview of git](http://git.or.cz/)
   - [oficial docs](http://kernel.org/pub/software/scm/git/docs/)
     - [GIT Howto Index](http://www.kernel.org/pub/software/scm/git/docs/howto-index.html)
 - [GIT Guide](http://wiki.sourcemage.org/Git_Guide) from sourcemange.org
 - [Wine developers guide to GIT](http://wiki.winehq.org/GitWine)
 - [Kernel Hacker's Guide to git](http://linux.yyz.us/git-howto.html)
 - [Git Cheat Sheet](http://www.itp.tuwien.ac.at/~mattems/blog/2006/07/03#git_howto) - Maximilian Attems enumerates a few frequently used git commands

*(I wil try to update this as I find new stuff)*