+++
title = "ldap account management"
date = "2006-06-12T22:22:04-04:00"
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

Ok, so in [last eppisode]{ldap-upgrade-to-2.3.23-brakage} we looked at how my Debian/testing upgrade of `slapd` killed my 
slapd install because I was using two incompatible schemas.

Now, I will show you how to limit what accounts are accessible to pam_ldap module on each host.

<!--more-->

I decided to not use *account*'s *host* field, but make something similar.

    # cat /etc/ldap/schema/jukie.schema 
    objectIdentifier jukie 999.999
    objectIdentifier jukieClassType jukie:1
    objectIdentifier jukieAttributeType jukie:2

    attributetype ( jukieAttributeType:1 NAME 'jukieHost'
                    DESC 'host name'
                    EQUALITY caseIgnoreMatch
                    SUBSTR caseIgnoreSubstringsMatch
                    SYNTAX 1.3.6.1.4.1.1466.115.121.1.15 )

    objectclass ( jukieClassType:1 NAME 'jukieHostList'
                    DESC 'host list'
                    AUXILIARY
                    MAY jukieHost )

This defines a new `objectClass` called `jukieHostList` which will list any number of `jukieHost` entries.  The entries are text.  As
before, I will use these entries to list one hostname each, or specify a wild card `*` to indicate that this account can be used 
anywhere -- or rather that this user can user any machine.

Here is a bash function that will generate an ldap script that will modify an existing user.  I had used this to update my 
entire ldap database.

    gen() {
            name=$1
            hosts=`echo $2 | tr , ' '`

            echo "version: 1"
            echo ""
            echo "dn: uid=$name,ou=Users,dc=example"
            echo "changetype: modify"
            for h in $hosts ; do
                    hh=`echo $h|tr '%' '*'`
                    echo "add: jukieHost"
                    echo "jukieHost: $hh"
                    echo "-"
            done
            echo "add: objectClass"
            echo "objectClass: jukieHostList"
            echo "-"
    }

An example would be:

    $ gen bart host1,host2,host3 | ldapmodify -x -D cn=admin,dc=example -w `cat /etc/ldap.secret`

And then you would add this to your `/etc/pam_ldap.conf`:

    pam_filter |(jukieHost=host1)(jukieHost=\*)

It's all very alien to me and I don't understand all of it, but it works... so for now I leave it alone... awaiting further breakage on next upgrade. :(

Links:

  - [Schema Specification](http://www.openldap.org/doc/admin23/schema.html)
  - My [Ldap Authentication on Debian](http://www.jukie.net/~bart/ldap/ldap-authentication-on-debian/index.html) HOWTO