+++
title = 'Nix Neovim Overlay'
date = '2026-03-31T10:14:56-04:00'

categories = ["post"]
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ["nix", "neovim"]
keywords = ["", ""]
description = "build neovim from github tag on NixOS using overlays"
showFullContent = false
readingTime = true
hideComments = false

draft = true
+++

## title

I run NixOS, my configuration is quite conservative (stable release), but I do occasionally install from unstable.

Neovim v0.12 just dropped and I wanted to switch to it.  NixOS has not yet updated v0.12 (not even in unstable).

I wanted to build my own Neovim v0.12 using overlays...

<!--more-->

Here is a snippet from the configuration...

```nix
{
  nixpkgs.overlays = [
    (self: super: {
      neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (oldAttrs: {
        version = "0.12.0";
        src = super.fetchFromGitHub {
          owner = "neovim";
          repo = "neovim";
          rev = "v0.12.0";
          sha256 = "uWhrGAwQ2nnAkyJ46qGkYxJ5K1jtyUIQOAVu3yTlquk=";
        };
      });
    })
  ];
}
```

You can paste the inner-block into your `configuration.nix`. I actually import the file into my `configuration.nix` using an import, as it makes it easier to comment out.

```nix
{
    imports = [ overlays/neovim.nix ];
}
```

Then we kick off a build (note that this will build neovim, and anything that depends on neovim, so it might take a bit)...

```sh
❯ nixos-rebuild build --flake .
```

and we have the new neovim...

```sh
❯ nvim --version
NVIM v0.12.0
Build type: Release
LuaJIT 2.1.1741730670
Run "nvim -V1 -v" for more info
```

