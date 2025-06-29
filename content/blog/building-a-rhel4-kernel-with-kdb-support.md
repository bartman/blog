+++
title = "building a RHEL4 kernel with kdb support"
date = "2006-04-10T10:28:24-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['linux', 'kernel', 'kdb']
keywords = ['linux', 'kernel', 'kdb']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

Sometimes I have a need to reproduce bugs on other platforms.  When that platform uses a heavily patched kernel, it makes it hard to debug.  Below are some notes I took while building a RHEL4 kernel with [kdb support](http://oss.sgi.com/projects/kdb/faq.html).

<!--more-->

### 1. get the kernel

It's not easy to find the kernel sources for RHEL4 if you don't have the CDs.  I was working off-site so I didn't.

I finally found [a security article](http://www.linuxsecurity.com/content/view/120531) on 
[LinuxSecurity.com](http://www.linuxsecurity.com/) that talked about a security fix and referenced the FTP source for
[kernel-2.6.9-22.EL.src.rpm](ftp://updates.redhat.com/enterprise/4Desktop/en/os/SRPMS/kernel-2.6.9-22.EL.src.rpm).
I grabbed that.

### 2. install the rpm

This step is easy, just run `rpm -i kernel-2.6.9-22.EL.src.rpm`.  The sources are unpacked into 
`/usr/src/redhat` directories.

### 3. prepare the kernel

This step unpacks the tarball and applies the millions of patches packages with the redhat kernel:

        $ rpmbuild --target=i686 -bp /usr/src/redhat/SPECS/kernel-2.6.spec

The kernel is now in `/usr/src/redhat/BUILD/kernel-2.6.9/linux-2.6.9`

### 4. getting the KDB patches

If you need help, read the [README](ftp://oss.sgi.com/projects/kdb/download/v4.4/README).

You need to get two KDB patches.  One common, and one for your architecture.  In my case that's i386.  
*(I hope that is your case too, if not email me and maybe I can help you with the conversion of the patches)*

The original patches (see below) require some manual fixing.

        $ cd /usr/src/redhat/SOURCES/
        $ wget http://www.jukie.net/~bart/kernel/2.6.9-22+kdb/kdb-v4.4-2.6.9-22.EL-common-2.patch.bz2
        $ bunzip2 kdb-v4.4-2.6.9-22.EL-common-2.patch.bz2

        $ wget http://www.jukie.net/~bart/kernel/2.6.9-22+kdb/kdb-v4.4-2.6.9-22.EL-i386-1.patch.bz2
        $ bunzip2 kdb-v4.4-2.6.9-22.EL-i386-1.patch.bz2

here are the links: [kdb-v4.4-2.6.9-22.EL-common-2.patch.bz2](/~bart/kernel/2.6.9-22+kdb/kdb-v4.4-2.6.9-22.EL-common-2.patch.bz2),
[kdb-v4.4-2.6.9-22.EL-i386-1.patch.bz2](/~bart/kernel/2.6.9-22+kdb/kdb-v4.4-2.6.9-22.EL-i386-1.patch.bz2).  Note that you don't apply
these patches yourself, the build system will do that for you.

For reference, these are the original patches I started with:

        $ wget ftp://oss.sgi.com/projects/kdb/download/v4.4/kdb-v4.4-2.6.9-common-2.bz2
        $ wget ftp://oss.sgi.com/projects/kdb/download/v4.4/kdb-v4.4-2.6.9-i386-1.bz2

### 5. patching the .spec file

To build an RPM you need a spec file.  The spec file shipped with the *.src.rpm* contains a list of all the patches that will be applied, so we just need to add the two *kdb* patches.  Here is the diff you will have to make:

 1. add the patches into the list of patches at the end:

 after `Patch10001` add:

        Patch10002: kdb-v4.4-2.6.9-22.EL-common-2.patch
        Patch10003: kdb-v4.4-2.6.9-22.EL-i386-1.patch

 2. add the options to pass to `patch` when applying our *kdb* patches:

 after `%patch10001` add:

        # kdb-v4.4-2.6.9-22.EL-common-2.patch
        %patch10002 -p1
        # kdb-v4.4-2.6.9-22.EL-i386-1.patch
        %patch10003 -p1
         
You can just get my spec patch:

        $ cd /usr/src/redhat/SPECS/
        $ wget http://www.jukie.net/~bart/kernel/2.6.9-22+kdb/kernel-2.6.spec.patch

here is the link: [kernel-2.6.spec.patch](/~bart/kernel/2.6.9-22+kdb/kernel-2.6.spec.patch)

Then apply it by running

        $ cd /usr/src/redhat/SPECS/
        $ patch -p1 < kernel-2.6.spec.patch

### 8. patching the configs

I added 4 lines to each of the *i686* config files in `/usr/src/redhat/SOURCES`:

        +CONFIG_KDB=y
        +# CONFIG_KDB_MODULES is not set
        +# CONFIG_KDB_OFF is not set
        +CONFIG_KDB_CONTINUE_CATASTROPHIC=0

You can just get my config patch:

        $ wget http://www.jukie.net/~bart/kernel/2.6.9-22+kdb/kernel-2.6.9-i686-configs.patch

here is the link: [kernel-2.6.9-i686-configs.patch](/~bart/kernel/2.6.9-22+kdb/kernel-2.6.9-i686-configs.patch)

Then apply it by running

        $ cd /usr/src/redhat/SOURCES/
        $ patch -p1 < kernel-2.6.9-i686-configs.patch

### 7. building the rpm packages

To build both source and binary packages run:

        $ rpmbuild --target=i686 -ba /usr/src/redhat/SPECS/kernel-2.6.spec

The final products will be stored in `/usr/src/redhat/RPMS/i686/` and `/usr/src/redhat/SRPMS/`.  Should something fail you can review the tree in `/usr/src/redhat/BUILD/kernel-2.6.9/linux-2.6.9` to see if you can fix it.

Note that this will build a `2.6.9-22.EL.root` kernel.  There is probably a good reason for including the user name of who built it.  Eh, whatever.

This is what I get in the end:

        /usr/src/redhat/RPMS/i686/:
        total 40M
        9.9M kernel-2.6.9-22.EL.root.i686.rpm
        3.7M kernel-devel-2.6.9-22.EL.root.i686.rpm
        9.5M kernel-hugemem-2.6.9-22.EL.root.i686.rpm
        3.8M kernel-hugemem-devel-2.6.9-22.EL.root.i686.rpm
        9.6M kernel-smp-2.6.9-22.EL.root.i686.rpm
        3.7M kernel-smp-devel-2.6.9-22.EL.root.i686.rpm

        /usr/src/redhat/SRPMS:
        total 40M
        40M kernel-2.6.9-22.EL.root.src.rpm


### 8. installing the new rpms

To install the new package simply run

        $ cd /usr/src/redhat/RPMS/i686/
        $ rpm -i kernel-2.6.9-22.EL.root.i686.rpm kernel-devel-2.6.9-22.EL.root.i686.rpm

  *(I install the devel packages because I am building 3rd party modules against it)*

I am not sure if this updates `/etc/grub.conf`.  Check it.  Make sure you have something like this:

        title Red Hat Enterprise Linux AS (2.6.9-22.EL.root)
                root (hd0,0)
                kernel /boot/vmlinuz-2.6.9-22.EL.root ro root=LABEL=/1 rhgb quiet
                initrd /boot/initrd-2.6.9-22.EL.root.img

Then *cross your fingers* and `reboot`.

### 9. using kdb

Read the [Inside the Linux kernel debugger](http://www-128.ibm.com/developerworks/linux/library/l-kdbug/) 
article from IBM.
