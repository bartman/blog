+++
title = "git-clean in svn land"
date = "2007-07-10T21:45:12-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['svn', 'scm']
keywords = ['svn', 'scm']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

Some things are easier in [git]{tag/git}.  For example to nuke all changes and only keep files that are

tracked by git I would run:



        git-clean -d -x

        git-checkout -f



In [svn]{tag/svn} it's a bit more involved, but not impossible:



        svn status --no-ignore | awk '{print $2}' | xargs rm -rf

        svn revert -R .

        svn update



For extra *fun*... the `svn revert -R` will actually stop on any symlinks to directories.  Fun!
