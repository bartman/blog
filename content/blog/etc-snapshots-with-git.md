+++
title = "etc snapshots with git"
date = "2007-03-12T13:47:06-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['git', 'linux', 'debian']
keywords = ['git', 'linux', 'debian']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I got this idea from a blog posting a few months back.  I think the guy was using *darcs*.  Unfortunately, I
was unable to find the reference to link to him.

Anyway, here is how you can track your `/etc` directory with *git*, and have *apt* update it
automatically each time a package is installed.

<!--more-->

*The following steps require root access:*

 * install git

        apt-get install git-core

 * initialize `/etc` to be a git repo

        cd /etc
        git init-db
        chmod og-rwx .git

 * ignore a few files

        cat > .gitignore
        *~
        *.dpkg-new
        *.dpkg-old

 * commit the current state

        git add .
        git commit -a -m"initial import"

 * install a snapshot script for *apt* to call

        cat > apt/git-snapshot-script 
        #!/bin/bash
        set -e
        caller=$(ps axww | grep "^ *$$" -B3 | grep " apt-get " | head -n1 | sed 's/^.*\(apt-get .*\)/\1/' )
        git-add .
        git-commit -a -m"snapshot after: $caller"

   ... make it executable ...

        chmod +x apt/git-snapshot-script

 * configure *apt* to track changes

        cat >> /etc/apt/apt.conf
        DPkg {
                  Post-Invoke {"cd /etc ; ./apt/git-snapshot-script";};
        }

 * track these two files

        git add .
        git commit -a -m"apt will track /etc automagically using git"

... and you're done.

Note that the `chmod og-rwx /etc/.git` step is very important.  Your `/etc/.git` directory should
only be accessible to root.  If not, it's as good as giving everyone access to your `/etc/shadow`
and other *secrets* that hide in `/etc`.  Should you clone this repository to another box, you 
have to make sure that the same precautions are taken.

Now when you install a package, it will be tracked in the git repository.

        # apt-get install mercurial
        ...
        Created commit daa7de7264b65cd073a1ef0f75ba50aa488d5af2
         3 files changed, 409 insertions(+), 0 deletions(-)
         create mode 100644 bash_completion.d/mercurial
         create mode 100644 mercurial/hgrc
         create mode 100644 mercurial/hgrc.d/hgext.rc

You can see what changed...

        # git whatchanged -1
        commit daa7de7264b65cd073a1ef0f75ba50aa488d5af2
        Author: Bart Trojanowski <bart@jukie.net>
        Date:   Mon Mar 12 16:09:18 2007 -0400

            snapshot after: apt-get install mercurial

        :000000 100644 0000000... a7f4740... A  bash_completion.d/mercurial
        :000000 100644 0000000... dfc3400... A  mercurial/hgrc
        :000000 100644 0000000... 8f2d526... A  mercurial/hgrc.d/hgext.rc

**Update...**

Only two days after writing the original posting I got two replies.  In one, Michael Prokop told me that he had
[ported my procedure to use mercurial](http://michael-prokop.at/blog/2007/03/14/maintain-etc-with-mercurial-on-debian/).  Rock on!

Later still I was notified by Yannick Gingras that he also [tackled the etc tracking with mercurial task](http://ygingras.net/b/2007/11/a-case-for-hg-on-etc).

And lastly, it should be noted that debian now has an etckeeper that trackes /etc in git.
