+++
title = "squid and apt"
date = "2009-11-13T10:22:21-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['apt', 'debian', 'squid']
keywords = ['apt', 'debian', 'squid']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

In the past few months `apt-get update` started failing when using a *squid3* web cache.

It woudl give errors like these...

  - `404 Not Found [IP: 149.20.20.135 80]`
  - `The HTTP server sent an invalid reply header [IP: 130.89.149.227 80]`
  - `Failed to fetch .../Packages 404 Not Found [IP: 149.20.20.135 80]`
  - `Failed to fetch .../Sources 404 Not Found [IP: 149.20.20.135 80]`
  - etc

<!--more-->

I initally found some [missleading information](http://www.mail-archive.com/squid-users@squid-cache.org/msg68401.html)
that would suggest this bug was fixed in future releases of squid3; that was not the case.

I finally found a solution to the issue in [this blog post](http://veejoe.net/blog/2009/05/trouble-with-apt-get-and-squid/).

After adding the following line to my `/etc/squid3/squid.conf`, apt went back to working.

    refresh_all_ims on