+++
title = "how would you read a file into an array of lines"
date = "2009-06-10T15:00:39-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['bash', 'shell', 'zsh']
keywords = ['bash', 'shell', 'zsh']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I was working on a shell script that needed to look at some lines in a bunch of files and perform
some data mining.  I started it in bash, so I am writing it in bash even though [dave0](http://www.dmo.ca)
notes that I should have started in in perl.  Point taken... I suffer for my mistake.

After a quick google I learned that a nice way to do what the topic of this post describes can
be done using

        IFS='
        '
        declare -a foo=( $(cat $file) )

Which is great! Right?

<!--more-->

Well, it turns out that it really sucks.  For a few dozen lines this takes 8 seconds
on my system, and it doesn't account for shell startup or spinning up the disk.

        s=$(date +%s)
        declare -a foo=( $(cat $file) )
        e=$(date +%s)
        echo $(( $e - $s ))

8 seconds, really!?

So I tried a variant...

        s=$(date +%s)
        declare -a foo=( $(< $file) )
        e=$(date +%s)
        echo $(( $e - $s ))

Still 8 seconds.

But I know that bash isn't always slow... maybe if I read one line at a time:

        s=$(date +%s)
        declare -a foo=( )
        while read txt ; do
                foo[${#foo[@]}]=$txt
        done < $file
        e=$(date +%s)
        echo $(( $e - $s ))

Now, it's 0 seconds.

### Well what about zsh?

Since you asked... zsh runs all these in 0s.

I hate bash.

I am rewriting this in perl.