+++
title = "GITDiff vim plugin"
date = "2007-03-30T22:10:19-04:00"
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

Taking a TODO item off my list, I am adding a plugin to vim that splits the current
window and presents a diff between the current file and any revision of that file in
the current git repository.

<!--more-->

Take this script and put it into `.vim/plugin/gitdiff.vim` and rejoice.

        if exists("loaded_gitdiff") || &compatible
            finish
        endif
        let loaded_gitdiff = 1

        command! -nargs=? GITDiff :call s:GitDiff(<f-args>)

        function! s:GitDiff(...)
            if a:0 == 1
                let rev = a:1
            else
                let rev = 'HEAD'
            endif

            let ftype = &filetype

            let prefix = system("git rev-parse --show-prefix")
            let gitfile = substitute(prefix,'\n$','','') . expand("%")

            " Check out the revision to a temp file
            let tmpfile = tempname()
            let cmd = "git show  " . rev . ":" . gitfile . " > " . tmpfile
            let cmd_output = system(cmd)
            if v:shell_error && cmd_output != ""
                echohl WarningMsg | echon cmd_output
                return
            endif

            " Begin diff
            exe "vert diffsplit" . tmpfile
            exe "set filetype=" . ftype
            set foldmethod=diff
            wincmd l

        endfunction

To use it, run `:GITDiff` to see the differences the current file and it on `HEAD`, or 
`:GITDiff commitish` to see the differences made since some other commit, branch or tag.

And once you're done and closed the diff windows, you should run `:diffoff` to disable the diff highlights.

This is based on similar scripts for
[rcs](http://www.axisym3.net/jdany/wp-content/vim/rcsdiff.vim), 
[cvs](http://www.axisym3.net/jdany/wp-content/vim/cvsdiff.vim), and
[svn](http://www.axisym3.net/jdany/wp-content/vim/svndiff.vim)
by [Juan Frias](http://www.axisym3.net/jdany/vim-the-editor/).

**More links:**

 * [vim commit message highlighting](http://madism.org/~madcoder/dotfiles/vim/ftplugin/git.vim)

   I copy this one into `~/.vim/ftplugin/gitcommit.vim` so that it matches the `~/.vim/syntax/gitconfig.vim` that I grom from `/usr/share/doc/git/`

   Then you have to add the following to your `.vimrc`:

        let git_diff_spawn_mode=2
        autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=gitcommit

   Or you can use MadCoder's [instructions](http://blog.madism.org/index.php/2006/10/17/109-vim-mode-for-git-commits).

 * handling [several revision control systems](http://mail.bitmover.com/pipermail/bitkeeper-users/2006-February/002375.html) in vim
