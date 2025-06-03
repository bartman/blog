+++
title = "git workflow: git amend"
date = "2009-04-09T15:59:05-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['git scm']
keywords = ['git scm']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

In my workflow I try to use the index (*staging area*) and last commit efficiently.  Very often I will commit something partially working
with a *"work in progress"* commit message to tell myself that I am not done.  As I work I will `git commit --amend` to that commit.

<!--more-->

It may look like:

    # hack hack hack
    git add foo.c
    git commit -m"WIP: hacking on this and that"

    # hack hack hack
    git add -p bar.c
    git commit --amend

I have typed `git commit --amend` a lot.  Typing it is not so bad, but this command also invokes an editor.  Most of the time, I am not
interested in what the editor is there for -- to update the commit message.

Enter `git amend`:

    git config --global alias.amend 'commit --amend -C HEAD'

This alias adds a `git amend` command that will reuse the current commit message when it amend it.

It's the little things :)