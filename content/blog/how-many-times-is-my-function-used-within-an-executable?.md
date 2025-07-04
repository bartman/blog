+++
title = "How many times is my function used within an executable?"
date = "2010-04-26T16:26:44-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['debug', 'devel', 'linux']
keywords = ['debug', 'devel', 'linux']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I am working on a large kernel module which had just come out of a large (and fruitful)
internal API refactoring exercise.  I now want to go through and cull the unused functions.

It turns out, all that is needed is the `readelf` utility (part of `binutils` package).

<!--more-->

First, we need to grab a list of externally visible functions:

    readelf -s mymodule.ko | awk '/\<FUNC\>.*\<GLOBAL\>/ { print $8 }'

Next, for each symbol we will print out the users of that function:

    readelf -r mymodule.ko | grep '\<{}\>'

Below is the script that bring it all together.  It turns out that `readelf` will
truncate long symbols, so we use `nm` to get the list of symbols, and `readelf`
to get the relocation table.

    #!/bin/bash
    set -e

    MOD=$1
    if ! [ -n "$MOD" -a -r "$MOD" ] ; then
            echo >&2 "need an elf object file as argument"
            exit 1
    fi

    RELOCS=/tmp/relocations-$$

    readelf -r "$MOD" > "$RELOCS"

    nm --defined-only "$MOD" \
    | while read symofs symtype symname ; do
            if [ "$symtype" = "T" -a -n "${symofs//0/}" ] ; then
                    count=$(grep "   \<$symofs\> " "$RELOCS" | wc -l)
                    printf "%9d  $symofs  $symname\n" "$count"
            fi
    done | sort -n

    rm -f "$RELOCS"
