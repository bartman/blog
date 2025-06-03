+++
title = "improving find -exec efficiency"
date = "2018-12-12T14:51:29-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['bash', 'find', 'linux', 'script', 'shell', 'mindblown']
keywords = ['bash', 'find', 'linux', 'script', 'shell', 'mindblown']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

So today I learned about `find -exec ... +`



<!--more-->



        $ mkdir 1 2 3 4

        $ for d in 1 2 3 4 ; do touch $d/{a,b} ; done

        $ find -type f -exec echo {} \;

        ./2/b

        ./2/a

        ./4/b

        ./4/a

        ./1/b

        ./1/a

        ./3/b

        ./3/a

        $ find -type f -exec echo {} +

        ./2/b ./2/a ./4/b ./4/a ./1/b ./1/a ./3/b ./3/a



... sweet!
