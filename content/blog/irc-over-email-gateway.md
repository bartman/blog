+++
title = "IRC over email gateway"
date = "2005-01-24T13:01:58-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['irc']
keywords = ['irc']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

12:47 <@  bartman> hey, you know what would be cool... if you could ahve an 
                   email-to-irc proxy
12:48 <     muffy> bartman: Please explain why that would be cool.
12:48 <@  bartman> then people, like Tyler, who have opprisive French overlords                    could use irc by just emailing a bot
12:48 <@  bartman> ofcourse IP-over-email sould be even cooler  
12:49 <     muffy> But how would Tyler receive messages?  One email per message                    would be too much I would think.
12:59 <     steve> the bot could send (digest) messages to respective users 
                   when their username appears in the line
12:59 <@  bartman> nod  
13:00 <@  bartman> queue up for a few seconds/minutes and then purge in one 
                   email
13:00 <@  bartman> even private conversations could be maintained bu using the 
                   Reply-To: tag
13:00 <     muffy> I suppose.  But that takes them out of the general 
                   conversations.  I would think queueing up and sending every 
                   few minutes might be better.
13:01 <     steve> i still like my way, send iff their username appears in the 
                   line
13:01 <     steve> so long as everyone "plays nice" and addresses it to them, 
                   they get messages important to them
13:02 <     dave0> Would be simple to take the evil at 
                   http://www.dmo.ca/projects/hacks/IRC/ircnotify and put it in                    a .procmailrc
13:02 <     muffy> Well, we could always give them the option of whether they 
                   want just messages addressed to them or global ones.
13:02 <     dave0> but mailing of digests is a little more painful
13:03 <@  bartman> steve: note that you didn't "play nice"
13:03 <     steve> i never do
13:04 <@  bartman> getting only the addressed messages would be pointless
13:04 <     steve> oops, that should have been                                  13:04              steve never does
13:04 <@  bartman> you would get only 1% of the conversation
13:04 <@  bartman> and no context
13:04 <     steve> i meant for the name to  be a "trigger", which would then 
                   send the digest from the last trigger to now
13:05 <@  bartman> a trigger, not filter... gotcha  
13:05 <@  bartman> there would have to be a timed trigger too  
...