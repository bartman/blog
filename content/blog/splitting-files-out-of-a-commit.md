+++
title = "splitting files out of a commit"
date = "2009-05-01T17:26:45-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['git', 'scm']
keywords = ['git', 'scm']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I previously wrote on [splitting patches with git]{20081112150409}.  This is very similar
but deals with removing a file from a commit.

<!--more-->

So say you just made a `git commit -a` and realized that you didn't mean to commit
all the files into one commit.  You could `git reset HEAD~1` and start over:

        $ git commit -a -m"some message"
        $ git reset HEAD~1
        $ git commit -m"some message" some of the files
        $ git commit -m"some thing else" some other files

A cooler way is to revert only some of the files back to the previous revision
(the ones you didn't mean to include in the first commit).

        (1) git commit -a -m"some message"
        (2) git reset HEAD~1 -- files for second commit
        (3) git amend
        (4) git commit -a -m"some thing else"

We start off as before *(1)* creating a commit with too much in it.  Then after realizing that
some of the files were not intended to go in that commit, *(2)* we remove just those files from
the index and revert them to the previous state.  Next, *(3)* we update the commit with the state
of the index using `git amend` ([which is an alias I use]{git-amend}).  Finally  *(4)* since
`reset` didn't alter the state of the working tree, the files removed in step 2 can now be added
as a new commit.

Naturally this could be used inside an interactive rebase.