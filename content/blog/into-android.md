+++
title = "getting into android"
date = "2009-07-27T21:03:07-04:00"
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

I am a late comer to the Android craze.  I got to play with one recently at the [Linux Symposium](http://linuxsymposium.org)
in Montreal, and I decided I have to get one.  I ended up picking up a pair from ebay -- one to hack on, and one to carry
in my pocket.

I'd like to work on the core platform and not so much the apps.

Anyway, my storey is boring so far.

Below are the interesting links I found so far while researching the platform.

<!--more-->

### Names.

Note that the device I am talking about here is the [T-Mobile G1](http://www.t-mobileg1.com),
known to some as the [Android Dev Phone 1](http://android.brightstarcorp.com/), to others as the
[HTC Dream](http://www.gsmarena.com/htc_dream-2665.php), or just as *Google Phone*.

I'll just call it the G1... because it's short.

### Hardware.

First let's start with the guts.  It was amazingly hard to find the
[hardware block diagram](http://www.phonewreck.com/images/t-mobile_g1_block_diagram.jpg)
for the G1.


 * Specification
   * [HTC Dream product specs](http://www.htc.com/www/product/dream/specification.html) - Platform info from the horse's mouth.

 * Architecture
   * phoneWreck's [T-Mobile G1 – Review and Teardown](http://www.phonewreck.com/2008/12/09/t-mobile-g1-review-and-teardown/) - 
     This is where the block diagram came from.  They also ripped the phone apart to show all the components.
   * techonline's [Under the Hood: Android dreams, GooglePhone delivers](http://www.techonline.com/product/underthehood/211600819?pgno=1) -
     Similar article, briefly covers the major hardware components.


 * CPU/chipset
   
   The heart of the G1 is an ARM11 based RISC processor from Qualcomm -- wrapped into a MSM7201A chipset.
   Note that the ARM family is ARM11, but the architecture version is 
   ARMv6 (see [wikipedia](http://en.wikipedia.org/wiki/ARM_architecture#ARM_cores)).
   
   I have yet to be able to find any low level information on the MSM7201A.  The official page on the 
   [MSM7201A Chipset Solution](http://www.qctconnect.com/products/msm_7201.html) from Qualcomm is rather shallow.
   
   [Dave Sparks](http://www.mail-archive.com/android-developers@googlegroups.com/msg33476.html) was seen saying:
   
     *Chipset vendors consider that information a trade secret and only
     release it to high-volume customers that have signed non-disclosure
     agreements.*
   
   Anyway, here is what I found:
   
   * PDAdb.net's [MSM7201A Chipset simplified technical specifications](http://pdadb.net/index.php?m=cpu&id=a7201a&c=qualcomm_msm7201a)
   * htc-linux's [Kernel for MSM7xxxA based devices](http://htc-linux.org/wiki/index.php?title=Kernel)
   * ARM's [instruction set](http://www.arm.com/products/CPUs/architecture.html) page
     * ARM's [ARMv6 architecture](http://www.arm.com/pdfs/ARMv6_Architecture.pdf) document
     * [ARM1136J(F)-S technical reference manual](http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0211k/index.html)

 * Emulator
   * official [Android emulator](http://developer.android.com/guide/developing/tools/emulator.html) page
   * [T-Mobile G1 Emulator powered by Modea](http://tmobile.modeaondemand.com/htc/g1/) presentation
   * [Google Android Emulator Tutorial](http://www.android.encke.net/android-emulator-tutorial.html)
   * [Sensor Simulator](http://code.google.com/p/openintents/wiki/SensorSimulator)

### How To's

 * Building
   * [Get source](http://source.android.com/download),
     [Git web](http://android.git.kernel.org/)
   * [Android Build System](http://www.kandroid.org/android_pdk/build_system.html)
   * [Building For Dream](http://source.android.com/documentation/building-for-dream)
   * [Building the Android source and Deploying it to your G1 or Dev Phone](http://www.koushikdutta.com/2008/12/building-android-source-and-deploying.html)


 * Setting up
   * [How to Setup T-Mobile G1 on EDGE on Rogers/Fido](http://www.androidincanada.ca/category/tutorials/) - for Canadians
     * [Rogers HTC Dream review](http://www.boygeniusreport.com/2009/05/24/rogers-htc-dream-review/) - 3g with radio tunes to rogers network, and other features.
     * wikipedia's [Mobile Network Code](http://en.wikipedia.org/wiki/Mobile_Network_Code) could be useful if you need the MCC/MNC codes for your region.

 * Other weird stuff
   * [Busybox on the G1](http://androidcommunity.com/forums/f2/busybox-on-the-g1-4358)
   * [Debian & Android Together on G1](http://www.saurik.com/id/10)

### Resources

 * Web sites
   * [Android developers](http://developer.android.com/) site
   * [Android open source project](http://source.android.com/) and [documentation](http://source.android.com/documentation) pages
   * Wikipedia's [android](http://en.wikipedia.org/wiki/Android_(operating_system)), [HTC dream](http://en.wikipedia.org/wiki/HTC_Dream), [ARM](http://en.wikipedia.org/wiki/ARM_architecture#ARM_cores) pages
   * xda-developers' [HTC Dream Wiki page](http://wiki.xda-developers.com/index.php?pagename=HTC_Dream) - The basics ont eh pone, links to android SDKs, links to other websites.
   * [Android Spin](http://androidspin.com/) - tracks unofficial firmware releases
   * How to [Unlock T-mobile G1](http://www.unlock-tmobileg1.com/procedures/activate.php) - so that it can be used on a non-Tmobile network; *NOTE* that there are lots of other sites that provide this service.
   * [Droidproof](http://droidproof.com/)

 * More for Canadians that will use the Tmobile phone on Rogers network:
   * [GSM HSDPA 3G service outside of the USA 1700 Mhz 2100 Mhz](http://forums.t-mobile.com/tmbl/board/message?board.id=Android3&message.id=17962#M17962)
   * [Rogers Dream](http://www.htcwiki.com/page/Rogers+Dream) writeup

 * for Rogers branded Dream phones
   * [Rooting the Rogers Dream](http://forum.xda-developers.com/showthread.php?p=4280573#post4280573)

 * Software
   * [AndroidIRC](http://androidirc.net/) - apparently the only irc client worth getting
   * [ConnectBot](http://code.google.com/p/connectbot/) - ssh client for android

 * IRC
   * `#htc-linux` on `irc.freenode.org` ([archive](http://ibot.rikers.org/%23htc-linux/)) -
     deals with running Linux on HTC devices.
   * `#android` on `irc.freenode.org` -
     deals with writing apps for the Android platform
   * `#android-dev` on `irc.freenode.org` -
     deals with developing the Android platform

 * RSS
   * [Tips & News for Canadian Android Users!](http://www.androidincanada.ca) [RSS](http://www.androidincanada.ca/feed/)
   * [JesusFreke's AndBlog](http://jf.andblogs.net) [RSS](http://jf.andblogs.net/feed/)
   * [Android and Me](http://androidandme.com) [RSS](http://feeds2.feedburner.com/androidandme)
   * [AndroidSPIN: Android ROM Information](http://www.androidspin.com/) [RSS](http://www.androidspin.com/android_build_rss.asp)
     * [Haykuro's custom ROMS for the G1](http://code.google.com/p/sapphire-port-dream/)
   * [Android Developers Blog](http://android-developers.blogspot.com/) [RSS](http://android-developers.blogspot.com/atom.xml)