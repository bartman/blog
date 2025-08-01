+++
title = "tags/cscope for system headers"
date = "2006-08-18T15:05:16-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['code', 'vim', 'tags']
keywords = ['code', 'vim', 'tags']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I love tags files for in coding, and enjoy using the tag feature in [vim]{tag/vim} as well as the derived
tag-based completion.  I do a lot of my development in the kernel, so all I usually have to do is
put /usr/src/linux into my vim tags configuration.

Sometimes I have to do some user space hacking too, and I often forget all the names of *glib* and *pthread* library 
functions.  Having a system wide tags file is very very useful.  Below is a Makefile that I carry around with me
and place in /usr/include to keep my system tags in sync.

<!--more-->

        $ cat /usr/include/Makefile
        all: cscope.out tags

        cscope.out: cscope.files
                cscope -P`pwd` -b

        cscope.files:
                find . -name '*.h' > cscope.files

        tags: cscope.files
                rm -f tags
                xargs -n100 ctags -a < cscope.files

In my [vimrc](/~bart/conf/vimrc), I just have a line that sucks that in:

        :set tags=./tags,tags,../tags,../../tags,../../../tags,../../../../tags,/usr/src/linux/tags,/usr/include/tags

... as well as multiple other directories.  The first few just make sure that I can find my tags in the current
project I happen to be in... irregardless of how many directories I have descended into the project tree.
