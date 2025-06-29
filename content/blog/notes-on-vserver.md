+++
title = "notes on vserver"
date = "2004-10-04T08:45:25-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['linux', 'vserver']
keywords = ['linux', 'vserver']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

<font color=gray><i>[ this entry will be updated as I think of more stuff to add ]</i></font>

<p><b>ssh &amp; X forwarding</b></p>

<p>For a while I was having issues with ssh X forwarding to my vserver.
Finally found the problem.  The problem is actually with X authentication 
against localhost, and setting localhost to the IP address of the machine
in <i>/etc/hosts</i> solved that.</p>

<p>Also someone <a href=http://list.linux-vserver.org/archive/vserver/msg00982.html>recommended</a> putting &quot;<i>X11UseLocalhost no</i>&quot; in <i>/etc/ssh/sshd_config</i>.</p>

<br>
<hr width=100>
<br>

<p><b>raw access to block devices</b></p>

<p>vservers don't have the capabilities to create device nodes.  However if
you leave nodes in /dev accessible then they will be available to the root 
user in the vserver for unlimited access.</p>

<p>To protect the system from cross vserver contamination, you should nuke all
block devices:
<pre>
        find /vservers/*/dev -type b | xargs --max-args=100 rm -f
</pre>
Now if anyone breaks into one vserver they will not be able to <i>dd</i> all
over your disks.</p>


