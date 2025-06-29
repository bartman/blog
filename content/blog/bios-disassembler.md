+++
title = "bios disassembler"
date = "2007-05-04T20:50:42-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['bios', 'x86', 'asm']
keywords = ['bios', 'x86', 'asm']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I've been having some issues setting up a x86 environment from scratch in order to get the 
BIOS to work once returning to real mode.  

I decided to figure out why.  I know that the BIOS has the code to setup the processor and
the peripherals to make things work... how does it do this?

<!--more-->

I started by imaging the BIOS from `F000:0000` to `F000:FFFF`, aka the last 64k in the first 
megabyte.  This is where the BIOS code lives.

This ended up being a lot to look through, and a lot to disassemble.  I found that 
[binary view](http://biew.sourceforge.net), or `biew` (debian package), worked pretty well.  But 
it was hard to jump around, and biew didn't have good support for searching, or writing the 
disassembled code out to file so I could use vim.  So I looked elsewhere.

The only other disassembler I found that could do real-mode from a raw file was nasm, but it 
got confused because 0000:0000 was not the entry point.  So I wrote a 
[short script](http://www.jukie.net/~bart/scripts/bios-disassembler/bios-disassembler) to
use nasm repeatably to walk through all the `call` instructions and disassemble all known
code sections.

It's hardcoded to assume that it's running at segment 0xF000.  I will probably have to change it
once I need to debug the video BIOS... but for now you can run this:

        ./disassemble.sh -e 0xFFF0 my-binary-bios-blob

And it will magically dump all the code that is touched by the init sequence.  You can also use
this to follow code accessed by an interrupt vector.  In my BIOS INT 8, for example, which is
triggered by hardware IRQ 0 -- the timer interrupt -- is located at `F000:F006`.  To disassemble
this code I need to run:

        ./disassemble.sh -e 0xF006 my-binary-bios-blob

I don't think this will be useful to anyone... but maybe, since you read this far :)
