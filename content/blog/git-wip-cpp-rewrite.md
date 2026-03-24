+++
title = 'git-wip C++ rewrite — over a decade later'
date = '2025-12-16T17:14:36-05:00'

categories = ["post"]
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = [ "git", "vim", "neovim", "c++", "lua" ]
keywords = [ "git", "vim", "neovim", "c++", "lua" ]
description = "git-wip C++ rewrite — a decade later"
showFullContent = false
readingTime = true
hideComments = false
+++

Many many years ago I wrote about [git-wip](http://www.jukie.net/bart/blog/save-everything-with-git-wip), a tool I created to automatically snapshot your working tree on every file save.  The original was a bash script, written over a few weekends in 2009.  It served me well for over a decade, but it had accumulated technical debt: the bash script had issues with whitespace in filenames, it used external tools like `git-sh-setup`, it was getting harder to extend, slow on large repos, and so on.

A decade and a half of GitHub issues had piled up.  Some were feature requests.  Others were bugs.  Many were just things that didn't work on platforms that weren't my own.  I had ignored most of them — the script was good enough for me, and I didn't really have to pull to work on it in my free time.  Sorry.

That changed recently.

<!--more-->

## What is this git-wip again?

*WIP* stands for "Work In Progress".  `git-wip` is a program that saves all your changes not on a commit (and optionally untracked/ignored files) into `wip/*` branches.  The `wip/*` branch contains all the changes made in your editor since the last commit.  They are meant as means to recover from unwanted changes down the line.  If you commit every 5 minutes, this tool is not for you.  If you work for hours between commits, this could be quite useful as a means to recover things that have since been deleted.

TL;DR install:
```sh
$ make
$ make install        # installs git-wip to ~/.local by default
```

TL;DR manual usage:
```
$ edit edit edit
$ git wip
$ edit edit edit
$ git wip
$ git wip status
branch master has 20 wip commits on refs/wip/master
```

But the intended usecase is as a neovim/vim plugin.  Every time you `:w` it will call out to git-wip and it capture your save on a *hidden* `wip/*` branch.  And you can inspect/recover any change using git tools.  You can even push them to another system (or services like gitlab or github).

## Why rewrite?

The spark came when I tried to add a new feature and spent more time fighting the bash script than actually implementing anything.  I had some long flights coming up, and I thought: what if I just rewrote this properly?

My goals were:

- **Usability fixes** — handle whitespace in filenames, better error messages, finally implement the status and delete commands.
- **Performance** — the bash script forked a dozen processes per invocation; the new version should be fast enough that you don't notice it on every `:w`
- **Editor support** — the old vim plugin was fragile; the new one should be clean Lua for Neovim
- **Testability** — the original had very few tests; I wanted proper unit tests and integration tests
- **Address GitHub issues** — there were about a dozen open issues; many were now fixable with a proper implementation

## What I built

The new git-wip is written in C++23 using [libgit2](https://libgit2.org/) for all Git operations.  I chose C++ because:

- it was modern, familiar, and performant
- libgit2 is the canonical Git library

The only runtime dependency is libgit2.  All other dependencies (like [spdlog](https://github.com/gabime/spdlog) for logging) are fetched automatically by CMake's FetchContent.

The codebase is organized as:

```
src/
  main.cpp              # argument dispatch
  command.hpp/cpp       # base Command class
  git_guards.hpp        # RAII wrappers for libgit2 handles
  cmd_save.hpp/cpp      # save command
  cmd_log.hpp/cpp       # log command
  cmd_status.hpp/cpp    # status command
  cmd_delete.hpp/cpp    # delete command

lua/git-wip/init.lua    # Neovim plugin (Lua)

test/
  unit/                 # C++ unit tests with Google Test
  cli/                  # Shell-based CLI integration tests
  nvim/                 # Neovim plugin tests
```

### New commands

I took the opportunity to add commands that should have been there from the start:

- `git wip status -l -f` — list WIP commits and show per-commit diff stats
- `git wip status <ref>` — check WIP status for any branch
- `git wip list -v` — list all WIP refs with commit counts and orphaned refs
- `git wip delete` — delete WIP refs, including `--cleanup` for orphaned refs

### Neovim plugin

The old vim plugin was a one-liner that called the bash script via `system()` and could take seconds to complete.  The new Neovim plugin is written in Lua.  Nicer to work with, takes configuration options in a sane way, integrates with Lazy package manager, and much faster (probably mostly because `git-wip` uses libgit2 under the hood).

Key features:

- **Runtime API compatibility** — the plugin detects Neovim version at runtime and uses `vim.system()` (Neovim 0.10+) or `vim.fn.system()` (older versions)
- **Configuration options** — `gpg_sign`, `untracked`, `ignored`, `filetypes`
- **`:Wip` and `:WipAll` commands** — manual invocation without needing to save
- **Quiet mode** — uses `--editor` flag to silently succeed when there are no changes

```lua
require("git-wip").setup({
    gpg_sign = false,
    untracked = true,
    ignored = false,
    filetypes = { "lua", "c", "cpp" },
})
```

## Testing

The old script had no tests.  The new implementation has three test suites:

### Unit tests (C++)

Google Test-based unit tests for the helper functions and Git operations.  Includes a fixture that creates a private Git repository to test against real Git data.

```
$ make test
...
 3/15 Test  #3: unit/test_wip_helpers ............   Passed    0.05 sec
```

### CLI integration tests (shell)

The legacy test cases from the original bash script, plus new ones.  These test the full binary end-to-end by creating real git repos and checking the output.

```
 4/15 Test  #4: cli/test_legacy ..................   Passed    0.11 sec
 5/15 Test  #5: cli/test_spaces ..................   Passed    0.03 sec
 ...
```

### Neovim plugin tests (shell)

Tests that run the Lua plugin through `nvim --headless`.  These verify that the autocmd fires, the commands work, and the plugin handles edge cases like buffers without filenames.

```
13/15 Test #13: nvim/test_nvim_single ............   Passed    1.68 sec
14/15 Test #14: nvim/test_nvim_buffers ...........   Passed    3.76 sec
15/15 Test #15: nvim/test_nvim_windows ...........   Passed    3.23 sec
```

All tests run in GitHub Actions on a matrix of:

- **Debian stable** and **Ubuntu 24.04 LTS**
- **GCC** and **Clang** compilers
- **Release** and **Debug** builds

That's 16 build configurations, all tested on every push.  The test artifacts (on failure) are uploaded for 7 days so I can reproduce any CI failure locally.

## Performance

I haven't done formal benchmarks, but the difference is immediately noticeable.  The bash script spawned 12-15 processes per invocation (`git rev-parse`, `git symbolic-ref`, `git add`, `git write-tree`, `git commit-tree`, `git update-ref`, etc.).  The C++ version makes the same Git calls through libgit2 in-process.

File saves feel instant.  The notification appears as quickly as git itself would run those operations — which is to say, fast.

## Building

### On Debian / Ubuntu

```sh
$ git clone https://github.com/bartman/git-wip.git
$ cd git-wip
$ ./dependencies.sh              # install build dependencies
$ make                           # build → build/src/git-wip
$ make test                      # run all tests
$ make install                   # install to ~/.local/bin
```

### On NixOS

```sh
$ git clone https://github.com/bartman/git-wip.git
$ cd git-wip
$ nix develop                   # drop into shell with all deps
$ make                          # build → build/src/git-wip
$ make test                     # run all tests
$ make install                  # install to ~/.local/bin
```

The flake provides a dev shell with CMake, Ninja, GCC, Clang, libgit2, and Google Test.

## What's next

The C++ code is now merged to master.  Tag v0.2 points to the last bash-based version.  I'll give it a few weeks and release a v0.3.

If you're already a git-wip user, the new version is a drop-in replacement -- you do have to build the executable.  If you've been waiting for one of those GitHub issues to be fixed — they probably are now.

You can try it.

---

**Related:** [Original git-wip blog post](http://www.jukie.net/bart/blog/save-everything-with-git-wip) | [wip.rs](https://github.com/dlight/wip.rs) — a Rust watcher that invokes git-wip automatically
