+++
title = "OpenSSH VPNs"
date = "2006-06-05T09:57:26-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['ssh', 'vpn', 'security']
keywords = ['ssh', 'vpn', 'security']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

Long time ago, I wrote a brief howto on [SSH + PPP = VPN](/~bart/security/vpn/) (don't use it).  Today I found out that as of version 3.4 [OpenSSH](http://www.openbsd.org/cgi-bin/man.cgi?query=ssh) supports VPN features.  That is, you can [create a tun device and route packets through your ssh connection](http://marc2.theaimsgroup.com/?l=secure-shell&m=114467685608028&w=2).

That's pretty neat if you only have ssh to go with.  But pretty crappy because you need root on both ends, and if you have root on both ends you can gowith IPSEC or OpenVPN/tinc/cipe/etc.

<!--more-->

The text of the email [linked to above reads](http://marc2.theaimsgroup.com/?l=secure-shell&m=114467685608028&w=2):

    I'm no expert here, but this how I've done it.

    SSH VPN between Network1 (10.0.0.0/24) and Network2 (10.0.1.0/24)
    As root (or other privileged user) from end point node on Network1 (
    host.network1):

    ssh -fw0:0 host.network2 "ifconfig tun0 10.0.2.1 netmask 255.255.255.252 \
    ; echo 1 > /proc/sys/net/ipv4/ip_forward \
    ; /sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE \
    ; route add -net 10.0.0.0/24 gw 10.0.2.2 dev tun0"

    ifconfig tun0  10.0.2.2 netmask 255.255.255.252

    echo 1 > /proc/sys/net/ipv4/ip_forward

    /sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

    route add -net  10.0.1.0/24 gw 10.0.2.1 dev tun0

    You can leave out the iptables bits if the tunnel end points
    (host.network1 and host.network2 in the example) are the default route
    for their respective networks, or if you want to put static routes on
    all the systems on each network.

Here is some [more cool OpenSSH stuff](http://www.linux.com/article.pl?sid=06/05/19/145227).