+++
title = "pipe to pastey.net"
date = "2007-04-18T14:36:32-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['shell', 'mouse-free']
keywords = ['shell', 'mouse-free']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

Here is a little script that lets me post to [pastey.net](http://pastey.net) from a shell prompt

        #!/bin/bash
        set -e

        AUTHOR=bartman
        SUBJECT=pipe
        LANGUAGE=c

        w3m -post <( echo -n -e "language=$LANGUAGE&author=$AUTHOR&subject=$SUBJECT&tabstop=4&text=" ; sed 's/%/%25/g' | sed 's/&/%26/g' ) \
        -dump http://pastey.net/submit.php
