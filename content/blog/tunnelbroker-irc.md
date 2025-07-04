+++
title = "tunnelbroker vs IRC"
date = "2013-03-16T19:05:07-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['ipv6', 'irc']
keywords = ['ipv6', 'irc']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

*IRC not working over HE.net 6in4 tunnel? read on...*

I recently switched VPS's (to [Digital Ocean](https://www.digitalocean.com/))
and because my new co-location provider does not come
with native IPv6, I had to use a tunnel.  Naturally I chose tunnelbroker.net.
However, after reestablishing all important services, I noticed that TCP ports
in the range 6666-6669 don't work -- not on IPv6 anyways.  These are usually
used by IRC servers.

I did a bit of detective work on trying to figure out what was going on.
Initially looking for solutions on the internet, but all I found were other
people having this same problem with tunnelbroker.net tunnels.

<!--more-->

Now, it seems that the packets are getting into their network.

Look over this TCP traceroute example:

    $ tcptraceroute6 irc6 6666
     1  tube (2607:f2c0:f00e:999::1)  0.198 ms  0.260 ms  0.188 ms
     2  2607:f2c0:1::2:14 (2607:f2c0:1::2:14)  12.108 ms  13.040 ms  11.939 ms
     3  2607:f2c0:1:2120::2 (2607:f2c0:1:2120::2)  12.876 ms  11.137 ms  10.982 ms
     4  10gigabitethernet4-3.core1.tor1.he.net (2001:470:1:2de::1)  11.704 ms  14.839 ms  19.287 ms
     5  10gigabitethernet7-3.core1.chi1.he.net (2001:470:0:1e2::2)  21.271 ms  21.266 ms  22.184 ms
     6  tserv1.chi1.he.net (2001:470:0:6e::2)  27.561 ms  26.941 ms  27.180 ms
     7  * * *
     8  * * *
     9  * * *
    10  * * *

In the above example, you can see that the TCP traceroute breaks after
getting to `tserv1.chi1.he.net`.

Let's compare it to a port that works, like 5000 -- also used by IRC but
for server-to-server communication.

    $ tcptraceroute6 irc6 5000
     1  tube (2607:f2c0:f00e:999::1)  0.259 ms  0.228 ms  0.261 ms
     2  2607:f2c0:1::2:14 (2607:f2c0:1::2:14)  13.000 ms  11.475 ms  12.787 ms
     3  2607:f2c0:1:2120::2 (2607:f2c0:1:2120::2)  11.347 ms  10.918 ms  11.036 ms
     4  10gigabitethernet4-3.core1.tor1.he.net (2001:470:1:2de::1)  19.952 ms  11.974 ms  21.632 ms
     5  10gigabitethernet7-3.core1.chi1.he.net (2001:470:0:1e2::2)  26.053 ms  24.848 ms  21.408 ms
     6  tserv1.chi1.he.net (2001:470:0:6e::2)  27.132 ms  26.866 ms  26.718 ms
     7  mytunnel-2-pt.tunnel.tserv9.chi1.ipv6.he.net (2001:470:1f10:999::2)  46.349 ms  46.849 ms  41.896 ms

Note that in this case the packets make it through to the tunnel end point.

The unfortunate part of this exercise is that in the world of tunnelled IPv6,
a lot of things happen between "6" and "7".

Fortunately, all you need to do is go to the [tunnelbroker.net](http://www.tunnelbroker.net/) website,
select your tunnel, and go to the `Advanced` tab.  Here you will find a button to
*unblock IRC*.

I did this, and all of a sudden my packets went though.

Yey!