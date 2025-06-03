+++
title = "vimgrep alias"
date = "2007-04-18T09:41:51-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['vim', 'shell', 'zsh']
keywords = ['vim', 'shell', 'zsh']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I've been using Solaris recently... since yesterday.  First reactions: *How can anyone use their command line tools!?*

Fortunately the system I was on had zsh and vim.

Here is a macro I use to avoid Solaris grep:

        function vimgrep () { tmp="$@" ; vim -c "vimgrep $tmp | copen" ; }

(I could not figure out a way to do it w/o the `tmp` variable)

Now you can do things like:

        vimgrep pattern 'dir/**/*.c'