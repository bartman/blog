+++
title = "Scott Chacon smacks git around"
date = "2009-06-10T20:20:41-04:00"
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

I came across [a RailsConf talk](http://en.oreilly.com/rails2009/public/schedule/detail/7367) given
by [Scott Chacon](http://jointheconversation.org/) last month.  As previously, his git work is really good.
His presentation style has also guided my [Git the basics](http://excess.org/article/2008/07/ogre-git-tutorial/)
talk which I gave about a year ago.

Anyway, I want to summarize what I learned from Scott's presentation...

<!--more-->

 - If you want to read along, grab the [PDF slides](http://assets.en.oreilly.com/1/event/24/Smacking%20Git%20Around%20-%20Advanced%20Git%20Tricks%20Presentation.pdf).

 - Scott likes (to smack around his) git; here is a quote:
   
   *Scott Chacon has an understandable but borderline unhealthy obsession with Git*
   -- [Ilya Grigorik](http://igvita.com)

 - Scott wrote a second book about Git titled [Pro Git](http://www.apress.com/book/view/9781430218333).
   This will probably make it to my bookshelf if for no other reason then to support Scott's work.
   
   Slightly related, I've also [learned](http://oreilly.com/catalog/9780596520120/) that there is an
   O'Reilly book titled [Version Control with Git](http://oreilly.com/catalog/9780596520120/).  I'll
   have to have a look some day.

 - `git diff HEAD...topic-branch`
   
   While I often use the `...` form with `git log` I have never used it to *diff*.
   
   Unlike `git diff HEAD topic-branch` which shows the diffs between current commit and
   the other branch, this form will show the changes since the common ancestor and
   `HEAD`.  It's essentially the same as saying:
   
        git diff $(git merge-base HEAD topic-branch) topic-branch

 - With some discipline one can use unrelated branches and *subtree merge strategy* as
   an alternative to submodules.
   
   It's centrally interesting, but relies on several non-trivial steps to move changes
   from the integration branch to the submodule.
   
   This trick comes from Tim Dysinger's article on [Replacing Braid or Piston (for Git) with 40 lines of Rake](http://dysinger.net/2008/04/29/replacing-braid-or-piston-for-git-with-40-lines-of-rake/).  And I can see how it could be used
   as part of a larger infrastructure to do cool things.

 - Recnet versions of git started telling me when I did a typo on the git command.
   It usually suggests an alternative.  Well with...
   
        git config --global help.autocorrect 1
   
   ... you can make git actually execute the correction.

 - You can use *git attributes* to show nice*er* diffs for non-text files.  For example...
   
        echo '*.png diff=exif' >> .gitattributes
        git config diff.exif.textconv exiftool
   
   ... will tell git to use `exiftool` to convert a `*.png` to text so it can show you a `git diff`.
   Displaying this does not show you what changed in the image, but it's better then just being
   told that the binary filed changed.
   
   One cool use of this could be to use `antiword` to convert the `*.doc` file to text so 
   git can show a nice diff for MS Word files.  Something like this is proposed for `*.odf` files
   [here](http://git.or.cz/gitwiki/GitTips#HowtousegittotrackOpenDocument.28OpenOffice.2CKoffice.29files.3F).

 - Scott also shows how you could use git filters to expand things like `$Date:$` to show the
   last modified date of a file.
   
        cat >expand_date <<<END
        #!/bin/sh
        date=$(git log --pretty=format:"%ad" -1)
        sed -e "s,\\\$Date:[^$]*\\\$,\\\$Date: $date\\\$,g"
        END
   
        cat >clean_date <<<END
        #!/bin/sh
        sed -e "s,\\\$Date:[^\\\$]*\\\$,\\\$Date: \\\$,g"
        END
   
        git config filter.dater.smudge ./expand_date
        git config filter.dater.clean  ./clean_date
        echo '* filter=dater' >> .gitattributes
   
        echo '# $Date:$' > file
   
   And on next checkout that file will be smudged.

Naturally there may be other things in the slides that *you* may find interesting also... so
go [check it out](http://en.oreilly.com/rails2009/public/schedule/detail/7367).
