+++
title = "brute force attacks sshd?"
date = "2005-01-10T22:55:22-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['security', 'linux']
keywords = ['security', 'linux']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

This will show you the IP addresses that have failed to login as well 
as the number of attempts that failed.  

grep 'Failed password ' /var/log/auth.log | sed 's/^.* \([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\) .*$/\1/' | sort  | uniq -c | sort -n | tail -n 10

You can safely ignore a few failed attempts, but I was getting close to 
3000 over the last week from one IP.  I decided that warranted some 
action. :)

I will probably grow this to a script that will automatically generate
and maintain a "evil IP list" in iptables.  For now you can take the top
offenders and drop them into a -j DROP rule.

