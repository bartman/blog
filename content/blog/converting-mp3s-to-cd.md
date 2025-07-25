+++
title = "converting mp3s to CD"
date = "2006-04-14T20:25:07-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['linux', 'audio']
keywords = ['linux', 'audio']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

How to convert 22kHz mp3 to a CD playable in a CD player.  Not the most spectacular 
task, but I had to do some digging to figure it out.  And I might as well write it down
for the next time :)

<!--more-->

### Problem:

A relative asked me to convert some audio from some legal proceedings, given 
to him in mp3 format, to a CD so he could listem to it.

The audio files were in a different sample rate then what CD's use.

    $ file 12345678.mp3
    12345678.mp3: RIFF (little-endian) data, WAVE audio, MPEG Layer 3, stereo 22050 Hz

*(file name is obscured)*

### Solution:

First we have to convert the file from MPEG to WAV. (`apt-get install mp3-decoder`)

    $ mp3-decoder -w 12345678.pre.wav 12345678.mp3

Then we get a WAV file that is in the wrong bit rate:

    $ file 12345678.pre.wav
    12345678.pre.wav: RIFF (little-endian) data, WAVE audio, Microsoft PCM, 16 bit, stereo 22050 Hz

This was the step that was a bit difficult to discover.  I don't use sox often, but I knew that sox 
was the right tool for this job.  This is how to upsample the file:

    $ sox -t wav 12345678.pre.wav -t wav -r 44100 12345678.wav resample -ql

Which gives us a CD-quality audio track:

    $ file 12345678.wav 
    12345678.wav: RIFF (little-endian) data, WAVE audio, Microsoft PCM, 16 bit, stereo 44100 Hz

And now we can burn the file to CD and make a relative happy:

    $ cdrecord -v -dao -audio -pad speed=24 12345678.wav 

And that's it.

---

### See also...

I have been told that you can use *mplayer* also (*have not tried it*)... here is something that
you can investigate also:

    $ mplayer -ao pcm:12345678.wav 
