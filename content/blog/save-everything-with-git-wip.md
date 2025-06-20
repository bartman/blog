+++
title = "using WIP branches to save every edit"
date = "2009-11-04T19:53:44-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['git', 'vim']
keywords = ['git', 'vim']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I am experimenting with a new workflow to help solve the problem of lost work
between commits.  As described [in my previous post]{20091104194146}, there
are already several ways to deal with keeping track of frequent edits.  The
only problem is that they all involve dedication and extra effort.

<!--more-->

This all started a few days ago when a buddy, [Jean](http://geemoo.ca/), asked
me how he could commit from vim when he issued a `:w` command.  I thought this
was a great idea and initially wanted to just give him a mapping for `:W` that
would just `git commit --amend`... or something equally easy.  Since I didn't
have time to implement it right away, I decided thinking more about how to
solve it better.

Enter [git-wip](http://github.com/bartman/git-wip).  *WIP* stands for Work In Progress,
and is a term that is commonly used to describe work that is not ready to
be shared and is still in progress.  This `git wip` tool manages hidden side
branches that live along side every other branch you work on.  Any time
it's invoked it will commit the state of the working tree to this
branch.  As an example, if you work on branch *feature-X* then `git wip`
will use *wip/feature-X* for tracking changes that follow the last commit,
but the *feature-X* branch will never be altered by `git wip`.

If you were to use `git wip` like you do `git commit` -- manually invoking
the command -- you might as well use `git commit`.  The intent of `git wip` is to
create commits that will be thrown away 99% of the time.  The changes that
`git wip` tracks are only useful for recovering code you added but then
accidentally changed or deleted before committing.  It's something you
never expect but sometimes just hits you.

Making is low effort is done by having your editor execute `git wip` on
every file save.  Every save will now create a new commit capturing the state
of the project.  Don't worry, it will not clobber your history.  All the
changes are kept separate from your main branches.

There is a more detailed description on the [github page](http://github.com/bartman/git-wip),
but what ends up happening is something like this...

    * === * === * === * === * === *      <-- feature
     \     \     \     \     \     \
      *     *     *     *     *     *    <-- wip/feature
       \           \     \     \
        *           *     *     *        <-- wip/feature@{1}
         \                 \
          *                 *            <-- wip/feature@{2}

In the above ASCII diagram the horizontal `* === *` line represents your history (moving left-to-right).
These are the changes captured with `git commit`.

The diagonal lines represent work between commits, which is tracked by `git wip`.  If you commit,
`git wip` will automatically start tracking your saves from the new commit point.  The `wip/*`
branches will exist for as long as `reflog` is configured to keep them around, which is 30 days
by default.

At any time you can look at the history of of your `wip/*` branch with respect to the commit it
refers to with `git wip log` or graphically with `gitk wip/feature feature`.

... anyway ...

I said I was experimenting.  I am not sure how well this will work out.  The few unknowns at this
time are:

 * How bloated will my repos get in 30 days of capturing *every* save?  Will I even notice?
 * Will I be able to tolerate `:w` being slower?
 * Will it be useful?

If you're interested in playing...

 * download the script from github page: 
   
   `git clone git://github.com/bartman/git-wip.git`

 * install git-wip in your PATH
   
   `cp git-wip ~/bin/`

 * tell vim to call it whenever it saves

   Add this to your `~/.vimrc`:

        augroup git-wip
                autocmd!
                autocmd BufWritePost * :silent !git wip save "WIP from vim" --editor -- "%"
        augroup END

... and let me know if you'd change anything.