+++
title = "automatic version creation with git"
date = "2006-10-20T14:54:37-04:00"
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

[openswan](http://www.openswan.org/) is going through a process of redefining what their versions numbers will mean... what's
stable, what's testing, what's devel, etc.

I participated in the discovery of how to do this *automagically* from git release tags.  Patrick was so happy with the results
that the conversation ended with ...

        14:49 <patlap> C'mon bart, blog it :-)

... and how can I tell the CEO of [Xelerance](http://www.xelerance.com/) "no"  :)

<!--more-->

We started off by looking at what git can tell us about the current release:

   * `git-rev-parse <id>` tells up what the ID of the `<id>` is, we can find out the current commit's 
      ID by using HEAD (or nothing at all)
   * `git-rev-list <id>..HEAD` tells us what the commits were between the `<id>` and the current commit
   * `git-describe <id>` shows us, in a nice format, a unique description of the commit.

Using all of this together Patrick came up with:

        BRANCH=`git-describe | awk -F'-g[0-9a-fA-F]+' '{print $1}'`
        COMMIT=`git-rev-parse HEAD | awk '{print substr($1,0,8)}'`
        INCREMENT=`git-rev-list $BRANCH..HEAD | wc -l | awk '{print $1}'` 
        TGZ="openswan-$BRANCH-($INCREMENT)-g$COMMIT.tgz"

What this attempts to achieve is create a tar ball name that describes the release using the last tag, the number of builds since the tag was made, and the short commit ID.  Here is the breakdown of the bits:

   * *BRANCH* will tell us what major release this is a part of,
   * *INCREMENT* is a pseudo build number (it's really the number of commits since the last release), and
   * g*COMMIT* is the short ID of the commit that generated the build.
