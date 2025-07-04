+++
title = "starting on git-find"
date = "2006-07-27T16:29:41-04:00"
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

So I am giving myself some time to write a `git-find` script that I can use to feed
commits to another tool, like `git-graft` (or `git-cherry-pick`).

I don't really know what I am doing yet, so I want to survey what is available in 
`git-*` tools and reuse as much of the available features.

<!--more-->

`git-find` needs to:

 - take as input a commit-range in various formats;  I had previously
   stated that I want something like this:

        <A>                    - all commits from <A> to HEAD
        <A> <B> ...            - individual commits listed
        <A>..<B>               - all commits in given range
        -                      - commit hashes from stdin
  
  ... interestingly enough this is almost what can already be done with 
  `git-rev-list`.  `git-find` should then use `git-rev-list` to locate 
  the initial set of commits to work on.

 - once we have a commit, we have to decide if that commit matches the 
   selected criteria.  That means we have to be able to apply a condition
   check onto the diffs between a commit and it's parent.  That's easy,
   `git-diff` for looking at lines and files that changed.

 - will it need access to the historical state of the tree?

   There may be some cases where that is useful...

   `git-cat-file` can take an object in the git store and output the contents, 
   but `git-cat-file` is very low-level.  However, it's pretty simple
   to follow the paths to dump a file.  `cg-admin-cat`, from *cogito*, 
   is a great example on how this can be done.

 - certain types of matches may require that we have to look at the commit 
   message text.  Will need to use `git-log` for that.

I think that's it.  Looks like all the pieces are there.  The hardest part,
for this bash weenie, will be to represent the conditions in *bash*.

*Why am I not doing this in perl, again?*

Anyway, on with the show...

 - first is to find out all the revisions...

        $ git-rev-list HEAD~2..HEAD
        5209eda86363a3ba2e000903ad8de29589b18b58
        24cf6e5847073d50390e0b7950e8e6b5a09103bc
        7b8cf0cf2973cc8df3bdd36b9b36542b1f04d70a
        e14421b9aa85f11853a0dacae09498515daab7b8

 - having those we want to peek at the log...

        $ git-rev-list HEAD~2..HEAD | xargs -n1 git-log --max-count=1 | cat
        <output ommited>

 - now let's look at the diff for each of those revisions

        git-rev-list HEAD~2..HEAD | while read commit ; do
                git-diff ${commit}~1 $commit
        done

... the rest is really just shell magic.

** ... few hours go by ... **

So here is the the first implementation [git-find.git](http://gitweb.jukie.net/git-find.git).

I had to add glob support to `git-diff`, which took a while to figure out. ;)