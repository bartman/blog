+++
title = "LDAP authentication (part 1)"
date = "2005-01-08T09:50:26-05:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['linux', 'debian', 'ldap']
keywords = ['linux', 'debian', 'ldap']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

.



Wasted some time this week converting my server to LDAP directories and

renumbering UIDs/GIDs to the "Debian numbering ranges" from the RedHat

ranges that I have lived with for 7 years -- I have a lot of data to

migrate over to the new IDs... data is intact.



LDAP is so ugly after you used SQL, and is a bitch to setup, but after a

few hours I managed to get it working with PAM and NSS.  I will have to

document my steps because I had to read ~10 documents on the web to

finally get things working -- the Debian packages do not do all the work

for you in this case. 



I still don't have my desktops setup the way I want, but the vservers

can feed from LDAP for user IDs (for ssh logins and lookup when you do

things like ls -l or id).  And there is always the issue of what is to

be done with the mobile machine...  I think I will just use ssh-fs 

(via fuse) and not worry about having a common .



Stay tuned for further details :)


