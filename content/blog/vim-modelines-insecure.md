+++
title = "vim modelines insecure"
date = "2007-05-10T13:45:51-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['vim', 'security']
keywords = ['vim', 'security']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I have previously disabled `modelines` in my [vimrc](/~bart/conf/vimrc), but had turned them on recently
only to learn today that they are subject to another [vulnerability](http://secunia.com/advisories/25182/).

I've seen [this before](http://www.guninski.com/vim1.html).  Enough is enough. :)

Fortunately, this [sparked a debate](http://marc.info/?l=vim-dev&m=117762581821298&w=2) on vim-dev mailing list.  One of 
the [outcomes](http://marc.info/?l=vim-dev&m=117828819017137&w=2) is a [vim script](http://www.vim.org/scripts/script.php?script_id=1876)
that [replaces the modeline parser](http://ciaranm.org/tag/securemodelines) in vim.  It is said to be a 
lot more strict about what it permits as valid modeline components and allows the user to control that in the vimrc.

You can grab [the script](http://www.vim.org/scripts/script.php?script_id=1876), put it in your `.vim/plugins/` directory
and turn off the built-in modelines parser:

        set modelines=0

Optionally you can set this variable to have the new parser show errors in parsing.

        let g:secure_modelines_verbose=1