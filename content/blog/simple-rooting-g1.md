+++
title = "simpler android rooting"
date = "2009-08-27T10:02:32-04:00"
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

I've previously written about [how to root an android phone]{rooting-g1}, and mentioned that [there was a better way](http://androidandme.com/2009/08/news/root-a-t-mobile-mytouch-3g-or-g1-in-6-minutes-and-flash-cyanogens-rom-with-donut-crumbs/)
which I had not tried yet.  Well, I did try it today.

The procedure written by [Zinx](http://zenthought.org/content/project/flashrec) from [ZenThought](http://zenthought.org/) exploits a recently found bug in the Linux kernel (see [CVE-2009-2692](http://web.nvd.nist.gov/view/vuln/detail?vulnId=CVE-2009-2692)).

<!--more-->

<b>WARNING:</b> <font color=red>this may very well brick your phone!</font>  Read all the instructions here, and the links I provide.  If you're still not discouraged, continue on :)

<b>UPDATE 20090904:</b> The *flashrec* tool now supports 32a and 32b CPUs.  Read the [flashrec project page](http://zenthought.org/content/project/flashrec) for details.  See my other post titled:
[the dreaded process of rooting Rogers Dream]{rooting-rogers-dream}.

The exploit code is a fun read and I encourage the geeks to go and get [flashrec-20090815.tar.gz](http://zenthought.org/system/files/asset/2/flashrec-20090815.tar.gz) and read it.

For the rest of you, here are the steps to use it:

 - on a freshly network-unlocked Tmobile G1...
 - point your browser at [flashrec-1.1-20090904.apk](http://zenthought.org/system/files/asset/2/flashrec-1.1-20090904.apk), or a shorter version of the url [http://2tu.us/rhg](http://2tu.us/rhg)
 - follow the procedure to allow untrusted package sources
 - run the app
 - backup your current recovery image
 - download the new recovery image
 - install the new recovery image
 - now reboot the phone to recovery mode; you can do either:
   - regular shutdown, and power up with HOME key held, or
   - `adb shell reboot recovery`

... and now you can install any rom you want.

<b>NOTE:</b> if you boot the Tmobile firmware now, it will reflash the original recovery image; should this happen just run the *flashrec* app again.

To install the latest CyanogenMod, you'll need to download...

 - for <font color=blue>Tmobile G1</font> get these files:
   - [ota-radio-2_22_19_26I.zip](http://android-roms.googlecode.com/files/ota-radio-2_22_19_26I.zip)
   - [update-cm-4.0.4-signed.zip](http://n0rp.chemlab.org/android/update-cm-4.0.4-signed.zip)

<!--
 - for <font color=red>Rogers Dream</font> you just want one:
   - [cm404-32a-signed.zip](http://briancrook.ca/magic/cm404-32a-signed.zip)
   -->

copy both to the SD card.  If you have the [Android Debug Bridge](http://developer.android.com/guide/developing/tools/adb.html) (or `adb`) working
you can just run:

    # adb push ota-radio-2_22_19_26I.zip /sdcard/ota-radio-2_22_19_26I.zip
    # adb push update-cm-4.0.4-signed.zip /sdcard/update-cm-4.0.4-signed.zip

<!--
... or for rogers ...

    # adb push cm404-32a-signed.zip /sdcard/cm404-32a-signed.zip
    -->

From the `Android system recovery` screen (power up with `HOME` key held).

*(note, you can use the rolly-ball to manuver the menu and push the ball to select options)*

 - Flashing for <font color=blue>Tmobile G1</font>...
   - select `Alt-A` or `apply any zip from sd`
   - select `ota-radio-2_22_19_26I.zip`  
     
     ... wait ...
  
   - select `Alt-A` or `apply any zip from sd`
   - select `update-cm-4.0.4-signed.zip`

<!--
 - Flashing for <font color=red>Rogers Dream</font>...
   - select `Alt-A` or `apply any zip from sd`
   - select `cm404-32a-signed.zip`
   -->

 - On first rooting you need to wipe to factory defaults
   - reboot with `HOME` + `BACK` keys.
     
     ... wait ...

   - select `Alt-W` or `wipe data/factory reset`
   - reboot with `HOME` + `BACK` keys.
     
     ... wait a long time ...
     
   - if you come back to the recovery menu, reboot with `HOME` + `BACK` keys again.
     
     ... now, wait some more ...

On the first boot (and it will reboot several times) it will take under 5 minutes.  Be patient.
During this first long boot the phone is initializing the apps.

### Where did fastboot go?

If you install using this method you will have the nice recovery image, and a nice image
to run, but you will still have the original Tmobile G1 SPL (the bootloader).  <b>If you want fastboot</b>
you will need to install the [HardSPL](http://wiki.xda-developers.com/index.php?pagename=HTC_Dream_Bootloader)
bootloader separately.

It is important to reemphasize the importance of what will happen if this doesn't work... <b>you will brick your phone</b>.
Go to [this page](http://wiki.xda-developers.com/index.php?pagename=HTC_Dream_Bootloader), read it, and decide if what you're doing is fine with you.

The procedure is as follows:

 - download [splhard1_update_signed.zip](http://forum.xda-developers.com/attachment.php?attachmentid=142426&d=1230965195)
 - put it on the sdcard (maybe with `adb push`)
 - reboot holding `HOME`
 - select `Alt-A` and flash with the `splhard1_update_signed.zip` file
 - power down
 - boot holding `BACK` button

You now have `fastboot`...

    # fastboot devices
    HT123XY45678        fastboot

*Yey!*