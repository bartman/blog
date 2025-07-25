+++
title = "pxeboot and nfsroot with debian"
date = "2007-03-16T09:22:36-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['pxe', 'nfs', 'boot', 'linux', 'debian']
keywords = ['pxe', 'nfs', 'boot', 'linux', 'debian']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I have two boxes (i386 and amd64) in the *lab* that I use for testing of drivers I work on.  Recently **another** Maxtor
hard disk died on me, and I decided to get network booting working.  I already have a file server from
which I host my `$HOME` directories and do all backups from.  It sounded like a win.

I've never done this before, so it took me a few hours to get the first host going, the second took 10 minutes
plus the amount of time to build the kernel for it.

Below, I describe steps I took to get pxe-enabled hardware to boot a debian image, from a debian *DHCP*, 
*TFTP* and *NFS* servers.

<!--more-->

My setup includes three machines:

  * `gluon` - gateway and *DHCP* server,
  * `meson` - *TFTP* and *NFS* server, and
  * `nitrogen` - disk-less client.

You can run these services on one machine, or split them over four boxes if you need to.

Let's start by looking at the sequence of steps the disk-less client will go through to get to the boot prompt:

  * *BIOS* boots from PXE-enabled firmware image.
    * you need to configure your *BIOS* to enable PXE booting.  *PXE* is a protocol that enables *DHCP* booting.  If you
      don't have PXE in your *BIOS*, you can still use a special *PROM* on an older NIC.  I will not cover that.

  * *PXE* uses *DHCP* to get the IP address for the host.
    * *DHCP* server uses the *MAC* address of the NIC to match it up with an IP configuration, and further info on how 
      to boot.  In these details is the IP address of the *TFTP* server to use.

  * *PXE* uses *TFTP* server to fetch the initial boot image, or `pxelinux.0`.
    * `pxelinux.0` is provided by *syslinux* package.

  * `pxelinux.0` image gets configuration from *TFTP* server.
    * this is where the disk-less client learns about the kernel to boot and boot parameters to use.

  * kernel parameters tell it to fetch the root file system over *NFS*.

  * profit.

And now on to the setup.  I am going to cover things in the boot order, but feel free to skip around.  This might
be a good time to start building that kernel and do the rest while it builds.  I am not sure if distro kernels 
support *nfsroot*.  Mine didn't seem to.

Don't forget to change the IPs below to match your network configuration.

**BIOS**

You need to enable PXE booting in your *BIOS*.  I cannot really help here.  It should work on modern PC's and laptops.

**DHCP**

Install `dhcpd`.

        apt-get install dhcpd

On the *DHCP* server (in `/etc/dhcpd.conf`) you will need network booting options enabled:

        allow bootp;
        allow booting;

You will need to define a subnet, and teach the disk-less box where all the other systems are on the network:

        subnet 10.0.0.0 netmask 255.255.255.0 {
                range 10.0.0.150 10.0.0.200;                            # dynamic IP range

                default-lease-time 3600;
                max-lease-time 7200;

                option domain-name "yourdomain.com";

                option routers 10.0.0.254;                              # default gateway(s)
                option subnet-mask 255.255.255.0;
                option domain-name-servers 10.0.0.250, 10.0.0.250;
                option time-offset -18000;                              # Eastern Standard Time

        }

Next define a name host that boots using the file `pxelinux.0` named on *NFS* server `10.0.0.2`.

        host llama0 {
                hardware ethernet 01:23:45:67:89:ab;                    # client MAC
                option host-name "diskless";                            # client name
                fixed-address 10.0.0.100;                               # client IP
                next-server 10.0.0.2;                                   # TFTP server
                filename "pxelinux.0";                                  # file on TFTP server
        }

Restart `dhcpd`, if it fails to start up check the logs.

        /etc/init.d/dhcp restart

At this point you should have your disk-less client getting an IP address.

**TFTP**

Next is the *TFTP* server.  The *TFTP* server gets launched from *inetd*.  I am using `openbsd-inetd`.

        $ apt-get install atftpd openbsd-inetd

The *inetd* daemon passes to *TFTP* the directory where all the files are held.  This configuration is 
in `/etc/inetd.conf`.

        tftp            dgram   udp     wait    nobody  /usr/sbin/tcpd  /usr/sbin/in.tftpd /tftpboot

I kept mine in `/tftpboot` for historical reasons.  If the directory does not exist, you will have to create it.

        $ mkdir /tftpboot

**PXE**

So far the *TFTP* server is useless.  Let's install the initial boot image (`pxelinux.0`).

        $ apt-get install syslinux
        $ cp /usr/lib/syslinux/pxelinux.0 /tftpboot/

At this point you can have the disk-less client boot the `pxelinux.0` image.  It still needs a 
configuration.  It looks for it in `/pxelinux.cfg/` on the *TFTP* server.

        $ mkdir /tftpboot/pxelinux.cfg/

If uses the *MAC* address of the client to key on.  Failing that it uses the IP address (in hex).  We 
will use the *MAC*.  Note that the actual *MAC* address is preceeded by `01-` and the colons are replaced by 
dashes.  **MAC letters must be in lower case!**.

The configuration will look something like this:

        $ cat /tftpboot/pxelinux.cfg/01-01-23-45-67-89-ab
        IPAPPEND 2                      # I don't know :)
        SERIAL 0 115200                 # show on serial console

        PROMPT 1                        # show boot: prompt
        TIMEOUT 10                      # boot default after 1 second
        DEFAULT linux

        label linux
          kernel vmlinuz-diskless
          append rw console=ttyS0,115200n81 console=tty0 netdev=irq=11,name=eth0 netdev=irq=10,name=eth1 root=/dev/nfs ip=::::diskless:eth0:dhcp nfsroot=10.10.10.200:/nfsroot/diskless panic=100

        label another
          kernel another
          append ...

Note that the config file can support multiple images.  The default is `linux`.  The kernel image is `vmlinuz-diskless`, once we build it it will reside in `/tftpboot/vmlinuz-diskless`.

The kernel `append` command line is a bit long, so let me explain:

 * `rw` - mount read/write, you can use a read-only nfsroot, but that might require more work.
 * `console=ttyS0,115200n81 console=tty0` - setup two consoles, on serial and on the terminal (screen).
 * `netdev=irq=11,name=eth0 netdev=irq=10,name=eth1` - I have two network cards and wanted to force their order based on IRQ.
 * `panic=100` - should booting fail, reboot after 100 seconds -- nice since my "lab" is in the basement.
 * `root=/dev/nfs` - root is on *NFS*.
 * `ip=::::diskless:eth0:dhcp` - IP configuration for nfsroot comes from *DHCP*, we will use interface `eth0`, hostname is *diskless*.
 * `nfsroot=10.0.0.3:/nfsroot/diskless` - nfsroot will be mounted from this host/path.

Note that the kernel parameters can be no longer then 256 characters.  If you do have a *initrd* image, it can be listed on the append line.

At this time, the disk-less client will know to look for a kernel, but it will not find it.

**ROOTFS**

I keep my network booting root filesystems organized under `/nfsroot/${hostname}/`, and I install them using `debootstrap`.

        $ mkdir /nfsroot/diskless
        $ apt-get install debootstrap
        $ debootstrap --include=nfsbooted,dhcp3-client,procps,passwd,vim,less,configure-debian  etch  /nfsroot/diskless

This will take a while.

*nfsbooted* is a boot script that changes permissions of *ramfs* partitions so they can be accessed by everyone.  For it to work you will need to create a directory in the rootfs image.

        $ mkdir /nfsroot/diskless/.nfsroot

Once it's done, you have to modify a few files.  You might as well do it from the chroot, if you don't make sure you're not
chaning files in `/` but in `/nfsroot/diskless`.

        $ chroot /nfsroot/diskless su -

 * `/etc/hosts` needs to contain the following

        127.0.0.1       localhost

 * `/etc/hostname` should be set to your hostname

        diskless

 * `/etc/resolv.conf` should contain something sane, copy it from the *NFS* server.

 * `/etc/nfsbooted/mountfix.conf` needs to point to the right directory:

        NFSROOTDIR=/.nfsroot

 * `/etc/fstab` will contain a few *tmpfs* partitions so that temp files don't have to go over *NFS*.  Here is what mine looks like:

        /               /.nfsroot       none    bind,ro         0 0
        proc            /proc           proc    defaults        0 0

        # copied from /etc/nfsbooted/fstab
        /dev/ram        /tmp            ramfs   defaults,rw,auto,dev            0 0
        /dev/ram1       /var/run        ramfs   defaults,rw,auto,dev            0 0
        /dev/ram2       /var/state      ramfs   defaults,rw,auto,dev            0 0
        /dev/ram3       /var/lock       ramfs   defaults,rw,auto,dev            0 0
        /dev/ram4       /var/account    ramfs   defaults,rw,auto,dev            0 0
        /dev/ram5       /var/log        ramfs   defaults,rw,auto,dev            0 0
        /dev/ram6       /var/lib/gdm    ramfs   defaults,rw,auto,dev            0 0
        /dev/ram7       /var/tmp        ramfs   defaults,rw,auto,dev            0 0

 * finally, you should finish off the debian installation

        $ configure-debian --all

Then exit the chroot.

        $ exit

I think that's it.  I hope I didn't forget anything :)

**KERNEL**

Let's build a kernel.  There are so many ways to build one.  Here is just one.

        $ apt-get install git-core build-essential
        $ git clone git://git2.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.20.y.git linux
        $ cd linux
        $ make allmodconfig

This will create a configuration with everything enabled as a module.  But some things are required to be 
built into the kernel.  So, edit and/or add the following:

* *DHCP* support

        CONFIG_IP_PNP=y
        CONFIG_IP_PNP_DHCP=y

* *NFS* client support

        CONFIG_NFS_FS=y
        CONFIG_NFS_V3=y
        CONFIG_NFS_V4=y
        CONFIG_NFS_DIRECTIO=y

* *NFS* root support

        CONFIG_ROOT_NFS=y

* your network interface

        CONFIG_E1000=y                          # if you have Intel E1000
        CONFIG_BNX2=y                           # if you have Broadcom NetXtreme

If you don't know what NIC you have, enable a bunch.  It costs little.

Next we build...

        $ make -j2 bzImage modules

Then install...

        $ make INSTALL_MOD_PATH=/nfsroot/diskless modules_install
        $ make INSTALL_PATH=/nfsroot/diskless/boot install

And lastly copy the *vmlinuz* file to the *TFTP* server.

        $ cp /nfsroot/diskless/boot/vmlinuz* /tftpboot

At this point the disk-less client will be able to boot the kernel and will die when it tries to mount the *nfsroot*.

**NFS**

Last step is to configure the *NFS* server to export our new *nfsroot*.

        $ apt-get install nfs-kernel-server

This is done through `/etc/exports`

        /nfsroot/diskless 10.0.0.100(rw,no_root_squash,no_subtree_check)

And export it

        $ exportfs -a

And now, it should all work.

**References**

I used (at least) the following documents to get the above procedure:

 * [Root over NFS - Another Approach](http://www.faqs.org/docs/Linux-HOWTO/Diskless-root-NFS-other-HOWTO.html)
 * [Linux NFS Root and PXE-Boot](http://www.digitalpeer.com/id/linuxnfs)
 * [NFS-Root mini-HOWTO](http://www.faqs.org/docs/Linux-mini/NFS-Root.html)
 * [How to reorder or rename logical interface names in Linux](http://www.science.uva.nl/research/air/wiki/LogicalInterfaceNames)
 * [Debian Diskless Terminals Howto](http://www.logilab.org/view?rql=Any%20X%20WHERE%20X%20eid%203281)
 * [NFSroot HOWTO](http://www.onesis.org/NFSroot-HOWTO.php)

And these were found to be also useful:

 * [Howto Install a Debian GNU/Linux system onto a USB flash thumb drive](http://feraga.com/node/25)
 * [Debian Cheatpage](http://people.debian.org/~daniel/documents/cheatpage.html)
 * [Boot Linux, FreeBSD, FreeDOS from PXE (Preboot Execution Environment)](http://www.im.uec.ac.jp/~fukuhara/pxe/)
 * [PXE booting floppy images](http://www.smop.co.uk/node/102)
