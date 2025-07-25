+++
title = "vim7 from source"
date = "2006-03-28T16:51:53-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['vim', 'linux']
keywords = ['vim', 'linux']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I found a bug in vim6.4 (my comment block was too big and the line after the comment block was not left-justified) and wanted to see if vim7 had a fix.

<!--more-->

Here are the steps I used to build/install my vim.

1. get dependencies

        $ apt-get build-dep vim


2. get vim7

        $ cvs -z3 -d:pserver:anonymous@cvs.sf.net:/cvsroot/vim checkout vim7

    or

        $ svn co https://svn.sourceforge.net/svnroot/vim/vim7

3. configure

        $ CFLAGS="-O2 -march=pentium-m -mtune=pentium-m -g -Wall" ./configure --prefix=/usr/local \
          --mandir='${prefix}'/share/man --with-compiledby="bart@jukie.net" --enable-gpm --enable-cscope \
          --with-features=big --enable-multibyte --with-x --enable-xim --enable-fontset --enable-gui=gnome2 \
          --enable-perlinterp --enable-pythoninterp --enable-rubyinterp --enable-tclinterp --program-suffix=7

    ... mostly from debian's vim 6.4 package except for using my `-march` and `-mtune` and `--prefix`.  Use 
    `-mcpu=` instead of `-mtune=` for gcc-3.x.


4. build

        $ make


5. install

        $ sudo make install


6. fix install

    ...for some reason `--program-suffix` didn't work.

        $ sudo ln -s vim /usr/local/bin/vim7


It took about 5 minutes to build on my laptop.  That's about the same amount of time it takes emacs to start up ... :)

