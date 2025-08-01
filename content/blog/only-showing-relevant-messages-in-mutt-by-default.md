+++
title = "only showing relevant messages in mutt by default"
date = "2009-06-08T23:25:31-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['mutt']
keywords = ['mutt']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

Following [Steve Kemp's blog](http://blog.steve.org.uk/that_s_really_one_of_the_saddest_things_i_ve_ever_heard_.html), I've 
made a small but very cool improvement to my [mutt setup](http://www.jukie.net/~bart/conf/muttrc).

Here are the new lines:

        macro index     .i      "l((~N|~O|~F)!~D)|(~d<1w!~Q)\n"
        macro index     .n      "l~N\n"
        macro index     .o      "l(~N|~O)\n"
        macro index     .a      "l~A\n"
        macro index     .t      "l~d<1d\n"
        macro index     .y      "l~d<2d ~d>1d\n"

        folder-hook     .       push '.i'

<!--more-->

The first block of macros sets up `.` followed by one of `i`, `n`, `a`, `t`, or `y` to
change the filter that is applied to the mailbox messages.  This is usually triggered
with the `l` command, which invokes the mutt built-in `limit` function.  In order, these
do the following:

 - `.i` shows the new/old/flagged but undeleted messages, and those that arrived in the last week but have not yet been replied to.
   ... *i.e.* what I should look at first.
 - `.n` shows all new unread messages
 - `.o` shows all new and old unread messages
 - `.a` shows all messages (resets the limit fiter)
 - `.t` shows today's messages
 - `.y` shows yesterday's messages

Finally the `filter-hook` will activate the `.i` filter when I enter any mailbox.

Thanks Steve!