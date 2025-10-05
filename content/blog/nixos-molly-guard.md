+++
title = 'NixOS molly-guard'
date = '2025-10-05T10:20:57-04:00'

categories = ["post"]
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ["nixos", "reboot"]
keywords = ["nixos", "reboot"]
description = ""
showFullContent = false
readingTime = true
hideComments = false
+++

I accidentally ran `sudo reboot` on my local desktop, thinking the shell was connected to a remote server over ssh. This rebooted the wrong system... Oops.

On Debian for years, I used a package [molly-guard](https://packages.debian.org/sid/molly-guard), and I had installed [molly-guard](https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/by-name/mo/molly-guard/package.nix#L35) on my NixOS desktop, but apparently I didn't configure it correctly.

<!--more-->

## Default Molly-Guard Behavior
I had molly-guard installed via `environment.systemPackages`, but its default config does not set `ALWAYS_QUERY_HOSTNAME=true`, so it didn't prompt on local sessions.

## Config Source
Molly-guard reads its config from the Nix store path in its derivation, not from `/etc/molly-guard/rc`.

## Initial Attempt with postInstall
I added a `postInstall` step in the package override to edit `$out/etc/molly-guard/rc` and uncomment `ALWAYS_QUERY_HOSTNAME=true`, but this phase didn't execute during the build.
Apparently debian-derived packages do not have an 'installPhase` so `postInstall` never runs.

## Successful Fix with postFixup
I switched to a `postFixup` step instead:

```nix
let
  molly-guard-patched = pkgs.molly-guard.overrideAttrs (old: {
    postFixup = (old.postFixup or "") + ''
      sed -i '/ALWAYS_QUERY_HOSTNAME=true/s/^# *//' $out/etc/molly-guard/rc
    '';
  });
in
{
  environment.systemPackages = with pkgs; [
    molly-guard-patched
    # other packages...
  ];
}
```

After `nixos-rebuild switch`, this applied the change.

## Verification
To confirm:

```
❯ grep SETTINGS `which reboot`
MOLLYGUARD_SETTINGS="/nix/store/dpd7v9jla4a36sfdn0pdj9pj9hgzl42r-molly-guard-0.7.2/etc/molly-guard/rc"; export MOLLYGUARD_SETTINGS

❯ grep ALWAYS_QUERY_HOSTNAME /nix/store/dpd7v9jla4a36sfdn0pdj9pj9hgzl42r-molly-guard-0.7.2/etc/molly-guard/rc
ALWAYS_QUERY_HOSTNAME=true
```

Now, `sudo reboot` always prompts for the hostname, even locally.
