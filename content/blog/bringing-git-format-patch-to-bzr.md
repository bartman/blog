+++
title = "bringing git-format-patch to bzr"
date = "2009-06-22T21:40:23-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['git', 'bzr']
keywords = ['git', 'bzr']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

It should be of no surprise to readers of this blog that I am a fan of Git.  If you know me, you will
also know that I am no fan of Bzr.

I was working on something today and wanted to export a patch... you know, like `git format-patch` does.
Well, bzr does not seem to have an equivalent.

<!--more-->

I had to hack something together in a shell script... [bzr-export-patch](/~bart/scripts/bzr-export-patch/bzr-export-patch.html)
is a crude approximation of `git format-patch`.  ([download](/~bart/scripts/bzr-export-patch/bzr-export-patch))

Here is what it looks like...

        # bzr-export-patch 
        show_help - export a revno as a patch

        show_help [ --stdout ] <revno>[..<revno>]

To dump a patch to stdout...

        # bzr-export-patch --stdout 200
        revno 200
        From: ... <...@...>
        Date: ...
        Branch-Nick: ...
        Subject: ...
        ...

You can also dump out files like with `git format-patch`...

        # bzr-export-patch 295
        00295-remove-cpu-from-templte-parameters-.patch

... but I still don't like bzr.