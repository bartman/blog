+++
title = "less, colourful"
date = "2007-07-22T00:26:49-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['linux', 'shell']
keywords = ['linux', 'shell']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

Make your **less** more pretty with these environment variables...



        export LESS_TERMCAP_mb=$'\E[01;31m'

        export LESS_TERMCAP_md=$'\E[01;31m'

        export LESS_TERMCAP_me=$'\E[0m'

        export LESS_TERMCAP_se=$'\E[0m'

        export LESS_TERMCAP_so=$'\E[01;44;33m'

        export LESS_TERMCAP_ue=$'\E[0m'

        export LESS_TERMCAP_us=$'\E[01;32m'



You can put these in your `.zshrc` or `.bashrc`.
