+++
title = "klips-less openswan git tree"
date = "2007-02-22T21:53:55-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['openswan', 'klips']
keywords = ['openswan', 'klips']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

Recently Martin merged *openswan/pfkeyv2.h* with *linux/pfkeyv2.h*.  Sparks flew.
Michael Richardson and I have tried this before and decided to postpone it.  

I merged it into my tree, so it seems that we have to do the hard thing and 
divorce klips from openswan.git.  This basically requires that we create an openswan tree
that builds against pfkey definitions in another tree.

Michael suggested that Martin and I start with the #unstable branch of openswan.git.

What I see happening eventually is this `include/linux/pfkeyv2.h` defining all the 
pfkey RFC bits, and `include/klips/pfkeyv2.h` including that and adding it's 
extensions.  For now we will be happy if we can get pluto talking to the new 
*franken-klips*.

<!--more-->

So I am starting a new tree for klips-less openswan development.  Please seed from
openswan if you want it.

        # git clone http://git.openswan.org/public/scm/openswan.git/ openswan.git
        # git clone --reference openswan.git git://git.jukie.net/openswan-klipsless.git/

Currently this has nothing in it (technically it has the public openswan/#unstable branch).  Over 
the next few days I will trim out klips bits and teach the makefiles to build with an external klips tree.

Man... ripping code out is so much fun!

        $ git diff public/unstable HEAD | diffstat | tail -n 1
         251 files changed, 7 insertions(+), 91483 deletions(-)
