+++
title = "svn status like output in git"
date = "2007-08-31T14:26:46-04:00"
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

Today [Dave](http://www.dmo.ca/blog) asked me how to get a script-friendly list of untracked files,
and modified files... like `svn status`.

First I suggested that he look at `--diff-filter` and `--name-status` options for `git-diff`.

        git diff --name-status --diff-filter=M

While `git-diff` can actually report a lot of cool stuff (see the `git-diff-files` man page for 
more details), it did not solve all the problems.  The above worked for getting the list of 
modified files, but not for untracked files.  We scratched our heads and were unable to get anywhere.

Then Dave found `git-ls-files`... a primitive I probably have not ran since 2005.  Well it turn out
that if you need to use things that `git-status` reports on in a script, you really want to 
run `git-ls-files`.

        git ls-files --exclude-per-directory=.gitignore --exclude-from=.git/info/exclude \
                        --others \
                        --modified \
                        -t

Again, see the man page for `git-ls-files` for more details.
