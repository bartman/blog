+++
title = "qemu eats up /dev/shm"
date = "2007-07-16T11:45:53-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['qemu', 'linux', 'debian']
keywords = ['qemu', 'linux', 'debian']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I've been using qemu ([with kqemu]{kqemu-install}) to run my client's windows software, 
which talks to the linux driver/daemon that I **am** working on.  Having multiple qemu 
instances really chews into the shared memory... and the amount available depend on how /dev/shm
is mounted.

        # df /dev/shm
        Filesystem            Size  Used Avail Use% Mounted on
        none                  2.0G  713M  1.4G  35% /dev/shm

On Debian you can control this via `/etc/default/tmpfs` SHM_SIZE variable....

        SHM_SIZE=2048m

That's 2 gigs total that I can give to all the VMs.