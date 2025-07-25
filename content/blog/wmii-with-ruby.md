+++
title = "wmii w/ ruby wmiirc"
date = "2006-10-18T21:33:06-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['wmii', 'desktop', 'ruby']
keywords = ['wmii', 'desktop', 'ruby']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

My window managers have changed a few times over the years.  I started off with 
[OpenSTEP](http://en.wikipedia.org/wiki/Openstep) at Carleton, used that for a year.
Then switched to [Afterstep](http://en.wikipedia.org/wiki/Afterstep), which I used for 
about 3 years.  Next I switched to [sawfish/sawmill](http://en.wikipedia.org/wiki/Sawfish), 
and used it for about 4 years.  Recently I went through a crisis as sawfish stopped 
working for me in testing on amd64.  I found [ion3]{tag/ion3} to be a nice replacement.  I 
was a happy ion3 user for almost a year and then someone suggested that I try [wmii-3]{tag/wmii}.

<!--more-->

The appeal of ion3 was that it was my first *tiling window manager*.  Such a *wm* splits the screen for each window 
instead of managing floating/overlapping windows.  Over the years I've managed to develop 4 unique work flows:

   * **coding**: two or three (depending on screen resolution) vertically maximized xterms side-by-side;
   * **communication**: one work space with two xterms side-by-side, one holding irssi and the other mutt;
   * **browsing**: full screen web browser (currently that is *firefox*) and an rss reader (currently that is *aKregator*);
   * **gimp**: this app really needs floating windows.

There are other ones, like the *openoffice* workspace or the *music* workspace, but they are some small derivative of the 
golden four.

[ion3](http://modeemi.cs.tut.fi/~tuomov/ion/) was perfect for all for all of these, and as an added bonus most things 
could be done with mouse or keyboard.  I've already been a big enthusiast of keyboard shortcuts and the configurability 
of sawfish.  Being able to do everything in ion3 using the keyboard was a big win.  As mentioned above, I was quite 
happy using it until someone suggested that I try wmii-3.

[wmii-3](http://wmii.suckless.org/) has a lot in common with ion3.  They both encourage the use of the keyboard for 
window management with shortcuts that resemble vi's motion shortcuts, that is alt+[HJKL] for movement.  The big differentiator
for me was the tagging feature.  Any window can be tagged with one or more words, and these words end up representing the workspaces.
Tags could be things like "*web*", "*mail*", and "*work*" to name a few common ones.  

You can also have disposable tags like "*bug548*" where you bring in multiple windows from other workspaces that you need 
for a relatively short lived task.  In this case you may need to browse the web, edit your code, and talk to a colleague 
about the bug... so your web browser would be tagged with "*web+bug548*", your editor would be "*work+bug548*", and your 
irssi would be "*mail+bug548*".  These three programs would all be in their original tags as well as in the "*bug548*" tag.

Final note... this is where Ruby comes in.  I found that *wmii* by itself is a bit slow to user input -- it's much faster then 
things like kde or gnome, but slower then ion3 -- because the *event loop* of the window manager is written as a shell script.
However, some one wrote [wmii+ruby](http://eigenclass.org/hiki.rb?wmii+ruby), which is an event loop for ruby written in ruby.
If you are interested in a fast, dynamic, tiling, keyboard-oriented window manager I suggest you start from *wmii+ruby*. :)

If you want to use the latest from darcs then you will have to:

    $ sudo apt-get install darcs wmii libhttp-access2-ruby1.8 ruby1.8
    $ darcs get http://eigenclass.org/repos/ruby-wmii/head wmii+ruby
    $ cd wmii+ruby
    $ ruby install.rb

If you are interested, you can checkout my [~/.wmii-3/](/~bart/conf/wmii-3/) config files.

**NOTE 1**

Some people have had problems with ruby 1.9 and wmii+ruby.  If you have ruby 1.9, you may need to 
change `ruby` to `ruby1.8` on the first line of your `~/.wmii-3/wmiirc`.

    $ head -n1 .wmii-3/wmiirc
    #!/usr/bin/env ruby1.8
                   ^^^^^^^

I have not found this to be the case... but if you do... you can fix it.

**NOTE 2**

wmii v3.5 is not compatible with today's version of wmii+ruby.  I had to pin my wmii package at v3.1.  To do this you can
add the following 3 lines to `/etc/apt/preferences` ...

    Package: wmii
    Pin: version 3.1*
    Pin-Priority: 1001

If you don't have a distribution that has 3.1, will have to add it to your `/etc/apt/sources.list` file ...

    deb http://ftp.debian.org/debian/ etch main contrib non-free

With these two changes (and an `apt-get update`) you should see that *apt* will select v3.1 over v3.6.

    # apt-cache policy wmii
    wmii:
      Installed: 3.1-5
      Candidate: 3.1-5
      Package pin: 3.1-5
      Version table:
         3.6~rc2+20070518-2 1001
            500 http://ftp.debian.org testing/main Packages
     *** 3.1-5 1001
            500 http://ftp.debian.org etch/main Packages
            100 /var/lib/dpkg/status
