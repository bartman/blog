+++
title = "nfs local caching with fscache and cachefilesd on Lenny"
date = "2009-06-12T21:56:38-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['debian', 'nfs']
keywords = ['debian', 'nfs']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

The idea is to put a [caching layer](http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=tree;f=Documentation/filesystems/caching/fscache.txt;h=HEAD;hb=HEAD)
between filesystems, that tend to be slow, and the user, who is impatient.  This is accomplished by the *fscache* kernel module, and the *cachefilesd* user space daemon.
The kernel module intercepts what would be disk/network access and redirects it to the daemon.  The daemon uses local media, which supposedly is faster, to cache recent data.

The new Linux native implementation is very generic, and can be used to accelerate anything like floppies and CD-ROMs.  I am interested in this because I find NFS slow.

Read more about it at [Linux Magazine](http://www.linux-mag.com/id/7378/).

<!--more-->

I must come clean.  I don't yet know how well this all works.  But I have really high expectations.

### building kernel

 - build a v2.6.30 kernel that supports fscache and nfs local caching

   Here is what I put in my `.config` file:

                CONFIG_FSCACHE=m
                CONFIG_FSCACHE_STATS=y
                CONFIG_FSCACHE_HISTOGRAM=y
                CONFIG_CACHEFILES=m
                CONFIG_CACHEFILES_HISTOGRAM=y
                ...
                CONFIG_NFS_FSCACHE=y

   This step is not debian specific.
   I'll skip the boring details.  If you need help with building a kernel, [google](http://google.com) for it :)

### building debs

If you're on Sqeeze, you might be able to skip this building section and just install the debs from Squeeze.  However, because Lenny doesn't come with support for fscache you'll have to do the following:

 - build a `cachefilesd`

   (you don't have to build as root)

   This is pretty easy on Debian.  You need to add `deb-src` from `testing` into your `/etc/apt/sources.list` ...

                # grep deb-src /etc/apt/sources.list
                deb-src http://ftp.debian.org/debian/ testing main contrib

   Then download the index:

                # sudo apt-get update

   Install dependencies for the build:

                # sudo apt-get build-dep cachefilesd

   Get the daemon source package:

                # apt-get source cachefilesd

   Build:

                # cd cachefilesd-*/
                # dpkg-buildpackage -b

   Install:

                # cd ..
                # sudo dpkg -i cachefilesd_*_*.deb

 - build the new `mount.nfs` command (from *nfs-common*):

   (again, don't build as root)

   Install dependencies for the build:

                # sudo apt-get build-dep nfs-utils

   Get the daemon source package:

                # apt-get source nfs-utils

   Build:

                # cd nfs-utils-*/
                # dpkg-buildpackage -b

   Install:

                # cd ..
                # sudo dpkg -i nfs-*_*_*.deb

### configure

Now you have all the software ready, you just have to enable it.

 - remount the hard disk that `/var/cache` is on with `dir_index,user_xattr` options:

                # mount -o remount,dir_index,user_xattr /

   ( note that for you it may be another location, not `/` )

 - enable the daemon

                # sed -i -e 's/^#RUN=yes/RUN=yes/' /etc/default/cachefilesd
                # /etc/init.d/cachefilesd start

 - remount the nfs filesystems with the fsc option

                # mount | awk '/type nfs/ { print $3 }' | xargs -n1 mount -o remount,fsc

   ( this may not work for you, it's been inconsitent for me; remounting the directory cleanly, or rebooting should work if you follow the next step )

 - modify `/etc/fstab` to make things persistent:
 
   - add the `fsc` flag to the nfs mounts

   - add the `dir_index,user_xattr` to the filesystem that holds `/var/cache`


### Does it work?

 - the only proof I have of it working is that it's wasting space on my local disk when I use NFS :)

                 # du /var/cache/fscache/ -s
                 40 /var/cache/fscache/

 - and doing `cat * >/dev/null` does seem faster, even after a clean remount