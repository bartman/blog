+++
title = "local caching for git repos"
date = "2006-10-28T11:16:07-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['git', 'scm']
keywords = ['git', 'scm']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I try to minimize the amount of data I pull from git repositories.  To do this I have a 
directory on my file server that has a bunch of clones of git (and hg and previously bk) 
repositories.  All of these are exported and mounted on my other machines in `/site/scm/`.
I will refer to this as *cache* :)

Next, I have a cron job that regularly updates those trees from the their upstream 
counterparts.  All my working copies are cloned from those repositories using the
`--local --shared` mode, or using `--reference` if I think I will be committing 
upstream any time soon.

<!--more-->

**Using local git *cache* to build an unmodified tree**

If I just want to build a kernel I would run:

    git-clone --local --shared -n /site/scm/git/linux-2.6.git linux-2.6-build
    git-tag -l
    git-checkout -b my-build-branch v2.6.18.1

This will create a new clone in `linux-2.6-build`, and pretty much leave the tree 
empty -- the result is a tree that's about 500k in size.  Next, I look at the tags
available and decide I want to build *v2.6.18.1*.  I do a checkout onto a new branch 
called `my-build-branch`.  The result is a tree with all actual history stored 
on the file server, and only the *v2.6.18.1* version in the build directory.

**Setting up a working tree with commits to upstream**

Next, if I am working on a project that will end up generating commits I want to
push up, then I would run something like this:

    git-clone -n --reference /site/scm/xelerance/openswan.git \
                git+ssh://vault.xelerance.com/.../openswan.git/ \
                openswan-work
    git-checkout -f -b my-public public
    echo "Push: my-public:public" >> .git/remotes/origin

This one is a bit more complicated.  The `git-clone` will create a repository
that is seeded from *vault.xelerance.com*, but only if the objects are not 
present in the *local cache*.  All pulls and pushes are done with *vault* over ssh,
but before any objects are downloaded, the *local cache* is first checked.  Next
step is to create a working branch called `my-public` on which I will make 
my changes to the upstream `public` branch.  Finally, I record that I want to 
push my changes from `my-public` to `public` upstream.

**Using personal working branches and upstream-tracking branches**

The reason why having distinct `my-public` and `public` branches is not initially 
obvious.  The local `public` branch tracks the upstream repository's `public` branch.
Initially, it contains none of my local changes, just what other developers have pushed.
I do all of my work on `my-public`, and only push after I have merged those 
`public` changes with my code.

A common interaction would be

  - `git fetch` - updates the `public` branch, and possibly other branches, with upstream's changes
  - `git pull . public` - update current working branch, `my-public`, with changes from `public`
  - edit, compile, test, commit
  - `git fetch` - get the changes done in parallel
  - `git pull . public` - merge the other developer's work into mine
  - `git push` - push changes on `my-public` to `public` upstream
  - `git push` - update local `public` branch to track latest `public in upstream

Finally I should mention that the `my-*` branches never leave my repository.  They are only used
to differentiate local branches from upstream-tracking branches.

**Update script**

Oh... and finally, getting back to the *cache*, here is the script that updates 
all my repositories in my *cache*.

    #!/bin/bash
    
    for d in */.git/../ ; do 
            ( 
            cd $d 
            echo
            echo ================= $(pwd)
            echo
            remotes=$(cd .git/remotes/ ; ls | grep -v '~$')
            branches=$(cd .git/branches/ ; ls | grep -v '~$')
            for o in $remotes $branches ; do
                    echo ----------------- fetch $o
                    git fetch $o
            done
            echo ----------------- repack
            git repack -a -d 
            )
    done

**Merging multiple remotes into one cache**

Here is another great feature of git.  By default the only remote that git tracks is `origin`.  But, 
you can have multiple entries under `.git/remotes/` directory that allows you to track multiple 
remote trees that share common ancestry.

I think this is most evident in the linux tree.

    $ cd /site/scm/git//linux-2.6.git/
    
    $ ls .git/remotes/       
    origin  v2.6.15.y  v2.6.16.y  v2.6.17.y  v2.6.18.y
    
    $ cat .git/remotes/origin 
    URL: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
    Pull: master:origin
    
    $ cat .git/remotes/v2.6.18.y
    URL: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.18.y.git
    Pull: master:v2.6.18.y

This allows me to compare stable trees with Linus trees.  But best of all, when I clone this tree
-- as shown above -- there is only one place that stores all the common ancestry: the *cache*.
