+++
title = 'nixos custom ppd printer'
date = '2025-06-25T10:48:10-04:00'

categories = ["blog"]
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ["nixos", "cups", "print", "linux"]
keywords = ["nixos", "print", "ppd"]
description = ""
showFullContent = false
readingTime = true
hideComments = false
+++

I have bought a [Brother MFC-L3780CDW](https://www.brother.ca/en/p/MFCL3780CDW) printer, and needed to get it working on NixOS.

While NixOS supports many Brother printers out of the box, I was unable to get the colour & duplex printing working together with any of the ones I tried.

In the past I've used a Brother supplied `.deb` package on Debian based systems.

This post describes how to install a PPD driver for this printer, but you can use this procedure with other printers.

<!--more-->

## the PPD

Brother provides driver packages for Debian and RedHat based systems.
You need to download the driver package from the Brother Downloads page.
You can find it by searching for your printer, then follow the Download link.

The Brother MFC-L3780CDW link takes me here...

https://support.brother.com/g/b/downloadlist.aspx?c=ca&lang=en&prod=mfcl3780cdw_us_as&os=128

Following the "Linux printer driver" link provides `mfcl3780cdwpdrv-3.5.1-1.i386.deb`.

Within the deb you will find the PPD file.

```sh
❯ dpkg-deb -c ~/Downloads/brother/3780cdw/mfcl3780cdwpdrv-3.5.1-1.i386.deb | grep ppd
-rwxr-xr-x root/root     22956 2021-12-22 21:52 ./opt/brother/Printers/mfcl3780cdw/cupswrapper/brother_mfcl3780cdw_printer_en.ppd
```

If you don't have `dpkg-deb` you can run it with `nix run "nixpkgs#dpkg-deb" -- ...`.

To extract the files in the deb:

```sh
❯ dpkg-deb -x mfcl3780cdwpdrv-3.5.1-1.i386.deb mfcl3780cdwp
```

## configure.nix

I assume you have captured your nixos configuration in a git repo.
Place the .PPD from the `.deb` inside your git repo.

You should have `services.printing` enabled, we now have to add the PPD into it.

```nix
  services.printing = {
    enable = true;
    browsed.enable = true;
    drivers = [
      (pkgs.writeTextDir "share/cups/model/brother_mfcl3780cdw_printer_en.ppd"
        (builtins.readFile external/brother_mfcl3780cdw_printer_en.ppd))
    ];
  };
```

Above, the "share/cups/..." path is where the PPD will be placed, while
the "external/..." path is where the PPD will be found, relative to the flake.nix.

Don't forget to `git add` the `.ppd` file.

## deploy

Next you will run `nixos-rebuild switch` as usual.

The printer driver should now be available in the CUPS GUIs.

I used `http://127.0.0.1:631/` to add my printer, but KDE/GNOME/etc settings panel should work as well.


