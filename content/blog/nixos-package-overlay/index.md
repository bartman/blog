+++
title = 'nixos package overlay'
date = '2025-06-23T10:35:26-04:00'

categories = ["blog"]
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ["nix", "nixos", "linux"]
keywords = ["nix", "nixos", "overlay"]
description = ""
showFullContent = false
readingTime = true
hideComments = false
+++

I'm running NixOS as my desktop, and I want to include a package,
that is now newer in `git` than what's published with the stable
release of NixOS (25.04).

This can be done with overlays.

<!--more-->

## the setup

Specifically I want to use [my changes to mtr](../mtr-braille-graph/).
Changes are available on github [bartman/mtr's master branch](https://github.com/bartman/mtr).

While this is available in the official [upstream](https://github.com/traviscross/mtr) also,
I decided to use my branch just in case I keep mucking with it.

I already have `mtr` packages installed in my config...

```nix
  environment.systemPackages = with pkgs; [
    mtr
  ];
```

## getting the hash

Nix wants a SHA-256 hash of the code we want to use for integrity and reproducibility.
We can obtain it using `nix-prefetch-git`...

```sh
❯ nix-prefetch-git https://github.com/bartman/mtr.git HEAD
```
and you'll see something like:
```json
  "sha256": "0lr3kq5vma4wjbspbnh2jpcv3vkhdi57023nv46yfz8f3n83l408",
```
in the output (obviously if you use a different package, your hash will be different).

NOTE: if you don't have `nix-prefetch-git` installed, you can also run...
```sh
❯ nix run nixpkgs#nix-prefetch-git -- https://github.com/bartman/mtr.git HEAD
```

## adding the overlay

The overlay itself looks like this:

```nix
  nixpkgs.overlays = [
    (self: super: {
      mtr = super.mtr.overrideAttrs (oldAttrs: {
        src = super.fetchFromGitHub {
          owner = "bartman";
          repo = "mtr";
          rev = "master";
          sha256 = "0lr3kq5vma4wjbspbnh2jpcv3vkhdi57023nv46yfz8f3n83l408";
        };
        patches = [];
      });
    })
  ];
```

The key parts are:
- `mtr` is the package name we are replacing the source for
- `fetchFromGitHub` is a function that clones the repo from github, using owner/repo/branch
- `sha256` is the hash from before
- `patches` disables the patches the maintainer provided, because they conflicted with code on the upstream `master` branch

Then just `nixos-rebuild` as usual, and you're up and running with your overlay.
