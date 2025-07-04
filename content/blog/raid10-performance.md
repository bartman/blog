+++
title = "software RAID10 performance"
date = "2006-05-26T08:56:44-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['raid', 'linux']
keywords = ['raid', 'linux']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

A buddy of mine works at IBM, he has a big ass SCSI raid array (DS300) on which he runs RAID5 (which is bad, BTW).  He wanted to know what the overhead of running software [RAID10](http://en.wikipedia.org/wiki/Redundant_array_of_independent_disks#RAID_10) (aka RAID1+0) on this system would be.  [His numbers are here](http://phobos.ca/mediawiki/index.php/Disc_Performance_Benchmark).

<!--more-->

### The setup:

I have 8 SATA drives in two [RAID0](http://en.wikipedia.org/wiki/Redundant_array_of_independent_disks#RAID_0) arrays built over four [RAID1](http://en.wikipedia.org/wiki/Redundant_array_of_independent_disks#RAID_1) arrays:

        # cat /proc/mdstat  | grep ^md
        md5 : active raid0 md1[0] md2[1]
        md6 : active raid0 md3[0] md4[1]
        md4 : active raid1 sdh3[1] sdf3[0]
        md3 : active raid1 sde3[0] sdg3[1]
        md2 : active raid1 sdd3[0] sdb3[1]
        md1 : active raid1 sda3[0] sdc3[1]

Disks *sda* through *sdd* are on the onboard controller.  Disks *sde* and *sdf* are on a 32/33 PCI controller, and *sdg* and *sdh* are on another (on the same 32/33 PCI bus).

### The data:

Here are the raw *hdparm* throughput benchmarks for a couple of the disks:

        # hdparm -tT /dev/sda ; hdparm -tT /dev/sdd
        /dev/sda:
         Timing cached reads:   3432 MB in  2.00 seconds = 1715.40 MB/sec
         Timing buffered disk reads:  182 MB in  3.01 seconds =  60.47 MB/sec

        /dev/sdd:
         Timing cached reads:   3528 MB in  2.00 seconds = 1762.51 MB/sec
         Timing buffered disk reads:  212 MB in  3.00 seconds =  70.56 MB/sec

Here is *dstat* running in another terminal:

        ----total-cpu-usage---- -disk/total -net/total- ---paging-- ---system--
        usr sys idl wai hiq siq|_read write|_recv _send|__in_ _out_|_int_ _csw_
          0   2  79  18   0   1|  12M    0 |1382B 1254B|   0     0 |1216   225 
          1  12   0  86   0   1|  61M    0 |2447B 2145B|   0     0 |1623  1022 
          0  11   0  89   0   0|  61M   12k|1930B 1770B|   0     0 |1616  1255 
          1  13  14  70   0   2|  49M 1598k| 910B 1174B|   0     0 |1680  1790 
        <snip>
          0   0  93   7   0   0|5116k    0 | 802B  752B|   0     0 |1154   103 
          0  14   0  85   0   1|  70M    0 |1348B 1168B|   0     0 |1682  1151 
          1  14   0  85   0   1| 137M   52k|1896B 1682B|   0     0 |3267  3307 
          0  50  50   0   0   0|   0    16k| 264B  648B|   0     0 |  77    30 

Now here are the numbers for the RAID1 devices:

        # hdparm -tT /dev/md1 ; hdparm -tT /dev/md3
        /dev/md1:
         Timing cached reads:   3556 MB in  2.00 seconds = 1776.49 MB/sec
         Timing buffered disk reads:  182 MB in  3.02 seconds =  60.25 MB/sec

        /dev/md3:
         Timing cached reads:   3556 MB in  2.00 seconds = 1777.38 MB/sec
         Timing buffered disk reads:  216 MB in  3.00 seconds =  71.96 MB/sec

And here is the *dstat* output ran in another terminal:

        ----total-cpu-usage---- -disk/total -net/total- ---paging-- ---system--
        usr sys idl wai hiq siq|_read write|_recv _send|__in_ _out_|_int_ _csw_
          0  13   4  82   0   1|  57M    0 |1176B 1056B|   0     0 |1579  1396 
          1  12   0  85   0   2|  61M    0 | 954B  836B|   0     0 |1601  1485 
          0  14   1  83   0   2|  64M  142k| 142k 7146B|   0     0 |1881  1767 
        <snip>
          0  12  19  68   0   1|  57M    0 | 712B  752B|   0     0 |1571  1393 
          1  13   0  83   0   3|  73M    0 | 646B  654B|   0     0 |1695  1773 
          1  10   0  85   0   4|  73M  368k| 706B  696B|   0     0 |1718  1784 
          1   8  76  15   0   0|  13M    0 |3226B 3308B|   0     0 |1250   396 

Here are the metrics for the RAID10 devices:

        # hdparm -tT /dev/md5 ; hdparm -tT /dev/md6
        /dev/md5:
         Timing cached reads:   3536 MB in  2.00 seconds = 1766.50 MB/sec
         Timing buffered disk reads:  164 MB in  3.02 seconds =  54.38 MB/sec

        /dev/md6:
         Timing cached reads:   3544 MB in  2.00 seconds = 1770.50 MB/sec
         Timing buffered disk reads:  230 MB in  3.02 seconds =  76.22 MB/sec

And *dstat* running in another terminal:

        ----total-cpu-usage---- -disk/total -net/total- ---paging-- ---system--
        usr sys idl wai hiq siq|_read write|_recv _send|__in_ _out_|_int_ _csw_
          0  57   1  22   0  20|  50M    0 |1414B 1298B|   0     0 |1925  3262 
          1  57   0  21   0  21|  54M    0 | 646B  654B|   0     0 |1974  3756 
          1  55   0  21   0  23|  59M   52k| 646B  670B|   0     0 |2068  3615 
        <snip>
          0   9  75   9   0   7|  17M  106k|1748B 1650B|   0     0 |1522   311 
          1  56   0  12   0  31|  86M    0 | 646B  654B|   0     0 |3068  1090 
          1  55   0  14   0  30|  77M  183k| 712B  784B|   0     0 |2845  1860 
          0  53  12  14   0  21|  50M   34k|1182B 1348B|   0     0 |2180  1913 

### Conclusions:

If you read the results you will discover that the *read throughput* actually stays pretty much the same through the test regardless of the level of RAID you throw at it.  That's probably good because it shows that Linux MD is not adding additional overhead.  However, this is not the full picture.  What would be more interesting is to do a write test to determine what impact writing to two disks at the same time does to the performance.

### TODO:

When I don't care so much about my data, try an *hdparm* write test and *dbench*.