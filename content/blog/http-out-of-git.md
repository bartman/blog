+++
title = "serving http content out of a git repo"
date = "2010-02-27T09:34:35-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['git', 'web', 'lighttpd']
keywords = ['git', 'web', 'lighttpd']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

While preparing for my [Git]{tag/git} Workshop for [Flourish Conf](http://flourishconf.com/),
I thought about serving files over http directly out of a git repo.

Here is a short shell script that I came up with: [git-serv.cgi](http://git.jukie.net/snippets.git/tree/git-serv-sh/git-serv.cgi).

It takes request URLs like `http://domain/examples/dir/file` and looks up the
objects in a bare git repository in `/home/git/examples.git`.  It looks only on
the *master* branch, and nothing is ever checked out.  If it finds a *tree*
object, it prints the file listing at that point in the tree.  If the object is
a *blog*, it dumps the contents.  Otherwise some error is reported.

The other way to achieve something similar would be to use a [hook script](http://www.kernel.org/pub/software/scm/git/docs/githooks.html),
like what I used with my [resume](http://www.jukie.net/resume/) [post-update hook](http://git.jukie.net/resume.git/tree/git-post-update-hook).