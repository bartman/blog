+++
title = "bacula rejected Hello command"
date = "2009-10-13T17:42:48-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['bacula']
keywords = ['bacula']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I added a new host to bacula today.  That resulted in:

        13-Oct 16:58 bacula-dir JobId 1026: Fatal error: File daemon at "oxygen:9102" rejected Hello command
        13-Oct 16:58 bacula-dir JobId 1026: Error: Bacula bacula-dir 2.4.4 (28Dec08): 13-Oct-2009 16:58:39

After looking around on the web and coming up with nothing, I noticed the version difference.
The new host happened to run version 3.x.y of bacula-fd, unlike my director that runs 2.4.y.
Apparently bacula doesn't support the director being an older version than the client.

<!--more-->

I downgraded my bacula-fd from 3.0.2 to 2.4.4, and all was well again.  On debian this is done by putting the following into 
`/etc/apt/preferences` (see [this](http://jaqque.sbih.org/kplug/apt-pinning.html) for more info).

        Package: bacula-fd bacula-common
        Pin: release a=stable
        Pin-Priority: 1000

and then running `apt-get install --reinstall bacula-fd bacula-common`.