+++
title = "rpm hell is right"
date = "2006-06-08T09:21:57-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['linux', 'redhat']
keywords = ['linux', 'redhat']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

Joey Hess [blogs](http://kitenet.net/~joey/blog/entry/rpm_hell.html) about [bug 119185](https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=119185) in the Red Hat bugzilla.

Wow!  Talk about screwing your users.  I am not sure if *Jeff Johnson* speaks for Red Hat.  If he does, why would anyone want to use a Red Hat (or Red Hat based) distro.

The rpm bug is one thing, but treating your client this poorly is awful.  I am surprised how patient *Tethys*, the poster, was about the whole process.  It is clear that he feels more strongly about the quality of the product then the vendor does.

It sounds like in the end another person, possibly from Red Hat or Fedora, came up to the plate and they worked out a solution that checks for existence of read-only mounts.  Not perfect, but at least it addresses the problem the client had.

Sounds like *dpkg* does the right thing, it fails to install the package on the first write failure to disk.  It then rolls back.
