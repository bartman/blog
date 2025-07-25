+++
title = "gitdiff.vba v2"
date = "2007-05-02T21:19:41-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['vim', 'git', 'vimgit']
keywords = ['vim', 'git', 'vimgit']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I released version 2 of my [gitdiff.vba](http://www.vim.org/scripts/script.php?script_id=1846)
vim script.

It now supports two features:

   - `:GITDiff [commitish]`

     Split the vim window vertically, display the HEAD, or some other changeset, version of the file in the split, then diff them.

   - `:GITChanges [commitish]`

     Highlight lines that were changed since the HEAD or some other changeset.

I also started using the [VimBall](http://www.vim.org/scripts/script.php?script_id=1502) script, which is a package format
for vim scripts.  So to install it, you need to first have the vimball extension.  Further, if you have the 
[GetLatestVimScripts](http://www.vim.org/scripts/script.php?script_id=642) you can use the `:GLVS` commands to
automatically upgrade your packages.

Next, I want to merge in [maddcoder's](http://madism.org/~madcoder/dotfiles/vim/ftplugin/git.vim)
[gitcommit.vim](http://www.jukie.net/~bart/conf/vim/ftplugin/gitcommit.vim) script, and call the 
result something more **grand** like 'vim-gittools.vba'.