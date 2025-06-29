+++
title = "running really nice"
date = "2009-12-05T13:04:55-05:00"
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

Everyone that uses the shell eventually learns about `nice` -- the tool that runs a process at a reduced priority.
Well, there is also `ionice` that allows you to tweak processes from taking over all disk IO.

I added a `vnice()` function into my ZSH config so I can run or mark processes for lower priority for
both `nice` and `ionice` levels.

<!--more-->

The `vnice` function can be ran in two modes.

  - `vnice make`
    
    This will run the `make` program under lower CPU and IO priorities.

  - `vnice $(pidof git)`
    
    This will lower the priorities of all processes with the name of git.

Here is the actual code that you can add to your `zshrc`:

        vnice() {
                if [[ -z "$1" ]] ; then
                        echo "vnice [ <pid>... | <program> ]" >&2
                        return 1
                elif [[ "$1" =~ ^[0-9]+$ ]] ; then
                        while [[ "$1" =~ ^[0-9]+$ ]] ; do
                                ionice -n7 -p $1
                                renice 20 $1
                                shift
                        done
                else
                        ionice -n7 nice -n20 $@
                fi
        }

The above might work under bash, but it has not been tested