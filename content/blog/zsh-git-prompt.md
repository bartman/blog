+++
title = "show more git info on zsh prompt"
date = "2008-05-09T11:15:34-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['git', 'zsh', 'shell']
keywords = ['git', 'zsh', 'shell']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

UPDATE: This post was [updated]{pimping-out-zsh-prompt} (yet again).

This is my [third]{zsh-git-branch} [post]{zsh-git-branch2} on the topic.  I have *harshly* assimulated
[MadCoder's](http://blog.madism.org/index.php/2008/05/07/173-git-prompt)
[configuration](http://madism.org/~madcoder/dotfiles/zsh/60_prompt).  Here is my new zsh prompt:

![zsh git prompt](/~bart/screenshots/zsh-git-prompt.png)

**UPDATE:** I've [updated my prompt again]{pimping-out-zsh-prompt}.

<!--more-->

I have decided to move the user name, host, and full path to the right of the screen, since most of the
time I know those (if you don't use zsh: the right prompt vanishes if the command line is long so to not get
in the way of editing, it also goes away after you execute the command).  On the left, I now show the git
state (see below) and the last component of the `$PWD`.

The git bits include:

 - the name of the current branch;
 - the current state of:
   - `git rebase`,
   - `git merge`,
   - `git am` and
   - `git bisect`;
 - also on the right prompt I highlight (in yellow) the parts of the path that are subdirs of the 
   repository.

And here are my config files:

 - [.zshrc](/~bart/conf/zshrc) - just loads files in `$HOME/.zsh.d`
 - [.zsh.d](/~bart/conf/zsh.d) - zsh config split by topic, of those you want to look at this one:
   - [.zsh.d/S55_git](/~bart/conf/zsh/rc/S55_git) - my git related stuff
   - [.zsh.d/S60_prompt](/~bart/conf/zsh/rc/S60_prompt) - the prompt

If you want more info read the [previous]{zsh-git-branch} [posts]{zsh-git-branch2}, or email...

**UPDATE:** *since I originally wrote this, and the [previous]{zsh-git-branch} [articles]{zsh-git-branch2} on
the topic, several new techniques have been written and some have many cool new features.  I recommend
[checking out this writeup](http://gitready.com/advanced/2009/01/28/zsh-git-status.html).  However, the
alternatives seem to be non-caching and thus take a ong time to refresh the prompts on large repositories.
As a result, they are not very interesting to me since I tend to work on large projects where calling* git status
*could take a few seconds.  If you're still interested in a fast prompt read on...*
