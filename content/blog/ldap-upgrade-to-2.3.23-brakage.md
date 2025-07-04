+++
title = "stupid ldap"
date = "2006-06-12T19:45:23-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['ldap', 'linux', 'debian']
keywords = ['ldap', 'linux', 'debian']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

For some very stupid reason I decided to upgrade my fileserver, which happens to run my ldap database as well.

    Setting up slapd (2.3.23-1) ...
      Backing up /etc/ldap/slapd.conf in /var/backups/slapd-2.2.26-5... done.
      Moving old database directories to /var/backups:
    
      Backup path /var/backups/dc=jukie-2.2.26-5.ldapdb exists. Giving up...
    dpkg: error processing slapd (--configure):
     subprocess post-installation script returned error exit status 1
    Errors were encountered while processing:
     slapd
    E: Sub-process /usr/bin/dpkg returned an error code (1)

*Frig!*

<!--more-->

Ehh, ok... so now what?

    # cp /var/backups/slapd-2.2.26-5/dc\=jukie.ldif /etc/ldap/backup-20060612.ldif
    # slapadd -l /etc/ldap/backup-20060612.ldif
    bdb_db_open: Warning - No DB_CONFIG file found in directory /var/lib/ldap: (2)
    Expect poor performance for suffix dc=jukie.
    slapadd: dn="uid=root,ou=Users,dc=jukie" (line=111): (65) invalid structural object class chain (inetOrgPerson/account)
    meson:/etc/ldap# man bdb_db_open
    No manual entry for bdb_db_open

So it turns out that I used to use `account` as an *objectClass*, and for whatever reason you cannot mix that with inetOrgPerson.  If you can, I have no idea how.

    dn: uid=root,ou=Users,dc=jukie
    objectClass: inetOrgPerson
    objectClass: sambaSamAccount
    objectClass: posixAccount
    objectClass: shadowAccount
    objectClass: account
    gidNumber: 0
    uid: root
    uidNumber: 0
    homeDirectory: /home/root
    creatorsName: cn=admin,dc=jukie
    loginShell: /bin/bash
    ...
    host: alpha.jukie.net
    host: beta.jukie.net

And the only reason I wanted to keep the account schema was for the `host` fields.  I use these to filter accounts at machines.  A host would only allow an account if the account contained the `host:` field with it's name.  It's pretty simple:

    # grep ^pam_filter /etc/pam_ldap.conf 
    pam_filter |(host=alpha.jukie.net)(host=\*)

Note, the `*` indicates any host.  My `root` account actually has a `*`, but I changed the example above to show the more interesting case.

After a bit of searching I [found a suitable replacement](http://www.samba.org/samba/docs/man/Samba-HOWTO-Collection/passdb.html) called `sambaUserWorkstations`; here is the definition:

> Here you can give a comma-separated list of machines on which the user is allowed to login. You may observe problems when you try to connect to a Samba domain member. Because domain members are not in this list, the domain controllers will reject them. Where this attribute is omitted, the default implies no restrictions.

`sambaUserWorkstations` is part of the `sambaSamAccount` *objectClass* which I already had.  Good.

The only problem I found with it is that it does not permit this:

    sambaUserWorkstations: alpha.jukie.net
    sambaUserWorkstations: beta.jukie.net

...but this...

    sambaUserWorkstations: alpha.jukie.net,beta.jukie.net

And that screws up my `pam_filter`.  It should still work for my account because I have a `*` in the `sambaUserWorkstations` field but I have to figure out how to do partial matches for everyone that has access to multiple machines.  And I would love to modify my schema to fix this but I am [warned by OpenLDAP not to](http://rpmfind.net/linux/0/redhat-archive/7.2/de/doc/RH-DOCS/rhl-rg-en-7.2/s1-ldap-files.html)....

        Caution Caution
            You should not modify any of the schema items defined in the schema files installed by OpenLDAP. 

...TO BE CONTINUED.
