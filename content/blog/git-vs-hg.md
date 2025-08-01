+++
title = "git vs hg"
date = "2006-06-21T15:14:02-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['git', 'mercurial', 'scm']
keywords = ['git', 'mercurial', 'scm']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

After working almost exclusively with [git](http://git.or.cz/) for a few months, I had to do some work
on a freebsd kernel.  The freebsd kernel is maintained in [mercurial](http://www.selenic.com/mercurial). I
noticed right away a few features that I have started to take for granted with git.

<!--more-->

But let's go back for a bit...

I started using BK in 2001 while working for Soma Networks.  I really loved it and was really happy 
when Linus adopted it for kernel development.

Then BK pulled it's free license and Linus [wrote 
git](http://en.wikipedia.org/wiki/Git_%28software%29#Early_history).  At first I really liked git, it was 
simple, powerful, and open.  And I knew that it would be a solid tool in about a year time because of 
the amount of people that would follow wherever Linus led them -- and that they would try to tell him 
that he was wrong while following.

Sometime around the 2nd or 3rd moth of git's development, Matt Mackall told Linus that he was doing the 
back end wrong.  That is, instead of storing state, git should store differences in state.  Matt had a 
cool storage scheme called a *revlog*, which he had proven several times ince then was faster at certain 
operations.  Linus of course didn't listen.  Matt thought that he was right and started to work on mercurial (aka **hg**).

And while I see Matt's case, and he could very well be 100% correct about his issues with git, I 
find that git is a much more powerfull tool... at least after getting over the 
[complex interface](http://www.kernel.org/pub/software/scm/git/docs/git.html).  I have to say that 
the [documentation](http://www.kernel.org/pub/software/scm/git/docs/everyday.html) a lot
[better](http://www.kernel.org/pub/software/scm/git/docs/tutorial.html) today then it was when I
gave up on git.  Having to use git for work, and having plentiful documentation, have gotten me 
[over the initial pain]{learning-to-love-git}.

And here are a few things that make git great:

  1. git-branch

     The first thing I noticed was the fact that it is relatively hard to track two branches using hg.
     I would have never noticed that had I not worked with git's very powerful branching :)

     I really like the fact that you can have multiple branches in one repo and track them both.  For 
     example I want to track both the [release](http://hg.fr.freebsd.org/src-releng_6/) and the 
     [development](http://hg.fr.freebsd.org/src-head/) branches of `/usr/src` directory of freebsd.

     With git I can manage them using `.git/remotes/release` and `.git/remotes/development`, or even easier
     with cogito's cg-branch-add command.  Then I can simply pull and update both branches

        git-fetch release
        git-fetch development

     These are called [topic](http://www.kernel.org/pub/software/scm/git/docs/howto/using-topic-branches.txt)
     [branches](http://www.kernel.org/pub/software/scm/git/docs/howto/separating-topic-branches.txt).

     And I can do the fetch regardless of what branch I am currently on, as it just updates the repository.  This 
     is really cool when you're trying to compare changes between two development streams of the same tree.  To 
     pull into whatever branch I am currently working on I run:

        git-pull . release/some-branch
        git-pull . development/the-branch-of-bob

     That's just awesome.

  2. git-rebase

     So say you're working on a large project -- in therms of the number of developers -- to which you 
     don't have commit privileges to.  Usually you would submit patches via email and hope they get 
     excepted... because if they do you will not have to maintain them *out of tree*.

     Say after the first submission you are told to fix a few things and try again.  A new upstream comes
     out and since you're not really interested in doing development on a patch for an older kernel
     -- because that will never get accepted.

     So now, you need to move your development onto a new branch.  With other SCMs you would do a merge
     of the new release into your working branch.  And then as you do more development on that branch
     you end up having a mix of three kinds of changesets: a) upstream changes, b) your changes, and c)
     merges of your changes with the upstream.  It becomes harder and harder to determine what is your 
     new code.  

     In git, when the upstream release comes out you can *rebase*, which basicall means *take all my
     changes and apply them onto this new release branch*.  If any changeset you made fails to apply 
     cleanly onto the new branch, you are asked to resolve it and then continue the rebase operation.

     git keeps all your changes and work flow intact, it even keeps the old changes you made to the first 
     branch in history.  Nothing is lost.  But at the end you have a ranch that you could ask the upstream 
     to pull from if they wanted to.  It's clean because it's not polluted by merge changesets that are 
     completely uninteresting in this kind of development.

     That's just awesome.

  3. git-clone --shared

     A shared clone is one which points directly to a (preferably) local repository for getting
     it's objects.  This is really great for working repositories... and even better then hard-linking,
     because it never needs updating.  Although there is a `--local` flag that does hardlinks.

     So when you clone a local repository as `--shared`.  The clone will contain no object initially,
     instead it will have a `.git/objects/info/alternates` set to the original repository.  Whenever
     the object is not found in the new clone it will look in the `alternates` for that object.

     This means that having *per-task* working repositories is trivial -- just in case doing a clone
     was ward -- and incurring almost zero overhead.

        git clone git://remote/repo clean-clone
        git clone --local --shared clean-clone work-1
        git clone --local --shared clean-clone work-2

  4. git-clone --reference

     I manually maintain a list of frequently used git repositories on my file server.  I call this
     my cache because I use it to reduce the amount of data that I need to get from the internet when
     I clone a new tree.

        git clone git://remote/repo clean-seed-of-repo
        git clone --reference clean-seed-of-repo git://remote/repo work-1
        git clone --reference clean-seed-of-repo git://remote/repo work-2
     
     This takes the `--local --shared` idea a bit further.  It allows the working directories to push
     to the `remote/repo` but fetch objects from the `clean-seed-of-repo` if possible.

     Having a local seed for various frequently used seeds also means that a full clone, with all history 
     of the kernel, is about 500k on disk.  You can run all the analysis tools, like gitk, without 
     having a full checkout.  You can then checkout a tree and not waste disk space on history...

     Read more about this: [caching git repos]{git-caching}.

...more to come.

NOTE: I started writing this when I was still using hg on a daily basis.  Some of these features may
have been added go mercurial by now.

related links:

 - [GIT vs Other: Need argument](http://marc.info/?t=117682816700010&r=1&w=2)
 - [Ted Tso - Git and Hg](http://tytso.livejournal.com/29467.html)

other:
 
 - [Mercurial upgrade](http://pablotron.org/?cid=1524)
 - [GIT vs SVN](http://git.or.cz/gitwiki/GitSvnComparsion)
 - [An introduction to git-svn for Subversion/SVK users and deserters](http://utsl.gen.nz/talks/git-svn/intro.html#howto-track-svn)

