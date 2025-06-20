+++
title = "klips loses zlib"
date = "2007-02-18T00:22:14-05:00"
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

Last time I [wrote about openswan]{leaner-meaner-openswan} I commented how Martin and I chopped off 
18 thousand lines from KLIPS.

Most recently I finished rewriting IPCOMP handling to use CryptoAPI's api to zlib, and Martin was able
to remove the zlib that was duplicated in KLIPS.  Here are the updated stats:

        $ git diff origin/public HEAD -- include/openswan net/ipsec/ | diffstat | tail -n1
         135 files changed, 14549 insertions(+), 39839 deletions(-)

That, along with other cleanup, bumped us up to **25k** lines less then the #public branch of openswan.

It may also be interesting to note that so far we have removed about half the KLIPS code:

        $ git diff v2.6.18 HEAD -- include/openswan net/ipsec/ | diffstat | tail -n1
         77 files changed, 28290 insertions(+)

We're not quite there, but working hard :)

If you wish to play with the code, please seed from kernel.org before fetching from me:

        $ git clone git://git2.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ linux-2.6.git
        $ git clone --reference linux-2.6.git git://git.jukie.net/klips-fsm.git/ klips-fsm.git
