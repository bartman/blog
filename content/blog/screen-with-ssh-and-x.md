+++
title = "forwarding ssh and X through screen"
date = "2007-08-11T10:57:46-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['screen', 'ssh', 'desktop', 'x', 'zsh']
keywords = ['screen', 'ssh', 'desktop', 'x', 'zsh']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I have an update to my [previous article]{screen-ssh-agent} on forwarding [ssh-agent]{tag/ssh} 
through [screen]{tag/screen}.  I've since switched to [zsh]{tag/zsh} and am now forwarding 
the X `DISPLAY` environment variable through to the screen shell.

You can grab my [~/.zsh.d/S51\_screen](/~bart/conf/zsh/rc/S51_screen),
[~/.zsh.d/S60\_prompt](/~bart/conf/zsh/rc/S60_prompt), and
[~/.screenrc](/~bart/conf/screenrc) or 
read below.

<!--more-->

*( I assume you already have ssh-agent working; [see this if you need help](http://oclug.on.ca/archives/oclug/2002-July/022194.html) )*

Here is the zsh setup; note that I use `HOSTNAME` to differentiate between multiple hosts that 
share the same `/home/` directory mounted over NFS.

        # need the host name set sometimes
        [ -z "$HOSTNAME" ] && export HOSTNAME=$(hostname)

        # preserve the X environment variables
        store_display() {
                export | grep '\(DISPLAY\|XAUTHORITY\)=' > ~/.display.${HOSTNAME}
        }

        # read out the X environment variables
        update_display() {
                [ -r ~/.display.${HOSTNAME} ] && source ~/.display.${HOSTNAME}
        }

        # WINDOW is set when we are in a screen session
        if [ -n "$WINDOW" ] ; then 
                # update the display variables right away
                update_display

                # setup the preexec function to update the variables before each command
                preexec () {
                        update_display
                }
        fi

        # this will reset the ssh-auth-sock link and screen display file before we run screen
        _screen_prep() {
                if [ "$SSH_AUTH_SOCK" != "$HOME/.screen/ssh-auth-sock.$HOSTNAME" ] ; then
                        ln -fs "$SSH_AUTH_SOCK" "$HOME/.screen/ssh-auth-sock.$HOSTNAME"
                fi
                store_display
        }
        alias screen='_screen_prep ; screen'

We also teach screen to override the `SSH_AUTH_SOCK` variable when starting up.

        unsetenv SSH_AUTH_SOCK
        setenv SSH_AUTH_SOCK "$HOME/.screen/ssh-auth-sock.$HOSTNAME"
        
And that's it.