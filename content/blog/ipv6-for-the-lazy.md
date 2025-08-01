+++
title = "ipv6 on your desktop in 2 steps"
date = "2010-11-03T09:51:30-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['ipv6', 'debian']
keywords = ['ipv6', 'debian']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

Some people have been telling me that they "have no time" or "are too lazy" to setup IPv6 on their desktop, but would like to.

Below are 2 easy steps to get IPv6 running on your Debian Linux sytem (shoudl be identical on Ubuntu, and similar distros).

If you're not running Linux, check out these pages instead: [MacOS X](http://www.deepdarc.com/miredo-osx/), [Windows](http://pugio.net/2007/07/howto-enable-ipv6-the-teredo-w.html).

<!--more-->

### 1 - security

At present, most of the home users use NAT.  This means that connections from outside to your network are mostly impossible.  This provides some sense of pseudo-security.  With IPv6, you get full connectivity between all systems on the network.

Do you really want everyone in the world to be able to ssh to your sytem?  Mabye not.

Here is a simple way to add *stateful firewalling* to your IPv6 setup.  This setup will permit connections you initiate, but drop connections from outside.

 * Put [this script](http://git.jukie.net/snippets.git/plain/ultra-simple-stateful-firewall/etc/network/if-pre-up.d/iptables) in `/etc/network/if-pre-up.d/iptables` <br>
   and make it executable: `chmod +x /etc/network/if-pre-up.d/iptables`

 * Put [the IPv6 firewall config](http://git.jukie.net/snippets.git/plain/ultra-simple-stateful-firewall/etc/default/ip6tables) in `/etc/default/ip6tables`. <br>
   (lines that start with a *#* are comments... read them)

 * Load the firewall rules: <br>
   `sudo ip6tables-restore < /etc/default/ip6tables` <br>
   (it will start up on the next boot automatically)

You don't have connectivity yet, but the firewall is now configured.

If you like the idea of a stateful firewall for your IPv4, grab the [the IPv4 firewall config](http://git.jukie.net/snippets.git/plain/ultra-simple-stateful-firewall/etc/default/iptables) and put it in `/etc/default/iptables`.  this may break your connectivity since it's very restrictive... read the file before you decide to use it.

### 2 - miredo

[Miredo](http://www.remlab.net/miredo/) is a program that implements [Teredo tunneling](http://en.wikipedia.org/wiki/Teredo_tunneling) for UNIX systems.  Toredo is by far the easiest way to get IPv6 on your system, and Miredo is the easiest way to do that on Debian.

        sudo apt-get install miredo
        sudo /etc/init.d/miredo restart

In seconds you'll be connected and you'll be able to verify your IPv6 connectivity.

        ping6 ipv6.google.com

If you want to know what dynamic IPv6 address miredo gave you, you can run this:

        ip -6 ad show dev teredo | awk '/^ *inet6 / { print $2 }'

The address that starts with `2` is your public address.  The address started with `fe80::` is [Link-local address](http://en.wikipedia.org/wiki/Link-local_address#IPv6) and is not used for communicating with hosts on the internet, but rather to talk to routers.