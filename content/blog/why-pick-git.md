+++
title = "Why pick Git?"
date = "2009-07-02T11:32:22-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['git']
keywords = ['git']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

Someone on the Git LinkedIn group asked "why pick Git?".  I started writing a
response on LinkedIn but quickly realized I had more to say on the topic than I'd
care to leave behind closed doors of LinkedIn.

If you already use Git, none of the stuff I talk about below will surprise you.
But if this sparks your interest see my [Git talk](http://excess.org/article/2008/07/ogre-git-tutorial/).

<!--more-->

### Why distributed?

Git is distributed which brings a lot to the table.  Particularly, I see four
major wins with distributed revision control (like Git) over centralized
revision control (like svn):

- non-intrusive micro-commits
  
  Being distributed means that everyone in the team can now work on a feature
  or bug in complete isolation, if they so chose, until their part is ready to
  share.  That's the non intrusive part.
  
  In addition users are now free to commit any amount of work, even if it's not
  finished.  This means that developers can try things out and then back them
  out if they didn't work out without sharing those experiments.

- detached operation
  
  In a distributed revision control system, each developer has all the
  repository meta data.  This means that they can continue to work on a train,
  or a plane, or with a broken VPN connection.  They only need to be connected
  when they want to sync up with the other developers or to share their
  changes.

- no single point of failure
  
  While most projects will elect a single repository to be the main integration
  point, that is only a social distinction not a technical one.
  
  Developers can share commits between one another without talking to the
  server.  If the server is not around for some reason, those developers can
  continue to be productive.

- backups are trivial
  
  Everyone participating in the development is now maintaining a backup.

### Why not centralized?

It's worth while to dispel the so called *benefit* of centralized development.
I often hear concerns that distributed makes it easy for developers to horde
their work.  This is particularly scary in the corporate setting.  Years of
interaction with other developers have taught me that the revision control tool
does not solve this phenomenon of hoarding, and I believe that centralized
development can actually make it worse.

Before revision control systems became distributed people that liked to hoard
their work (or just didn't or couldn't work on a public branch) would develop
in their working copies for weeks, polishing their changes, and then finally
committing their work.  Because they were not (all) careless individuals, they
would often keep multiple complete copies of their work as they progressed
through stages; these snapshots ware essentially revisions of their work.
Distributed revision control systems gives these people the ability to commit
their work to a private repository.

It is true that some centralized systems can be setup to allow any user to
create a branch.  However, this usually leads to a very messy branch namespace.
Being distributed means that the private branches, that developers create for
their own purposes, do not have to pollute the namsepace on the shared server.

### Why Git?

There are many distribute revision control systems, why pick Git?

- massive mind share
  
  Git has a huge development community.  Everyone benefits because of the
  brilliant people that run the show.  And this is just going to improve as more
  and more projects switch to Git.
  
  I personally am often astounded to find out that thing I wished Git had, Git
  actually already had... I just didn't know about them yet.
  
  Which brings us to ...

- very complete tool set
  
  Not only do all the Git commands do a lot for you (like letting you commit
  parts of files via *interactive add* or rearange your existing commits), but
  Git also comes with tools like `gitk`, `rebase`, `cherry pick`, `bisect`,
  `reflog`, and so forth.  Some of which have been partially imitated in other
  revision control systems.
  
  Again, with new projects converting to Git this will improve as the new comers
  come with new ideas and requirements.

- Git has cheap branches
  
  In Git branching is *really* cheap.  This opens up the field to new types of
  "*workflows*" that were previously not possible.  It is very common amongst
  Git users to have multiple threads of development on the go at a time; say for
  example: 
  
  - one per bug being fixed,
  - one per new feature being developed,
  - several integration branches when importing work from others,
  - one master integration branch,
  - and branches for public releases.
  
  But there is more...

- multi-HEAD development
  
  Once you start working on multiple branches you will find that you will be
  exchanging work between them often.  Having all branches accessible in the
  same working tree is often quite useful, and since it was a foundation of Git,
  Git makes it quite easy to use.  As a matter of fact you can store completely
  unrelated branches (like your source code and project web page) in the same
  repository.


A list like this can never be complete, but hopefully it gives you something to
think about when choosing your revision control system.
