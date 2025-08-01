+++
title = "show current git branch in zsh"
date = "2007-12-19T22:13:58-05:00"
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

**NOTE**: This post has been [updated]{zsh-git-branch2}.

Earlier today I saw a blog post titled "[Git in your prompt](http://acts.as.streeteasy.com/archives/2007/12/19/git_in_your_prompt/)"
which showed how to get the current git branch to display in zsh and bash.  I tried it on my setup and found it really slow, probably due
having `$HOME` on NFS or having big git repos or maybe not enough ram.

Anyway, after looking at some zsh docs [and blog posts](http://xanana.ucsc.edu/~wgscott/wordpress_new/wordpress/?p=12), I had 
added caching to the idea.  Now the git-branch is only queried on a directory change or on a command that matches `*git*`.

<!--more-->

The following can be dropped into your `$HOME/.zshrc` or you can grab my configuration:

 - [.zshrc](/~bart/conf/zshrc) - just loads files in `$HOME/.zsh.d`
 - [.zsh.d](/~bart/conf/zsh.d) - zsh config split by topic

First you need to tell zsh to execute function found in some magic arrays.  Each of these is an array of function 
names.  Each function name is executed when zsh performs some action.  I put these 
in [.zsh.d/S10_zshopts](/~bart/conf/zsh/rc/S10_zshopts).

        typeset -ga preexec_functions
        typeset -ga precmd_functions
        typeset -ga chpwd_functions

We will also use the *expansions-in-prompt* feature:

        setopt prompt_subst

The next section is in [.zsh.d/S55_git](/~bart/conf/zsh/rc/S55_git) of my config.  I currently only grab the current
git branch and store it in `$__CURRENT_GIT_BRANCH` environment variable.  My plan is to grow it to include `git-status`
info, and maybe bisect.  Anyway, this is the only variable to initialize.

        export __CURRENT_GIT_BRANCH=

Next is the function that extracts the branch name ().  I took this verbatim from Corey's blog.

        parse_git_branch() {
                git-branch --no-color 2> /dev/null \
                | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) -- /'
        }

I want this variable to be updated when we execute any command that matches `*git*`.

        preexec_functions+='zsh_preexec_update_git_vars'
        zsh_preexec_update_git_vars() {
                case "$(history $HISTCMD)" in 
                        *git*)
                        export __CURRENT_GIT_BRANCH="$(parse_git_branch)"
                        ;;
                esac
        }

And I also want it updated when I change directories.

        chpwd_functions+='zsh_chpwd_update_git_vars'
        zsh_chpwd_update_git_vars() {
                export __CURRENT_GIT_BRANCH="$(parse_git_branch)"
        }

Finally I make it accessible to the prompt.

        get_git_prompt_info() {
                echo $__CURRENT_GIT_BRANCH
        }

The prompt iteself is defined in [.zsh.d/S60_prompt](/~bart/conf/zsh/rc/S60_prompt).
My example is far more complex, but essentially you need to do something like:

        PROMPT='%c$(get_git_prompt_info) %% '

... or this ...

        RPROMPT='$(get_git_prompt_info)'

Here is what it looks like for me...

        [bart@xenon] cd ~                                                              (~)
        [bart@xenon]                                                                   (~)
        [bart@xenon] cd work/wmii/wmiirc-lua.git                                       (~)
        [bart@xenon]                              (master) -- (~/work/wmii/wmiirc-lua.git)

NOTE that the *right-prompt* actually disappears after I hit `<enter>`.