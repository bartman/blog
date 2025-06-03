+++
title = "zsh fun"
date = "2007-04-18T15:58:57-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['zsh', 'shell']
keywords = ['zsh', 'shell']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I have been playing with zsh a bit today.  Here is the outcome:

 - use vim to view man pages; this requires [manpageview.vim](http://www.vim.org/scripts/script.php?script_id=489)
   vim plugin.

        function vman() { vim -c ":RMan ${*}" ; }

 - these function store the current directory in X clipboard and then restore the path from the clipboard, which 
    is handy when you want to restore the path in another xterm...

        function xpwd () { pwd | xclip -i ; xclip -o ; }
        function xcd () { cd `xclip -o` ; }