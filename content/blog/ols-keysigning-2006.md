+++
title = "OLS keysigning / 2006"
date = "2006-07-29T14:41:29-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['ols', 'gpg']
keywords = ['ols', 'gpg']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I think this year's key post-*keysigning-party* work was the least effort ever.  I wanted to write down the procedure for anyone interested.

First a few assumptions:

 - you have been given a file that contains the fingerprints and names of everyone that attended the keysigning party,
 - you verified the file's sha1 sum at the event,
 - this file's sha1 sum was verified at the event by everyone whose keys you want to sign,
 - you trust that the people whose keys you are signing did not lie about checking the sha1 sum of the file.

A tool that make sthings easier is [caff](http://pgp-tools.alioth.debian.org/) and [gpg-agent](http://gnupg.org/).  

<!--more-->

        apt-get install keysigning-party gnupg-agent.

Install it and configure as per: "[Running caff with gpg-agent](http://svn.debian.org/wsvn/pgp-tools/trunk/caff/README.gpg-agent?op=file&rev=0&sc=0).  Also, run the agent:

        eval `gpg-agent --daemon`

Now prepare a list of keys you want to sign.  It needs to contain at least the fingerprints of all the keys that are in the event's file whose sha1 sum was validated.  I did this by
opening up vim with two buffers and copying the keys whose owners I identified at the event...

        vim -o tosign fingerprints.txt

Next, fetch all the keys:

        grep 'fingerprint = ' tosign | cut -d = -f 2 | cut -d ' ' -f 9- | tr -d ' ' | uniq > tosign.keys
        cat tosign.keys | xargs gpg --recv-keys 

Yes, `caff` usually does this for you, but the next step is to make sure that the keys you got match the fingerprint.  We do this in two cheezy shell hacks.

First get the fingerprints of the keys we downloaded:

        for key in `cat tosign.keys` ; do gpg --fingerprint $key ; done | grep 'fingerprint = ' | uniq > tosign.fprs

Then make sure that each of the fingerprints is in the `tosign` file.

        cat tosign.fprs | tr ' ' . | while read line ; do if ! ( grep -q $fprs tosign ) ; then echo -e "$fprs\n... not in 'tosign' file!" >&2 ; fi ; done

If you don't get any error reports then you can go ahead and sign everything...

        caff -u FF3459D52289688F `cat tosign.keys`

(you would replace the *FF3459D52289688F* with your key ID).

And as a final step I verify the fingerprints shows by gpg against the sheet given to me at the event.  But I cannot trust these fingerprints anyways, as they were printed out by the organizers.