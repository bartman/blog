+++
title = "show current git branch on zsh prompt (2)"
date = "2008-04-04T10:56:20-04:00"
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

**NOTE:** This post has been [updated]{zsh-git-prompt} (again).

I previously wrote about [showing the git branch name on the  zsh prompt]{zsh-git-branch}.  Caio Marcelo pointed out that
it didn't work very well because the git branch was being queried before the command was executed, and it should
be after to catch git commands that change the branch, like `git branch` and `git checkout`.

He was right, here is a repost.

<!--more-->

But first, here is what it looks like for me...

        [bart@xenon] cd ~                                                              (~)
        [bart@xenon]                                                                   (~)
        [bart@xenon] cd work/wmii/wmiirc-lua.git                                       (~)
        [bart@xenon]                              (master) -- (~/work/wmii/wmiirc-lua.git)
        [bart@xenon] git checkout foo             (master) -- (~/work/wmii/wmiirc-lua.git)
        Switched to branch "foo"
        [bart@xenon]                                 (foo) -- (~/work/wmii/wmiirc-lua.git)

NOTE that the *right-prompt* actually disappears after I hit `<enter>`, but is retained above for demonstration purposes.

Below I break down the configuration which you can put into your `$HOME/.zshrc`.  If you just want to look at files... 
you can grab them here ...

 - [.zshrc](/~bart/conf/zshrc) - just loads files in `$HOME/.zsh.d`
 - [.zsh.d](/~bart/conf/zsh.d) - zsh config split by topic, of those you want to look at this one:
   - [.zsh.d/S55_git](/~bart/conf/zsh/rc/S55_git) - my git related stuff

**Here is the setup in detail...**

First, you need to tell zsh to execute functions found in some magic arrays on certain 
events.  Each of these is an array of function names.  Each function name is executed 
when zsh performs some action.  I put these in [.zsh.d/S10_zshopts](/~bart/conf/zsh/rc/S10_zshopts).

        typeset -ga preexec_functions
        typeset -ga precmd_functions
        typeset -ga chpwd_functions

We will also use the *expansions-in-prompt* feature:

        setopt prompt_subst

The next section is in [.zsh.d/S55_git](/~bart/conf/zsh/rc/S55_git) of my config.  I currently only grab the current
git branch and store it in `$__CURRENT_GIT_BRANCH` environment variable.  My plan is to grow it to include `git-status`
info, and maybe bisect.  Anyway, this is the only variable to initialize.

        export __CURRENT_GIT_BRANCH=
        export __CURRENT_GIT_VARS_INVALID=1

The latter will be set to *non-null* when we detected that the next command could alter the branch.
Here are some functions to operate on the variables:

        zsh_git_invalidate_vars() {
                export __CURRENT_GIT_VARS_INVALID=1
        }
        zsh_git_compute_vars() {
                export __CURRENT_GIT_BRANCH="$(parse_git_branch)"
                export __CURRENT_GIT_VARS_INVALID=
        }

Next is the function that extracts the branch name.  I took this verbatim from [Corey's blog](http://acts.as.streeteasy.com/archives/2007/12/19/git_in_your_prompt/).

        parse_git_branch() {
                git-branch --no-color 2> /dev/null \
                | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) -- /'
        }

When the directory changes, we need invalidate the variables:

        chpwd_functions+='zsh_git_chpwd_update_vars'
        zsh_git_chpwd_update_vars() {
                zsh_git_invalidate_vars
        }

Also, when a command is executed, we check if it matches `*git*` glob and invalidate the variables in that case.

        preexec_functions+='zsh_git_preexec_update_vars'
        zsh_git_preexec_update_vars() {
                case "$(history $HISTCMD)" in 
                        *git*) zsh_git_invalidate_vars ;;
                esac
        }

Finally, we export a function that will be used by the `PROMPT`.  This function
will check if the variables are valid, and if so it will update them.  The output of this function
will be used in the `PROMPT`.

        get_git_prompt_info() {
                test -n "$__CURRENT_GIT_VARS_INVALID" && zsh_git_compute_vars
                echo $__CURRENT_GIT_BRANCH
        }

The prompt iteself is defined in [.zsh.d/S60_prompt](/~bart/conf/zsh/rc/S60_prompt).
My example is far more complex, but essentially you need to do something like:

        PROMPT='%c$(get_git_prompt_info) %% '

... or this for the right side ...

        RPROMPT='$(get_git_prompt_info)'
