+++
title = "I am so peeved at Rogers"
date = "2010-01-25T19:10:21-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['android', 'rogers', 'dream']
keywords = ['android', 'rogers', 'dream']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

<b>See the updates below if you want to keep your root.</b>

I just received the following text from Rogers, and as it claims my data
access has been disabled.  Since I am running [CyanogenMod](http://www.cyanogenmod.com/)
I never had the 911 issues that the stock Rogrers firmware experienced.

        Rogers/Fido Safety Message: URGENT Reminder 911 Calls HTC Dream
        software update: Mandatory software update is now available to help
        ensure 911 calls are completed from your phone. Please go immediately
        to rogers.com/dreamsoftwareupdate on your PC to download.

        In order to help ensure 911 calls are completed internet access was
        temporarily disabled on your phone at 01/24/10 6:00AM EST. To
        reactivate internet service, please complete your software update
        immediately. Upon completion, internet access will be re enabled
        within 24 hours.

        For users of Macintosh and Windows 7, please call 1-
        888-764-3771(1-888-ROGERS1) for update instructions.

        We apologize for the inconvenience but we prioritize customer safety
        above all.

So I called rogers to get it straightened out and get my data access back.
However since everyone in the country that has a Dream or Magic got 
their service cut... you can imagine I wasn't the first one to call and
complain.  When the automated system told me that I would have to wait for 30
minutes I hung up.  My time is a bit more important than that.

Ben Selinger [wrote about his experiences](http://forum.xda-developers.com/showpost.php?p=5437987&postcount=5)
and it seems to me that Rogers doesn't want people with phones they don't control as customers.

Well, this is one more strike for Rogers, and one more reason to leave.  Let's
hope [WIND](http://www.windmobile.ca/) is all that it's cracked up to be.

<!--more-->

### Updates

*UPDATE*: looks like there is some [good news](http://www.androidincanada.ca/news/rogers-begins-pushing-out-android-rom-update-for-htc-magicdream/#comment-31091533):
if you call and tell them you are running Linux, they'll "refresh your phone".  But you 
should [avoid using the upgrade](http://www.androidincanada.ca/news/rogers-begins-pushing-out-android-rom-update-for-htc-magicdream/#comment-31334960)
as it will mean the end of your root... at least for now.

*UPDATE 2*: called rogers support and spoke with 4 drones.  Two were not informative.  Then, I was told that
there was no block out on my data plan...  that was encouraging, enve though my phone still had no data
access.  I was then transfered to someone that was a bit more clueful, but they told me that the network
will not enable my account until my firmware is the right version.  He insisted that enabling my account
was not possilbe from their end.

<b>Bull!</b>

I think I have 3 choices.

 - leave Rogers.  which I still am likely to do when WIND starts to operate in Ottawa.
   .
   Here is a [map of WIND towers in Ottawa](http://maps.google.com/maps/ms?ie=UTF8&hl=en&msa=0&msid=104288380340351189346.00047cfc64a9dda52d6cc&z=11)

 - borrow someone's phone for a day to fool the system into thinking I have updated.

 - call "Rogers customer retentions", which I've been told can do anything to keep me as a customer.

*UPDATE 3*: After many wasted hours with tech support I found and followed [these instructions](http://forum.xda-developers.com/showpost.php?p=5440198&postcount=6)
which let me run the rogers *boot* and *system* images, withour flashing SPL.  This allows for having the community
recovery, which I'll later use to restore my cyanogen image.  So for now I have to run the crappy 1.5 firmware from
rogers which should get me data back.  Will update if/when my data comes back.

*UPDATE 4*: About an hour after downgrading via [eztery's instructions](http://forum.xda-developers.com/showpost.php?p=5440198&postcount=6), 
I got 3G back.  I was still in the rogers firmware.  I powered down and restored my backup of CM, and still had 3G after
booting my phone.  It's been up for a few days now.  I am happy.

*UPDATE 5*: If you lost root after applying the rogers firmware patch, you need to [look at this post](http://forum.xda-developers.com/showpost.php?p=5486789&postcount=1)
which claims to restore root.  I have not tested this.

### Related Links

 - Litui.Net writes about the [Rogers Mandatory Update Debacle](http://www.litui.net/archives/796)

 - pastebit of bpuld.prop files after Rogers f/w upgrade from [HTC Dream](http://pastebin.com/m17633f5b) and [HTC Magic](http://pastebin.com/m307ae90f)

 - [go from the Rogers' 911-fix firmware to root and Cyanogen](http://forum.xda-developers.com/showthread.php?p=5486789)
 - [go from Cyanogen to Rogers 911-fix firmware, but keeping SPL](http://forum.xda-developers.com/showpost.php?p=5440198)

 - [Brian Crook's images](http://briancrook.ca/magic/)
 - [Info about NBH file formats and related tools](http://wiki.xda-developers.com/index.php?pagename=Hermes_NBH)

 - [How Rogers Ruined My HTC Dream](http://android.mahram.ca/) - lots of good info from another dissatsified Rogers customer
 - [Rogers and the Squashing of Personal Freedom](http://blog.nsdev.org/?p=233) - yet another person blogging about their Rogers misfortunes