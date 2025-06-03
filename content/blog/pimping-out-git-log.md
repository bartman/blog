+++
title = "pimping out git log"
date = "2009-10-07T23:50:46-04:00"
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

I got playing with `git log` and ended up creating this alias:

    [alias]
        lg = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative

Which adds a `git lg` command that is a prettier version of `git log --oneline`.

<!--more-->

The notable features are:

 - one commit per line
 - show graph of commits
 - abbreviated commit IDs
 - dates relative to now
 - show commit references (like `git log --decorate`)
 - lots of colour

You can run the following to add it to your `~/.gitconfig`:

    git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"

Here is what it looks like for me...

![git-lg](../../img/git-lg.png)

There might be other gems hiden in my [.gitconfig](http://www.jukie.net/~bart/conf/gitconfig), so have a look.

### Update...

Since this article was written, I've pimped the `git lg` alias a bit more.  This one also displays the author's name.

Here is the new config:

    [alias]
        lg = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative

... and here is how you can install it on your system:

    git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
