+++
title = "screen -c relative path bug"
date = "2008-01-07T16:08:36-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['screen', 'bug', 'zsh']
keywords = ['screen', 'bug', 'zsh']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I must have recently upgraded to a new screen.  My screenrc file was using the `chdir` directive

so that the windows started inside would have a PWD I wanted them to.  As soon as I tried

to reconnect the screen session would die.



        screen -x

        Unable to open "screenrc"



I was able to find the [bug on savannah](http://savannah.gnu.org/bugs/?18890) that described

the symptom quite well.



I then wrote a [wrapper zsh function](http://www.jukie.net/~bart/conf/zsh.d/S51_screen) which fixes

the problem:



        REAL_SCREEN=$(which screen)



        # convert the path passed via the -c parameter to an absolute one

        screen() {

                local max=$((${#argv}-1))

                for (( x=1 ; x<=$max ; x++ )) ; do

                        local flag="${argv[$x]}"

                        if [[ "x$flag" = "x-c" ]] ; then

                                local y=$(($x+1))

                                local word="${argv[$y]}"

                                if [[ "x${word[1]}" != 'x/' ]] ; then

                                        argv[$y]="$PWD/$word"

                                fi

                        fi

                done



                echo ${REAL_SCREEN} ${1+"$argv"}

                ${REAL_SCREEN} ${1+"$@"}

        }
