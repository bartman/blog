+++
title = "fixing X for GeodeLX"
date = "2008-03-01T13:42:20-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['geode', 'x', 'linux', 'x86emu', 'ubuntu']
keywords = ['geode', 'x', 'linux', 'x86emu', 'ubuntu']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

Recently I have been doign a bit of contract work for [Symbio Technologies](http://www.thesymbiont.com/).  They have had
me do various little projects part time.  Most recently I got a chance to work on [X.org](http://x.org) video drivers for
the [Geode family](http://www.x.org/wiki/AMDGeodeDriver).

Here is the progress...

<!--more-->

* *starting X freezes the system*

  With X-core release 1.3 (specifically Ubuntu/Gutsy, as that is what Symbio uses) there was a bug that 
  caused a freeze of the system.  This only occurred on some hardware, notably those systems with the
  GSW VGA BIOS.

  The first symptom that I could see was the freeze.  I narrowed it down to X86EMU, an X subsystem that
  emulates the BIOS real-mode code in usermode to gain access to VGA BIOS features like monitor mode
  information (DDC).  It turned out that the emulator was trying to write to an invalid I/O port, which
  disabled PIC interrupts.
  
  The first patch was triggered by a suggestion from Alan Cox that certain I/O ports are not to be
  touched from user space.  These patches prevent X86EMU from accessing ports that Alan Cox said
  are not be accessed :)

  * against Gutsy's xorg-server 1.3 [X86EMU-added-blacklist-for-I-O-port-in-0-0xFF-range.patch](http://www.jukie.net/~bart/patches/xorg-server/20080111/0001-X86EMU-added-blacklist-for-I-O-port-in-0-0xFF-range.patch)
  * against xorg-server pre-1.5 [X86EMU-added-blacklist-for-I-O-port-in-0-0xFF-range.patch](http://www.jukie.net/~bart/patches/xorg-server/20080219/0001-X86EMU-added-blacklist-for-I-O-port-in-0-0xFF-range.patch)

  But why would the BIOS try to muck with the PIC when being asked for DDC info?  Well it turned out that
  it wasn't.  X86EMU choses not to allow drivers to access PCI directly, instead it goes through
  an emulation layer -- this is good -- but instead of emulating the access to arbitrary devices, it was always
  passing the requests to the VGA device that was in use by X -- this is bad.  The BIOS was trying
  to read something from the PCI bridge, but X was returning values from the VGA device.  The value
  was not validated, and caused PIC access.

  The second patch fixes the X86EMU PCI emulation bug.  When the code emulated wants to talk
  to a certain device, instead of using the VGA device use what they asked for.  The second patch
  here uses libpciaccess, while the first one does not.

  * against Gutsy's xorg-server 1.3 [X86EMU-pass-the-correct-bus-dev-fn-tag-to-pci-emula.patch](http://www.jukie.net/~bart/patches/xorg-server/20080111/0001-X86EMU-pass-the-correct-bus-dev-fn-tag-to-pci-emula.patch)
  * against xorg-server pre-1.5 [X86EMU-when-emulating-PCI-access-use-the-correct-d.patch](http://www.jukie.net/~bart/patches/xorg-server/20080219/0002-X86EMU-when-emulating-PCI-access-use-the-correct-d.patch)

  These patches were not yet picked up by upstream, but are in Ubuntu and possibly other distros.

  Ref: [launchpad #140051](https://bugs.launchpad.net/ubuntu/+source/xserver-xorg-video-amd/+bug/140051)
       [freedesktop #14332](http://bugs.freedesktop.org/show_bug.cgi?id=14332)

* *switching back to virtual terminal doesn't work*

  The problem here was in X86EMU again.  The GSW VGA BIOS was issuing a CPUID instruction to
  perform some operation required for a VT-switch.  The patch implements a CPUID instruction
  in X86EMU by returning raw values from the CPU, or the 486dx4 values on non-x86 processors.

  * against xorg-server 1.3..pre-1.5 [X86EMU-handle-CPUID-instruction.patch](http://www.jukie.net/~bart/patches/xorg-server/20080207/0001-X86EMU-handle-CPUID-instruction.patch)

  This patch was universally picked up by pretty much everyone because it's trivial.

  Ref: [launchpad #180742](https://bugs.launchpad.net/debian/+source/xorg-server/+bug/180742)

* *wide mode not working*

  Next problem was a long time wish of the Geode users; to have wide monitors supported in native
  resolutions.  The problem here was with the way that the resolutions are filtered by
  LXValidMode() against a table of valid modes.  Something that is not required if the
  modes come from DDC and/or we are not using a PANEL (ie using a monitor connected by
  VGA cable).

  Jordan and I colaborated on this.  In the end he produced a patch that I [fixed](http://lists.x.org/archives/xorg-driver-geode/2008-March/000257.html) a minor type-o bug in and tested...

  * against video-amd 2.7.7.6 [amd-wide-mode.patches](http://www.jukie.net/~bart/patches/xorg-video-amd/20080301/amd-wide-mode.patches)

  Ref: [launchpad #197069](https://bugs.launchpad.net/ubuntu/+source/xserver-xorg-video-amd/+bug/197069)

  Git: [1e763626a](http://gitweb.freedesktop.org/?p=xorg/driver/xf86-video-amd.git;a=commit;h=1e763626aaefa1ae0cf4d4896c0b7192955e5993)

  Packages [in my Ubuntu PPA](http://launchpad.net/~bart-jukie/+archive)

If you have any questions about the above, give me a shout.