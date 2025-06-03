+++
title = "ipw2200 not working"
date = "2007-07-05T11:31:39-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['linux', 'debian']
keywords = ['linux', 'debian']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

Err!  I recently nuked and paved over my X41, with debian/lenny.  When I wanted to use the wireless I was greeted by:

        ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.2.0kmprq
        ipw2200: Copyright(c) 2003-2006 Intel Corporation
        ACPI: PCI Interrupt 0000:04:02.0[A] -> GSI 21 (level, low) -> IRQ 23
        ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
        ipw2200: ipw2200-bss.fw request_firmware failed: Reason -2
        ipw2200: Unable to load firmware: -2
        ipw2200: failed to register network device
        ACPI: PCI interrupt for device 0000:04:02.0 disabled

It turns out that I have not done any wireless twiddling recently and forgotten that I had to 
get the firmware before things started working again.

<!--more-->

To get things working you need to download firmware (*ipw2200-fw-3.0.tgz*) from [ipw2200.sf.net](http://ipw2200.sourceforge.net/firmware.php).  You need
to agree to the license.

Next, you will unpack this file to /lib/firmware (thanks Rob Hull for the correction).

        cd /lib/firmware
        sudo tar xzf ipw2200-fw-3.0.tgz

Then restart the drivers:

        sudo rmmod ipw2200
        suod modprobe ipw2200

And the kernel is happy again!

        ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.2.0kmprq
        ipw2200: Copyright(c) 2003-2006 Intel Corporation
        ACPI: PCI Interrupt 0000:04:02.0[A] -> GSI 21 (level, low) -> IRQ 23
        ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
        ipw2200: Detected geography ZZM (11 802.11bg channels, 0 802.11a channels)