+++
title = "wmii+ruby xlock action"
date = "2007-01-15T11:19:17-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['wmii', 'ruby', 'desktop']
keywords = ['wmii', 'ruby', 'desktop']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I use *xscreensaver* and like to lock my display when I leave my computer.  Here 

is a snippet from my `wmiirc-config.rb` file that adds an `xlock` action to the 

`Alt-a` action menu.



        plugin_config["standard:actions"]["internal"].update({

          'xlock' => lambda do |wmii, *args|

                system("xscreensaver-command --lock")

          end

        })



I start my *xscreensaver* in the `.xsession` file:



        /usr/bin/xscreensaver -nosplash &



... before launching wmii.
