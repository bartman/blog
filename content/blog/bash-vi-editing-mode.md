+++
title = "bash vi editing mode"
date = "2004-03-26T08:26:02-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['bash', 'vim']
keywords = ['bash', 'vim']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

<b> bash comand line </b>
<p> For a few years now I've been using vi editing mode for bash and anything that uses readline.  Here is how I've set things up.
</p>

<p>In .bashrc I use the following to enable vi editing mode:
<pre>        set -o vi</pre>
This allows me to type as usual and use <i>ESC</i> to get into vi command mode.
Since <i>ESC</i> is so far away I frequently use <i>control-[</i>... unless I 
feel I need the exercise.
</p>

<p>Ok, so the whole <i>ESC</i> and even <i>control-[</i> sometimes gets tired.  For example if I want to search history I would have to push <i>ESC</i> to
get into <i>vi-command</i> mode and then be able to push <i>J</i> or <i>K</i>
to go through history.  I found a way around that by using the 'meta convert' 
feature of many terminal programs.  In xterm, for example, setting the 
<i>eightBitInput</i> to false will cause xterm to convert all 
<i>Meta-something</i> key combinations to <i>ESC-something</i> which means 
that I can push <i>Meta-k</i> to go up 1 in history.  It just so happens that 
all the other terminals I've used have this working already, but anyway, here 
is the line in my .Xdefaults:
<pre>        xterm*eightBitInput: false</pre>
Note that once you push <i>Meta-something</i> you are in <i>vi-command</i>
mode so to go up by two lines in history you would use <i>Meta-k k</i>, or
use <i>J</i> &amp; <i>K</i> to go up and down as you wish.
</p>

<b> everything else </b>
<p>Many programs use readline, as bash does, to present a command line to
the user.  In particular I wanted to get lftp, and others, to use vi editing 
mode as well.  For this I set the following in the .inputrc file:
<pre>        set editing-mode vi
        set keymap vi
	set convert-meta on</pre>
Now when I start up lftp, I can use vi editing just like in bash.
</p>

<b> making tab completion more advanced </b>
<p>I noticed that the vi editing mode in bash has much fewer commands 
defined then the emacs counterpart.  The commands are available but just 
not bound to any shortcuts.  Here is a list of extra bindings that I've
added to make TAB-completion, which makes bash so great, a bit more 
useful:
<pre>        # ^p check for partial match in history
        bind -m vi-insert "\C-p":dynamic-complete-history
        
        # ^n cycle through the list of partial matches
        bind -m vi-insert "\C-n":menu-complete</pre>
The comments give away the secrets of what the commands do.  They don't work
exactly like the vi equivalents for completion, but also provide a bit more
functionality.
</p>

<b> clearing the screen </b>
<p>Last feature I missed was to be able to clear the screen with 
<i>control-L</i>, as defined in emacs editing mode.  I've added the following
to bind the same in vi editing mode:
<pre>        # ^l clear screen
        bind -m vi-insert "\C-l":clear-screen</pre>
</p>

<b> further reading </b>
<p>Here are a few links that you might find useful:
<ul>
<li><a href=http://www.faqs.org/docs/bashman/bashref.html#SEC_Top>Bash Reference Manual</a>
<li><a href=http://www.lugod.org/mailinglists/archives/vox-tech/2003-06/msg00182.html>Arrow keys in vi editing mode</a>
</ul>
</p>