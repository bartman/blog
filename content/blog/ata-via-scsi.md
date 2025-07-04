+++
title = "ATA messages via SCSI layer"
date = "2007-04-06T14:18:50-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['ata', 'scsi', 'linux', 'kernel']
keywords = ['ata', 'scsi', 'linux', 'kernel']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

I've been working on a contract for [Symbio Technologies](http://www.thesymbiont.com/) for the last month.  They
are makers of a few thin client terminals.  

My work for Symbio involves talking to a SATA hard disk using ATA command set.  What makes this a bit more
interesting is that `/dev/hda` is the way of the past.  New devices are covered by [libata](http://linux-ata.org/faq.html)
drives which fit into the SCSI subsystem.

So, the challenge for me was how to send raw ATA messages using the SCSI layer to the SATA drive.  Besides the fact
that the interface is sparsely documented, it was pretty easy.

<!--more-->

**Specs**

Let's start off with ATA commands set.  You will need to get a copy of the ATA/ATAPI-7 spec from 
the [T13 committee](http://www.t13.org/) (for some reason [these links](http://linux-ata.org/devel.html)
don't work anymore).  Any command you send to the device will look like what's outlined in this document.

As mentioned above, the new way of interfacing with the ATA devices is via SATA.  There is even a documented
translation method called [SCSI ATA Translation](http://www.t10.org/drafts.htm#SAT) (or SAT).  This is maintained by 
the [T10 committee](http://www.t10.org/), and you want to download 
the [SAT2 document](http://www.t10.org/ftp/t10/drafts/sat2/sat2r00.pdf).

**WARNING**

Before you proceed...  I have no idea what I am talking about.  The stuff below may make your disk explode.

**IDE subsystem**

First let's review the history.

Once upon a time there was IDE, and we had a whole slew of IDE devices under `CONFIG_IDE` in the kernel .config file.

To communicate with these devices you would use one of the *IOCTL*'s:

  * `HDIO_DRIVE_TASK` - can issue commands that have LBA commands, cannot read or write data,
  * `HDIO_DRIVE_CMD` - can issue commands that read blocks of data, cannot send commands with LBA parameters, and
  * `HDIO_DRIVE_TASKFILE` - can issue pretty much anything, but is more complicated to use.

Each of these IOCTLs passes down a single buffer that is used for control, input and output data.

As you can see the first two are useless if you want to do any real communication.  They do seem to be helpful
for some SMART commands and for some other STATUS commands.  For anything else you need to use `HDIO_DRIVE_TASKFILE`.

* Here is another example which gets the SMART STATUS from the drive.

  I am using this because SMART STATUS is a *no data* command, so we can use the `HDIO_DRIVE_TASK` ioctl.

  This may make your eyes bleed, but truly this is how you use this interface.

        int fd, rc;
        uint8_t buf[7];

        fd = open ("/dev/hda", O_RDWR);

        buf[0] = WIN_SMART;     // command id
        buf[1] = SMART_STATUS;  // feature id
        buf[2] = 1;             // number of sectors
        buf[3] = 0x00;          // LBA low
        buf[4] = 0x4F;          // LBA mid
        buf[5] = 0xC2;          // LBA high
        buf[6] = 0;             // device select

        rc = ioctl (fd, HDIO_DRIVE_TASK, buf);

        printf ("status %02x\n", buf[0]);
        printf ("error  %02x\n", buf[1]);
        printf ("n sect %02x\n", buf[2]);
        printf ("LBA L  %02x\n", buf[3]);
        printf ("LBA M  %02x\n", buf[4]);
        printf ("LBA H  %02x\n", buf[5]);
        printf ("select %02x\n", buf[6]);

  Thing to note is that the descriptor size is 7 bytes, and there is no data transfered in 
  this command.  If you give the wrong command or feature you may cause a SATA reset and not
  be able to talk to your drive anymore.
        
  It's pretty awful of an interface, and it gets a bit worse...

* Here is an example of getting the IDENTIFY message from the drive:

  Here I am using an IDENTIFY request as it returns 1 block of data from the device.

        int fd, rc;
        uint8_t buf[4 + 512];

        fd = open ("/dev/hda", O_RDWR);

        buf[0] = WIN_IDENTIFY;  // command id
        buf[1] = 1;             // number of sectors
        buf[2] = 0;             // feature id
        buf[3] = 1;             // number of sectors

        rc = ioctl (fd, HDIO_DRIVE_CMD, buf);

        printf ("status %02x\n", buf[0]);
        printf ("error  %02x\n", buf[1]);
        printf ("n sect %02x\n", buf[2]);
  
  In this interface the descriptor is 4 bytes, and it's followed by a multiple of 512 blocks for 
  the data transfer.  You can only read with this interface, and you can cause SATA resets if you're
  not careful.

  But, wait... it gets worse.

* Here is an example of getting SMART log records...

  Here I am using SMART READ VALUES command which returns one block of data...

        int fd, rc;
        uint8_t buf[4 + 512];

        fd = open ("/dev/hda", O_RDWR);

        buf[0] = WIN_SMART;         // command id
        buf[1] = 0;                 // LBA low
        buf[2] = SMART_READ_VALUES; // feature id
        buf[3] = 1;                 // number of sectors

        rc = ioctl (fd, HDIO_DRIVE_CMD, buf);

        printf ("status %02x\n", buf[0]);
        printf ("error  %02x\n", buf[1]);
        printf ("n sect %02x\n", buf[2]);

  I said it gets worse.  It's worse because the encoding of the descriptor depends on the 
  command id.  And a lot of this is not documented, so you have to read the code.

Now onto the new interface...

**SCSI subsystem**

*libata* is the name of a set of drivers and some glue code that allows the SCSI layer to talk to ATA devices.  From
user land, for quite some time SATA drives have been showing up as `/dev/sda` (a SCSI disk device).  More recently
this was extended to PATA devices, and some old drivers were ported to *libata*.

[libata](http://www.aoc.nrao.edu/~tjuerges/ALMA/Kernel/libata/index.html) does support `HDIO_DRIVE_CMD` and 
`HDIO_DRIVE_TASK` for backwards compatibility -- mainly for `hdparm`, `hdtemp`, `smartmontools`, etc.  However 
it does not support `HDIO_DRIVE_TASKFILE`, and it 
is [suggested that people use SG_IO](http://www.mail-archive.com/linux-ide@vger.kernel.org/msg04280.html) instead.

The SCSI ioctl [SG_IO](http://sg.torque.net/sg/sg_io.html) allows the same features as the IDE TASKFILE, but 
sends the commands through the SCSI subsystem.  Since the SCSI and ATA commands are nothing alike *libata* maintains
translation code to do this for common commands, as mandated by the SAT2 T10 committee document referenced above.

If a command does not fit into the SAT2 translation you can wrap the ATA command with an SG_IO header and pass
it using ATA16 pass-through commands.

I am not going to talk about the easy case of using SCSI ioctls, for which there are SAT mappings, to talk to 
the ATA device... that's easy and pretty well documented.  For examples see the source code for the `sginfo` 
tool from sg3-utils package.

I will however show how to send the three different types of commands:

* First, an example of how to issue a *no data* command:

        int fd, rc;
        struct sg_io_hdr sg_io;
        uint8_t cdb[16];
        uint8_t sense[32];

        // under most circumstances /dev/sda maps to /dev/sg0
        // only SCSI generic interfaces can use SG_IO ioctl
        // see output of: sginfo -l
        fd = open ("/dev/sg0", O_RDWR);

        memset (&sg_io, 0, sizeof(sg_io));
        memset (&cdb, 0, sizeof(cdb));
        memset (&sense, 0, sizeof(sense));

        sg_io.interface_id    = 'S';
        sg_io.cmdp            = cdb;
        sg_io.cmd_len         = sizeof(cdb);
        sg_io.dxferp          = NULL;
        sg_io.dxfer_len       = 0;
        sg_io.dxfer_direction = SG_DXFER_NONE;
        sg_io.sbp             = sense;
        sg_io.mx_sb_len       = sizeof(sense);
        sg_io.timeout         = 5000;   // 5 seconds

        cdb[0] = 0x85;                  // pass-through ATA16 command (no translation)
        cdb[1] = (3 << 1);              // no data
        cdb[2] = 0x20;                  // no data
        cdb[4] = feature_id;            // ATA feature ID
        cdb[6] = 0;                     // number of sectors
        cdb[7] = lba_low >> 8;
        cdb[8] = lba_low;
        cdb[9] = lba_mid >> 8;
        cdb[10] = lba_mid;
        cdb[11] = lba_high >> 8;
        cdb[12] = lba_high;
        cdb[14] = command_id;           // ATA command ID

        rc = ioctl (fd, SG_IO, &sg_io);

        // check expected magic
        if (sense[0] != 0x72 || sense[7] != 0x0e || sense[8] != 0x09
                        || sense[9] != 0x0c || sense[10] != 0x00)
                error;

        printf ("error  = %02x", sense[11]);    // 0x00 means success
        printf ("status = %02x", sense[21]);    // 0x50 means success

* Next, an example of how to issue a *data-in* (or from device) command:

        int fd, rc;
        struct sg_io_hdr sg_io;
        uint8_t cdb[16];
        uint8_t sense[32];

        fd = open ("/dev/sg0", O_RDWR);

        memset (&sg_io, 0, sizeof(sg_io));
        memset (&cdb, 0, sizeof(cdb));
        memset (&sense, 0, sizeof(sense));

        sg_io.interface_id    = 'S';
        sg_io.cmdp            = cdb;
        sg_io.cmd_len         = sizeof(cdb);
        sg_io.dxferp          = data_in_buffer;
        sg_io.dxfer_len       = data_in_length;         // multiple of 512
        sg_io.dxfer_direction = SG_DXFER_FROM_DEV;
        sg_io.sbp             = sense;
        sg_io.mx_sb_len       = sizeof(sense);
        sg_io.timeout         = 5000;                   // 5 seconds

        cdb[0] = 0x85;                  // pass-through ATA16 command (no translation)
        cdb[1] = (4 << 1);              // data-in
        cdb[2] = 0x2e;                  // data-in
        cdb[4] = feature_id;            // ATA feature ID
        cdb[6] = 1;                     // number of sectors
        cdb[7] = lba_low >> 8;
        cdb[8] = lba_low;
        cdb[9] = lba_mid >> 8;
        cdb[10] = lba_mid;
        cdb[11] = lba_high >> 8;
        cdb[12] = lba_high;
        cdb[14] = command_id;           // ATA command ID

        rc = ioctl (fd, SG_IO, &sg_io);

        // check expected magic
        if (sense[0] != 0x72 || sense[7] != 0x0e || sense[8] != 0x09
                        || sense[9] != 0x0c || sense[10] != 0x00)
                error;

        printf ("error  = %02x", sense[11]);    // 0x00 means success
        printf ("status = %02x", sense[21]);    // 0x50 means success

* And last, an example of how to issue a *data-out* command:

        int fd, rc;
        struct sg_io_hdr sg_io;
        uint8_t cdb[16];
        uint8_t sense[32];

        fd = open ("/dev/sg0", O_RDWR);

        memset (&sg_io, 0, sizeof(sg_io));
        memset (&cdb, 0, sizeof(cdb));
        memset (&sense, 0, sizeof(sense));

        sg_io.interface_id    = 'S';
        sg_io.cmdp            = cdb;
        sg_io.cmd_len         = sizeof(cdb);
        sg_io.dxferp          = data_out_buffer;
        sg_io.dxfer_len       = data_out_length;        // multiple of 512
        sg_io.dxfer_direction = SG_DXFER_TO_DEV;
        sg_io.sbp             = sense;
        sg_io.mx_sb_len       = sizeof(sense);
        sg_io.timeout         = 5000;                   // 5 seconds

        cdb[0] = 0x85;                  // pass-through ATA16 command (no translation)
        cdb[1] = (5 << 1);              // data-out
        cdb[2] = 0x26;                  // data-out
        cdb[4] = feature_id;            // ATA feature ID
        cdb[6] = 1;                     // number of sectors
        cdb[7] = lba_low >> 8;
        cdb[8] = lba_low;
        cdb[9] = lba_mid >> 8;
        cdb[10] = lba_mid;
        cdb[11] = lba_high >> 8;
        cdb[12] = lba_high;
        cdb[14] = command_id;           // ATA command ID

        rc = ioctl (fd, SG_IO, &sg_io);

        // check expected magic
        if (sense[0] != 0x72 || sense[7] != 0x0e || sense[8] != 0x09
                        || sense[9] != 0x0c || sense[10] != 0x00)
                error;

        printf ("error  = %02x", sense[11]);    // 0x00 means success
        printf ("status = %02x", sense[21]);    // 0x50 means success

Hope that some of this was useful.  Please let me know if I missed something.
