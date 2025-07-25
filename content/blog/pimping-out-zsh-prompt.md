+++
title = "pimped out zsh prompt"
date = "2010-02-25T10:40:49-05:00"
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

Here is [yet another]{zsh-git-prompt} update to the series.  I've updated my git prompt again,
now using the *zsh 4.3.7* built in `vcs_info` module.  This time the motivation came
from [Zsh Prompt Magic](http://kriener.org/articles/2009/06/04/zsh-prompt-magic) article.
Here is what it looks like now:

![zsh git prompt](/~bart/screenshots/zsh-git-prompt2.png)

Everything is now self contained in one file: [S60_prompt](/~bart/conf/zsh/rc/S60_prompt).  Grab it and source
it into your zsh config.

The features are:

 - name of current branch,
 - git repo state (`rebase`, `am`, `bisect`, `merge`, etc),
 - markers indicating staged/unstaged changes,
   - little `1` after branch name indicates dirty working tree,
   - little `2` after branch name indicates staged changes,
 - highlight depth decended into the repository on the right,
 - show failure of commands via prompt background change,
 - show command/insert mode when using vi mode (`set -o vi`).

<!--more-->

The big difference in between my usage of the `vcs_info` and the one from the article, [referenced above](http://kriener.org/articles/2009/06/04/zsh-prompt-magic),
is that I have large repositories where updating the status can sometimes take a couple seconds.  I like to limit
updates as much as possible.  In the above config I use the following trick to limit the updates...

I have a `PR_GIT_UPDATE` variable which dictates weather zsh is going to do the
git prompt update before printing the next prompt.  It defaults to 1 so I get an
update on the first prompt display.

        PR_GIT_UPDATE=1

Next, I've setup a function to do the updates when `PR_GIT_UPDATE` is set.

        function zsh_git_prompt_precmd {
               if [[ -n "$PR_GIT_UPDATE" ]] ; then
                       vcs_info 'prompt'
                       PR_GIT_UPDATE=
               fi
        }

Zsh support `precmd` which is called before generating the prompt, and you just have to queue up
you function in this array:

        precmd_functions+='zsh_git_prompt_precmd'

Next, I have to set the `PR_GIT_UPDATE` when I change directories:

        function zsh_git_prompt_chpwd {
                PR_GIT_UPDATE=1
        }
        chpwd_functions+='zsh_git_prompt_chpwd'

Lastly, I want to update the prompt after executing certain types of commands:

        function zsh_git_prompt_preexec {
                case "$(history $HISTCMD)" in 
                    *git*)
                        PR_GIT_UPDATE=1
                        ;;
                esac
        }
        preexec_functions+='zsh_git_prompt_preexec'

... this is a bit naive, because I could have scripts that execute git commands also, or say if I start up vim
and issue `:Git` commands from within.  In those cases I'd have to manually update the prompt with "`cd .`".  I'd rather
have slightly out of date information that have to wait for each prompt to be displayed.