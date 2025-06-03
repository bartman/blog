+++
title = "two terminals one PWD"
date = "2009-05-04T10:16:05-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['shell']
keywords = ['shell']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I often find myself needing multiple terminals (*urxvt*) with shells (*zsh*) in the same directory.  The step of entering that
directory is teadieous, especially if there are many terminals involved.  I have a few tricks that I use to
make this faster.

<!--more-->

First, I use two shell functions to store the path in the X buffer:

        xpwd () {
            echo $PWD | xclip -i
            xclip -o
        }

        xcd () {
            cd `xclip -o`
        }

I'd run `xpwd` first in an existing terminal, then start, or switch to, another terminal and run `xcd`.
This relies on the `xclip` program (`apt-get install xclip`) which gives the shell access to your X clipboard.

Second, I added `Alt-'` (or `Mod1-apostrophe`) to [wmii-lua](http://www.jukie.net/~bart/blog/tag/wmiirc-lua).
The [view_workdir plugin](http://github.com/bartman/wmii-lua/blob/c4ee18bcb859e9e6e436edc87f645bfa0e730eba/src/plugins/view_workdir.lua)
will [keep track of directory changes](http://www.jukie.net/~bart/conf/zsh.d/S58_wmii) made in a terminal on
that tag.  When you push `Alt-'` *wmii-lua* will open up a terminal in that same directory.

I have another idea for wmii-lua: to be able to send the same input to all clients in the same view... but that's
not possible yet.