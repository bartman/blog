+++
title = "git-svnup"
date = "2007-08-07T11:25:31-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['git', 'svn', 'scm']
keywords = ['git', 'svn', 'scm']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

My employer (or client, since I am a [contractor](/~bart/consulting/) there) uses [svn]{tag/svn}.  I prefer to
use [git]{tag/git}.

This following git allows me to update all tracked svn branches in my git-svn repository:

        git config --get alias.svnup
        !git-config --get-regexp 'svn-remote.*url' | cut -d . -f 2 | xargs -n1 git-svn fetch

The way to invoke it is to run:

        git svnup
        git-svn rebase some-remote-snv-branch

You need to put that into your `~/.gitconfig` like so:

        [alias]
                svnup = !git-config --get-regexp 'svn-remote.*url' | cut -d . -f 2 | xargs -n1 git-svn fetch
