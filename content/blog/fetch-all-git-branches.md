+++
title = "fetching all git branches from remote"
date = "2006-11-01T00:20:27-05:00"
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

When you clone a new git repository, using a recent git release, by default git 
will create a `.git/remotes/origin` with all remote branches.  This file lists 
all remote branches that are to be updated on a fetch.

Over time the remote may get more branches, and it may be necessary to update the 
remote branch list.  The way to find out what is available at a remote is to 
call `git-ls-remote origin`, then pick out the branches of interest, and add them 
to the `.git/remotes/origin` file.

<!--more-->

Below is a script that I use to update all repositories on a regular basis.  It 
syncs up the list of remote branches for all remotes (not just *origin* -- the 
default remote name) and fetches all objects from the remote.

The script is crude, and it could use some improvements.  It's useful if you have 
a directory of many git trees that are used as a [git cache]{git-caching}.  Just 
`cd` into this *cache* directory and run the `update` script:

    #!/bin/bash

    set -e

    function sync_remote_branches {
        r=$1
        echo ----------------- sync remote $r

        rb=$(git-ls-remote -h $r | awk '{ print $2 }' | grep -v -e /origin$ -e /master$)

        for b in $rb ; do
                bn=$(echo $b | sed 's,^refs/heads/,,')
                if ! ( grep -q -e "^Pull: *$b:" -e "^Pull: *$bn" .git/remotes/$r ) ; then
                        echo "  +++ adding $b to .git/remotes/$r"

                        echo "Pull: $b:$b" >> .git/remotes/$r
                fi
        done

    }

    DIRS=$@
    if [ -z "$DIRS" ] ; then
            DIRS=$(echo */.git/../)
    elif ! [ -d "$1" ] ; then
            echo "$1: not a directory" >&2
            exit 1
    fi

    for d in $DIRS ; do
        (
        cd $d

        echo
        echo ================= $(pwd)
        echo

        [ -d .git/remotes ] || exit 1
        [ -d .git/branches ] || exit 1
        [ -d .git/refs/heads ] || exit 1

        remotes=$(cd .git/remotes/ && ls | grep -v '~$' || true)
        for o in $remotes ; do
                sync_remote_branches $o

                echo ----------------- fetch remote $o
                git fetch $o
        done

        branches=$(cd .git/branches/ && ls | grep -v '~$' || true)
        for o in $branches ; do
                echo ----------------- fetch branch $o
                git fetch $o
        done

        echo ----------------- repack
        git repack -d 
        )
    done

** Update **

I used to use `git repack -a -d` but found that fetching from this repo was 
really slow.  The `-a` flag replaces existing packs into one big pack.
That sucks when you have to do random-access on the repository... which is always.