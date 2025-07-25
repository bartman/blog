+++
title = "entropy injection"
date = "2006-04-28T14:51:40-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['linux', 'kernel', 'code']
keywords = ['linux', 'kernel', 'code']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I was installing openswan on my [sbc]{tag/sbc} router box.  The sbc doesn't have much hardware on it, and what it does
have did not contribute to the entropy pool.  

I have a few boxes around with relatively good entropy (keyboard/mouse input), but there was no way to pass 
that entropy to the router for RSA key generation.  I had to write some code to fix it.  Be warned, it's 
pretty **EVIL**...

**UPDATE:** see below about *rng-tools*.

<!--more-->

I started by reading the code of the random driver.  It would seem that there was no easy way to inject entropy into
the driver.  There are two interfaces to do so, on an irq number, and for block devices.  The first interface seems
to only be available to code that is compiled into the kernel as `rand_initialize_irq()` and `add_interrupt_randomness()`
are not exported symbols.

That leaves teh block device entropy generation scheme.  There is a little problem here too.  While
`add_disk_randomness()` is exported to modules, `rand_initialize_disk()` is not.  The *initialize* function must
be called the first time to setup a randomness state pointer in the *struct gendisk* object.

So had to copy some of that out.  The code is available here:
[entinj.c](/~bart/snippets/entropy-injector/entinj.c)
[Makefile](/~bart/snippets/entropy-injector/Makefile)

After building it, you should insmod the module and run:

        ssh random-system cat /dev/random > /dev/entinj

**WARNING:**  It works for me, it may not work for you.  I have not ran any random number validation tests, 
and I have not look at the code in enough detail to make sure that the random numbers are good.  

What I should do some day is actually get randomness of the Geode's GPIO pins and connect it to something 
that can generate random bits the correct way.

**UPDATE:** I have since learned about **rng-tools** package.

        apt-get install rng-tools pv
        ssh random-system cat /dev/random | pv -Wrb | rngd -f -r /dev/stdin

Which will read the randomness off one system, and then inject it into the local entropy pool
*(pv will just show the rate of randomness data being transfered through the pipe)*.
