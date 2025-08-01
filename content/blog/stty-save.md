+++
title = "fixing your terminal"
date = "2006-09-02T13:57:22-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['unix', 'screen']
keywords = ['unix', 'screen']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I sometimes get into an odd state in screen.  I am not sure what causes it, but it usually happens after I ctrl-C out of a console tool that
wanted to do something odd with termcap.  In this odd state the terminal no longer responds to the *default* control characters, like ctrl-H for 
erase.  

Usually running `reset` does the trick and restores the terminal configuration.  Well in screen, I found, this does not always work.  I googled a bit 
and found a pretty neat article titled [Unix Tip: Using stty to Your Advantage](http://open.itworld.com/5040/nls_unix_usingsetty_060223/page_1.html),
which shows how to save the current state of the terminal and restore it later.

To store the configuration:

        $ echo stty `stty -g` > restore-tty
        $ chmod 755 restore-tty 

and when things mess up...

        $ ./restore-tty

It fixes my problems.