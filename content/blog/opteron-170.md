+++
title = "opteron 170"
date = "2006-08-02T21:01:26-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['hardware', 'opteron']
keywords = ['hardware', 'opteron']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

My new shiny Opteron 170 just came in.  I used to say that *Opteron 1xx* line was a waste of money because it was basically the Athlon64 
but more expensive because of the Opteron branding.  Recently AMD made the choice easier by dropping dual-core Athlon64 processors with 
2M of L2 cache.  The last line of Athlon64 S939 will have a 512k L2 cache.  That's a mere 256k per core.  And isn't that only twice the 
size of the L1 cache?  yuck!

So, I blew the extra $300 on the extra 1.5M of L2 cache.

<!--more-->

**simple benchmarks...**

The only legitimate benchmark for me is a kernel compile.  I don't play games, I don't rip DVDs, I don't use spreadsheets, and I don't run
simulations.  I do however rebuild kernels (and other software) all the time.

NOTE: I am using the `make -jN` rule which dictates that N should be number of CPUs plus 1.  The 1 is to offset the overhead of blocking 
on disk I/O.

`BENCHMARK 1`

  I upgraded a 1 year old computer with this dual-core S939 cpu.  The old kernel was not compiled for SMP.  So it was time to 
  rebuild the kernel.  I grabbed the latest stable v2.6.17.7 and rebuilt it.  I disabled `ccache` for the benchmark.  Note I 
  have a lot of modules enabled, so this is a bloated kernel.

  Numbers may also be lower because my system is using RAID0... that makes writes to disk suck.

  - UP (one core enabled) 

        $ git clean -d
        $ make oldconfig
        $ time make CC=/usr/bin/gcc -j2
        real    22m27.897s
        user    19m42.098s
        sys     2m29.285s

  - SMP (both cores)

        $ git clean -d
        $ make oldconfig
        $ time make CC=/usr/bin/gcc -j3
        real    13m20.870s
        user    22m15.962s
        sys     3m40.155s

  So it looks like the first time the build (minus `sys` because I don't care about disk activity) took ~20 minutes.  The SMP test was about ~10 minutes.  Nice.

`BENCHMARK 2`

  I do a lot of driver development on UML.  This is a test of how much time I am saving per compile.

  - UP (one core enabled) 

        $ git clean -d
        $ make ARCH=um oldconfig
        $ time make ARCH=um CC=/usr/bin/gcc -j2
        real    4m4.847s
        user    3m17.264s
        sys     0m24.823s

  - SMP (both cores)

        $ git clean -d
        $ make ARCH=um oldconfig
        $ time make ARCH=um CC=/usr/bin/gcc -j3
        real    2m32.683s
        user    3m38.234s
        sys     0m35.762s

  This is a much leaner kernel configuration. :)

  Again, two cores give about twice the performance.

`BENCHMARK 3`

  I use `distcc` a lot.  Does a second core help here?

  NOTE: the first build run just primes the cache.

  - UP (one core enabled)

        $ git clean -d
        $ make ARCH=um oldconfig
        $ make ARCH=um -j2

        $ git clean -d
        $ make ARCH=um oldconfig
        $ time make ARCH=um -j2
        real    1m7.986s
        user    0m38.413s
        sys     0m14.007s

  - SMP (both cores)

        $ git clean -d
        $ make ARCH=um oldconfig
        $ make ARCH=um -j3

        $ git clean -d
        $ make ARCH=um oldconfig
        $ time make ARCH=um -j3
        real    0m59.191s
        user    0m54.497s
        sys     0m21.378s

  Looks even better then twice the speed.  I guess that's because we are doing less computing, and relatively more IO... and it's better to have more CPUs when you're waiting on IO to handle the bursty data arriving from disk.

**(in)stability...**

  I had a few lockups while in X windows and running high-CPU utilizing tasks.  I was in X and didn't have a serial console hooked up so I don't know what the problem actually was... it just froze.

  My first hunch is that it's related to DRM or the ATI card I have in the box.  Since I had these modules built into the kernel and didn't feel like recompiling again (even though it's super fast now), I tried `noapic` on the kernel
  command line (in GRUB).  That seems to have fixed it, for now.

  I also did some searching and found an article on the AMD forums [talking about similar issues in Windows](http://forums.amd.com/index.php?showtopic=80512).  There are 3 hypothesis raised there, and the guy finally disables the 
  NIC which solves his issues.  Another poster talked about power requirements of the system.  I will have to swap in another PS and see if that helps.

