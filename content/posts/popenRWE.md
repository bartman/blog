+++
title = "popen with stdin, stdout, and stderr"
date = "2009-03-22T20:39:39-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['c', 'code']
keywords = ['c', 'code']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I've look around for an open source implementation of `popen()` that can handle redirection of
*stdin*, *stdout*, and *stderr* of the program executed.  I was unable to find one, so I wrote
my own.

If you need to fork a helper process and maintain bidirectional communication wtih it, then you can 
use my [popenRWE()](/~bart/snippets/popenRWE/popenRWE.c.html) (source: [popenRWE.c](/~bart/snippets/popenRWE/popenRWE.c).

Here is an example of how it might be used:

        int pipe[3];
        int pid;
        const char *const args[] = {
                "cat",
                "-n",
                NULL
        };

        pid = popenRWE(pipe, args[0], args);

        // write to pipe[0] - input to cat
        // read from pipe[1] - output from cat
        // read from pipe[2] - errors from cat

        pcloseRWE(pid, pipe);