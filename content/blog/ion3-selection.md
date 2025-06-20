+++
title = "ion3 greatness and acting on X selections"
date = "2006-06-01T21:17:16-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['ion3', 'lua', 'desktop']
keywords = ['ion3', 'lua', 'desktop']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

So it turns out that I have not blogged about [ion3]{tag/ion3} yet.  I've been using ion3 as my window manager for about half a year, and I still love it.  It's fast, does not requrie a mouse for most tasks, and has very powerful scripting and keyboard binding capabilities.  But enough about the greatness of ion3... and onto the rest of the story...

For some time I wanted to have a magic key binding that would do *something* -- **anything** -- with my X selection.  Say, I highlight a URL and push this magic key, it should display it in a new browser tab.  If I highlight what looks to be a valid file, it should launch gvim on it, etc.  I previously tried with sawfish, but I suffer from a serious condition that causes me to vomit when I look at lisp-like languages -- one of the reasons I abandoned emacs years ago.

It was pretty easy in ion.  Below is my [lua]{tag/lua} code to implement what I described...

<!--more-->

    function exists(n)
        local f = assert(io.open(n, "r"))
        io.close(f)
        return not (f==nil)
    end

    function my_url_handler (ws)
        ioncore.request_selection(
            -- this is an anonymous function that is called with the selected text
            function (str)  
                if (string.find(str, "http://") ~= nil) then
                    ioncore.exec_on (ws, "firefox -new-tab " .. string.shell_safe(str))
                elseif (exists(str)) then
                    -- my vim is compiled from source and not in the PATH available to lua
                    ioncore.exec_on (ws, "/usr/local/bin/gvim " .. safe)
                end
            end)
    end

    defbindings("WScreen", { 
        kpress("Mod4+U", "my_url_handler(_)"),
    })

You can just throw this into your `~/.ion3/cfg_user.lua` file and restart ion.  Then highlight something, pressh `Win+U` and *voila*!

The plan is to extend this function to trigger on other kinds or strings.

Here are some links:
 - [Configuring and extending Ion3 with Lua](http://www.modeemi.cs.tut.fi/~tuomov/ion-doc-3/ionconf/ionconf.html)
 - [Ion3 scripts collection](http://modeemi.fi/~tuomov/repos/ion-scripts-3/)
 - [Programming in Lua](http://www.lua.org/pil/index.html)

### update

Another cool use of this is improved mouse-less operations with *xclip*...

    xclip - command line interface to X selections

I can now get strings out of cli output and act on them with a lua script in ion3.