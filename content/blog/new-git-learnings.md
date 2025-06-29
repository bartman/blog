+++
title = "new git learnings"
date = "2024-02-14T13:21:02-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['git', 'linux']
keywords = ['git', 'linux']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

watching the founder of github talk about git.

[https://www.youtube.com/watch?v=aolI_Rz0ZqY](https://www.youtube.com/watch?v=aolI_Rz0ZqY)

here is what I learned:

<!--more-->

* have `git branch` report branches in reverse change order

        $ git config --global branch.sort -committerdate 

* the builtin `git column` is a more useful `column` command

        $ seq 1 10 | git column --mode=column --width=15 --padding=2
        1   5   9
        2   6   10
        3   7
        4   8

* git can sign commits with ssh keys

        $ git config gpg.format ssh
        $ git config user.signingkey ~/.ssh/key.pub
        $ git commit -S

  or even push with signature, if the server supports it

        $ git push --signed

* git can do background tasks from cronjob, if enabled on a repo

        $ git maintenance start

* `git log --graph` is expensive, but can be made faster by enabling a cache of the graph at fetch time

        $ git config --global fetch.writeCommitGraph true

* `git fsmonitor` is a daemon that can run in the background, wich uses inotify to track changed files <br>
   significantly speeds up `git status` operations, and needs `watchman` installed

        $ sudo apt install watchman
        $ git config core.fsmonitor true
        $ git config core.untrackedcache true

* shallow clones can be done such that history is downloaded, but not blobs from historical (non-HEAD) commits<br>
   also possible to skip blobs and trees, so get commits only <br>
   git will pull down what it needs dynamically

        $ git clone --filter=blob:none
        $ git clone --filter=tree:0

* sparse checkouts, a way to clone everything, but only checkout parts of it

        $ git sparse-checkout mydir myotherdir