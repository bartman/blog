+++
title = "installing git man pages quickly"
date = "2008-09-15T11:29:59-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['git']
keywords = ['git']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I just upgraded git to get a fix [for a diff buffer overflow](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2008-3546).
I built the git binaries, but this box is too slow to rebuild the man pages.

Fortunately those are already prebuilt in a separate branch.  One way to install them without rebuilding them locally is to:

        # in a clone of git://git.kernel.org/pub/scm/git/git.git
        
        git archive --format=tar origin/man | sudo tar -x -C /usr/share/man/ -vf -

... with which I don't have to rebuild man pages locally.  Git rocks!