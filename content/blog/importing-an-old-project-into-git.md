+++
title = "importing an old project into git"
date = "2009-07-14T09:43:40-04:00"
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

I have recently been asked to revive an [old project](http://www.jukie.net/~bart/elfpgp/).  Way back when
I used to use bk for tracking changes.  But today, I don't even have a working bk tree.

Moving the history to git is easiest done by taking the tarballs I've published and creating a commit per tarball.

Below is a simple script that will do just that.

<!--more-->

To run it you'd do something like:

        mkdir my-repo
        cd my-repo
        git init
        ../import ../*.tar.gz

And here is the `import` script:

        #!/bin/zsh
        set -e

        commit=
        for tar in $@ ; do

                echo >&2
                echo >&2 "# Importing: $tar"
                [[ -f $tar ]] || exit 1
                
                base=$(basename $tar)
                date=$(stat --format="%y" $tar)
                
                git rm -qrf . || true
                tar -xz --strip-components=1 -f $tar
                git add .
                
                tree=$(git write-tree)
                commit=$(GIT_AUTHOR_DATE="$date" git commit-tree $tree ${commit:+-p} $commit <<<"import of $base")
                
                git reset --hard $commit
        done    

        echo >&2
        echo >&2 "# SUCCESS"

_

NOTE: the `tar` command will remove the leading path with the assumption that your project tar balls contain a single leading directory for all the files... as it is traditionally done.

WARNING: you don't want to run this script from a repo that already has commits.  This script forces the first tarball 
passed as the argument to become the first commit in history.  The current branch will contain no history other than
what is in the tarballs.