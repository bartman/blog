+++
title = "prettier function tracing"
date = "2009-08-20T21:53:58-04:00"
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

This is a follow up to my [pretty function tracing]{pretty-function-tracing} article.  I base this work on the code presented there.

Some one asked me how to get the gcc `-finstrument-functions` feature working.  If you don't know this
flag will modify the entry and exit to/from each function to make a call out to a special set of functions used
for tracing.

While I've read about this feature, I never actually tried it.  So here is what I learned...

<!--more-->

When you compile a *C* file with `-finstrument-function`, each function entry and exit will receive
the following respective callouts.  You're responsible to create these functions.

 - `__cyg_profile_func_enter(void *this_fn, void *call_site)`
 - `__cyg_profile_func_exit(void *this_fn, void *call_site)`

In the above two pointers are passed to the instruction that represents the function, `this_fn`,
and the location from which the call was made, `call_site`.

This could be as easy as implementing:


    void __cyg_profile_func_enter(void *this_fn, void *call_site)
    {
            printf("entry to %p from %p\n", this_fn, call_site);
    }
    __cyg_profile_func_exit(void *this_fn, void *call_site)
    {
            printf("exit from %p to %p\n", this_fn, call_site);
    }

It just prints the hex numbers of functions, which then requires post processing.

The [code I wrote](http://gitweb.jukie.net/function-tracer.git?a=blob;f=cyg.c;hb=HEAD)
uses the `backtrace_symbols()` glibc function that converts an offset in the running
executable into a string that describes the symbol.  It's usually used along with
the `backtrace()` function to generate stack dumps (or backtraces).  See 
the *manpage* if you're interested.

A few notes:

 - Don't pass the `-finstrument-function` parameter when compiling the tracing function as that would lead to recursion.
   
   In my example I put that code into a separate file `cyg.c`.

 - To get symbol resolution to work use `-g` when building and `-g -rdynamic` when linking.  See
   my [Makefile](http://gitweb.jukie.net/function-tracer.git?a=blob;f=Makefile;hb=HEAD).

 - My sample code is available in a git repo: [git://git.jukie.net/function-tracer.git](http://gitweb.jukie.net/function-tracer.git)

I now get traces like this:

    # make
    # ./a
    ,-< main(./a) from __libc_start_main+0xe6(/lib/libc.so.6)
    | ,-< f1(./a) from main+0x27(./a)
    | | ,-< f1a(./a) from f1+0x1a(./a)
    | | `-> f1a(./a) from f1+0x1a(./a)
    | `-> f1(./a) from main+0x27(./a)
    | ,-< f2(./a) from main+0x34(./a)
    | | ,-< f2a(./a) from f2+0x1a(./a)
    | | `-> f2a(./a) from f2+0x1a(./a)
    | `-> f2(./a) from main+0x34(./a)
    `-> main(./a) from __libc_start_main+0xe6(/lib/libc.so.6)

To get any more out of this trace (like values passed in function parameters) you'd have to use
a disassembler.

### Resources

 - [Backtrace Library](http://www.wolf-software.net/Libraries/backtrace/)