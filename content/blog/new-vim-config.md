+++
title = "new vim config"
date = "2024-02-03T16:44:50-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['vim', 'nvim', 'neovim', 'linux']
keywords = ['vim', 'nvim', 'neovim', 'linux']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I started from scratch and built up a new Neovim config.

Based on this video series:
* [video](https://www.youtube.com/watch?v=zHTeCSVAFNY) by `typecraft` (thank you)

Pushed to github here:
[https://github.com/bartman/nvim-config](https://github.com/bartman/nvim-config)

<!--more-->

# about

So this is what it looks like...

![screencapture.png](https://raw.githubusercontent.com/bartman/nvim-config/master/screencapture.png)


You'll probably have to install some tools...

```
sudo apt install clang clangd npm
```

You will need neovim 0.10, or at least 0.9 for some of these plugins.

I found building it from source pretty easy on Debian/Ubuntu.

```
sudo apt install libgettextpo-dev gettext
git clone https://github.com/neovim/neovim
cd neovim
mkdir -p ~/usr
make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$HOME/usr/neovim
make install
```

Note that I installed things in `~/usr/neovim`, which means it needs to go in the PATH.
Alternatively you can make aliases for them in your `~/.bashrc` (or whatever shell you use).

```
alias vim=~/usr/neovim/nvim
alias vi=~/usr/neovim/nvim
alias vimdiff='~/usr/neovim/nvim -d'
```

Move the old config out of the way, if you have one...

```
mv ~/.config/nvim ~/.config/nvim.old
```

Then copy over the files under `config/nvim`...

```
mkdir -p ~/.config/nvim/
cp -r config/nvim/* ~/.config/nvim/
```

Start things up...

```
nvim
```

At this point you can run
 - `:Lazy` to check on the nvim packages being installed (`q` to close)
 - `:Mason` to check on diagnostic tools being installed (`q` to close)

You can use `:WhichKey` to browse through the keyboard shortcuts interactively.

You can also use the `,fk` shortcut to bring up Telescope keymap browser.
