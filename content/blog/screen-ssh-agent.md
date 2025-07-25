+++
title = "letting screen apps use the ssh-agent"
date = "2006-09-20T09:39:57-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['screen', 'ssh']
keywords = ['screen', 'ssh']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I have been wondering for a while how to do this... *How to pass the ssh-agent variables to screen clients*.  After doing a 
google search on it I found a couple of solutions:

  - [grabssh/fixssh](http://www.deadman.org/sshscreen.html) - two scripts that save the ssh agent environment variables and restore them;
  - [screen_agent](http://screen.frogcircus.org/ssh-agent) - this just executes an ssh-agent that is used by the screen session;
  - [fixx](http://saikat.guha.cc/code.php?id=1) - ok, this actually fixes X forwarding not ssh-agent and is a variation on the first;

Then I came across [Alexander Neumann's blog entry](http://www.2701.org/archive/200406150000.html) which is the perfect solution.  He 
simply redefines the `SSH_AUTH_SOCK` variable and makes it point to a symlink that he creates when he logs in.  This means that this 
method works when you're sshing into a machine running screen.  I will just have to overwrite this symlink when screen is being launched.

So two changes; first is in .screenrc

        unsetenv SSH_AUTH_SOCK
        setenv SSH_AUTH_SOCK $HOME/.screen/ssh-auth-sock.$HOSTNAME

Second is is to define an alias that overwrites the symlink when screen is started:

        _ssh_auth_save() {
                ln -sf "$SSH_AUTH_SOCK" "$HOME/.screen/ssh-auth-sock.$HOSTNAME"
        }
        alias screen='_ssh_auth_save ; export HOSTNAME=$(hostname) ; screen'

Note, that the export of `HOSTNAME` may be unnecessary for you... it depends on the shell.

**Update: see [my later article]{screen-with-ssh-and-x} on how to use screen with ssh and X forwarding.
