+++
title = "select loop for X events"
date = "2009-06-28T13:12:55-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['devel', 'x']
keywords = ['devel', 'x']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I am not a huge fan of threading when it can be avoided.  I always thought that it was OK for GUI programs to be threaded.
I just discovered that you can [handle X events from a select loop](http://www.linuxquestions.org/questions/programming-9/xnextevent-select-409355/#post2431345).

        dis = XOpenDisplay(DISPLAY);
        fd = ConnectionNumber(dis);

        FD_SET(fd, &in_fds);

        select(fd+1, &in_fds, NULL, NULL, NULL);

        ...