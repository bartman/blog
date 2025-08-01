+++
title = "leaner meaner openswan"
date = "2007-02-04T10:01:00-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['openswan', 'ipsec', 'linux', 'kernel']
keywords = ['openswan', 'ipsec', 'linux', 'kernel']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I started working for [Xelerance](http://www.xelerance.com) in April of 2006, 
and the [contract](http://biz.yahoo.com/prnews/070205/sfm078.html?.v=77) ended in 
December.  Since then I've been working on a KLIPS-ng, of sorts.  The idea was 
to remove all the crypto code from KLIPS and convert it to use CryptoAPI 
already in the Linux kernel.

Last objective of my work was to add OCF support to KLIPS, so that we could take advantage of 
the asynchronous crypto facilities provided there, as well as several OCF hardware drivers.  The BSD 
kernels have been using OCF, [Open Cryptographic Framework](http://ocf-linux.sourceforge.net/),
for some time and more recently it was ported to Linux.

<!--more-->

A lot of work as already been finished.  and we are a lot leaner.

        $ git diff origin/public my-ocf+fsm_v2.6.18 -- include/openswan net/ipsec/ | diffstat | tail -n1
         98 files changed, 5688 insertions(+), 22162 deletions(-)

That's about **16k** lines less... and still functional.

Recently Martin Hicks has expressed interest in fixing up KLIPS to bring it upto date with the 
[CodingStyle](http://lxr.linux.no/source/Documentation/CodingStyle), and to remove all 
the support for prehistoric kernels.  He would like to see KLIPS put up for inclusion into the 
kernel.

I suggested that he start not with the #public branch of KLIPS but with my tree where some of
the warts have been removed.

In the last week, he's been a patching machine!

        $ git diff origin/public HEAD -- include/openswan net/ipsec/ | diffstat | tail -n1
         130 files changed, 18140 insertions(+), 36060 deletions(-)

We are now **18k** lines leaner then #public.

The tree is available at *git://git.jukie.net/klips-fsm.git/*, but I would really appreciate if you seeded
from linux before getting my changes.  Here is one way you could do this:

        git clone git://git2.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ linux-2.6.git
        git clone --reference linux-2.6.git git://git.jukie.net/klips-fsm.git/ klips-fsm.git

(this will clone Linus' tree into `linux-2.6.git` and then use that as an *alternative* source of
   revisions to complete your clone of `klips-fsm.git`)

There have been two regressions that I noticed:

  - soft CPU lockups (seen once and not again)
  - compression is broken, but possibly in pluto 

My immediate KLIPS TODO list is:

  - compression needs a complete rewrite against CryptoAPI
  - implement OCF hooks in the new framework
  - finish asynchronous handling (it's been started)
