+++
title = "notmuch for vim"
date = "2009-11-20T22:59:02-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['mail', 'vim']
keywords = ['mail', 'vim']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

Quite some time ago now, I tried [sup](http://sup.rubyforge.org/) but
found it's indexing latencies unacceptable for my workflow.  I also found the user
interface a bit foreign and hard to get into.

More recently I've found [notmuch](http://notmuchmail.org/), a project that started as
a C rewrite of the core bits of sup.  Basically, it's a program that indexes and
searches through your existing mail.

I had two issues with it.

 * it had an emacs interface, and
 * it uses maildir instead of mailbox.

<!--more-->

The latter is a problem because maildir is horrible at managing large collections
of mail... and even more so over NFS.  I guess I'll have to part with NFS as a
medium of sharing my my mail... well, either that, or consider adding mbox indexing
to `notmuch`.

The former problem, of using emacs to interface with notmuch, I solved by
writing a script to do the same for vim.  The result of a couple of days of vim
scripting are here: [git.jukie.net/notmuch.git](http://gitweb.jukie.net/notmuch.git)
(see the [vim](http://gitweb.jukie.net/notmuch.git?a=shortlog;h=refs/heads/vim) branch).

`notmuch.vim` currently has two *modes* of operation:

 * *folders* mode - lists configured tags and number of messages under each tag,
 * *search* mode - where you can sort your email using tags and keyword searches, and
 * *show* mode - that displays threads of messages.

It actually works very similarly to *gmail*.  You tag email as it comes in, and the
display engines lets you recall email by a tag or new search criteria.

When you start the vim interface, by running `vim -c NotMuch` you get something like this:

![notmuch-vim-folders](../../img/notmuch-vim-folders.png)

On this screen you can see I have 3 *folders*, which actually overlap completely in this case.
The left column shows the count, the middle is an arbitrary name, and the right is the search
used to locate the messages.  Pressing `<Enter>` moves me into the thread list, or the *search* mode.

Here is what `notmuch.vim` looks like in *search* mode:

![notmuch-vim-search](../../img/notmuch-vim-search.png)

Notable in the above image are notmuch's ability to filter on various attributes of
email messages, namely: tags, and word matches.  Here, I have chosen to filter
messages having the *unread* and *index* tags assigned, and also those that had *PATCH*
in the subject.

If you select one of the messages, you'll get something like this:

![notmuch-vim-show](../../img/notmuch-vim-show.png)

In this display you get all messages that belong to the thread displayed in
chronological order -- again, similar to *gmail*.  By default the interface
hides most of the unimportant detail with vim folds, but there are shortcuts defined
to show the details.

So far supported features in `notmuch.vim` are:

 * searching through email by tags and content,
 * displaying email threads,
 * adding and removing tags,
 * syntax highlighting and folding of email chunks.

More about the interface of `notmuch.vim` can be found here: [README](http://gitweb.jukie.net/notmuch.git?a=blob;f=vim/README;hb=refs/heads/vim).

To try it run:

    git clone git://git.jukie.net/notmuch.git
    cd notmuch
    git checkout vim

    make
    make install

    cd vim
    make install

    notmuch setup
    notmuch new

    vim -c :NotMuch
