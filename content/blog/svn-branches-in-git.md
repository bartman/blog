+++
title = "how to track multiple svn branches in git"
date = "2008-03-03T20:03:59-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['git', 'svn', 'scm']
keywords = ['git', 'svn', 'scm']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I must say that I am no fan of [SVN]{tag/svn}, but SVN and I get a long a lot better since I started
using [git-svn]().  Long ago a good friend of mine, Dave O'Neill, taught me how to handle
[multiple branches using git-svn](http://www.dmo.ca/blog/20070608113513).  I had used that
technique until Dave taught me how to do it better.

Recently I saw this [blog post](http://blog.teksol.info/2008/2/29/how-to-handle-multiple-branches-from-subversion-using-git)
which referenced Dave's article talking about the first method.  I guess Dave never got around to
updating his blog with the *better way*.  So I am going to do that here:

<!--more-->

A few of my clients use SVN.  Some I am guilty of introducing to SVN.  But for this post
I need to give you an example that you can follow along with.  So let's use
[shell-fm](http://nex.scrapping.cc/shell-fm/) -- my favorite [last.fm](http://www.last.fm/user/BartTrojanowski/)
client -- with an SVN repo located at `svn://nex.scrapping.cc/shell-fm`.

**NOTE:** You should use a modern git release.  If `git --version` is older then `1.5.3`, you need to upgrade.

Let's start by cloning this repository using *git-svn*:

        $ git svn clone svn://nex.scrapping.cc/shell-fm -T trunk -b branches -t tags

**NOTE:** if you have commit access you may want to modify your svn:// url appropriately.

**UPDATE:** `--stdlayout` is a short form for `-T trunk -b branches -t tags`, and new versions of `git-svn` support it.

This process will take longer then an `svn checkout` would... a lot longer.  There
are two reasons for this. (1) you are getting all the history of the project, and 
(2) SVN has a very slow protocol for this purpose.

Anyway, once it's done (it took me about 5 minutes) you will have a directory called
`shell-fm` with the contents of `trunk` checked out in it.  If not for the fact that the 
`.svn` directory is replaced with a `.git` directory you would have thought that you were
using a slower SVN.

Enter into your new repository and you will see that you have a master branch that is,
by default, following `trunk`.

        $ git branch
        * master

This is not a [git tutorial](http://www.kernel.org/pub/software/scm/git/docs/tutorial.html) 
or a [git svn tutorial](http://git.or.cz/course/svn.html); but I should at least show
how to update your tree, and commit to upstream.

I would like to insert here an advanced topic of packing your repository.  I don't want to explain
it here, see the [man page], but trust me it will make your git experience much more enjoyable 
if you run the following once in a while:

        $ git gc

Now, to update your working tree to the latest of the branch you are currently tracking, you would run:

        $ git svn rebase

This is similar to `svn update`.  There are likely no updates available now, so this will
do nothing.

Next, if you want to share something with the upstream svn server you would run:

        $ vim source/main.c
        $ git commit -m"this is a test" source/main.c
        $ git svn dcommit

This is similar to `svn commit`.

Now, let's look at these branches I was promising:

        $ git branch -r
        1.2
        autoconf
        clean
        plugins
        ripperbahn
        tags/0.1.3
        tags/0.2
        tags/0.4
        trunk

Each of the above is tracking a remote branch in SVN, except for trunk which is tracking `trunk`.
When you run `git svn fetch` all branches will be updated, and new branches on the remote
will be added.  `git svn fetch` fetches the updates with out modifying the local working files
(which `git svn rebase` would).  `git svn fetch` mimics standard `git fetch` behaviour with an
upstream git server.

Working off remote branches is usually done on local topic branches -- that is to say, not
on `master` -- but you can use whatever you want as *git-svn* doesn't care.

Let's thus create a new branch for fixing a mythical bug on the 1.2 branch.

        $ git checkout -b fixing-bad-1.2-bug 1.2

Almost immediately, and without server interaction, we get a checkout of branch 1.2
contents.  You can see where you are with:

        $ git branch
        * fixing-bad-1.2-bug
          master

If you carefully inspect output of `git log` you can see that *git-svn* reveals
the branch name and upstream SVN commit ID on the last line of each commit:

        $ git log -1
        commit 308244b0d275db460e3b4527afd51258cece4d33
        Author: strogg <strogg@7df44517-d413-0410-91cf-82ca28b36b55>
        Date:   Thu Sep 13 19:39:51 2007 +0000

            This is a patch from Wisq to make shell-fm accept 302 redirects as well as 301.
            
            git-svn-id: svn://nex.scrapping.cc/shell-fm/branches/1.2@252 7df44517-d413-0410-91cf-82ca28b36b55

We are on `branches/1.2` commit id `252`.  If you prefer it, you can even get the
svn style log output with `git svn log`... *but why?*

Working on this branch is as easy as working off trunk.  You edit, commit, and `git svn dcommit` to upstream.

Switching between your local branches is easy...

        $ git checkout -f master
        $ hack hack hack
        $ git commit

        $ git checkout -f fixing-bad-1.2-bug
        # and we're back on 1.2 bug fixing

Note that you don't have to push your commits back to upstream immediately, or ever for that matter, to
make use of the git repository to store your local changes.  But if you do decide to you just need to
run `git svn dcommit`.

--

If you're interesting in migrating CVS to git, have a look at the [CVS to git Transition Guide](http://www.chem.helsinki.fi/~jonas/git_guides/HTML/CVS2git/).