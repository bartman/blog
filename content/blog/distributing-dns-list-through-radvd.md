+++
title = "distributing DNS list through radvd"
date = "2010-09-15T17:56:49-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['ipv6', 'dns']
keywords = ['ipv6', 'dns']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

If you have an IPv6 Linux network at home, you probably have a Linux host on the
perimeter that's running [radvd](http://www.litech.org/radvd/) -- this is the
server that responds to IPv6 neighbour discovery (ND) requests, distributes 
the *default route* to all your hosts, and tells your hosts how to auto
configure themselves.

All these tasks were handled by the *DHCP* server, albeit a lot differently, in
the good old days.  The one other thing that `dhcpd` did for us was to tell
all the hosts where the DNS servers were.

So, do I need to run the IPv6 version of `dhcpd` AND `radvd`?

<!--more-->

It turns out that `radvd` can perform the task of domain name server
distribution.  [RFC 5006](http://tools.ietf.org/html/rfc5006) extends
the features of the ND protocol to also send out *RDNSS* 
(or "*recursive DNS server*" info).

Say, I have a simple ipv6 router with `eth0` pointing out, and `eth1` pointing in.
Here is an example configuration for `radvd` (*/etc/radvd.conf*).

    interface eth1
    {
        AdvSendAdvert on;
        prefix 2001:470:ffff::/64 {                 # this is my internal network prefix
            AdvOnLink on;
            AdvAutonomous on;
            AdvRouterAddr on;
        };
        RDNSS 2001:470:ffff::1 2001:470:ffff::2 {   # I have 2 DNS servers
            # I have no options to add here
        };
    };

Most of the things that `radvd` sends out is consumed by the Linux kernel.  But
domain name resolution happens in user space.  The kernel just ignores the *RDNSS* stuff.

What you need to install is a daemon that listens for this info and updates your
`/etc/resolv.conf` files.  That daemon is [rdnssd](http://rdnssd.linkfanel.net/).

    # apt-get install rdnssd
    ...

It may take a while, but as soon as the `radvd` server sends out it's broadcast, all systems
running `rdnssd` will learn of the new DNS hosts.  The `/etc/rdnssd/merge-hook` script
will be called to update `/etc/resolv.conf`.