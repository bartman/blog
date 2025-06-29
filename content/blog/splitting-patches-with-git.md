+++
title = "splitting patches with git"
date = "2008-11-12T15:04:09-05:00"
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

Here is a really cool workflow using git...

Say you have several commits (you can think of them as patches for this exercise) in your current repository and want to split one into multiple parts.
There could be various reaons like upstream request, only want to release part of it, remove debug code, etc.

Anyway, there is one commit in your **unpublished** history that needs to be split.

<!--more-->

    (1)  git rebase -i HEAD~10
         # interactive mode brings up an editor with a list of the last 10 commits
         # pick patch to split, tag with edit
    (2)  git reset HEAD~1
    (3)  git add -p some-file
         # go through hunks and select the ones you want
         # using the 'e' menu option you can edit the patch (in your editor)
    (4)  git commit -m"part one"
    (5)  git add -i
         # select files to operate on
    (6)  git commit -m"part two"
    (7)  git commit -m"part three" -a
    (8)  git rebase --continue

First we need to select the right commit to edit (1), and then blow away the commit that will be split (2).

Next we use `git add -p` (the coolest command since git rebase -i) to apply just the parts of the changes you want to the index (3).
A new commit is made from just the parts in the index (4).

Steps (5) and (6) are a variation using `git add -i` which operates on all files... so you select the file you want to trim and select the *hunks* you want o include, then commit.

Finally the left over changes go into a new commit (7).

Since the patch that is being edited may not be the last one (ie the branch may have had changes past the commit you are splitting) you finish off with `git rebase --continue` to apply the rest (8).

BTW, if you have not yet seen [ Contributing with Git ](http://uk.youtube.com/watch?v=j45cs5_nY2k)... you should.
