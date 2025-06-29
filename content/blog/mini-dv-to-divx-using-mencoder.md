+++
title = "Mini-DV to divx using mencoder"
date = "2004-11-13T08:26:51-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['video', 'linux']
keywords = ['video', 'linux']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

<p>
I occasionally have footage to take off my MiniDV camera and need to convert it
to a format that I can easily burn and archive.  I am not much into mastering 
DVDs, just being able to play the file on my computer is good enough for now.
</p>

<p>
I've been using kino to do this job before, but that is hard to script.
So I decided to play a bit with mencoder.  I have no idea what I am doing, 
so I tried to encode at the highest possible bitrate/quality I could 
get out of the DivX (mpeg4) encoder.
</p>

<p>
First the capture... I use dvgrab to get the data off my firewire-connected 
MiniDV camera.  Just running 'dvgrab' will capture all video (until you stop it)
into files of the name dvgrab-001.avi, dvgrab-002.avi, etc.  The format is
avi, but it's still raw data inside.  So it's huge.  The files are split
every 1 gigabyte by default.
</p>

<p>
To encode it I am using the following command:
<blockquote>
mencoder dvgrab-001.avi -o video-001.avi -vf hqdn3d,kerndeint -ovc lavc -lavcopts vcodec=mpeg4:vqscale=1:vhq:v4mv:vbitrate=8000:threads=2:acodec=ac3 -oac lavc
</blockquote>
The intent is to deinterlace, enhance, and compress with the highest possible
quality preserved.  There is a lot of information in the mencoder documentation,
but here are the select bits from the above command:
<ul>
<li><b>-vf hqdn3d,kerndeint</b><br>
        apply a high precision/quality denoise 3D filter, and<br>
        apply Donald Graft's adaptive kernel deinterlacer.
<li><b>-lavcopts vcodec=mpeg4:vqscale=1:vhq:v4mv:vbitrate=8000:threads=2:acodec=ac3</b><br>
        use mpeg4 from the libavcodec,<br>
        (vqscale=1) with highest fixed quantisation (huge files),<br>
        (vhq) high quality macro block decisions,<br>
        (v4mv) allow 4 motion vectors per macroblock,<br>
        (vbitrate=8000) very high datarate cap,<br>
        (threads=2) use multiple threads, and<br>
        (acodec=ac3) use ac3 audio encoding.
</ul>
The raw DV files were compressed about 10:1 with the above configuration.
</p>

<p>
Also started using dvd+rw tools for burning... since the cdrecord support
for DVD+RW drives is incomplete (there is an unsupported patch that 
sometimes works).  Here is how you burn an iso to a DVD:
<ul>
<li>growisofs -Z dvd.iso
</ul>
... and that's it.
</p>

<p>
Next, I need to find some time to read the mencoder doc and revise the above.
I should also start using the double pass encoding -- apparently gives a better
picture quality.
</p>

<p>
Also, the fixed quantisation has a negative (side)effect of wasting the data
rate, I will have to see what quality I get at higher vqscale settings.
</p>

<p>
Finally, the dvgrab program splits on 1G boundaries, where I would much 
prefer a scene split -- like kino allowed in post processing.  mencoder
could possibly do this, just have to find out how.
<p>

<p>
Here are some related links:
<ul>
<li><a href=http://home.scarlet.be/~eb023909/Linux-Video.htm>Video on Linux</a>
- someone's blog
<li><a href=http://www.mplayerhq.hu/DOCS/man/en/mplayer.1.html>mplayer manpage</a> - mencoder included
<li><a href=http://www.mplayerhq.hu/DOCS/HTML/en/index.html>mplayer doc</a> - mencoder included
</p>