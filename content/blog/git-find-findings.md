+++
title = "git-find findings"
date = "2006-07-28T10:55:00-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['git', 'git-find']
keywords = ['git', 'git-find']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

So I have a simple [git-find](http://gitweb.jukie.net/git-find.git) working, and now I want to use 
it to rip out some patches I am interested in.  The repository I am working on has a lot of uninteresting deltas 
in it that I don't care about.  I am actually only interesting in backporting an interface change in one file 
from the `klipsng` branch:

        $ git-find klipsng --file linux/net/ipsec/ipsec_sa.c
        ...

This works as advertised, I get a list of revisions that altered that file.  The current git command line parsing
does not allow me to do much with this however.

<!--more-->

Next I would like to generate a set of patches so I can have a look at these changes.  I would love to do this:

        $ git-find klipsng --file linux/net/ipsec/ipsec_sa.c | git-format-patch -

But `git-format-patch` does not understand the dash.  It does understand a list of revisions like this:

        $ git-find klipsng --file linux/net/ipsec/ipsec_sa.c > list
        $ git-format-patch `cat list`

But when any of the git tools see a revision on the command line, they interpret it as *everything from that revision
to HEAD*, and that produces a lot of patches! :)

The best I can do right now is this:

        $ git-find klipsng --file linux/net/ipsec/ipsec_sa.c \
        | tac \
        | while read rev ; do (( num++ )) ; git-format-patch --start-number $num $rev~1..$rev ; done
        $ rename 's/\.txt$/.patch/' *.txt

... will have to hack on git-format-patch tonight.