+++
title = "sawfish workspace themes"
date = "2004-11-24T13:01:46-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['desktop']
keywords = ['desktop']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

<p>
(<i>Don't get too excited... it may not be what you think</i>)
</p>

<p>
I have been using <a href=http://sawmill.sourceforge.net/>sawfish</a> for 
many years now, and <a href=http://www.jukie.net/~bart/sawfish/> written 
a few custom hacks for it</a>.  My current theme is Tlines.  I've tried <a 
href=http://www.jukie.net/~bart/conf/xsession>most</a> the other window 
managers and come back to sawfish every time I get adventurous, because 
sawfish is so bloody configurable.
</p>

<p>
Recently I started using the following settings, as a very cool time 
saver:
<ul>
 <li> focus = enter-only
 <li> root-window binding 'button1-click2' locks my screen
 <li> root-window binding 'w' start galeon
 <li> root-window binding 't' start 3 vertical non-overlapping terminals
 <li> root-window binding 'g' start gimp + gqview (also non-overlapping)
</ul>
</p>

<p>
Since I use enter-only focus, I never lose focus (ie: something other then 
the root-window is always in forcus) unless I enter an empty workspace.
When I do, the root-window becomes focused and the last three bindings
actually become usable.
</p>

<p>
So if I am doing <a href=http://gallery.jukie.net>photo editing</a>, I want 
to have gimp and gqview opened.  I enter a new work space and push 'g'... 
which starts those.
</p>

<p>
The 'w', 't', and 'g' are the most common themes that I have for
workspaces, and this saves a bit of time launching them from the
right-click menu or from an xterm.
</p>

<p>
My next sawfish hack will be to write some scheme that will allow me to
switch focus to the window whose center is closest to the current one
given a direction.  So M-left would give me the window that is to the
left of the current one.  But, I've been meaning to do this for years
now... so, don't hold your breath.  Scheme is scary. :)
</p>
