+++
title = "generating ssh keys in 2025"
date = "2025-05-28T20:10:00-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ["ssh", "linux"]
keywords = ["ssh", "linux"]
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I'm setting up a new system, and I always create a new key when I bulid a new desktop...
Having not done it in a few years, I wanted to see what the recomended ssh key looks like these days.

<!--more-->

Came across this link:
[SSH Key Best Practices for 2025 – Using ed25519, key rotation, and other best practices](https://www.brandonchecketts.com/archives/ssh-ed25519-key-best-practices-for-2025)

here is what I learned:
- use ed2219, which is the default on modern openssh
- provide a meaningful description, that includes a year of creation
- plan on rotating keys every couple years
- password protect (duh)

The author also said that he like to generate a key a few times to get a noverl and momorable hash.

Cute, so what would it take to find one with something that looks cool
```bash
#!/usr/bin/env bash
set -e
 
user=                  # fill me
system=                # fill me
year=$(date +'%Y')
 
key=id_ed25519_${system}_${user}_$year
pub=$key.pub
 
die() { echo >&2 "$*" ; exit 1 ; }
 
[ -f "$key" ] && die "$key: exists, refusing to continue"
[ -f "$pub" ] && die "$pub: exists, refusing to continue"
 
iteration=0    
start=$(date +%s)
while true ; do
        echo "------------------------------------------------------------------------"

        let iteration=iteration+1
        duration=$(( $(date +%s) - $start ))
        echo iteration=$iteration duration=$duration
        echo
        
        ssh-keygen -t ed25519 -f $key -C "$user+$year@$system" -N '' 
        echo
        cat $pub
        echo
        
        read -p 'do you like it? [y/n/Q]' -n 1 answer 
        case "$answer" in 
                N|n) ;;          
                Y|y) ssh-keygen -p -f $key ; exit 0 ;;
                *) die terminating ;;
        esac    
 
        rm -f $key $pub
done
```


