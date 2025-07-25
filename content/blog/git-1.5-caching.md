+++
title = "git caching for v1.5.x"
date = "2007-02-21T04:13:16-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['scm', 'git']
keywords = ['scm', 'git']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I wrote about [git caching]{git-caching} several months back.  The term, *git caching*, was something I
had given a local repository that can be used as a reference for multiple projects.  New features in the
recently released git 1.5.x requires that I blog again about this great tool.

Recap: I am working on a linux patch -- [klips]{tags/openswan} to be specific.  I have more repositories 
then I know what to do with.  Git has this cool feature where it can point to another directory to 
find it's object files, this is called *alternate* or *reference* repository.

<!--more-->

**Git 1.5.0**

First, you will need git 1.5.0 or better, as it added some new branching and remote management features.  If 
you need to build it follow these steps:

        $ git clone git://git2.kernel.org/pub/scm/git/git.git
        $ cd git
        $ make configure
        $ ./configure --prefix=/usr
        $ make all doc
        $ sudo make install install-doc

( you may need [my patch](/~bart/patches/git/20070221/0001-allow-git-remote-to-parse-out-names-with-periods-in-them.patch) otherwise you will not be able to have dots in your remote names )

**The cache**

Now, let's make a new cache for the linux tree:

        $ mkdir -p /site/scm/git/linux.git
        $ cd /site/scm/git/linux.git
        $ git init-db

Now we add some repositories we want to track:

        $ git remote add linux git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
        $ git remote add linux-v2.6.15.y git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.15.y.git
        $ git remote add linux-v2.6.16.y git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
        $ git remote add linux-v2.6.17.y git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.17.y.git
        $ git remote add linux-v2.6.18.y git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.18.y.git
        $ git remote add linux-v2.6.19.y git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.19.y.git
        $ git remote add linux-v2.6.20.y git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.20.y.git

So far we have no objects for these repositories.  To fetch them all I used to [maintain a script]{fetch-all-git-branches} 
that got them one by one.  But now we have a single git command to update everything:

        $ git remote update

And it not only gets all remotes, it also gets all branches of all remotes.

Wow!

If you forgot some, you can add them and update again:

        $ git remote add linux-kgdb git://git2.kernel.org/pub/scm/linux/kernel/git/trini/linux-2.6-kgdb-master.git
        $ git remote add linux-kgdb-testing git://git2.kernel.org/pub/scm/linux/kernel/git/trini/linux-2.6-kgdb-testing.git
        $ git remote update

Now you can schedule this at night time using cron so you always have a fresh 
cache.  Note that the intent is not to clone this repository locally.  It does 
not have to be upto date all the time.  Once a day is just fine.

**Working repositories**

Say I want to work on a patch for the kernel.  I clone as I would normally, but I add a `--reference` option and point it at my cache.

        $ git clone --reference /site/scm/git/linux.git \
                git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git \
                linux-work

Now `linux-work` has the latest from Linus, but it didn't have to download it from the `kernel.org` server.  It just asked
the server for the object hashes and fetched all that it could from the *reference*.  Here is what's inside:

        $ git branch -a
        * master
          origin/HEAD
          origin/master

Note that 1.5.x tracks all branches off the remote.  When you `git fetch origin` it will get any new branches that 
Linus created.

Git 1.5.x also separates local and remote branches.  The `-a` shows all branches.  By default all remote branches 
that are tracked will have the remote's name as a prefix.  You can access them with that name:

        $ git log -1 origin/master
        commit c8f71b01a50597e298dc3214a2f2be7b8d31170c
        Author: Linus Torvalds <torvalds@woody.linux-foundation.org>
        Date:   Tue Feb 20 20:32:30 2007 -0800

            Linux 2.6.21-rc1

**How references work**

Should you need to, you can change the reference to a superset repository (ie, it contains all the objects that 
your working repo needs) as the location is just a path to another repo:

        $ cat .git/objects/info/alternate
        /site/scm/git/linux.git/.git/objects/

**Chaining reference repositories**

Ok, here comes a(nother) neat part.  You can have an alternate point to a repository that is itself using an alternate.

Why?  Well, recall I am working on KLIPS, not on Linux directly.  KLIPS has it's own git repository that is based on Linux.  Locally
my main KLIPS clone references the linux cache, as described above.  This KLIPS tree is my cache.  My actual work repository references this cache.
