+++
title = "fixing vim's [[ and ]] for bad code"
date = "2007-03-28T12:36:31-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['vim']
keywords = ['vim']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I just added something to my [.vim/c.vim](http://www.jukie.net/~bart/conf/vim/c.vim)
to make `[[` and `]]` work even if the code does not have `{` on new lines.

        function! FindFunctionDefinition(dir)
                let l:lastpattern = @/
                if a:dir==-1
                        ?^\(\a.*(\_[^\)]*) *\)\{,1\}{
                elseif a:dir==1
                        /^\(\a.*(\_[^\)]*) *\)\{,1\}{
                endif 
                let @/ = l:lastpattern
        endfunction

        nmap [[ :call FindFunctionDefinition(-1)<CR>
        nmap ]] :call FindFunctionDefinition(1)<CR>

This will make `[[` and `]]` find the next and previous function even if the first `{` is not in the first column.