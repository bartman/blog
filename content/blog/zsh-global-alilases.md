+++
title = "zsh tip of the day - global aliases"
date = "2007-09-24T10:41:40-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['zsh']
keywords = ['zsh']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

Most shells have aliases.  Last week I started using a new (to me) feature in zsh aliases.  Zsh
lets you create arbitrary substitutions for the command line, not just the executable.

The simple example of a alias would create a new command that acts like another with some parameters added to it:

        alias ll='ls -l'

You can also alias other common patterns in zsh.  Say, you noticed that you used `| tail -n10` a lot in your
shell.  You can alias it like so:

        alias -g TT10='| tail -n10"
        history TT10
        (10 lines follow)

You can also make this tail macro a bit more useful by not fixing it to use 10 lines:

        alias -g TT='| tail -n'
        history TT 10
        (10 lines follow)

Of course you need to pick alias names that will not conflict with normal usage.

<!--more-->

--

Michael Prokop commented that *it caused headache just too often. Mainly because no matter how complicate your global alias name is: it will break your cmdline at least once. ;)*

He provided [two](http://hg.grml.org/grml-etc-core/file/tip/etc/zsh/zshrc) [links](http://zshwiki.org/home/examples/zleiab) for me to checkout.

Michael continues...  *just use your "global alias abbreviation" but
instead of just typing it, you also press an abbreviation key (being
`,.` be default for grml). So just type `ls -la L,.` and it will
expand to `ls -la | less`. It's not as risky as the global aliases
but it's powerful as well. :)*
