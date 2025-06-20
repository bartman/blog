+++
title = "lbdb and mutt"
date = "2006-09-06T16:32:40-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['mutt', 'mail', 'email', 'linux']
keywords = ['mutt', 'mail', 'email', 'linux']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I recently added an outgoing mail filter to capture the email addresses of people I write email to.  This saves me time on adding them to my address book manually.  

I ran into [Mark's Mutt Fan and Tip page](http://mark.stosberg.com/Tech/mutt.html) and was pleased by the description of *lbdb*.  I then found a way to write an [outgoing filter](http://marc.10east.com/?l=mutt-users&m=101982014805783&w=2) to capture email addresses as I send mail... I wasn't really interested in lbdb holding the forged SPAM addresses.

<!--more-->

The first script will pass emails to lbdb and sendmail.

    $ cat bin/mysendmail 
    #!/bin/bash
    tee >(lbdb-fetchaddr -a)|/usr/lib/sendmail -oem -oi $@

<blockquote>
<i>
aside:  I never knew about the >() and <(), but ever since I read the above article, I've been using it a lot with git.<br>
For example: </i> vimdiff <(<a href="http://www.jukie.net/~bart/scripts/tmp/git-cat">git-cat</a> -r old-revision somefile) somefile.
</blockquote>

This script corrects for the fact that lbdbq shows entries in the reverse order... I want the most recent to be on top.

    $ cat bin/mylbdbq 
    #!/bin/bash
    (lbdbq "$@" | tee >(head -n 1 >&2) 2>/dev/null | grep -v ^lbdbq:.*matches | tac) 2>&1

<blockquote>
<i>BTW, if there is a better way to reverse the order of lines 2..N in bash, please let me know.  I realize the above is ugly.</i>
</blockquote>

Finally, this is the mutt configuration.

    $ grep -e mysendmail -e mylbdbq .muttrc
    set sendmail="~/bin/mysendmail"
    set query_command="~/bin/mylbdbq %s"

Now you have to write some email and populate your `.lbdb/m_inmail.list` file.

Finally when your lbdb is non-empty you can use `ctrl-t` on the address entry line to complete from lbdb.
Pressing `TAB` will complete from the *mutt_aliases* file as before.
