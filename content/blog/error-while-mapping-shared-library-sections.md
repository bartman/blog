+++
title = "Error while mapping shared library sections"
date = "2005-05-28T19:00:34-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['linux', 'gdb']
keywords = ['linux', 'gdb']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

<p>
It irks me when I am searching for a solution to a problem I have, get a 
few dozen hits on google, but all I get are people stating the same problem.
Here is my attempt at improving the scoring of solutions.
</p>

<p>
In gdb 6.0 there is a frequently seen problem where the debugger complains
about "<b>Error while mapping shared library sections</b>".  I was unable 
to find the real cause of this, but 
<a href=http://www.linuxquestions.org/questions/showthread.php?postid=975227>
this link</a> stated that an upgrade to gdb 6.1 fixes the problem.  There is also a link to a 
<a href=https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=127274>related redhat bugzilla bug entry</a>.
</p>
