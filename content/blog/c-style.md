+++
title = "C style"
date = "2006-12-18T10:02:19-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['code', 'linux', 'c']
keywords = ['code', 'linux', 'c']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

A new comer to my place of work was asking me how he can improve his 
code style.  Here are some suggestions I had for him.

<!--more-->

- try to keep lines no wider then 80 columns

  Compilers don't care, but according to what was taught in my  psychology class
  people get best reading performance when there are 60 characters per line.

  Also when you print, code is most legible if the code is 80 char's accross.

- keep nesting to a minimum...

  Again, compilers don't care, but it again helps legibility.
  
  It's hard to keep in your brain what code is doing if you nest more
  then 3-4 times.
  
  If you need to nest more then 3 times (ie you've tabbed in 4 times)
  then you really need a function to capture some of the functionality.
  
  Starting a new function has an instant benefit of being self
  documenting because you capture the name -- which should give away 
  what the function does -- and also you provide the lift of inputs and
  outputs by the means of the arguments and return.

  It also helps code reuse as you can use that same function from multiple 
  places.  You should rarely need to copy-and-paste code.

- try to keep functions short...

  This goes with the above.  The less you nest, the less you need to
  cram into functions.

  It was recommended to me that the entire function should fit on a
  screen.  Say 50 lines.  I don't always make it, but I try.

[vim](http://www.vim.org) can do some of this for you.  In particular 
it can warn that a line is too long.  

        set textwidth=78          " Set the line wrap length
        match Error80 /\%>80v.\+/ " highlight anything past 80 in red

        if has("gui_running")
            hi Error80   gui=NONE   guifg=#ffffff   guibg=#6e2e2e
        else
            exec "hi Error80   cterm=NONE   ctermfg=" . <SID>X(79) . " ctermbg=" . <SID>X(32)
        endif

See my [vimrc](/~bart/conf/vimrc), [c.vim](/~bart/conf/vim/c.vim), 
and [my_inkpot.vim](/~bart/conf/vim/colors/my_inkpot.vim) (my colour scheme).
