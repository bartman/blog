+++
title = "generating html colourized sourcecode"
date = "2006-06-01T23:40:10-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['vim', 'html', 'bash']
keywords = ['vim', 'html', 'bash']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I wanted to have vim colouring of source files in html format.  There is

[Text::VimColor](http://search.cpan.org/~geoffr/Text-VimColor/lib/Text/VimColor.pm)

perl module, but it's not in Debian.  



Vim has a `:TOhtml` command (see [:h syntax](http://www.vim.org/htmldoc/syntax.html)). I wrote a [tohtml](/~bart/scripts/tohtml/) shell script to solve the problem using `:TOhtml`.  And yes, the html was generated with itself.
