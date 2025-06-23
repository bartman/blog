+++
title = 'nixos Fooocus'
date = '2025-06-23T12:01:33-04:00'

categories = ["blog"]
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ["nixos", "fooocus", "genai", "docker"]
keywords = ["nixos", "docker", "fooocus"]
description = ""
showFullContent = false
readingTime = true
hideComments = false
+++

I had Fooocus running on Debian, and I recall it was not trivial to setup.

I am now running NixOS, and wanted to run it again to enhance some images.

Here is how to run dockerized Fooocus app on NixOS (or anywhere, really).

<!--more-->

## configure docker on nix

```nix
hardware.nvidia-container-toolkit.enable = true;
virtualisation.docker = {
  enable = true;
  autoPrune.enable = true;
  enableOnBoot = true;
};
```

Optionally allow the port through firewall (for external access)

```nix
networking.firewall.allowedTCPPorts = [ 7865 ];
```

(then `nixos-rebuild switch`)

## run Fooocus

```sh
docker run -it --device nvidia.com/gpu=all -p 7865:7865 -v ./models:/fooocus/models -v ./outputs:/fooocus/outputs jamesbrink/fooocus
```

(it will take some time on the first run)

## some links

- Fooocus: https://github.com/lllyasviel/Fooocus
- docker image: https://hub.docker.com/r/jamesbrink/fooocus
- nixos help: https://www.reddit.com/r/NixOS/comments/1kpo2s1/best_way_to_run_comfyui/
