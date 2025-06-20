+++
title = "reverting a git changeset"
date = "2006-07-06T16:22:56-04:00"
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

I accidentally committed a changeset without a description and wanted to fix it.  As I was pushing enter I 
realized that I didn't want to commit yet.  I have not pushed anywhere -- an important requirement for this kind of revert.

I basically want to do a `bk fix -c` (if I recall my *bk* correctly).

Since `git revert` pollutes the history, it is not the right thing to do here since the *bad* changeset was not pushed.
But it would be the right thing to do had I pushed my change.

<!--more-->

Here is the right thing to do:

        1 $  git diff HEAD~1 > ../last.patch
        2 $  git checkout -f -b tmp HEAD
        3 $  git branch -D master
        4 $  git checkout -f -b master HEAD~1
        5 $  git branch -D tmp
        6 $  patch -p1 < ../last.patch 
        7 $  cg commit net/ipsec/ipsec_ipcomp.c

(*Warning:* this is actually completely unnecessary, see below)

Here is what actually happens:

  1. backup the work that we had done into a patch.
  2. get of master onto a temporary branch, *tmp*, which just allows us to...
  3. delete the current *master*, so that we can...
  4. backup one revision and create a new *master* branch before the *bad* commit.
  5. now delete the *tmp* branch.
  6. revert the change we want to commit, and finally
  7. commit the changes <br>
     ... but this time comment them :)

*NOTE:* I think one or two steps can be carved off by using `git branch` instead of `git checkout`.  If you find a better way, I would love to hear about it.

*UPDATE:* It turns out that you can do this with `git commit --amend` in new git releases.

*Final Update:* Roberto Aguilar pointed out that I should have used `git reset`... in retrospect, what was I thinking!?