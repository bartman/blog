+++
title = "kvm nfs hang"
date = "2008-01-08T00:25:40-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['kvm', 'linux']
keywords = ['kvm', 'linux']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I ran into a strange NFS + KVM issue.  Every so often under heavy NFS load my KVM client

would hang retrying the nfs server.  On the console the client was showing:



        nfs: server host not responding, still trying



I found [this bug post](https://sourceforge.net/tracker/?func=detail&atid=893831&aid=1771262&group_id=180599)

which does not seem to have been resolved in 2.6.24.



Using the kvm flag `-net nic,model=rtl8139` fixed the problem for me.


