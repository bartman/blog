+++
title = "debugging with -dbg libraries"
date = "2007-08-31T15:03:06-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['debian', 'devel', 'debug']
keywords = ['debian', 'devel', 'debug']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I am having a problem getting openssl to verify a signature that I generated from a smartcard.  I decided to step through the 
openssl code to see what it's actually doing when I call `RSA_verify()`... but I didn't feel like rebuilding openssl.

<!--more-->

        apt-get install libssl-dbg

... this installs some files under `/usr/lib/debug/usr/lib`.  A path that I have never seen before.  I was unable to get anywhere
with `LD_*_PATH` variables, then I found some reference that I should make this the gdb *debug file directory*.

        $ gdb
        (gdb) set debug-file-directory /usr/lib/debug

... this gives gdb access to the files that seem to have the debug info.  Then I add my breakpoint and run...

        (gdb) b RSA_verify
        ...

        (gdb) run
        ...

        (gdb) l
        147     rsa_sign.c: No such file or directory.
        in rsa_sign.c

... that makes sense, I don't have the source for openssl (yet).

        apt-get source openssl

Now I can tell gdb where to find it ...

        (gdb) dir /home/bart/tmp/openssl-0.9.8e/crypto/rsa/

Finally, gdb knows where it is.

        (gdb) l
        147             {
        148             int i,ret=0,sigtype;
        149             unsigned char *s;
        150             X509_SIG *sig=NULL;
        151     
        152             if (siglen != (unsigned int)RSA_size(rsa))
        153                     {
        154                     RSAerr(RSA_F_RSA_VERIFY,RSA_R_WRONG_SIGNATURE_LENGTH);
        155                     return(0);
        156                     }

oooh... yucky indenting. :)