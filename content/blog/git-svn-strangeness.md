+++
title = "git-svn strangeness"
date = "2008-09-16T15:51:13-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['git', 'svn']
keywords = ['git', 'svn']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

As awesome as `git-svn` is, I had it fail today with this message:

        Last fetched revision of refs/remotes/branches/foo was r19307, but we are about to fetch: r19307!

To which I said: "WTF?".  I still don't know what it means, but I can share with you how I recovered it.

It turns out that git-svn is quite capable of recovering from this.  You just have to remove its meta-data
for the offending branch, and resync with SVN.

        rm -f .git/svn/branches/foo/.rev_*
        git svn fetch

I actually had multiple branches in this bad state -- but not all of them -- and I had to repeat it for
all those that it complained about.

**UPDATE:** I upgraded to git v1.6.0.2 and the problem went away.