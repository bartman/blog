+++
title = "firefox crashes with form input"
date = "2006-06-28T08:34:56-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['firefox', 'desktop']
keywords = ['firefox', 'desktop']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I ran into a strange bug with firefox locking up each time I pushed a form submit button.  When I ran it from the console I had an endless stream of:



        mork warning: unexpected byte in ReadContent()

        mork warning: unexpected byte in ReadContent()

        mork warning: unexpected byte in ReadContent()

        mork warning: unexpected byte in ReadContent()

        mork warning: unexpected byte in ReadContent()

        mork warning: unexpected byte in ReadContent()

        mork warning: unexpected byte in ReadContent()

        mork warning: unexpected byte in ReadContent()



Googling for it revealed an [intresting thread](http://lists.freebsd.org/pipermail/freebsd-ports/2005-January/019341.html) which dates this bug to firefox 1.0.  Grr.



Here is the fix:



    rm -f .mozilla/firefox/*.default/formhistory.dat


