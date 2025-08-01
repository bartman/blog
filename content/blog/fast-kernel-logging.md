+++
title = "fast kernel logging"
date = "2004-09-22T10:43:34-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['linux', 'kernel']
keywords = ['linux', 'kernel']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

<p>As part of some driver work for a client I looked at some fast logging methods since logging via printk() to syslog sucks.</p>

<p> Here are the hits I got:
<ul>
<li><a href=http://gnumonks.org/projects/project_details?p_id=1>ULOG</a> - it's what netfilter uses for logging packets.  It relies on netlink for transport and a ulogd in user space to treat the logs.  Apparently ULOG2 is in the works.
<li><a href=http://dbus.freedesktop.org/>DBUS</a> - patch from <a href=http://tech9.net/rml/log/>Robert Love</a> that adds a fast event notification mechanism to the kernel.  It too relies on netlink for transport.  It's mostly meant for <a href=http://www-106.ibm.com/developerworks/linux/library/l-dbus.html?ca=dgr-lnxw82D-Bus>events</a> like &quot;Your CPU is overheating&quot;, not packet logging.
<li><a href=http://www.opersys.com/relayfs>relayfs</a> - a patch that adds a flexible buffering scheme for logging.  Seems like the most flexible of the bunch.
</ul>
</p>

<p>
Looks like none of the above are flexible and supported by deployed kernels
(our target is RHEL3)... so syslog it is in the interim.
</p>