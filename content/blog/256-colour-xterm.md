+++
title = "256 colour xterms"
date = "2006-08-24T22:48:42-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['xterm', 'linux', 'vim']
keywords = ['xterm', 'linux', 'vim']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

*Welcome to the 90's!  256 colours are here!*

It's pretty sad.  I got really excited today when I read the [Tip #1312: 256 colors in vim](http://www.vim.org/tips/tip.php?tip_id=1312).

I quickly installed the few colour schemes listed in the *tip* and was really impressed with the [inkpot](http://www.vim.org/scripts/script.php?script_id=1143)
scheme... it's pretty.

<!--more-->

So first, you seem to need a recent xterm vim 6.4 or vim 7.  The xterm or vim that shipped with Debian/Sarge does not support 256 colours... or at least, that's what
was reported to me on IRC.

Here are some useful links:

   - [vim tip 1312](http://www.vim.org/tips/tip.php?tip_id=1312) - the tip that started it all
   - [The 256 color mode of xterm](http://frexx.de/xterm-256-notes/)
     - useful notes and scripts to test xterm support
     - some vim colorschmes -- I am sticking to *inkpot*
     - how to get *screen* to work with 256 colours
   - [konsole-256color](http://blog.cynapses.org/) - blog entry on konsole/screen/vim in 256 colours
   - [making mutt display 256 colors](http://comments.gmane.org/gmane.mail.mutt.user/25292) - a discussion on mutt user's group that gets into some screen details
   - [XTerm and 8-bit Characters](http://www.leonerd.org.uk/hacks/hints/xterm-8bit.html) - has nothing to do with colours, but related
   - [vim tip #1384](http://www.vim.org/tips/tip.php?tip_id=1384) - xterm256 color names for console vim
   - [vim color scheme test](http://www.cs.cmu.edu/~maverick/VimColorSchemeTest/)
   - [XTerm Colour Chart](http://excess.org/misc/xterm_colour_chart.py.html) - shows xterm and urxvt [colour cubes](http://excess.org/misc/xterm_colour_chart_sm.png)
   - [XTerm 256-Colour Chart](http://excess.org/article/2007/06/xterm-256-colour-chart/) - another xterm chart program (also works with urxvt 88 colour mode)

**NB:** I had to make the change mentioned on the page to my .screenrc **and** rebuild my screen package:

    sudo apt-get build-dep screen
    apt-get source screen
    cd screen*
    dpkg-buildpackage
    cd ..
    dpkg -i screen*.deb

Here are my config files:

  - [vimrc](/~bart/conf/vimrc), and [colorschmes](/~bart/conf/vim/colors/)
  - [screenrc](/~bart/conf/screenrc)
