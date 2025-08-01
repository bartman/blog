+++
title = "vim and linux CodingStyle"
date = "2007-02-09T17:26:06-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['vim', 'linux', 'kernel', 'c', 'code']
keywords = ['vim', 'linux', 'kernel', 'c', 'code']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

It would seem that either no one that codes for the [Linux kernel](http://www.kernel.org/) 
does so under [vim](http://www.vim.org), or if they do they don't have the time to share 
their vim configuration that doesn't conflict with the 
kernel's [CodingStyle](http://lxr.linux.no/source/Documentation/CodingStyle).

Below I will discuss some changes I had to make to my [.vimrc](/~bart/conf/vimrc) and 
[.vim/c.vim](/~bart/conf/vim/c.vim) to work with C efficiently.

<!--more-->

**Auto Commands**

I am using `BufEnter` *auto commands* to alter the my configuration based on the type of 
file I am editing.  This is a pretty old feature of vim.  Newer versions of vim provide 
a *ftplugin*'s for doing the same way with less effort.  For me the effort was already done.

To have vim use a different set of options for C files you would have something like this in
your `.vimrc`:

        set nocompatible                        " vim defaults, not vi!
        filetype on                             " automatic file type detection
        if has('autocmd')
                filetype plugin indent on

                autocmd BufEnter *.c,*.h,*.cpp,*.hpp,*.cc source ~/.vim/c.vim
        endif

The rest of this entry will talk about things I put into my `.vim/c.vim` file.

**Intenting**

Like everyone knows *tabs* are 8 spaces deep.  In addition to that, indentation of the first word
should be done with the *TAB* character and not with spaces.  You can drop tis into your config:

        set noexpandtab                         " use tabs, not spaces
        set tabstop=8                           " tabstops of 8
        set shiftwidth=8                        " indents of 8
        set textwidth=78                        " screen in 80 columns wide, wrap at 78

And while we are on the topic of indenting, the next few options make vim behave better when you are 
editing formated text:

        set autoindent smartindent              " turn on auto/smart indenting
        set smarttab                            " make <tab> and <backspace> smarter
        set backspace=eol,start,indent          " allow backspacing over indent, eol, & start

Vim has a feature which makes it indent code differently based on file type; here is how you would enable it:

        filetype plugin indent on

And some indenting macros...

        nmap <C-J> vip=                         " forces (re)indentation of a block of code

**Highlighting**

Turn on highlighting.  This is a must :)

        syntax on

I like to have my C99 & Linux kernel types show up different.  There are also some keywords that linux
kernel uses which should stand out.

        syn keyword cType uint ubyte ulong uint64_t uint32_t uint16_t uint8_t boolean_t int64_t int32_t int16_t int8_t u_int64_t u_int32_t u_int16_t u_int8_t
        syn keyword cOperator likely unlikely

Recall that text should not exceed 80 columns, have spaces as the indent, or have trailing 
spaces.  This will create three new Highlight classes that can be used by the `colorscheme`
to show you mistakes in the formatting:

        syn match ErrorLeadSpace /^ \+/         " highlight any leading spaces
        syn match ErrorTailSpace / \+$/         " highlight any trailing spaces
        match Error80            /\%>80v.\+/    " highlight anything past 80 in red

The above just creates rules for marking new regions.  To have them show up in different colours you have to 
modify your `colorscheme`... or use [my hack on inkpot](/~bart/conf/.vim/colors/my_inkpot.vim).  The changes
I made were to add...

        if has("gui_running")
                hi Error80        gui=NONE   guifg=#ffffff   guibg=#6e2e2e
                hi ErrorLeadSpace gui=NONE   guifg=#ffffff   guibg=#6e2e2e
                hi ErrorTailSpace gui=NONE   guifg=#ffffff   guibg=#6e2e2e
        else
                exec "hi Error80        cterm=NONE   ctermfg=" . <SID>X(79) . " ctermbg=" . <SID>X(32)
                exec "hi ErrorLeadSpace cterm=NONE   ctermfg=" . <SID>X(79) . " ctermbg=" . <SID>X(33)
                exec "hi ErrorTailSpace cterm=NONE   ctermfg=" . <SID>X(79) . " ctermbg=" . <SID>X(33)
        endif

**C formatting**

When editing C code in vim, the program can properly continue comment blocks and fix other.  The
first chunk, `formatoptions` deals primarily with text in code -- like comments.

        set formatoptions=tcqlron

Next we configure how to indent parts of the code.  Hopefully, this will format exactly as to 
the CodingStyle specifications (let me know if I missed something).  There are great examples
in the `:h cinoptions-values` part of the vim manual.

        set cinoptions=:0,l1,t0,g0

**Folds**

You can have vim hide code by folding it based on {} blocks.  Turn this on with

        set foldmethod=syntax

**tags**

Tags in vim allow you to jump between symbol usage and symbol definition.  I use the code belowto tell
vim where to locate `tags` files.  I tell it to search in the current directory, then upto 4 below, and 
then a few system locations like the running kernel tree and `/usr/include`.

        let $kernel_version=system('uname -r | tr -d "\n"')
        set tags=./tags,tags,../tags,../../tags,../../../tags,../../../../tags,/lib/modules/$kernel_version/build/tags,/usr/include/tags

I often update the tag indexes with a simple cron job:

        $ cat /etc/cron.daily/system-tags
        #!/bin/bash

        cd /usr/include
        find . -name '*.h' > cscope.files
        cscope -b
        rm -f tags
        cat cscope.files | xargs -n100 ctags -a 

        cd /lib/modules/$(uname -r)/build/
        make -j2 tags cscope

If you want to use `cscope`, I recommend the [cscope_quickfix](http://cscope.sourceforge.net/) plugin.


