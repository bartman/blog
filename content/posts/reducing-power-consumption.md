+++
title = "reducing power consumption"
date = "2007-07-24T08:23:55-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['linux', 'power', 'laptop']
keywords = ['linux', 'power', 'laptop']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I was recently talking to [Jean](http://geemoo.ca/) about lowering power consumption.  One of

the things I do is to purge all modules when I go to battery power.  Here is the script I 

use to remove unwanted modules.



        lsmod | awk '/0 *$/ {print $1}' | xargs -n1 sudo rmmod



Building things as modules makes this more successful.  And you have to run it a few times to 

get all the unused modules out.  Maybe something like this would work...



        while lsmod | grep -q '0 *$' ; do

                lsmod | awk '/0 *$/ {print $1}' | xargs -n1 sudo rmmod

        done


