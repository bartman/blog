+++
title = "shrinking URLs"
date = "2009-03-20T21:42:28-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['script', 'bash', 'shell']
keywords = ['script', 'bash', 'shell']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I wrote a [short script](/~bart/scripts//shorturl/shorturl) to shrink URLs:

        % shorturl http://www.jukie.net/~bart/shorturl
        http://2tu.us/ce8

        % shorturl
        Type in some urls and I'll try to shrink them for you...
        http://www.jukie.net/~bart/shorturl
        http://2tu.us/ce8
        http://www.jukie.net/~bart/20090320214228
        http://2tu.us/ce9

I am doing this as part of my new [identi.ca](http://identi.ca/barttrojanowski) addiction`^W`
usage and extending GregKH's [command line micro blogging tool](http://github.com/bartman/bti/commits/master).

*UPDATE:* also picked up by [@vando for use with mcabber](http://identi.ca/notice/21908233).