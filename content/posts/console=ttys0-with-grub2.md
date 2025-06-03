+++
title = "console=ttyS0 with grub2"
date = "2010-05-23T09:20:01-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['ubuntu', 'grub', 'linux']
keywords = ['ubuntu', 'grub', 'linux']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

Just a quick note so I don't forget now to enable console logging on systems running `grub2` (like Ubuntu 10.04, Lucid).



- edit `/etc/default/grub`

  - set `GRUB_CMDLINE_LINUX` to `"console=ttyS0,115200n8 console=tty0"`

- run `update-grub`

- reboot



( more info [can be found here](https://wiki.ubuntu.com/Grub2) )
