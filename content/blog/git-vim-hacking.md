+++
title = "git-vim hacking"
date = "2009-06-08T01:04:05-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['git', 'vim', 'vimgit']
keywords = ['git', 'vim', 'vimgit']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I did some hacking on [my fork](http://github.com/bartman/git-vim/tree) on
[git-vim](http://github.com/motemen/git-vim/tree).  I am impressed how well
[things work](http://www.osnews.com/story/21556/Using_Git_with_Vim).
*motemen*, the upstream author, did a really great job setting things up.

I've been mostly tyoing with command handling and completion this evening.
I want to make that I could type `:git diff ma<tab>` and have it do the
rigth thing... it seems to work.

Next, I need to integrate my [other](http://www.vim.org/scripts/script.php?script_id=1846)
[git](http://www.vim.org/scripts/script.php?script_id=2185) [hacks](http://www.jukie.net/~bart/conf/vim/plugin/)
and also [others](http://consttype.org/cgi/gitweb.cgi?p=githistorybrowser.git;a=summary) that seem interesting.
I should also see if I can get the upstream author to consider including any of it.
