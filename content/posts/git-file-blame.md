+++
title = "how old are these files in git?"
date = "2009-04-01T11:20:30-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['git']
keywords = ['git']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

A freind asked me how he could check the age of a file in his git repository.  I came up with this:



        % git ls-files | xargs -n1 -i{} git log -1 --pretty=format:"%ci {}" -- {}

        2007-04-11 11:39:31 -0400 .gitignore

        2008-10-18 10:52:27 -0400 Xdefaults

        ...



It walks through all the files tracked by git and prints the time stamp of the last commit that

modified that file.



Git rocks!
