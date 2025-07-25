+++
title = "urxvt mouseless url yanking"
date = "2007-05-03T01:35:55-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['urxvt', 'shell', 'desktop']
keywords = ['urxvt', 'shell', 'desktop']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

In the quest for a completely mouse free desktop, I wanted to be able to yank URLs from the termial
without using the mouse.  This happens often enough in IRC when I would want to grab the most recent 
URL and run it in firefox.

I talked to the author of [vimperator](http://vimperator.mozdev.org) and he suggested that
I look at urxvt (packaged as rxvt-unicode).  So I did.

A few hours later and I have a perl plug-in for urxvt that does just want I wanted.

<!--more-->

I use [wmii]{tags/wmii} and one of the keys that is unused atm, is Alt-U.  I mapped the new feature to Alt-U, but
it's configurable.

**Overview**

   - `Alt-U`   - enter URL yank mode, select last URL; pressed subsequently selects previous URL
   - `<esc>`   - exit URL yank mode
   - `y`       - copy selected URL to clipboard
   - `<enter>` - launch browser (see below) on selected URL
   - `ctrl-n`  - select next url
   - `ctrl-p`  - select previous url

NOTE: *the key combinations are intended to be vim-like and permit me to extend them to be able to
mark arbitrary text using similar shortcuts as screen copy mode.  So HJKL are reserved for future use,
hence the use of a control key.*

**The code**

   - [gitweb interface](http://gitweb.jukie.net/urxvt.git) for the urxvt script repo
   - [current version](http://gitweb.jukie.net/urxvt.git?a=blob;f=mark-yank-urls) of mark-yank-urls

**Clone my repo**

   - you will need git

        apt-get install git-core
        git clone git://git.jukie.net/urxvt

**Install**

   - you will need [urxvt](http://packages.debian.org/stable/x11/rxvt-unicode)

        apt-get install rxvt-unicode

   - put `mark-yank-urls` in `$HOME/.urxvt/`

     *If you got it from git, run make install*

   - in order to copy things into the clipboard the script needs one of two things

     - the [clipboard perl module](http://search.cpan.org/~king/Clipboard-0.09/lib/Clipboard.pm)

            cpan Clipboard

     - the [xclip](http://packages.debian.org/stable/x11/xclip) utility

            apt-get install xclip

**Configure**

   - put this in `$HOME/.Xdefaults`

        URxvt.keysym.M-u: perl:mark-yank-urls:activate_mark_mode
        URxvt.underlineURLs: true
        URxvt.perl-lib: /home/jukie/bart/.urxvt/                               <--- your path
        URxvt.perl-ext: selection,mark-yank-urls
        URxvt.urlLauncher: firefox

**Run**

   - you can just run `urxvt`, but if you don't have .Xdefaults working right, use this:

        urxvt --perl-lib ${HOME}/.urxvt/ -pe mark-yank-urls