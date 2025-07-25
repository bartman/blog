+++
title = "using git workflows to avoid loosing intermediate changes"
date = "2009-11-04T19:41:46-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['git']
keywords = ['git']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

A few days ago a buddy, [Jean](http://geemoo.ca/), had stumbled into a problem caused by
infrequent committing to his git repository.  Committing after the feature is implemented
is common when working with tools like SVN... but we have multiple workflows available
to us under git to manage frequent commits.

<!--more-->

Here are some examples of things I've used and seen people do...

 * the commit and amaend workflow
   
   *hack*
   `git commit`
   *hack*
   `git commit --amend`
   *hack*
   `git commit --amend`
   
   Here the `amend` steps will combine new work with the first commit.  The intermediate
   work is still accessible via [reflog](http://www.kernel.org/pub/software/scm/git/docs/git-reflog.html).

 * the interactive rebase workflow
   
   *hack*
   `git commit`
   *hack*
   `git commit`
   *hack*
   `git commit`
   *hack*
   `git rebase -i HEAD~3`
   
   The last step is intended to reorder and merge commits as you see fit.  You'd usually
   cleanup only those commits that have yet to be shared, because that avoids doing extra merges.

 * *hack*
   `git commit`
   *hack*
   `git commit`
   *hack*
   `git commit`
   *hack*
   `git reset HEAD~3`
   *cleanup*
   `git commit`
   
   Here we discard the last 3 commits and recombine the edits into a new commit.

... by far this is a non exhaustive list.

Anyway, I am writing this so I can introduce something I started working on today
called [git wip]{save-everything-with-git-wip}.
