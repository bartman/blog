+++
title = "rooting the droid"
date = "2009-07-31T18:55:22-04:00"
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

In my continued quest to learn more and start hacking on the Android phones,
I've recently rooted my Android based HTC Dream (aka Tmobile G1) phones.

I'll start by explain the terminology.  There are two ways in which the phones can be unlocked:

 - so called *rooting*, which I describe in this post, involves replacing the bootloader so that the phone can use
   community generated firmware images, aka *ROM*'s.

 - there is also *unjailing* or *unlocking* the phone so that it can be used with any SIM card on any GSM network;
   and I'll talk about that in due time.

<!--more-->

<b>WARNING:</b> <font color=red>this may very well brick your phone!</font>  Read all the instructions here, and the links I provide.  If you're still not discouraged, continue on :)

Before you proceed, I cannot stress the importance of following directions.

 - Here are [five great reasons to root your Android phone](http://lifehacker.com/5342237/five-great-reasons-to-root-your-android-phone?skyline=true&s=i), in case you were currious why anyone would.

 - I used the excellent [Beginners Guide for Rooting your Android G1 to install Cupcake](http://androidandme.com/2009/05/guides/beginners-guide-for-rooting-your-android-g1-to-install-cupcake/)
   
   <b>UPDATE:</b> The guide I used has been rewritten as [How to root a T-Mobile G1 and myTouch 3G Android phone](http://androidandme.com/2009/08/news/how-to-root-a-t-mobile-g1-and-mytouch-3g-android-phone/), it now has more details and screenshots.
   
   <b>UPDATE 2:</b> Have not tried yet, but there is a new exploit that installs root on most recent firmware; see [Root a T-Mobile myTouch 3G or G1 in 6 minutes and flash Cyanogen’s rom with Donut crumbs](http://feedproxy.google.com/~r/androidandme/~3/ijUUOZz8Edg/).
   
   There are multiple write-ups like this one.
 
   - I initially started with [How-to- Root, Hack, and Flash your G1/Dream](http://forum.xda-developers.com/showthread.php?t=442480)
     article posted on [XDA developers](http://forum.xda-developers.com/) forums.
     
     It was very accurate, but rather old.  It does not use the `root.apk` application from the marketplace, which does most of the
     work for you.
   
   - there is also [How To Root Your T-Mobile G1](http://www.droidproof.com/blog/how-to/how-to-root-your-t-mobile-g1/)
     at the [DroidProof](http://www.droidproof.com/) blog.  The write up has 
     a [YouTube video](http://www.youtube.com/watch?v=tS9l2XVG0iY) that maybe worth watching.
     It's based on the previous (old) method of rooting, but note that they forget to tell you start up `telnetd` first.
   
   - another one is [US/UK T-mobile HTC Dream G1 import/modding/jailbreak guide](http://hdmp4.com/G1%20import%20guide),
     but I have not looked at it.  It has some links to different discussion threads that may help if you're stuck.

 - While I encourage you to follow the [Beginners Guide](http://androidandme.com/2009/05/guides/beginners-guide-for-rooting-your-android-g1-to-install-cupcake/),
   it basically boils down to this:
   
   - downgrade to RC29 (which has that [famed root exploit](http://mobile.slashdot.org/article.pl?sid=08/11/08/1720246))
   - gain root using [root.apk](http://www.androidactivity.com/root/root.apk) (less typing: [2tu.us/nj0](http://2tu.us/nj0)), or the manual method (see below)
   - upgrade radio to v1.5 from [HTC official site](http://www.htc.com/www/support/android/adp.html) 
     or [googlecode.com mirror](http://android-roms.googlecode.com/files/ota-radio-2_22_19_26I.zip)
   - install custom image

 - Getting this far is a PITA, and takes an evening.  After this, upgrading to any image is trivial: just copy it 
   to `update.zip` on the flash card, boot holding the *home* key, and push the magic *Alt-L* + *Alt-S* combo.

### Manual method:

after a clean boot of RC29...

 - type in `<enter><enter>telnetd<enter>`
 - install the `telnet` app from the market
 - download a new `recovery.img` (I am using [Cyanogen's pimped out](http://forum.xda-developers.com/showthread.php?p=3915123) [cm-recovery-1.4.img](http://n0rp.chemlab.org/android/cm-recovery-1.4.img) image)
 - download [HardSPL/update.zip](http://koushikdutta.blurryfox.com/G1RootWalkthrough/HardSPL/update.zip)
 - copy the `recovery.img` and `update.zip` to the SDCARD
 - install the new recovery image...
   
   - `mount -o rw,remount -t yaffs2 /dev/block/mtdblock3 /system`
   - `cd sdcard`
   - `flash_image recovery recovery.img`
   - `cat recovery.img > /system/recovery.img`
   - `sync`
 - shutdown, boot holding down HOME key
 - update...
   - if using `cm-recovery`, when you get the menu, press `alt-s`
   - if using standard `recovery.img`, when you see the triangle logo, press `alt-l` then `alt-s`
 - follow prompts, it will reboot a few times

you now have root.  As before you need to install a community modded image:

 - *first* upgrade radio to v1.5 from [HTC official site](http://www.htc.com/www/support/android/adp.html) 
   or [googlecode.com mirror](http://android-roms.googlecode.com/files/ota-radio-2_22_19_26I.zip)
   
   - download, copy to SDCARD
   - boot with HOME held
   - run `alt-s`

 - then install a custom image.  I recommend using [CyanogenMod](http://forum.xda-developers.com/showthread.php?t=537204) images.
   
   - download, copy to SDCARD
   - boot with HOME held
   - run `alt-s`
   
   NOTE: the `CyanogenMod` takes a long time to boot the first time.


### Additional notes:

 - Here is a matrix of [common ROMs](http://spreadsheets.google.com/ccc?key=tAs2qa3xlveMKSI2BLcUI7g)

 - Here is an index of [informative threads](http://forum.xda-developers.com/showthread.php?t=519523) on *xda-developers.com*

 - With certain ROMs, future updates become even easier with [Cyanogen updater](http://forum.xda-developers.com/showthread.php?t=544663) or [jfupdater](http://code.google.com/p/jfupdater/).

 - [Nandroid v2.0 - Full NAND backup and restore too](http://forum.xda-developers.com/showthread.php?t=459830)

 - Recent CyanogenMod images also support [apps on SD-card](http://forum.xda-developers.com/showthread.php?p=4107149) which is nice since the G1 has little internal flash.
   
   To activate this feature partition your disk to have 1 big vfat partion and 1 smaller ext2/3/4 partition, boot to the cm-recovery image, enter the shell (`alt-x`), and type in `apps2sd`.

 - If you're stuck finding files, check here: [Android development files](https://www.digital-bit.ch/wiki/G1devel)

 - A community member going by alias [cyanogen](http://twitter.com/cyanogen) has some nice ROMs and tools:
   - [improved recovery image](http://forum.xda-developers.com/showthread.php?p=3915123)
   - [stable v4.0.1 firmware](http://forum.xda-developers.com/showthread.php?t=537204)
   - [old stable v3.6.8.1 firmware](http://forum.xda-developers.com/showthread.php?t=537204)
   - [experimental v3.9.10 firmware](http://forum.xda-developers.com/showthread.php?t=539744)
   - [github repository](http://github.com/cyanogen)

 - How to use [ext2/3/4](http://forum.xda-developers.com/showthread.php?t=543985) 
   on [the sdcard](http://forums.androidandme.com/topic/how-do-you-access-your-ext2ext3-sd-card-partition)
   
   Note that this is not required with *cyanogen* roms.

 - other interesting ROMs I didn't try...
   - [xROM](http://forum.xda-developers.com/showthread.php?t=543621)

 - some pages that explain finer details further
   - [HTC_Dream_Bootloader](http://wiki.xda-developers.com/index.php?pagename=HTC_Dream_Bootloader)
   - [HTC_Dream_Rooting](http://wiki.xda-developers.com/index.php?pagename=HTC_Dream_Rooting)
   - [HTC_Dream__haykuro_Cupcake](http://wiki.xda-developers.com/index.php?pagename=HTC_Dream__haykuro_Cupcake)
   - [HTC_Dream_overview_and_useful_information](http://wiki.xda-developers.com/index.php?pagename=HTC_Dream_overview_and_useful_information)