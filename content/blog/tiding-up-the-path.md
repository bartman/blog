+++
title = "tiding up the PATH"
date = "2009-06-09T00:02:08-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['zsh']
keywords = ['zsh']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I have previously noticed that loading up the list of application available in `$PATH` took a long
time in [wmii-lua]{tag/wmiirc-lua}.  I recently found out that it was related to me having multiple
duplicates in my [zsh]{tag/zsh} environment.

To clean this up I [added the following](http://www.jukie.net/~bart/conf/zsh.d/S99_tidy) to my
zsh configuration:

        typeset -U path cdpath manpath fpath

This removes duplicates from the `PATH`, `CDPATH`, `MANPATH`, and `FPATH` environment variables.

Well, technically it removes duplicates from the `path`, `cdpath`, `manpath`, and `fpath` arrays;
but these are treated special and updating them automatically generates their respective `:`-delimited
environment variables.

Zsh rocks!