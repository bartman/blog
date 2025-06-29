+++
title = "uml and multiple network segments"
date = "2006-07-13T17:47:23-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['uml', 'linux']
keywords = ['uml', 'linux']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I am doing a lot of network testing and require multiple virtual networks
created for my UML's.  Debian's uml-utilities package does not currently support
bringing up multiple network segments, although the uml_switch daemon can
be ran multiple times.  In such a setup each uml_switch is associated with
it's own tapX device and maintains one network segment.

I modified two files:

  - [/etc/init.d/uml-utilities](http://www.jukie.net/~bart/debian/uml/utilities/init.d-uml-utilities)
  - [/etc/default/uml-utilities](http://www.jukie.net/~bart/debian/uml/utilities/default-uml-utilities)

And filed bug [378166](http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=378166).

<!--more-->

The remaining bit to configure for you is your `/etc/network/interfaces` to assign the right IPs to the tapX 
devices...

        auto tap0
        iface tap0 inet static
                address 192.168.10.254
                netmask 255.255.255.0
                tunctl_user uml-net
                up echo 1 > /proc/sys/net/ipv4/conf/tap0/forwarding

        auto tap1
        iface tap1 inet static
                address 192.168.20.254
                netmask 255.255.255.0
                tunctl_user uml-net
                up echo 1 > /proc/sys/net/ipv4/conf/tap1/forwarding


And finally you have to pass the right configuration to your uml instances.  Here is an example of what my 
uml startup looks like:

    ./east.linux \
            mode=skas0 \
            mem=256M \
            ubd0=east.fs \
            root=/dev/ubda 
            eth0=daemon,,unix,/var/run/uml-utilities/uml_switch.tap0.ctl \
            eth1=daemon,,unix,/var/run/uml-utilities/uml_switch.tap1.ctl \
            con0=fd:0,fd:1 
            umid=east

And that will start a UML instance connected to two network segments.

Now, onto [Openswan](http://www.openswan.org/) testing.