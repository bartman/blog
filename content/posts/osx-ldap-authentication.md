+++
title = "Authenticating Linux against OSX LDAP directory"
date = "2008-06-28T16:07:32-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['osx', 'linux', 'ubuntu', 'ldap']
keywords = ['osx', 'linux', 'ubuntu', 'ldap']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I was recently asked by a colleague, and now also a [client](http://infonium.ca/), to look over the [LDAP]{tag/ldap} configuration on his Ubuntu boxen.  He was having

issues with the root account.  The problem turned out being that the Ubuntu box was trying to get the root authentication from LDAP.

It successfully found an LDAP account on the OSX LDAP server, but was unable to login since that account is disabled.  The solution

was to filter out the root account from the LDAP reply using the `pam_filter` directive in `/etc/ldap.conf`.  Jay was also kind enough

to document his [setup for others](https://help.ubuntu.com/community/OSXLDAPClientAuthentication) that are trying to accomplish a 

similar task.



*side note: Jay briefly showed me his OSX/Linux integration... looks pretty cool.  Particularly the LDAP directory and automount of OSX exported volumes for users.  OSX seems to make certain things really easy.*


