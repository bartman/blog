+++
title = "google-codesearch from vim"
date = "2006-10-07T15:18:02-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['vim', 'google', 'code']
keywords = ['vim', 'google', 'code']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I just saw [vim hint 1354](http://www.vim.org/tips/tip.php?tip_id=1354) pop up in 
my RSS feed.  It's a neat idea... but it's hard to decide what documentation should 
be looked up.  Simply using the file type is insufficient.

It turns out that it's a lot more awesome to do [google codesearch](http://www.google.com/codesearch)
lookup on it.

<!--more-->

        function! OnlineDoc()
            let s:browser = "firefox"
            let s:wordUnderCursor = expand("<cword>")

            if &ft == "cpp" || &ft == "c" || &ft == "ruby" || &ft == "php" || &ft == "python"
                let s:url = "http://www.google.com/codesearch?q=".s:wordUnderCursor."+lang:".&ft
            elseif &ft == "vim"
                let s:url = "http://www.google.com/codesearch?q=".s:wordUnderCursor
            else
                return
            endif

            let s:cmd = "silent !" . s:browser . " " . s:url
            execute  s:cmd
            redraw!
        endfunction

        " online doc search
        map <LocalLeader>k :call OnlineDoc()<CR>

My `<LocalLeader>` is mapped to a coma; see my [.vimrc](http://www.jukie.net/~bart/conf/vimrc) for details.  I use `,k` as my 
*codesearch* shortcut because I already use `K` to look up man pages... so I will be less likely to forget this one.

**NOTE**: I was informed by Blake Akers, of Webology, that this snippet doesn't work since Google CodeSearch was abandoned in 2011.  Please
refer to [History of Google CodeSearch](https://www.webology.technology/2018/07/21/history-of-google-codesearch/) for an alternative:
[codesearch.com](https://searchcode.com/).