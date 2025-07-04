+++
title = "HDD -> SDD"
date = "2011-06-16T18:02:55-04:00"
author = "bartman"
authorTwitter = "barttrojanowski"
cover = ""
tags = ['hw', 'ssd']
keywords = ['hw', 'ssd']
description = ""
showFullContent = false
readingTime = false
hideComments = false
+++

After reading and hearing everyone raving about SSDs for a couple of years it was hard to resists the upgrade.

So I got an [Intel SSD 510 120GB](http://www.techspot.com/review/387-intel-510-ssd/page4.html) to replace my Seagate 2.5" laptop HDD.

The prices in the ~120GB SSD category are pretty close.  I chose the Intel based on reading that they have a low failure rate (I was unable to find the soruce when writing this up).

The Thinkpad X61 only has SATA-II; the drive supposedly has better performance on SATA3.

<i>UPDATE:</i> [Samat K Jain](http://samat.org/) points out that "<i>the ThinkPad X61 is limited to 1.5 Gbps, even with SATA-II (Lenovo's excuse: power saving, by keeping bus clocks down)</i>".  Lots of discussion about that [on the net](http://www.google.com/search?q=ThinkPad+X61+SATA).

<!--more-->

My setup...

* Thinkpad X61 w/ 4G of RAM
* Linux 2.6.39
* XFS on encrypted LVM (default Debian install)

Here are the summarized bonie++ results.

<table border="1" cellpadding="2" cellspacing="0">
<tr>
  <td><b>Test</b></td>
  <td><b>HDD</b></td>
  <td><b>SDD</b></td>
  <td><b>SDD improvement</b></td>
</tr>
<tr>
  <td>Sequential Output (KB/s)</td>
  <td>40777</td>
  <td>76504</td>
  <td>1.87</td>
</tr>
<tr>
  <td>Sequential Input (KB/s)</td>
  <td>50883</td>
  <td>89495</td>
  <td>1.75</td>
</tr>
<tr>
  <td>Random Seeks (Hz)</td>
  <td>115.7</td>
  <td>8242</td>
  <td>71.23</td>
</tr>
</table>


Detailed results follow.

### SATA connected...

* HDD (direct, internal SATA)

        ------Sequential Output------
        -Per Chr- --Block-- -Rewrite-
        K/sec %CP K/sec %CP K/sec %CP
          507  96 40777   9 18916   4
        21918us   30049ms    4885ms  

        ------Sequential Create------
        -Create-- --Read--- -Delete--
         /sec %CP  /sec %CP  /sec %CP
         4205  33 +++++ +++  7906  56
          323ms     361us   36194us  

        --Sequential Input-
        -Per Chr- --Block--
        K/sec %CP K/sec %CP
         1188  98 50883   6
        28682us     427ms  

        --Random-
        --Seeks--
         /sec %CP
        115.7   3
         1258ms

        --------Random Create--------
        -Create-- --Read--- -Delete--
         /sec %CP  /sec %CP  /sec %CP
         4969  41 +++++ +++  8127  58
        33240us     248us   17470us

        1.96,1.96,oxygen,1,1308235638,8G,,507,96,40777,9,18916,4,1188,98,50883,6,115.7,3,16,,,,,4205,33,+++++,+++,7906,56,4969,41,+++++,+++,8127,58,21918us,30049ms,4885ms,28682us,427ms,1258ms,323ms,361us,36194us,33240us,248us,17470us

* SDD (direct, internal SATA)

        $ bonnie++
        ...

        ------Sequential Output------
        -Per Chr- --Block-- -Rewrite-
        K/sec %CP K/sec %CP K/sec %CP
          699  98 76504  11 33240   5
        13000us     138ms    3195ms  

        ------Sequential Create------
        -Create-- --Read--- -Delete--
         /sec %CP  /sec %CP  /sec %CP
         1685  18 +++++ +++  1566  15
        19248us     347us   16185us  

        --Sequential Input-
        -Per Chr- --Block--
        K/sec %CP K/sec %CP
         1766  98 89495   9
         9253us     115ms  

        --Random-
        --Seeks--
         /sec %CP
         8242 156
        18453us

        --------Random Create--------
        -Create-- --Read--- -Delete--
         /sec %CP  /sec %CP  /sec %CP
         1442  16 +++++ +++  1407  14
        16373us    1645us   40035us

        1.96,1.96,oxygen,1,1308421092,8G,,699,98,76504,11,33240,5,1766,98,89495,9,8242,156,16,,,,,1685,18,+++++,+++,1566,15,1442,16,+++++,+++,1407,14,13000us,138ms,3195ms,9253us,115ms,18453us,19248us,347us,16185us,16373us,1645us,40035us

### USB connected...

* HDD (external USB encolosure)

        $ bonnie++
        ...
        TBD

* SDD (external USB encolosure)

        $ bonnie++
        ...

        ------Sequential Output------
        -Per Chr- --Block-- -Rewrite-
        K/sec %CP K/sec %CP K/sec %CP
          236  97 27309   5 14605   4
        49235us    6536ms    6152ms  

        ------Sequential Create------
        -Create-- --Read--- -Delete--
         /sec %CP  /sec %CP  /sec %CP
         9045  58 +++++ +++ 12715  76
          181ms     653us     362us  

        --Sequential Input-
        -Per Chr- --Block--
        K/sec %CP K/sec %CP
          759  99 39972   4
        15913us   17705us  

        --Random-
        --Seeks--
         /sec %CP
         1667  36
          507ms

        --------Random Create--------
        -Create-- --Read--- -Delete--
         /sec %CP  /sec %CP  /sec %CP
        11224  70 +++++ +++ 13911  87
         3317us      73us    3122us

        1.96,1.96,oxygen,1,1308279549,8G,,236,97,27309,5,14605,4,759,99,39972,4,1667,36,16,,,,,9045,58,+++++,+++,12715,76,11224,70,+++++,+++,13911,87,49235us,6536ms,6152ms,15913us,17705us,507ms,181ms,653us,362us,3317us,73us,3122us


