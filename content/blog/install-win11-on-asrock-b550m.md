+++
title = 'Overcoming Windows 11 Installation Resets on Ryzen 7'
date = '2025-12-16T17:14:36-05:00'

categories = ["post"]
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = [ "windows", "ryzen", "install", "tech" ]
keywords = ["Windows 11", "Ryzen", "Installation Issues", "Hardware Troubleshooting"]
description = "Overcoming Windows 11 Installation Resets on Ryzen 7: A Simple Power Management Fix"
showFullContent = false
readingTime = true
hideComments = false
+++

I was hitting Windows 11 installer resets on an ASRock B550M Steel Legend motherboard with a AMD Ryzen 7 5700G processor. The system ran Linux stable for months and BIOS was perfectly stable also, but Windows installers (both 10 and 11) triggered resets, even while idle. It looked like a Windows-specific power management issue, likely related to CPU C-states.

<!--more-->

After extensive troubleshooting—updating BIOS, swapping DIMMs, changing M.2 slots, even trying a new PSU—nothing stuck. The culprit? Deep C-states enabled in Windows Preinstallation Environment (PE), causing instability on certain Ryzen configs. Here's the workaround that finally got me through the install.

### The Solution: Disable C-States During Installation

The key is to temporarily disable processor idle states (beyond C1) using `powercfg` commands in the installer. This prevents power-related crashes without permanent changes. Follow these steps:

1. **Download the Windows Installer ISO and Create Bootable Media**

   Grab the latest Windows 11 ISO from Microsoft's website using the Media Creation Tool. Use Rufus or `dd` to burn it to a USB drive. Ensure the drive is formatted as FAT32 for compatibility.

2. **Add a power.bat File to the Installer Drive**

   On the USB drive (let's assume it's mounted as D: on your working machine), create a file named `power.bat` in the root directory. Edit it with these three lines:
   ```
   powercfg /setacvalueindex scheme_current sub_processor IDLEDISABLE 1
   powercfg /setdcvalueindex scheme_current sub_processor IDLEDISABLE 1
   powercfg /setactive scheme_current
   ```
   These commands disable deep C-states in the current power scheme, forcing the CPU to stay in a more active idle mode.

   NOTE: You could also put this script on another USB stick.  Or just type it in after you boot.  I prefer the script since the system will reboot in a couple of minutes, so the clock is ticking.

3. **Boot into the Installer and Run the Batch File**

   Insert the USB, boot into the Windows installer (ensure UEFI mode in BIOS). At the first screen (language selection), press **Shift + F10** to open Command Prompt.
   Change to the USB drive (usually D: or E:). Run the script.
   ```
   > d:
   > power.bat
   ```
   Close the prompt and proceed with the installation.  It should no longer reset.

4. **Wait Until the System Reboots**

   Let the installer copy files and prepare the drive. It will reboot automatically after the first stage.

5. **Run the Batch File Again After Reboot**

   As soon as it reboots into the second stage (OOBE or setup completion), press **Shift + F10** immediately to open Command Prompt again. Switch to the USB drive and run `power.bat` once more.
   ```
   > d:
   > power.bat
   ```
   This ensures C-states stay disabled during the final setup.

6. **Continue the Install as Normal**

   Proceed through the rest of the setup, including account creation.

7. (OPTIONAL) **Skip "NRO" registration**

   You could wait until you're prompted for network, hit **Shift + F10** and run this magic command:
   ```
   > oobe\bypassnro
   ```
   This will actually force you to run the second pass of the installer again, but on the next reboot, you will be presented with a "I don't have internet" option.

And that's how I spent my Saturday.  Thank you Microsoft.

This method got me past the resets and into a fully installed Windows 11. Once booted, you can verify stability and optionally re-enable C-states via Power Options if needed (though on my Ryzen 5700G, leaving them disabled improved idle behavior without issues).

### Why This Works

Windows PE enables aggressive power saving by default, which can conflict with Ryzen's C-state implementation on some motherboards. Linux distros often default to safer idle modes, explaining the stability difference. The `powercfg` tweaks force "idle polling," keeping the CPU awake enough to avoid crashes.

If this doesn't resolve your issue, check for hardware faults (e.g., run MemTest86) or BIOS settings like Global C-state Control. Share your setup in the comments if you're still stuck!

Hope this saves you hours of frustration.
