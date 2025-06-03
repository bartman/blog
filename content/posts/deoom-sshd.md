+++
title = "protecting sshd from OOM killer"
date = "2007-12-12T10:03:16-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['linux', 'kernel', 'oom']
keywords = ['linux', 'kernel', 'oom']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

When Linux runs low on memory it tries to kill off applications that may be responsible for 
the high memory usage.  It sometimes gets is all wrong, so the kernel has a way to tell it
which processes are to be treated differently by the OOM killer.

I am using ssh to run some stress tests.  Occasionally they cause memory to run out, and when I
am not paying attention sshd is killed off... which means I cannot turn off the tests.

Here is a script that makes sshd immune to OOM killer.

        for pid in $(pidof sshd) ; do
                echo "disabling oom on pid $pid"
                echo -17 | sudo tee /proc/$pid/oom_adj > /dev/null
        done

*NOTE*: the `sudo tee` is a useful trick when you want to write to a file as root w/o spawning a subshell.