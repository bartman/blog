+++
title = "Cyanogen's recipe for Cupcake/Donut-like pastry"
date = "2009-08-30T17:45:51-04:00"
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

I finally got my [Cupcake to build]{baking-cupcake}.  The next step is to try to build something far tastier... naturally that
something has to be the Cyanogen Cupcake/Donut blend.

Grab a coffee, sit back, and read on to find out how to build your own CyanogenMod Android ROM from Cyanogen's Git repositories...

<!--more-->

### What is this poisonous pastry you speak of?

Wikipedia taught me that [Cyanogen](http://en.wikipedia.org/wiki/Cyanogen) is *is the chemical compound with the formula (CN)2. It is a colorless, toxic gas with a pungent odor.*
Fortunately you don't have to expose yourself to toxic gases to build this Android firmware.

The [Cyanogen](http://twitter.com/cyanogen) I speak of is a hacker alias for the mortal otherwise named Steve Kondik.  Cyanogen's firmware
is called CyanogenMod, and has it's own community page: [www.CyanogenMod.com](http://www.cyanogenmod.com).  Steve is clearly a superhero of
Android community builds.  I've been running his ROMs and I am enjoying the fruits of his labour.  Truly good stuff.

What makes Cyanogen's work impressive is that he makes all his work [available on github](http://github.com/cyanogen).  There
are quite a few trees and I wanted to unravel the mystery of building my own CyanogenMod-esque firmware.

### Getting the sources

[Like before]{baking-cupcake} you have to setup your environment.  You can refer to 
[Google's Android guide](http://source.android.com/download#TOC-Setting-up-your-machine) for that.  If you already have Java6, the 
Android SDK, and [repo](http://source.android.com/download/using-repo) utility in your `PATH`, then you're probably all set.

Next grab the android repo repository...

    # mkdir mydroid
    # cd mydroid
    # repo init -u git://android.git.kernel.org/platform/manifest.git -b cupcake
    # repo sync

... and get the `local_manifest.xml` from Cyanogen's [android github repo](http://github.com/cyanogen/android/downloads)

    # wget http://cloud.github.com/downloads/cyanogen/android/local_manifest-4.0.xml -O .repo/local_manifest.xml

... and sync up your tree ...

    # repo sync

### Building

After that you should have all of Cyanogen's sources, and can follow the [standard build instructions](http://source.android.com/documentation/building-for-dream),
starting at step 2.  For the purposes of completeness I include them here...

 - grab the `proprietary` files from an existing phone running a CyanogenMod firmware; the stock Tmobile G1 firmware will be missing a few files (possibly obtained from other Android phones).

        # cd vendor/htc/dream-open
        # ./extract-files.sh
        # cd -

 - update your environment for the build...
   
   `# source build/envsetup.sh`
   
   *This surprisingly works with `bash` and `zsh`.*

 - configure build system for Dream...
   
   `# lunch htc_dream-eng`
   
   *ok, seriously... why is this command called `lunch` ?*

 - and build...
   
   `# m`
   
   *In this case `make` works just as well.  The `m` comes from the envsetup.sh script you sourced in, and it builds everything.  There is also `mm` which builds just the directory you're in.*

### Sometimes things fail

In case of errors read them carefully.  I had to make the following minor fixes at build time.

 - in `external/obexftp` I had to patch one file to mask an error:

        diff --git a/obexftp/bt_kit.c b/obexftp/bt_kit.c
        index 06d03c7..e660b5c 100644
        --- a/obexftp/bt_kit.c
        +++ b/obexftp/bt_kit.c
        @@ -541,6 +541,7 @@ int btkit_unregister_service(int svclass)
                       DEBUG(1, "Service record unregistration failed.");
                 sdp_close(session);
        +        return 0;
         }

   The patch file is here: [cm-external-obexftp-btkit_unregister_service.patch](/~bart/patches/cyanogenmod/20090904/cm-external-obexftp-btkit_unregister_service.patch).

 - the file `libOmxCore.so` does not seem to be copied to `out`, as expected; I had to copy it in manually:

         # cp vendor/htc/dream-open/proprietary/libOmxCore.so \
              out/target/product/dream-open/obj/lib/libOmxCore.so

Following these you can rerun `m` or `make`.

### So, where is my firmware?

After the build is done you will have the interesting bits in `out/target/product/dream-open`

    out/target/product/dream-open/system.img
    out/target/product/dream-open/boot.img
    out/target/product/dream-open/recovery.img
    out/target/product/dream-open/userdata.img

The process of taking this and building a signed `update.zip` has a few more steps, which I hope to document at some point.  But this firmware is
enough to run on your device.

### Flashing

<b>WARNING:</b> Please be cautious.  <font color=red>This may very well brick your phone!</font>   I am not responsible for broken phones.

To flash them you'll need to put `fastboot` in your `PATH`.  The binary was built as part of the standard build and lies in `out/host/linux-x86`.

    # export PATH=$PATH:out/host/linux-x86/bin

You'd flash your phone using fastboot like so...

    # cd out/target/product/dream-open
    # fastboot flash system system.img
    # fastboot flash boot boot.img
    # fastboot flash userdata userdata.img
    # fastboot reboot
    # cd -

I think it's best not to flash in the recovery.img.  Should you have problems with your build, you can still recover by
going back to the recovery image and flashing in the real CyanogenMod ROM.

### Links

- Cyanogen
  - ... on [github](http://github.com/cyanogen)
  - ... the [manifests](http://github.com/cyanogen/android/downloads)

- Google docs
  - [Installing the Android SDK](http://developer.android.com/sdk/1.5_r3/installing.html)
  - [Get source](http://source.android.com/download)
  - [Building For Dream](http://source.android.com/documentation/building-for-dream)

- Building writeups
  - [Building the Android source and Deploying it to your G1 or Dev Phone](http://www.koushikdutta.com/2008/12/building-android-source-and-deploying.html)
  - [Building Android 1.5 – Getting the source](http://www.johandekoning.nl/index.php/2009/06/07/building-android-15-getting-the-source) 
    - [part 2](http://www.johandekoning.nl/index.php/2009/06/08/building-android-15-building-the-source/),
      [part 3](http://www.johandekoning.nl/index.php/2009/07/03/building-android-1-5-flashing-the-phone/),
      [part 4](http://www.johandekoning.nl/index.php/2009/07/12/building-android-1-5-google-apps-and-audio-files/)

Other
  - [XDA full text search](http://wiki.xda-developers.com/index.php?pagename=FullTextSearch&s=hardspl)
    - [HTC Dream - Bootloaders](http://wiki.xda-developers.com/index.php?pagename=HTC_Dream_Bootloader)
    - [HTC Dream Root](http://wiki.xda-developers.com/index.php?pagename=HTC_Dream_Rooting)
    - [HTC_Dream__haykuro_Cupcake](http://wiki.xda-developers.com/index.php?pagename=HTC_Dream__haykuro_Cupcake)
    - [HTC Dream - Overview and useful information](http://wiki.xda-developers.com/index.php?pagename=HTC_Dream_overview_and_useful_information)

  - [config.gz from 32b](http://forum.xda-developers.com/showpost.php?p=4496062&postcount=703)

