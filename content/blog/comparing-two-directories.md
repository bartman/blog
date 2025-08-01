+++
title = "comparing two directories"
date = "2007-09-13T13:08:38-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['shell', 'linux']
keywords = ['shell', 'linux']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

In one of the project I am working on we have the build environment tarred up and stored 
in tgz files and committed in SVN.  To avoid updating the same 300M tarball we decided to
added incremental tarballs each time that we add new software to the build environment.
But that's not the important bit...

I wanted to figure out what software was installed since the last tarballs were extracted.  To
do this I need to compare two directories and create a new tarball with all the new files.  How
do you diff two directories pro grammatically?

I came up with this...

        cp -ax orig-dir new-dir

        ... do whatever in new-dir ...

        diff -u <(find orig-dir -printf "%p %t\n" | cut -d / -f 2-) \
                <(find new-dir -printf "%p %t\n" | cut -d / -f 2-) \
        | grep -v '^[+-]'

And then I found out that I can do it with rsync...

        rsync -a orig-dir/ new-dir/

        ... do whatever in new-dir ...

        rsync -av --dry-run orig-dir/ new-dir/