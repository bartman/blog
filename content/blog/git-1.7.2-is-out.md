+++
title = "git 1.7.2 is out"
date = "2010-07-23T13:45:22-04:00"
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

[Just announced](http://gitlog.wordpress.com/2010/07/22/git-1-7-2/) is release of [Git version 1.7.2](http://git.kernel.org/?p=git/git.git;a=tag;h=refs/tags/v1.7.2).

Scanning through the [ReleaseNotes](http://git.kernel.org/?p=git/git.git;a=blob;f=Documentation/RelNotes-1.7.2.txt;h=15cf01178c1f653230c8f718ef7024b147ecacf9;hb=64fdc08dac6694d1e754580e7acb82dfa4988bb9) the following look interesting:

 - `git -c var=val` will override config
 - `git show :/pattern` now uses regex
 - `git` no longer squelches if it doesn't find .git (useful when using in PS1)
 - `git checkout --orphan name` makes a new root branch (no parent)
 - `git cherry-pick` can now be given a list of refs
 - `git log --decorate` learned to colour more things

