+++
title = "Baking a cupcake"
date = "2009-08-16T15:18:54-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['android', 'g1']
keywords = ['android', 'g1']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

Today I wanted to see if I could build a bootable image for my Tmobile G1.

This post has been updated a few times.  I had a hard time building the `master` branch.
The `cupcake` branch built, but failed to run.  Next I tried `android-sdk-1.5_r3`, this
seems to boot but the phone is not really functional.  Next attempt was to build `cupcake`
and not change the kernel.  Duh!

<!--more-->

<b>Standard WARNING:</b> It worked for me, but it may not for you.  <font color=red>This may very well brick your phone!</font>

### Setup...

 - modern Linux distro (Debian/testing here)
 - standard build tools (gcc, make, etc)
 - Java6 JDK
 - Android SDK
 - the [repo](http://source.android.com/download/using-repo) utility in your path ([download repo](http://android.git.kernel.org/repo))
 - 5G of disk space

### Primitive build...

Next let's create a new repository to work in...

    # mkdir mydroid
    # cd mydroid
    # repo init -u git://android.git.kernel.org/platform/manifest.git -b cupcake

At this point you'll be prompted to tell the build system about yourself.  If you're already a 
git user, it will read the defaults from your git configuration (I think that's where it got
it from).

At this point only some meta data was downloaded.  You don't have any source code yet, so run...

    # repo sync

... to fetch all the sources from the kernel.org Android mirror site.  This could take a long time 
as it downloads about 1 gigabyte into the `.repo` directory... took about 30 min here.

As an aside, switching *repo* branches is done (to the best of my knowledge) by rerunning the `init` command
with a different `-b` option and then running `sync` to update the tree.  I may have this all wrong since
it takes just as long to do the `sync` as it did the first time :(

Now getting back to building, when `sync` is finished fetching things, you can continue with:

    # make

... this takes about an hour on my box.  It might work with `make -j10` but I have not tried.

### Now building it for real...

As before I start with a clean image...

    # mkdir mydroid
    # cd mydroid
    # repo init -u git://android.git.kernel.org/platform/manifest.git -b cupcake
    # repo sync

You should be able to just clean the existing image you have instead.

Here are the contents of my `local_manifest.xml` file...

    # cat > .repo/local_manifest.xml
    <?xml version="1.0" encoding="UTF-8"?>
    <manifest>
        <!--
             <remove-project name="kernel/common"/>
             <project path="kernel"                name="kernel/msm"                     revision="refs/heads/android-msm-2.6.29" />
             <project path="vendor/htc/dream-open" name="platform/vendor/htc/dream-open" revision="refs/heads/cupcake"            />
             <project path="hardware/msm7k"        name="platform/hardware/msm7k"        revision="refs/heads/cupcake"            />
        -->
        <project path="kernel"                name="kernel/msm"                     revision="refs/heads/android-msm-2.6.27" />
    </manifest>

Then sync up again

    # repo sync

While that's happening, you need to connect your rooted phone running some community firmware (liky CyanogenMod),
and start the Android Debug Bridge:

    # sudo adb start-server

Next copy all the proprietary bits out of the image:

    # cd vendor/htc/dream-open
    # ./extract-files.sh
    # cd -

Next setup the environemtn variables:

    # source build/envsetup.sh

Followisg that, change the build to build for the *HTC Dream*:

    # lunch htc_dream-eng

Now were are ready to build

    # make -j10

(rejoice, it completed in 13 minutes)

### Running the image...

<b>WARNING:</b> It worked for me, but it may not for you.  <font color=red>This may very well brick your phone!</font>

Finally, you get to program it into the phone:

    # cd out/target/product/dream-open
    # fastboot flash system system.img
    # fastboot flash boot boot.img
    # fastboot flash userdata userdata.img
    # fastboot reboot
    # cd -

OMG! it boots! but nothing really works.

### Disclaimer...

Apologies, this post is a work in progress.  I hope to get more details in here, but for now you can reed the fine links I've provided below.

### Resources...

 - Google/Android official build links
   - [Building For Dream](http://source.android.com/documentation/building-for-dream)
   - [Get source](http://source.android.com/download)

 - My Brain Hurts - [Building the Android source and Deploying it to your G1 or Dev Phone](http://www.koushikdutta.com/2008/12/building-android-source-and-deploying.html)

 - [Johan de Koning](http://www.johandekoning.nl/)'s *Building Android 1.5* series:
   - [Getting the source](http://www.johandekoning.nl/index.php/2009/06/07/building-android-15-getting-the-source),
   - [Building the source](http://www.johandekoning.nl/index.php/2009/06/08/building-android-15-building-the-source/),
   - [Flashing the phone](http://www.johandekoning.nl/index.php/2009/07/03/building-android-1-5-flashing-the-phone/), and
   - [Google Apps and audio files](http://www.johandekoning.nl/index.php/2009/07/12/building-android-1-5-google-apps-and-audio-files/).

 - Jean-Baptiste Queru's [The state of the branches](http://groups.google.com/group/android-platform/browse_thread/thread/3670ed63a7d9e3ab) post
   
   This thread is full of interesting bits like thread merging strategies, branch names, and relse number decoding.

 - Another useful thread on the topic of [Building cupcake for dream](http://groups.google.com/group/android-platform/browse_thread/thread/02d496adb75997d2/541a0ec1464c5aba?show_docid=541a0ec1464c5aba#)

 - Where to [download HTC proprietary binary bits](http://groups.google.com/group/android-platform/browse_thread/thread/c3fa817c33c99007?hl=en) required for building the image.

 - Linux Magazine's [Debugging an Android Application](http://www.linux-mag.com/cache/7491/1.html)

