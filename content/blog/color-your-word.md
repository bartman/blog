+++
title = "color your word"
date = "2008-04-12T10:03:37-04:00"
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

I just discovered a [git]{tag/git} feature that has eluded me since v1.4.3, when it was
introduced.  It's a way to colour differing words in `git diff` output.  Maybe you don't
know about it either... allow me demonstrate:

<!--more-->

Let's initialize a simple tree:

        # git init
        # echo some existing text > file
        # git add file
        # git commit -m"some commit" file
        # echo some changed text and some new > file

So now we have a tree with a file that contains one word altered.

Here is a comparison of `git-diff` with and without the `--color-words` option:

![git-diff file](/~bart/screenshots/git-diff-plain.png)

![git-diff --color-words file](/~bart/screenshots/git-diff-color-words.png)