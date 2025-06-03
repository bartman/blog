+++
title = "creating busybox symlinks"
date = "2008-10-11T08:16:38-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['busybox']
keywords = ['busybox']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

Busybox should have a `--create-symlinks-in=/sbin` feature, but for now...

        ./busybox --help | grep 'Currently defined functions:' -A30 | grep '^\s.*,' | tr , '\n' | xargs -n1 -i{} ln -s busybox {}

*update on 2012/03/22*:
Shawn Hicks points out that this works better (unverified by me):

        ./busybox --help | busybox grep 'Currently defined functions:' -A30 | busybox grep -v 'Currently defined functions:'|busybox tr , '\n'|busybox tr -d '\n\t'|busybox tr ' ' '\n'|busybox xargs -n 1 ln -s busybox

*update on 2012/10/07*:
Nicholas Fearnley further updates the recipe to this:

        ./busybox --help | busybox grep 'Currently defined functions:' -A300 | busybox grep -v 'Currently defined functions:' | busybox tr , '\n' | busybox xargs -n1 busybox ln -s busybox