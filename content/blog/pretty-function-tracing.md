+++
title = "pretty function tracing"
date = "2006-07-26T22:45:31-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['code', 'c']
keywords = ['code', 'c']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I wanted to see how different functions got used in a block of code that I was new to... and was having a hard time understanding.  My UML instance was acting flaky and didn't 
cooperate with gdb, so I could not single step the code.

I added a small chunk of C code to generate pretty tracing that looks like this:

        ,-< ipsec_sa_wipe:946
        | ,-< ipsec_sa_put:549
        | `-> ipsec_sa_put:561 = 0
        `-> ipsec_sa_wipe:1054 = 0

Functions can nest upto 25 times (arbitrary max) and after that it stops indenting nicely.  The code has to be modified so that at the entry of each block there is a call to the 
`IN` macro, and on the exit to the  `OUT` macro.  Here is an example:

        void
        foo (void)
        {
                IN();

                // something

                OUT();
        }

Have a look at [the code](/~bart/snippets/pretty-function-tracer.c.html).

I should probably hack something like this using [systemtap](http://sources.redhat.com/systemtap/) or at least use [jprobes](http://sourceware.org/ml/systemtap/2005-q2/msg00507.html) for
the tracing instead of modifying the source.

**Related:**

 - a [friend pointed me](http://phobos.ca/mediawiki/index.php/Function_enter/leave_Instrumentation) to gcc `-finstrument-functions` option that makes gcc generate calls to an arbitrary handler for each function entered and exited.
 - [hrprof](http://handhelds.freshmeat.net/projects/hrprof/) uses the `-finstrument-function` feature and extracts more information.
 - a bit more research revealed [etrace](http://ndevilla.free.fr/etrace/) which seems to do this kind of function tracing at run-time.