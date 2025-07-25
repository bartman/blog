+++
title = "git-graft and git-find brainstorm"
date = "2006-07-27T11:36:32-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['git', 'git-find', 'git-graft']
keywords = ['git', 'git-find', 'git-graft']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I want to be able to take a bunch of patches that were applied to one *semi-related* 
branch and appened them to the current branch, or better yet a new branch of the 
current.  The *bunch of patches* will be selected by what they change; I should 
be able to graft all patches that modify some file, or modify some regular expression.

Here is what I mean:

     ,-----X---X---X---X--- ... ---             "historical" branch
    o
     `--------------------Y                     "current" branch
                           \
                            `---Z---Z---...     "working" branch

You start off at `current` branch and run something like:

    git-find historical --file some_file.c --or --re 'some pattern' \
    | git-graft --new-branch working -

This will let me take the interesting subset of `X` commits and apply them at some 
point `Y`.  Should the patches `X` cause conflicts with the `current` branch, then 
`git-graft` needs to let the user resolve those conflicts a patch at a time.  The 
default is to apply onto the `current` branch, however if desired it should be 
possible to create the changes on a new, `working`, branch.  The result is a new 
set of `Z` commits, as shown above.

<!--more-->

There are two commands here: `git-find` and `git-graft`.  Starting with `git-find`; here is what I would like it to support initially:

    git-find <commits> <match-condition>

    git-find searches the commits in a specified range and returns
    those commits that modify the repository in a specific way.

    The commits to start with can be represented in a few ways:

        <A>                    - all commits from <A> to HEAD
        <A> <B> ...            - individual commits listed
        <A>..<B>               - all commits in given range
        -                      - list of commit hashes from stdin

    The match criteria can be defined using a grammar similar to
    the find command.  The following are supported match conditions:
    
        --file <glob>          - match on this file pattern
        --re <reg-exp>         - match diffs that contain this change

    To separate the match conditions use the following

        ( <condition>... )     - group together match conditions
        --or                   - boolean or
        --and                  - boolean and

I would also like it to search for things in the commit message, like `--author`, `--date`, `--desc`, `--signed`, etc.  But that can be added later.

The second tool I need is `git-graft`; this tool lets you cherry pick a slew of patches from one branch to the other.  Initially I wanted 
to have `git-graft` just pick a range of, like all the *X*'es above, and "graft" them onto a new branch.  However, my current usecase
requires that something selects the changesets I want and append that onto a branch.

This sounds very familiar.  That's kinda what `git-cherry-pick` does, but for one commit.  So I have to make a choice:

  - I can build `git-graft` ontop of `git-cherry-pick` and add statefullness to it the way that `git-rebase` works, **or**
  - I can extend the way that `git-cherry-pick` works and make it accept a range of commits to appply and add statefullness to it.

I think I will start with the first approach and then have the git maintainers decide.  So, now back to `git-graft`...

`git-graft` operates in a similar way to [git-rebase](http://www.kernel.org/pub/software/scm/git/docs/git-rebase.html),
except that `git-rebase` is too rigid.  It's possible to implement `git-rebase` on top of `git-graft`.  Here is what I want to see:

    git-rebase <options> <commits>

    git-rebase takes a range of commits and applies them one-by-one
    onto a branch.  If a patch does noe cleanly apply, git-rebase will
    stop and allow the user to resolve any conflicts and continue.

    Branching control:

        -b --new-branch <new-branch>
                               - create and checkout a new branch 
                                 before applying patches
        --branch-from <existing-branch>
                               - <new-branch> is created from an
                                 <existing-branch>
    Commits to apply:

        <A>                    - apply all commits from <A> to HEAD
        <A> <B> ...            - apply individual commits listed
        <A>..<B>               - apply all commits in given range
        -                      - read list of commit hashes from stdin

... now off to write some code.