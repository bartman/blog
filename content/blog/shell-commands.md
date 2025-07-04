+++
title = "shell commands"
date = "2006-09-28T02:08:13-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['bash', 'linux']
keywords = ['bash', 'linux']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I saw [this blog post](http://perldition.org/blog/post/450) by Debian's Florian Ragwitz, and ran my own list of most commonly used shell commands.  Here they are...

        history |awk '{print $2}'|awk 'BEGIN {FS="|"} {print $1}' | sort | uniq -c | sort -r | head -15
            627 git
            266 vim
             98 cd
             76 grep
             69 ls
             63 gitk
             60 ssh
             51 sudo
             47 vv
             47 apt-cache
             40 cat
             34 make
             33 patch
             30 rm
             25 man

<!--more-->

I use `git`, `gitk`, `vim`, and `make` constantly for work.  `git diff` will sometimes get piped into a file and later restored using `patch`.  I have several systems that I `ssh` to.  `sudo` usually precedes things like `apt-get install` and `apt-get upgrade`... that's where apt-cache came from.

The one thing that stands out is `vv`.  `vv` is a pager for shell command output based on `vim` and some bash scripting.  Checkout the [vv function](http://www.jukie.net/~bart/conf/bash.d/S101_common_tools.sh) in my bashrc.  It lets me run things like

        vv git diff file 
        vv git log origin..HEAD

which equate to

        git diff file | vim -R -
        git log origin..HEAD | vim -R -

`vv` is an evolution of my `v` command prefix.  While `vv` will always go into the `vim` pager, `v` will only direct text into the pager if it's more then what would fit on the screen.  See the [least function](http://www.jukie.net/~bart/conf/bash.d/S101_common_tools.sh) which is used to decide when to go to a pager.