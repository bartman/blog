+++
title = "cloning xterms in wmii+ruby"
date = "2007-01-12T13:12:52-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['ruby', 'desktop', 'bash', 'wmii']
keywords = ['ruby', 'desktop', 'bash', 'wmii']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I have recently added a few things to by [wmii+ruby](http://eigenclass.org/hiki.rb?wmii+ruby) [configuration](/~bart/conf/wmii-3/wmiirc-config.rb) that I wanted to share.  These are:

  * start a program in a given view from bash prompt (authored by [Dave O'Neill](http://www.dmo.ca/blog/20070111010218))
  * start a program in a given view using `Alt-Shift-p` (authored by [Jean Richard](http://geemoo.ca/))
  * start an xterm in a given view using `Alt-Shift-Return`
  * cache directory changes in a view, start an xterm in the view's last directory using `Alt-Apostrophe`

<!--more-->

The first two are not mine.  Follow [Dave's link](http://www.dmo.ca/blog/20070111010218) to get his changes, or 
look at my [config](/~bart/conf/wmii-3/wmiirc-config.rb).

To execute a program in a given view using `Alt-Shift-p` instead of `Alt-Ctrl-y` put this in your `wmiirc-config.rb` file:

    use_binding "execute-program-with-tag", "MODKEY-Shift-p"

To start an xterm in a given view using `Alt-Shift-Return` add this to your `wmiirc-config.rb` file:

    use_binding "execute-xterm-with-tag"

And grab the `execute-xterm-with-tag` from my modified [standard-plugin.rb](/~bart/conf/wmii-3/plugins/standard-plugin.rb) file.

--

The final feature needs a bit more explanation.  I often work on multiple distinct projects.  Each project has a unique space 
on my filesystem associated with it.  I discovered that when I open a terminal in a view the first thing I have to do is 
`cd work/<client name>/<task working on>`.  Since I already have a wmii view created for that client and task, it would be really
nice if the window manager did that for me.

Say I am working for Acme Corp, and I have two projects that I am working on for them... parachute and anvil.  I would have views
for tags `acme:para` and `acme:anvil`, and respective work directories `work/acme/parachute` and `work/acme/anvil`.  When I 
am in the `acme:para` view and I create a new xterm, I would like it to start up in the `work/acme/parachute` directory automatically.

To do this I had to modify how the builtin bash `cd` works:

        function cd () 
        { 
                builtin cd $@ \
                && \
                ( echo "ShellChangeDir $PWD" | wmiir write /event )
        }

... basically, for each successful `cd` command I generate a wmii event with the new working directory.

Next in [wmiirc-config.rb](/~bart/conf/wmii-3/wmiirc-config.rb) I use these events to store the last directory that I entered.

        @view_pwd = {}
        register("ShellChangeDir", nil, nil) {|dir,|
            view = read("/view/name")
            @view_pwd[view] = dir
        }

Finally, I added a new shortcut -- `Alt-Apostrophe` -- to start a new terminal from the directory last used by that view:

        on_key("MODKEY-apostrophe") {
            require 'fileutils'
            term = plugin_config["standard"]["x-terminal-emulator"] || "xterm"
            view = read("/view/name")
            dir = @view_pwd[view]
            if dir != ""
                # LOGGER.debug "exec #{term} on #{view} in #{dir}"
                FileUtils.cd(dir) { |dir|
                    system "wmiisetsid #{term} &"
                }
            else
                system "wmiisetsid #{term} &"
            end
        }

And that's it. :)