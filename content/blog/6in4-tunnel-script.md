+++
title = "how to manually create a 6in4 tunnel"
date = "2011-05-17T20:46:17-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['ipv6', 'linux', 'script']
keywords = ['ipv6', 'linux', 'script']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I'm doing some IPv6 codig for a client and needed to setup a bunch of [6in4](http://en.wikipedia.org/wiki/6in4) tunnels.

Thre are many ways to do this through distribution init scripts ([Debian](http://wiki.debian.org/DebianIPv6), [Fedora](http://dice.neko-san.net/2011/03/fedora-sysconfig-for-6in4-tunnel-router/)), but I wanted something less permanent and more dynamic for testing.

The procedure can be summarized in these steps:

- create a tunnel `mytun` between local `1.1.1.1` and remote `2.2.2.2`

        ip tunnel add mytun mode sit local 1.1.1.1 \
                        remote 2.2.2.2 ttl 64 dev eth0

- give the local end an address

        ip addr add dev mytun f8c0::1.1.1.1/64

- bring up the tunnel

        ip link set dev mytun up

<!--more-->

And here is a script that builds both ends of the tunnel: [mk6in4tun](http://git.jukie.net/snippets.git/tree/mk6in4tun/mk6in4tun)

    ./mk6in4tun 2.2.2.2
    ### tunnel topology
        [f8c0:69bd::1.1.1.1] 1.1.1.1 (eth0) <======> (???) 2.2.2.2 [f8c0:69bd::2.2.2.2]

    ### local setup ###
        sudo modprobe ipv6
        sudo ip tunnel add tun69bd mode sit local 1.1.1.1 remote 2.2.2.2 ttl 64 dev eth0
        sudo ip addr add dev tun69bd f8c0:69bd::1.1.1.1/64
        sudo ip link set dev tun69bd up
        sudo iptables -I INPUT -s 2.2.2.2 -d 1.1.1.1 -p 41 -j ACCEPT

    ### remote setup ###
        sudo modprobe ipv6
        sudo ip tunnel add tun69bd mode sit local 2.2.2.2 remote 1.1.1.1 ttl 64 
        sudo ip addr add dev tun69bd f8c0:69bd::2.2.2.2/64
        sudo ip link set dev tun69bd up
        sudo iptables -I INPUT -s 1.1.1.1 -d 2.2.2.2 -p 41 -j ACCEPT

    ### taredown instructions ###
        sudo ip tunnel rem tun69bd
