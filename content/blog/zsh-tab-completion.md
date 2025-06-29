+++
title = "zsh tab completion awesomeness"
date = "2007-09-08T11:59:05-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['zsh', 'shell']
keywords = ['zsh', 'shell']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I have been using [zsh]{tag/zsh} for a few months.  I love it.  The best part of zsh is the tab completion.

Here are a few examples (note that you don't actually type in the `<tab>`):

<!--more-->

  - I need to see how I coded something up a month ago, I don't remember what project it was in but I know the filename:

        vim work/**/prime.c<tab>

    zsh generats

        vim work/one/prime.c work/two/three/four/prime.c ...

  - I want to perform an operation on several file in different subdirectories:

        something dir/{file1,file<tab>

    and zsh completes the files inside the `{}`s.  Even better is that it does not get confused by nested `{}`s...

        something dir/{file1,subdir/{file2,<tab>

  - say I have a directory of pictures with filenames that have dates, and I want to get a file not in 2007...

        something ^2007*.jpg<tab>

    the `^` negates the exapnssion.

  - my files are in *YYYYMMDD-HHMMSS.jpg* format, and I know it was between 2005 and 2007, and between the hours of 20 and 22...

        something 200<5-7>*-<20-22>*.jpg<tab>

    the `<a-b>` will match anything between *a* and *b*.

  - zsh can also try to fix type-o's, if all other completions fail

        touch foo.c bar.h
        vim fox.c<tab>
    
    will complete to `foo.c`.

  - zsh also makes it easier to edit a filename you forgot...

        touch really-long-file-name-that-has-a-unique-word-xxx-in-it.txt
        vim xxx.txt<tab>

For more, see `man zshall`. :)
