+++
title = "switching to abiword"
date = "2007-08-21T14:20:38-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['vi', 'abiword']
keywords = ['vi', 'abiword']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

Someone on the [#oclug](http://oclug.on.ca) channel said today:

  *Mind you, and vim-keybindings add-on for OOo would be nice.*

So I did the natural thing I googled for it.  I am already using vi-bindings
in firefox (vimperator) and in zsh.

I came accords a link on [using vi shortcuts in abiword](http://linuxmafia.com/faq/Apps/abiword-vi-mode.html), which
was instantly interesting to me.  I tried the procedure and it didn't work.  However,
making the following change did work...

        --- .AbiSuite/AbiWord.Profile-original	2007-08-21 14:18:02.278538328 -0400
        +++ .AbiSuite/AbiWord.Profile	2007-08-21 14:20:52.738536739 -0400
        @@ -98,10 +98,8 @@
         
                <Scheme
                        name="_custom_"
        +               KeyBindings="viEdit"
                        />
         
                <Recent

And now I have modal editing support in an office suite.  I still have to play with it to see if
I find it useful... but initially it looks great.