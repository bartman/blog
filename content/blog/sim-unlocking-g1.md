+++
title = "sim unlocking a G1"
date = "2009-08-13T10:00:25-04:00"
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

One of the phones I picked up on eBay was SIM-locked (see my [previous post]{into-android}) and I had to go through the 
process of unlocking it so I could use it on my local cell network.

<b>WARNING:</b> It worked for me, but it may not for you.  <font color=red>This may very well brick your phone!</font>  In some cases you will only
have 3 chances (in others 10) to unlock, failing to do so can damage your SIM card or the phone.

Still here?  Let's get started...

<!--more-->

You will need the following:

 - sim-locked <b>T-mobile G1</b> (aka HTC Dream) with a <b>fully charged</b> battery.
 - <b>T-mobile SIM-card</b> (no actual plan is required).
 - your SIM-card <b>with data plan</b>.
   - if the SIM-card is locked, you will need the PIN to unlock it.
 - a [Pay Pal](http://www.paypal.com) account.
   - you will be charged <b>$23.99</b> USD.
 - a [gmail](http://gmail.com) account.

I used [the guide](http://www.unlock-tmobileg1.com/procedures/activate.php) provided by [www.unlock-tmobileg1.com](http://www.unlock-tmobileg1.com/), but found 
some omissions.  Please read their guide, [review this post](http://www.mobileindustryreview.com/2008/12/unlocking_my_t-mobile_g1_uk.html), and my notes for best results :)

Here are the steps I followed:

 - <b>downgrade firmware to RC23</b>
   
   I had tried to unlock the phone with the firmware that was on the phone, but I was unable to add my APN to the list.  I think it only accepted
   the MCC/MNC numbers that T-Mobile uses.  Adding the APN is essential to actually use the phone off a T-Mobile network... so this is an important *feature*.
   
   Downgrade instructions can be obtained from [here](http://androidandme.com/2009/05/guides/beginners-guide-for-rooting-your-android-g1-to-install-cupcake/).
   But don't follow all the steps, just stop at RC29.

 - <b>obtain IMEI code</b>
   
   After booting the phone with the T-Mobile SIM card, press the *EMERGENCY CALL* button and enter `*#06#`.  Write down the IMEI.
   Confirm that it's the same number that's written on a sticker under the battery.

 - <b>obtain unlock code</b>
   
   Go to the [www.unlock-googlephone.com](http://www.unlock-googlephone.com/EN/unlock-Google-Phone.php) site and follow their ordering
   instructions.  Make sure you type in everything correctly.

 - <b>add APN for your network</b>
   
   Using either SIM-card, boot the phone and add your APN info.  This is done by pushing the *MENU* button to enter the APN settings,
   and then the *MENU* button again to add a new entry.
   
   You'll have to search around to find out what your provider uses, or extract the data from another phone.
   
   As outlined in my [previous]{into-android} [posts]{rooting-g1}, I am on a Rogers network... so I added the [Rogers APN](http://www.androidincanada.ca/category/tutorials/).

 - <b>SIM-unlock the phone</b>
   
   After a few hours, you will receive a `your code is ready` email from [www.unlock-googlephone.com](http://www.unlock-googlephone.com).
   The email will send you to their website and you will get your unlock code.  You may want to write down the number for your records.
   
   Using your SIM-card (with data plan) boot the phone.
   
   You will be asked for `SIM network unlock PIN`.  Enter the number they gave you.  Be very careful.

 - <b>register the phone with google</b>
   
   This last step will connect your phone with your gmail account.

Here are some additional resources:

 - thread on [PIN/PUK locked phones](http://androidcommunity.com/forums/archive/index.php/t-3835.html).
   - getting your [PIN/PUK codes from Rogers](http://forums.rogershelp.com/pun/viewtopic.php?id=67).
 - [secret codes](http://android-dls.com/wiki/index.php?title=Secret_Codes) and [how to change the PIN](http://www.infosyncworld.com/news/n/6567.html).
 - Android [safe mode](http://androidcommunity.com/forums/f41/g1-safe-mode-2565/).