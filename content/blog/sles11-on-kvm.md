+++
title = "sles 11 on kvm"
date = "2009-03-30T18:11:38-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['kvm', 'suse']
keywords = ['kvm', 'suse']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I need a SLES 11 system for porting some software for a client.  I got the DVD and tried to install in [kvm]{tag/kvm}.

First, I was pleasantly surprised that, like [Debian]{tag/debian}, [SuSE]{tag/suse} now supports virtio
disks (`/dev/vda`) right from the installer.  So far so good.

However, both SLES 11 and OpenSuse 11 fail to install because grub crashes.  I tried booting the SuSE cd
into "rescue" mode and tries to install grub manually using the chroot trick.  Same thing, grub seg faults.

<!--more-->

So I tried with a Debian CD.  I was able to install grub without problem (well, almost... see below).  This
suggests that the fault lies with the kernel that SuSE installed, and it's incompatibility with `/usr/sbin/grub`
that they ship.  Using the SLES `grub` and another kernel seems to work.  For refernece this is what I did,
after booting to the console:

        $ mount /dev/vda2 /mnt
        $ mount none -t proc /mnt/proc
        $ mount none -t sysfs /mnt/sys
        $ mount -o rbind /dev /mnt/dev
        $ chroot /mnt
        # /usr/sbin/grub-install.unsupported /dev/vda

I'll use `#` to denote that we are in the chroot.  Note that `vda` is the virtio disk, you may need to use `/dev/sda`
here (check with `cat /proc/partitions`).  Also, fi you do use virtio disks, you'll have to modify your 
`grub-install.unsupported` script as shown at the bottom of this write up.

But there is a bit more to do because when grub crashed during the install, there were tons of other things that
needed to be done.  I don't know them all, but we at least have to set the passwords:

        # passwd root
        New password: ...
        Reenter New password: ...

        # useradd -m bart
        # passwd bart
        New password: ...
        Reenter New password: ...

And now that were are done...

        # exit
        $ umount /mnt/dev
        $ umount /mnt/sys
        $ umount /mnt/proc
        $ umount /mnt
        $ reboot

Well, I am disappointed, but not all that surprised.  SuSE Linux has yet to capture my praise.

<h3>fixing grub-install</h3>

Remember how I said that SLES supported virtio from the isntaller?  Well, their grub-install script
was not patched, like Debian's was.

This is not the reason for grub crashing, BTW.  `grub-install` is just a script that calls to `grub`
to do the low level bits.  It has a `.unsupported` suffix on SLES because they replaced the official
script with a yast wrapper.

Anyway, I had to this patch to `/usr/sbin/grub-install.unsupported`:

        --- /usr/sbin/grub-install.unsupported.orig	2009-02-21 01:34:59.000000000 +0000
        +++ /usr/sbin/grub-install.unsupported	2009-03-30 23:44:55.000000000 +0000
        @@ -107,12 +107,12 @@
             # Break the device name into the disk part and the partition part.
             case "$host_os" in
             linux*)
        -	tmp_disk=`echo "$1" | sed -e 's%\([sh]d[a-z]\)[0-9]*$%\1%' \
        +	tmp_disk=`echo "$1" | sed -e 's%\([vsh]d[a-z]\)[0-9]*$%\1%' \
         				  -e 's%\(d[0-9]*\)p[0-9]*$%\1%' \
         				  -e 's%\(fd[0-9]*\)$%\1%' \
         				  -e 's%/part[0-9]*$%/disc%' \
         				  -e 's%\(c[0-7]d[0-9]*\).*$%\1%'`
        -	tmp_part=`echo "$1" | sed -e 's%.*/[sh]d[a-z]\([0-9]*\)$%\1%' \
        +	tmp_part=`echo "$1" | sed -e 's%.*/[vsh]d[a-z]\([0-9]*\)$%\1%' \
         				  -e 's%.*d[0-9]*p%%' \
         				  -e 's%.*/fd[0-9]*$%%' \
         				  -e 's%.*/floppy/[0-9]*$%%' \

This patch is not meant to be applied, just edit the file and add the the letter `v` in a couple of places.