

WORKLOAD REPOSITORY COMPARE PERIOD REPORT

Snapshot Set    DB Id    Instance     Inst Num Release     Cluster Host          Std Block Size
------------ ----------- ------------ -------- ----------- ------- ------------ ---------------
First (1st)   2532911053 DBM11203            1 11.2.0.3.0  NO      helicon          8192
Second (2nd)  2532911053 DBM11203            1 11.2.0.3.0  NO      helicon          8192

Snapshot Set  Begin Snap Id Begin Snap Time            End Snap Id End Snap Time                  Avg Active Users           Elapsed Time (min)            DB time (min)
------------ -------------- ------------------------- ------------ ------------------------- -------------------------- -------------------------- --------------------------
1st                    1822 23-Apr-14 18:30:05 (Wed)         1823 23-Apr-14 18:45:06 (Wed)                       7.1                      15.0                     106.7
2nd                    1826 23-Apr-14 19:30:10 (Wed)         1827 23-Apr-14 19:45:13 (Wed)                      14.0                      15.0                     210.2
                                                                                      ~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~
                                                                                      %Diff:                    96.8%                       0.1%                      96.9%

Host Configuration Comparison
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                                     1st                  2nd                 Diff     %Diff
----------------------------------- -------------------- -------------------- -------------------- ---------
Number of CPUs:                                        8                    8                    0       0.0
Number of CPU Cores:                                   8                    8                    0       0.0
Number of CPU Sockets:                                 2                    2                    0       0.0
Physical Memory:                                 7974.6M              7974.6M                   0M       0.0
Load at Start Snapshot:                             6.93                 8.37                 1.44      20.8
Load at End Snapshot:                               7.23                14.07                 6.84      94.6
%User Time:                                        23.79                39.62                15.83      66.5
%System Time:                                        .89                 1.43                  .54      60.7
%Idle Time:                                        74.79                58.14               -16.65     -22.3
%IO Wait Time:                                     21.81                30.48                 8.67      39.8
Cache Sizes
~~~~~~~~~~~
                          1st (M)    2nd (M)   Diff (M)    %Diff
---------------------- ---------- ---------- ---------- --------
Memory Target
.....SGA Target           1,024.0    1,024.0        0.0      0.0
..........Buffer Cache      728.0      728.0        0.0      0.0
..........Shared Pool       260.0      260.0        0.0      0.0
..........Large Pool          8.0        8.0        0.0      0.0
..........Java Pool           4.0        4.0        0.0      0.0
..........Streams Pool        8.0        8.0        0.0      0.0
.....PGA Target             128.0      128.0        0.0      0.0
Log Buffer                    7.8        7.8        0.0      0.0

Workload Comparison
~~~~~~~~~~~~~~~~~~~                   1st Per Sec          2nd Per Sec      %Diff              1st Per Txn          2nd Per Txn      %Diff
                                  ---------------      ---------------     ------          ---------------      ---------------     ------
                    DB time:                  7.1                 14.0       96.8                      0.0                  0.0       66.7
                   CPU time:                  1.9                  3.2       68.8                      0.0                  0.0        0.0
                  Redo size:            393,267.0            552,173.5       40.4                  1,931.8              1,933.1        0.1
              Logical reads:            406,407.8            649,091.1       59.7                  1,996.3              2,272.4       13.8
              Block changes:              2,827.7              3,948.6       39.6                     13.9                 13.8       -0.5
             Physical reads:                580.0                857.4       47.8                      2.8                  3.0        5.3
            Physical writes:                377.6                578.1       53.1                      1.9                  2.0        9.2
                 User calls:              2,896.4              4,051.3       39.9                     14.2                 14.2       -0.4
                     Parses:                  0.5                  1.6      189.1                      0.0                  0.0      100.0
                Hard parses:                  0.0                  0.4    3,600.0                      0.0                  0.0        0.0
           W/A MB processed:             82,999.0             85,027.5        2.4                    407.7                297.7        2.4
                     Logons:                  0.0                  0.0      200.0                      0.0                  0.0        0.0
                   Executes:              1,364.7              1,914.2       40.3                      6.7                  6.7        0.0
               Transactions:                203.6                285.6       40.3

                                            First               Second       Diff
                                  ---------------      ---------------     ------
  % Blocks changed per Read:                  0.7                  0.6       -0.1
           Recursive Call %:                  6.9                  7.3        0.4
 Rollback per transaction %:                  0.0                  0.0        0.0
              Rows per Sort:                 36.7                 13.0      -23.7
 Avg DB time per Call (sec):                  0.0                  0.0        0.0

Top Timed Events   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Events with a "-" did not make the Top list in this set of snapshots, but are displayed for comparison purposes

                                               1st                                                                                                2nd
------------------------------------------------------------------------------------------------   ------------------------------------------------------------------------------------------------
Event                          Wait Class           Waits      Time(s)  Avg Time(ms)    %DB time   Event                          Wait Class           Waits      Time(s)  Avg Time(ms)    %DB time
------------------------------ ------------- ------------ ------------ ------------- -----------   ------------------------------ ------------- ------------ ------------ ------------- -----------
 db file sequential read       User I/O           521,361      4,575.0           8.8        71.4    db file sequential read       User I/O           772,553      9,350.5          12.1        74.1
 CPU time                                             N/A      1,701.4           N/A        26.6    CPU time                                             N/A      2,876.5           N/A        22.8
 log file sync                 Commit             182,739         94.4           0.5         1.5    log file sync                 Commit             256,684        266.8           1.0         2.1
 log file parallel write       System I/O         178,857         38.8           0.2         0.6    log file parallel write       System I/O         242,510        105.0           0.4         0.8
 read by other session         User I/O             2,754         27.0           9.8         0.4    read by other session         User I/O             4,219         51.5          12.2         0.4
                          --------------------------------------------------------------------------------------------------------------------
Time Model Statistics   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of 'Diff' column of '% of DB time', descending (DB time statistic first, background statistics last)

                                                               % of DB time                               Time (seconds)                        Time per Trans (seconds)
                                                ------------------------------------------   ----------------------------------------   ----------------------------------------
Statistic Name                                             1st            2nd         Diff              1st            2nd      %Diff              1st            2nd      %Diff
---------------------------------------------   -------------- -------------- ------------   -------------- -------------- ----------   -------------- -------------- ----------
DB time                                                  100.0          100.0          0.0          6,404.5       12,612.5       96.9              0.0            0.0       66.7
DB CPU                                                    26.6           22.8         -3.8          1,701.4        2,876.5       69.1              0.0            0.0        0.0
sql execute elapsed time                                  95.5           95.3         -0.1          6,114.4       12,024.6       96.7              0.0            0.0       66.7
connection management call elapsed time                    0.0            0.1          0.1              0.0            7.4      100.0              0.0            0.0        0.0
parse time elapsed                                         0.4            0.5          0.0             26.9           57.1      112.4              0.0            0.0        0.0
hard parse elapsed time                                    0.0            0.0          0.0              0.0            3.6      100.0              0.0            0.0        0.0
hard parse (sharing criteria) elapsed time                 0.0            0.0          0.0              0.0            0.5      100.0              0.0            0.0        0.0
hard parse (bind mismatch) elapsed time                    0.0            0.0          0.0              0.0            0.5      100.0              0.0            0.0        0.0
PL/SQL compilation elapsed time                            0.0            0.0          0.0              0.0            0.3      100.0              0.0            0.0        0.0
sequence load elapsed time                                 0.0            0.0         -0.0              0.1            0.0     -100.0              0.0            0.0        0.0
PL/SQL execution elapsed time                              0.0            0.0          0.0              0.0            0.0      100.0              0.0            0.0        0.0
repeated bind elapsed time                                 0.0            0.0          0.0              0.0            0.0        0.0              0.0            0.0        0.0
Java execution elapsed time                                0.0            0.0          0.0              0.0            0.0        0.0              0.0            0.0        0.0
RMAN cpu time (backup/restore)                             0.0            0.0          0.0              0.0            0.0        0.0              0.0            0.0        0.0
failed parse (out of shared memory) elapsed t              0.0            0.0          0.0              0.0            0.0        0.0              0.0            0.0        0.0
failed parse elapsed time                                  0.0            0.0          0.0              0.0            0.0        0.0              0.0            0.0        0.0
inbound PL/SQL rpc elapsed time                            0.0            0.0          0.0              0.0            0.0        0.0              0.0            0.0        0.0
background cpu time                                        0.6            0.5         -0.1             38.7           62.1       60.4              0.0            0.0        0.0
background elapsed time                                    1.7            1.8          0.1            107.5          221.9      106.4              0.0            0.0        0.0
                          --------------------------------------------------------------------------------------------------------------------

Operating System Statistics   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by 'Statistic Name'

                                          Value (centi-seconds)                   per Second (DB time)                         per Second (Elapsed Time)                              per Trans
                                      -----------------------------   --------------------------------------------   --------------------------------------------   --------------------------------------------
Statistic Name                                   1st            2nd                1st              2nd      %Diff                1st              2nd      %Diff                1st              2nd      %Diff
-----------------------------------   -------------- --------------   ---------------- ---------------- ----------   ---------------- ---------------- ----------   ---------------- ---------------- ----------
BUSY_TIME                                    176,851        297,133               27.6             23.6      -14.7              196.2            329.1       67.8                1.0              1.2       19.8
GLOBAL_RECEIVE_SIZE_MAX                            0              0                0.0              0.0        0.0                0.0              0.0        0.0                0.0              0.0        0.0
GLOBAL_SEND_SIZE_MAX                               0              0                0.0              0.0        0.0                0.0              0.0        0.0                0.0              0.0        0.0
IDLE_TIME                                    524,631        412,759               81.9             32.7      -60.0              581.9            457.2      -21.4                2.9              1.6      -44.1
IOWAIT_TIME                                  152,976        216,362               23.9             17.2      -28.2              169.7            239.6       41.2                0.8              0.8        1.2
NICE_TIME                                         35             99                0.0              0.0        0.0                0.0              0.1      175.0                0.0              0.0        0.0
RSRC_MGR_CPU_WAIT_TIME                             0              0                0.0              0.0        0.0                0.0              0.0        0.0                0.0              0.0        0.0
SYS_TIME                                       6,268         10,170                1.0              0.8      -17.3                7.0             11.3       62.0                0.0              0.0       33.3
TCP_RECEIVE_SIZE_DEFAULT                           0              0                0.0              0.0        0.0                0.0              0.0        0.0                0.0              0.0        0.0
TCP_RECEIVE_SIZE_MAX                               0              0                0.0              0.0        0.0                0.0              0.0        0.0                0.0              0.0        0.0
TCP_RECEIVE_SIZE_MIN                               0              0                0.0              0.0        0.0                0.0              0.0        0.0                0.0              0.0        0.0
TCP_SEND_SIZE_DEFAULT                              0              0                0.0              0.0        0.0                0.0              0.0        0.0                0.0              0.0        0.0
TCP_SEND_SIZE_MAX                                  0              0                0.0              0.0        0.0                0.0              0.0        0.0                0.0              0.0        0.0
TCP_SEND_SIZE_MIN                                  0              0                0.0              0.0        0.0                0.0              0.0        0.0                0.0              0.0        0.0
USER_TIME                                    166,878        281,270               26.1             22.3      -14.4              185.1            311.5       68.3                0.9              1.1       19.8
VM_IN_BYTES                                        0              0                0.0              0.0        0.0                0.0              0.0        0.0                0.0              0.0        0.0
VM_OUT_BYTES                                       0              0                0.0              0.0        0.0                0.0              0.0        0.0                0.0              0.0        0.0
                          --------------------------------------------------------------------------------------------------------------------

Wait Classes   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of  'Diff' column of '% of DB time' descending

                               % of DB time                        # Waits/sec (Elapsed Time)                    Total Wait Time (sec)                       Avg Wait Time (ms)
                 ----------------------------------------   ----------------------------------------   ----------------------------------------   ----------------------------------------
Wait Class                  1st            2nd       Diff              1st            2nd      %Diff              1st            2nd      %Diff              1st            2nd      %Diff
--------------   -------------- -------------- ----------   -------------- -------------- ----------   -------------- -------------- ----------   -------------- -------------- ----------
User I/O                   71.9           74.6        2.7            581.6          860.8       48.0          4,604.2        9,403.7      104.2              8.8           12.1       37.8
Commit                      1.5            2.1        0.6            202.7          284.3       40.3             94.4          266.8      182.6              0.5            1.0      100.0
System I/O                  0.9            1.1        0.2            231.8          318.9       37.6             58.8          143.2      143.6              0.3            0.5       78.6
Concurrency                 0.0            0.1        0.1              1.2            3.0      156.8              0.9           11.5    1,241.9              0.8            4.2      419.8
Configuration               0.1            0.2        0.1              0.2            0.5      147.4              4.9           19.2      290.2             28.4           45.7       60.8
Network                     0.0            0.0       -0.0          1,573.4        2,200.1       39.8              2.5            3.8       54.4              0.0            0.0        0.0
Application                 0.0            0.0        0.0              0.8            1.4       78.9              0.8            2.2      175.0              1.2            1.8       53.0
Other                       0.0            0.0        0.0              1.8            4.1      125.3              0.5            1.2      163.8              0.3            0.3       17.9
                          --------------------------------------------------------------------------------------------------------------------

Wait Events   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of  'Diff' column of '% of DB time' descending (idle events last)

                                                              % of DB time                        # Waits/sec (Elapsed Time)                    Total Wait Time (sec)                       Avg Wait Time (ms)
                                                ----------------------------------------   ----------------------------------------   ----------------------------------------   ----------------------------------------
Event                          Wait Class                  1st            2nd       Diff              1st            2nd      %Diff              1st            2nd      %Diff              1st            2nd      %Diff
------------------------------ --------------   -------------- -------------- ----------   -------------- -------------- ----------   -------------- -------------- ----------   -------------- -------------- ----------
db file sequential read        User I/O                   71.4           74.1        2.7            578.3          855.7       48.0          4,575.0        9,350.5      104.4              8.8           12.1       37.8
log file sync                  Commit                      1.5            2.1        0.6            202.7          284.3       40.3             94.4          266.8      182.6              0.5            1.0      100.0
log file parallel write        System I/O                  0.6            0.8        0.2            198.4          268.6       35.4             38.8          105.0      170.4              0.2            0.4       95.5
cursor: pin S wait on X        Concurrency                 0.0            0.1        0.1              0.0            0.1      100.0              0.0            7.7      100.0              0.0          103.5      100.0
log file switch (private stran Configuration               0.0            0.1        0.1              0.1            0.3      163.6              2.4           12.1      393.9             24.4           45.3       85.4
db file parallel write         System I/O                  0.2            0.2       -0.0             27.9           43.5       55.9             14.4           22.9       59.4              0.6            0.6        1.8
control file sequential read   System I/O                  0.1            0.1        0.0              3.0            3.1        5.7              5.3           14.4      173.8              2.0            5.1      159.2
log file switch (checkpoint in Configuration               0.0            0.1        0.0              0.1            0.2      100.0              2.5            7.0      184.6             33.9           47.5       40.2
db file scattered read         User I/O                    0.0            0.0       -0.0              0.1            0.1      -23.1              1.5            1.0      -35.3             12.4           11.0      -10.8
read by other session          User I/O                    0.4            0.4       -0.0              3.1            4.7       53.1             27.0           51.5       90.7              9.8           12.2       24.5
SQL*Net message to client      Network                     0.0            0.0       -0.0          1,573.4        2,200.1       39.8              2.5            3.8       54.4              0.0            0.0        0.0
library cache lock             Concurrency                 0.0            0.0        0.0              0.0            0.1      100.0              0.0            1.0      100.0              0.0           20.7      100.0
enq: TX - row lock contention  Application                 0.0            0.0        0.0              0.8            1.4       78.9              0.8            2.2      175.0              1.2            1.8       53.0
library cache load lock        Concurrency                 0.0            0.0        0.0              0.0            0.0      100.0              0.0            0.5      100.0              0.0           19.2      100.0
db file parallel read          User I/O                    0.0            0.0       -0.0              0.0            0.0      -40.0              0.4            0.3      -23.1              9.6           10.6       10.8
library cache: mutex X         Concurrency                 0.0            0.0        0.0              0.0            0.2      500.0              0.0            0.5    4,600.0              0.4            2.2      481.1
os thread startup              Concurrency                 0.0            0.0       -0.0              0.0            0.0        0.0              0.4            0.4        0.0             35.4           38.1        7.7
kksfbc child completion        Other                       0.0            0.0        0.0              0.0            0.0      100.0              0.0            0.3      100.0              0.0           51.1      100.0
enq: TX - index contention     Concurrency                 0.0            0.0        0.0              0.0            0.0      300.0              0.1            0.5      363.6             15.5           16.1        3.5
latch: cache buffers chains    Concurrency                 0.0            0.0        0.0              0.5            1.5      198.0              0.1            0.3      466.7              0.1            0.3      108.3
direct path read               User I/O                    0.0            0.0       -0.0              0.0            0.0      100.0              0.3            0.5       34.3             19.2           14.5      -24.3
cursor: pin S                  Concurrency                 0.0            0.0        0.0              0.0            0.1      133.3              0.1            0.3      440.0              1.9            4.2      115.4
control file parallel write    System I/O                  0.0            0.0        0.0              0.7            0.7        7.4              0.1            0.4      250.0              0.2            0.5      211.8
buffer busy waits              Concurrency                 0.0            0.0       -0.0              0.4            0.7       69.0              0.2            0.2       21.1              0.5            0.4      -26.5
LGWR wait for redo copy        Other                       0.0            0.0        0.0              0.9            2.9      217.4              0.1            0.2      360.0              0.1            0.1       28.6
ASM file metadata operation    Other                       0.0            0.0       -0.0              0.6            0.6        0.0              0.2            0.3       40.9              0.4            0.6       42.5
enq: HW - contention           Configuration               0.0            0.0        0.0              0.0            0.0        0.0              0.0            0.1      100.0              0.0           28.2      100.0
log file sequential read       System I/O                  0.0            0.0        0.0              0.0            0.1       20.0              0.2            0.6      137.5              5.4           10.2       90.1
enq: JS - queue lock           Other                       0.0            0.0       -0.0              0.0            0.0        0.0              0.1            0.0     -100.0             50.6            0.0     -100.0
latch free                     Other                       0.0            0.0        0.0              0.1            0.2      187.5              0.0            0.1      650.0              0.3            0.7      108.8
enq: TX - contention           Other                       0.0            0.0        0.0              0.0            0.0        0.0              0.0            0.1      100.0              0.0           69.4      100.0
ADR block file read            Other                       0.0            0.0       -0.0              0.0            0.0        0.0              0.1            0.1       22.2              5.4            6.6       21.7
row cache lock                 Concurrency                 0.0            0.0        0.0              0.0            0.0      100.0              0.0            0.0      100.0              0.0            2.7      100.0
latch: shared pool             Concurrency                 0.0            0.0        0.0              0.0            0.0      100.0              0.0            0.0      100.0              0.0            2.0      100.0
reliable message               Other                       0.0            0.0       -0.0              0.1            0.1      -40.0              0.0            0.0        0.0              0.1            0.2       28.6
latch: object queue header ope Other                       0.0            0.0        0.0              0.0            0.1      200.0              0.0            0.0      100.0              0.2            0.3       24.0
latch: redo allocation         Other                       0.0            0.0        0.0              0.0            0.0      400.0              0.0            0.0      100.0              0.1            0.3       86.7
latch: In memory undo latch    Concurrency                 0.0            0.0        0.0              0.2            0.3       64.7              0.0            0.0      150.0              0.1            0.2       50.0
Disk file operations I/O       User I/O                    0.0            0.0        0.0              0.1            0.2      144.4              0.0            0.0      100.0              0.1            0.1       14.3
ADR block file write           Other                       0.0            0.0       -0.0              0.0            0.0        0.0              0.0            0.0        0.0              0.7            0.5      -25.8
latch: cache buffers lru chain Other                       0.0            0.0        0.0              0.0            0.0      100.0              0.0            0.0      100.0              0.1            0.3      177.8
enq: CU - contention           Other                       0.0            0.0        0.0              0.0            0.0        0.0              0.0            0.0        0.0              0.0            3.7      100.0
direct path write              User I/O                    0.0            0.0        0.0              0.0            0.0      200.0              0.0            0.0      100.0              0.1            0.2       71.4
CSS initialization             Other                       0.0            0.0       -0.0              0.0            0.0        0.0              0.0            0.0      100.0              4.7            6.6       40.2
latch: enqueue hash chains     Other                       0.0            0.0        0.0              0.0            0.0       50.0              0.0            0.0      100.0              0.2            0.3       34.8
latch: row cache objects       Concurrency                 0.0            0.0        0.0              0.0            0.0      100.0              0.0            0.0        0.0              0.0            0.3      100.0
log file single write          System I/O                  0.0            0.0       -0.0              0.0            0.1       20.0              0.0            0.0      100.0              0.1            0.1       25.0
db file async I/O submit       System I/O                  0.0            0.0       -0.0              1.7            2.8       65.1              0.0            0.0      100.0              0.0            0.0        0.0
latch: redo writing            Configuration               0.0            0.0        0.0              0.0            0.0        0.0              0.0            0.0        0.0              0.0            0.3      100.0
CSS operation: action          Other                       0.0            0.0       -0.0              0.0            0.0        0.0              0.0            0.0        0.0              1.0            1.6       62.4
latch: session allocation      Other                       0.0            0.0        0.0              0.0            0.0        0.0              0.0            0.0        0.0              0.0            0.2      100.0
CSS operation: query           Other                       0.0            0.0       -0.0              0.0            0.0        0.0              0.0            0.0        0.0              0.1            0.1       33.3
latch: undo global data        Other                       0.0            0.0       -0.0              0.0            0.0      100.0              0.0            0.0        0.0              0.2            0.2      -21.7
latch: checkpoint queue latch  Other                       0.0            0.0       -0.0              0.0            0.0        0.0              0.0            0.0        0.0              0.1            0.0      -69.2
latch: messages                Other                       0.0            0.0       -0.0              0.0            0.0        0.0              0.0            0.0        0.0              0.2            0.2       11.8
ADR file lock                  Other                       0.0            0.0       -0.0              0.0            0.0        0.0              0.0            0.0        0.0              0.0            0.0        0.0
asynch descriptor resize       Other                       0.0            0.0        0.0              0.0            0.1      133.3              0.0            0.0        0.0              0.0            0.0        0.0
SQL*Net message from client    Idle                      252.0          181.0      -71.0          1,573.4        2,200.1       39.8         16,140.8       22,827.1       41.4             11.4           11.5        1.0
Space Manager: slave idle wait Idle                       45.8           17.1      -28.7              0.7            0.5      -25.4          2,935.3        2,154.9      -26.6          4,835.7        4,778.0       -1.2
class slave wait               Idle                       56.3           28.7      -27.6              0.3            0.3       15.4          3,605.8        3,620.5        0.4         15,343.8       13,559.8      -11.6
Wait Events   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of  'Diff' column of '% of DB time' descending (idle events last)

                                                              % of DB time                        # Waits/sec (Elapsed Time)                    Total Wait Time (sec)                       Avg Wait Time (ms)
                                                ----------------------------------------   ----------------------------------------   ----------------------------------------   ----------------------------------------
Event                          Wait Class                  1st            2nd       Diff              1st            2nd      %Diff              1st            2nd      %Diff              1st            2nd      %Diff
------------------------------ --------------   -------------- -------------- ----------   -------------- -------------- ----------   -------------- -------------- ----------   -------------- -------------- ----------
DIAG idle wait                 Idle                       28.1           14.4      -13.8              2.0            2.0        0.0          1,802.0        1,810.6        0.5          1,001.1        1,001.4        0.0
Streams AQ: qmn slave idle wai Idle                       14.1            7.2       -6.9              0.1            0.1        0.0            903.2          902.1       -0.1          7,001.5        6,993.2       -0.1
Streams AQ: qmn coordinator id Idle                       14.1            7.2       -6.9              0.3            0.3       -3.0            903.3          902.3       -0.1          3,000.8        3,111.3        3.7
wait for unread message on bro Idle                       14.1            7.2       -6.9              1.0            1.0        0.0            901.0          905.4        0.5          1,001.1        1,001.5        0.0
ASM background timer           Idle                       14.1            7.2       -6.9              0.2            0.2        0.0            900.1          905.5        0.6          5,000.4        5,002.8        0.0
jobq slave wait                Idle                        0.9            0.5       -0.5              0.1            0.1        0.0             60.1           60.1        0.0            501.0          501.0       -0.0
KSV master wait                Idle                        0.0            0.0       -0.0              0.1            0.1       25.0              0.0            0.0        0.0              0.1            0.1       44.4
                          --------------------------------------------------------------------------------------------------------------------

Service Statistics   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of 'Diff' column of '% of DB time' descending
-> DB time         First:                        6,404.55 seconds, Second:                       12,612.51 seconds
-> CPU Time        First:                        1,701.44 seconds, Second:                        2,876.51 seconds
-> Physical Reads  First:                      522,880, Second:                      774,075
-> Logical Reads   First:                  366,396,963, Second:                  586,033,175

                                            % of DB time                     % CPU Time                   % Physical Reads                % Logical Reads
                                   -----------------------------   -----------------------------   -----------------------------   -----------------------------
Service Name                             1st       2nd      Diff         1st       2nd      Diff         1st       2nd      Diff         1st       2nd      Diff
--------------------------------   --------- --------- ---------   --------- --------- ---------   --------- --------- ---------   --------- --------- ---------
DBM11203.antognini.ch                   99.9      99.7      -0.2       100.0      99.8      -0.2        99.4      99.5       0.0       100.1      99.9      -0.1
SYS$USERS                                0.1       0.1      -0.0         0.0       0.0       0.0         0.1       0.1       0.0         0.0       0.0       0.0
SYS$BACKGROUND                           0.0       0.0       0.0         0.0       0.0       0.0         0.5       0.3      -0.2         0.0       0.0       0.0
                          --------------------------------------------------------------------------------------------------------------------

Service Statistics (RAC)   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by total Diff of '% of CR Blocks Received' and '% of Current Blocks Received'
-> GC CR Blks Received      First:                            1, Second:                            1
-> GC CURRENT Blks Received First:                            1, Second:                            1

                                         % CR Blks Received           % Current Blks Received
                                   -----------------------------   -----------------------------   ---------
Service Name                             1st       2nd      Diff         1st       2nd      Diff   Total Dif
--------------------------------   --------- --------- ---------   --------- --------- ---------   ---------
DBM11203.antognini.ch                    0.0       0.0       0.0         0.0       0.0       0.0         0.0
SYS$BACKGROUND                           0.0       0.0       0.0         0.0       0.0       0.0         0.0
SYS$USERS                                0.0       0.0       0.0         0.0       0.0       0.0         0.0
                          --------------------------------------------------------------------------------------------------------------------

Top SQL Comparison by Elapsed Time   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of 'Diff' column of 'Elapsed Time % of DB time' descending
-> '#Plans' column indicates the number of distinct execution plans for the statement in 1st and 2nd periods and in Both periods combined
-> '1st Total' and '2nd Total' show respective running totals for '1st' and '2nd' columns of 'Elapsed Time % of DB time'
-> DB time                                      First:                        6,404.55 seconds, Second:                       12,612.51 seconds
-> Captured SQL Elapsed Time                    First:                        6,104.90 seconds, Second:                       11,256.73 seconds
-> Captured SQL Elapsed Time as a % of DB time  First: 95.32%, Second: 89.25%
-> Captured PL/SQL Elapsed Time as a % of DB time  First: .08%, Second: .1%
-> Common SQL Elapsed Time as a % of DB time    First: 89.11%, Second: 89.22%
-> 'N/A' indicates no data was captured for the statement in the period

                                       Elapsed Time % of DB time                         Elapsed Time (ms) per Exec    #Exec/sec (DB time)      CPU Time (ms) per Exec      I/O Time (ms) per Exec    Physical Reads per Exec      #Rows Processed per Exec            #Executions             #Plans
                ----------------------------------------------------------------------   -------------------------   ---------------------   -------------------------   -------------------------   ---------------------   -----------------------------   -------------------------   ------------
SQL Id                     1st      1st Total            2nd      2nd Total       Diff            1st          2nd          1st        2nd            1st          2nd            1st          2nd          1st        2nd              1st            2nd            1st          2nd   1st/2nd/Both
-------------   -------------- -------------- -------------- -------------- ----------   ------------ ------------   ---------- ----------   ------------ ------------   ------------ ------------   ---------- ----------   -------------- --------------   ------------ ------------   ------------
9bz9sa0abpc48              6.2            6.2            N/A            N/A       -6.2             27          N/A          2.3        N/A              1          N/A             27          N/A          3.2        N/A              1.0            N/A         14,671          N/A
insert into customers (customer_id ,cust_first_name ,cust_last_name ,nls_language ,nls_territory ,credit_limit ,cust_email ,account_mgr_id ) values (:1 , :2 , :3 , :4 , :5 , :6 ,:7 , :8 )

g8rhybcumtwd6             21.1           27.3           18.4           18.4       -2.7            191          222          1.1        0.8            175          205             13           11          1.1        0.6             10.0           10.0          7,086       10,442     1/  1/   1
SELECT /*+ first_rows index(customers, customers_pk) index(orders, order_status_ix) */ o.order_id, line_item_id, product_id, unit_price, quantity, order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_firs
t_name, cust_last_name, credit_limit, cust_email, order_date FROM orders o , order_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id = c.customer_id and o.order_status <= 4

8vvvyuun2urt6              9.2           36.5           10.5           28.9        1.4              6            9         16.4       11.7              0            0              5            9          0.6        0.8              1.0            1.0        105,252      147,058
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY) values (:1 , :2 , :3 , :4 , :5 )

5g00dq4fxwnsw              6.8           43.3            8.0           36.9        1.2              4            7         16.4       11.7              0            0              4            7          0.5        0.6              0.9            0.9        105,254      147,054     1/  1/   1
update inventories set quantity_on_hand = quantity_on_hand - :1 where product_id = :2 and warehouse_id = :3

2yp5w5a36s5xv              1.6           44.9            2.6           39.5        0.9              3            6          5.8        4.1              0            0              3            6          0.3        0.5              1.0            1.0         36,853       51,945     1/  1/   1
update orders set order_mode = :1 , order_status = :2 , order_total = :3 where order_id = :4

82ud5h0qcg0bf             29.1           74.0           28.7           68.2       -0.3             15           21         19.5       14.0              0            0             15           20          1.6        1.5              1.0            1.0        124,882      176,182     1/  1/   1
select customer_id, cust_first_name ,cust_last_name ,nls_language ,nls_territory ,credit_limit ,cust_email ,account_mgr_id from customers where customer_id = :1

gyk686gnaygs2              0.8           74.8            0.7           68.9       -0.1              0            0         34.4       24.7              0            0              0            0          0.0        0.0              5.0            5.0        220,441      311,130     1/  1/   1
select product_id, product_name, product_description, category_id, weight_class, supplier_id, product_status list_price, min_price, catalog_url from product_information where category_id = :1

9zd49du11u7cf             10.2           85.0           10.2           79.1        0.1             18           25          5.8        4.1              1            1             17           24          1.9        1.9              1.0            1.0         36,852       51,948
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) values (:1 , :2 , :3 , :4 )

gshgncvvtv0c6              0.4           85.3            0.3           79.4       -0.0              0            0         19.5       14.0              0            0              0            0          0.0        0.0              1.0            1.0        124,883      176,186
insert into logon values(:1 ,:2 )

gfqas5ahy1x56              0.7           86.0            0.7           80.1       -0.0              1            2          5.8        4.1              0            0              1            1          0.1        0.1              2.9            2.8         36,854       51,947     1/  1/   1
SELECT o.order_id, line_item_id, product_id, unit_price, quantity, order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_first_name, cust_last_name, credit_limit, cust_email FRO
M orders o , order_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id = c.customer_id and o.order_id = :1

d5j6fbqmu3gjp              8.2           94.3            8.2           88.3       -0.0             14           20          5.7        4.1              0            0             14           20          1.8        1.8              0.9            1.0         36,752       51,887     1/  1/   1
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_price, quantity, order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_first_name, cust_last_name, credit_limit, cust_email FROM orders o , o
rder_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id = c.customer_id and c.customer_id = :1

                          --------------------------------------------------------------------------------------------------------------------

Top SQL Comparison by CPU Time   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of the 'Diff' column of 'CPU % of DB CPU' descending
-> '#Plans' column indicates the number of distinct execution plans for the statement in 1st and 2nd periods and in Both periods combined
-> '1st Total' and '2nd Total' show respective running totals for '1st' and '2nd' columns of 'CPU Time % of DB CPU'
-> Total CPU Time         First:                        1,701.44 seconds, Second:                        2,876.51 seconds
-> Captured SQL CPU Time  First:                        1,481.33 seconds, Second:                        2,522.68 seconds
-> Captured SQL as a % of Total CPU         First: 87.06%, Second: 87.7%
-> Captured PL/SQL as a % of Total CPU         First: .05%, Second: .06%
-> Common SQL as a % of Total CPU           First: 86.48%, Second: 87.74%
-> 'N/A' indicates no data was captured for the statement in the period

                                         CPU Time % of DB CPU                              CPU Time (ms) per Exec      I/O Time (ms) per Exec     #Exec/sec (DB time)     Exec Time (ms) per Exec    Physical Reads per Exec      #Rows Processed per Exec        #Plans
                ----------------------------------------------------------------------   -------------------------   -------------------------   ---------------------   -------------------------   ---------------------   -----------------------------   ------------
SQL Id                     1st      1st Total            2nd      2nd Total       Diff            1st          2nd            1st          2nd          1st        2nd            1st          2nd          1st        2nd              1st            2nd   1st/2nd/Both
-------------   -------------- -------------- -------------- -------------- ----------   ------------ ------------   ------------ ------------   ---------- ----------   ------------ ------------   ---------- ----------   -------------- --------------   ------------
g8rhybcumtwd6             72.9           72.9           74.5           74.5        1.7            175          205             13           11          1.1        0.8            191          222          1.1        0.6             10.0           10.0     1/  1/   1
SELECT /*+ first_rows index(customers, customers_pk) index(orders, order_status_ix) */ o.order_id, line_item_id, product_id, unit_price, quantity, order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_firs
t_name, cust_last_name, credit_limit, cust_email, order_date FROM orders o , order_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id = c.customer_id and o.order_status <= 4

gyk686gnaygs2              2.7           75.6            2.6           77.1       -0.2              0            0              0            0         34.4       24.7              0            0          0.0        0.0              5.0            5.0     1/  1/   1
select product_id, product_name, product_description, category_id, weight_class, supplier_id, product_status list_price, min_price, catalog_url from product_information where category_id = :1

82ud5h0qcg0bf              1.9           77.5            1.8           78.9       -0.1              0            0             15           20         19.5       14.0             15           21          1.6        1.5              1.0            1.0     1/  1/   1
select customer_id, cust_first_name ,cust_last_name ,nls_language ,nls_territory ,credit_limit ,cust_email ,account_mgr_id from customers where customer_id = :1

7v0pya6f6qc6s              0.7           78.2            0.6           79.6       -0.1              0            0              0            0         17.2       12.3              0            0          0.0        0.0             10.0           10.0     1/  1/   1
select p.product_id, product_name, product_description, category_id, weight_class, supplier_id, product_status, list_price, min_price, catalog_url, quantity_on_hand, warehouse_id from product_information p, inventories i where categor
y_id = :1 and i.product_id = p.product_id

dt8dtzvsq5kj5              0.6           78.8            0.6           80.2       -0.0              0            0              0            0         16.4       11.7              0            0          0.0        0.0             10.0           10.0     1/  1/   1
select p.product_id, product_name, product_description, category_id, weight_class, supplier_id, product_status, list_price, min_price, catalog_url, quantity_on_hand, warehouse_id from product_information p, inventories i where i.produ
ct_id = :1 and i.product_id = p.product_id

5g00dq4fxwnsw              0.9           79.7            0.9           81.1        0.0              0            0              4            7         16.4       11.7              4            7          0.5        0.6              0.9            0.9     1/  1/   1
update inventories set quantity_on_hand = quantity_on_hand - :1 where product_id = :2 and warehouse_id = :3

2yp5w5a36s5xv              0.6           80.3            0.7           81.7        0.0              0            0              3            6          5.8        4.1              3            6          0.3        0.5              1.0            1.0     1/  1/   1
update orders set order_mode = :1 , order_status = :2 , order_total = :3 where order_id = :4

gshgncvvtv0c6              1.0           81.3            1.0           82.7       -0.0              0            0              0            0         19.5       14.0              0            0          0.0        0.0              1.0            1.0
insert into logon values(:1 ,:2 )

8vvvyuun2urt6              1.8           83.1            1.8           84.5        0.0              0            0              5            9         16.4       11.7              6            9          0.6        0.8              1.0            1.0
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY) values (:1 , :2 , :3 , :4 , :5 )

9zd49du11u7cf              1.2           84.3            1.2           85.7       -0.0              1            1             17           24          5.8        4.1             18           25          1.9        1.9              1.0            1.0
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) values (:1 , :2 , :3 , :4 )

d5j6fbqmu3gjp              0.7           85.1            0.7           86.5       -0.0              0            0             14           20          5.7        4.1             14           20          1.8        1.8              0.9            1.0     1/  1/   1
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_price, quantity, order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_first_name, cust_last_name, credit_limit, cust_email FROM orders o , o
rder_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id = c.customer_id and c.customer_id = :1

                          --------------------------------------------------------------------------------------------------------------------

Top SQL Comparison by I/O Time   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of 'Diff' column of 'I/O Time % of DB time' descending
-> '#Plans' column indicates the number of distinct execution plans for the statement in 1st and 2nd periods and in Both periods combined
-> '1st Total' and '2nd Total' show respective running totals for '1st' and '2nd' columns of 'I/O Time % of DB time'
-> User I/O Class Wait Time as a % of DB time  First: 71.89%, Second: 74.56%
-> Total User I/O Time    First:                        4,604.22 seconds, Second:                        9,403.75 seconds
-> Captured SQL I/O Time  First:                        4,596.59 seconds, Second:                        8,647.47 seconds
-> Captured SQL as a % of Total User I/O    First: 99.83%, Second: 91.96%
-> Captured PL/SQL as a % of Total User I/O    First: .1%, Second: .08%
-> Common SQL as a % of Total User I/O      First: 91.3%, Second: 91.89%
-> 'N/A' indicates no data was captured for the statement in the period

                                         I/O Time % of DB time                             I/O Time (ms) per Exec    Elapsed Time (ms) per Exec    #Exec/sec (DB time)      CPU Time (ms) per Exec    Physical Reads per Exec      #Rows Processed per Exec            #Executions             #Plans
                ----------------------------------------------------------------------   -------------------------   -------------------------   ---------------------   -------------------------   ---------------------   -----------------------------   -------------------------   ------------
SQL Id                     1st      1st Total            2nd      2nd Total       Diff            1st          2nd            1st          2nd          1st        2nd            1st          2nd          1st        2nd              1st            2nd            1st          2nd   1st/2nd/Both
-------------   -------------- -------------- -------------- -------------- ----------   ------------ ------------   ------------ ------------   ---------- ----------   ------------ ------------   ---------- ----------   -------------- --------------   ------------ ------------   ------------
9bz9sa0abpc48              6.1            6.1            N/A            N/A       -6.1             27          N/A             27          N/A          2.3        N/A              1          N/A          3.2        N/A              1.0            N/A         14,671          N/A
insert into customers (customer_id ,cust_first_name ,cust_last_name ,nls_language ,nls_territory ,credit_limit ,cust_email ,account_mgr_id ) values (:1 , :2 , :3 , :4 , :5 , :6 ,:7 , :8 )

8vvvyuun2urt6              8.7           14.8           10.1           10.1        1.4              5            9              6            9         16.4       11.7              0            0          0.6        0.8              1.0            1.0        105,252      147,058
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY) values (:1 , :2 , :3 , :4 , :5 )

5g00dq4fxwnsw              6.6           21.3            7.8           17.9        1.2              4            7              4            7         16.4       11.7              0            0          0.5        0.6              0.9            0.9        105,254      147,054     1/  1/   1
update inventories set quantity_on_hand = quantity_on_hand - :1 where product_id = :2 and warehouse_id = :3

2yp5w5a36s5xv              1.5           22.8            2.4           20.3        0.9              3            6              3            6          5.8        4.1              0            0          0.3        0.5              1.0            1.0         36,853       51,945     1/  1/   1
update orders set order_mode = :1 , order_status = :2 , order_total = :3 where order_id = :4

g8rhybcumtwd6              1.4           24.2            0.9           21.2       -0.5             13           11            191          222          1.1        0.8            175          205          1.1        0.6             10.0           10.0          7,086       10,442     1/  1/   1
SELECT /*+ first_rows index(customers, customers_pk) index(orders, order_status_ix) */ o.order_id, line_item_id, product_id, unit_price, quantity, order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_firs
t_name, cust_last_name, credit_limit, cust_email, order_date FROM orders o , order_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id = c.customer_id and o.order_status <= 4

82ud5h0qcg0bf             28.7           52.8           28.4           49.6       -0.3             15           20             15           21         19.5       14.0              0            0          1.6        1.5              1.0            1.0        124,882      176,182     1/  1/   1
select customer_id, cust_first_name ,cust_last_name ,nls_language ,nls_territory ,credit_limit ,cust_email ,account_mgr_id from customers where customer_id = :1

9zd49du11u7cf              9.9           62.7            9.9           59.5        0.1             17           24             18           25          5.8        4.1              1            1          1.9        1.9              1.0            1.0         36,852       51,948
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) values (:1 , :2 , :3 , :4 )

d5j6fbqmu3gjp              8.1           70.8            8.1           67.6        0.0             14           20             14           20          5.7        4.1              0            0          1.8        1.8              0.9            1.0         36,752       51,887     1/  1/   1
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_price, quantity, order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_first_name, cust_last_name, credit_limit, cust_email FROM orders o , o
rder_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id = c.customer_id and c.customer_id = :1

gfqas5ahy1x56              0.6           71.3            0.6           68.2        0.0              1            1              1            2          5.8        4.1              0            0          0.1        0.1              2.9            2.8         36,854       51,947     1/  1/   1
SELECT o.order_id, line_item_id, product_id, unit_price, quantity, order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_first_name, cust_last_name, credit_limit, cust_email FRO
M orders o , order_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id = c.customer_id and o.order_id = :1

gshgncvvtv0c6              0.0           71.4            0.1           68.2        0.0              0            0              0            0         19.5       14.0              0            0          0.0        0.0              1.0            1.0        124,883      176,186
insert into logon values(:1 ,:2 )

gyk686gnaygs2              0.0           71.4            0.0           68.2        0.0              0            0              0            0         34.4       24.7              0            0          0.0        0.0              5.0            5.0        220,441      311,130     1/  1/   1
select product_id, product_name, product_description, category_id, weight_class, supplier_id, product_status list_price, min_price, catalog_url from product_information where category_id = :1

                          --------------------------------------------------------------------------------------------------------------------

Top SQL Comparison by Buffer Gets   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of 'Diff' column of '% Total Gets' descending
-> '#Plans' column indicates the number of distinct execution plans for the statement in 1st and 2nd periods and in Both periods combined
-> '1st Total' and '2nd Total' show respective running totals for '1st' and '2nd' columns of '% Total Gets'
-> Total SQL Buffer Gets                First:                 366,396,963, Second:                  586,033,175
-> Captured SQL Buffer Gets             First:                 365,485,842, Second:                   18,920,374
-> Captured SQL % of Total Buffer Gets  First: 99.75%, Second: 3.23%
-> Common SQL % of Total Buffer Gets    First: 99.65%, Second: 3.23%
-> 'N/A' indicates no data was captured for the statement in the period

                                     % Total Gets                            Gets per Exec              #Executions           Exec Time (ms) per Exec      CPU Time (ms) per Exec      I/O Time (ms) per Exec    Physical Reads per Exec      #Rows Processed per Exec        #Plans
                ------------------------------------------------------   ---------------------   -------------------------   -------------------------   -------------------------   -------------------------   ---------------------   -----------------------------   ------------
SQL Id                 1st  1st Total        2nd  2nd Total       Diff          1st        2nd            1st          2nd            1st          2nd            1st          2nd            1st          2nd          1st        2nd              1st            2nd   1st/2nd/Both
-------------   ---------- ---------- ---------- ---------- ----------   ---------- ----------   ------------ ------------   ------------ ------------   ------------ ------------   ------------ ------------   ---------- ----------   -------------- --------------   ------------
g8rhybcumtwd6         96.0       96.0        0.0        0.0      -96.0     49,626.7        0.0          7,086       10,442            191          222            175          205             13           11          1.1        0.6             10.0           10.0     1/  1/   1
SELECT /*+ first_rows index(customers, customers_pk) index(orders, order_status_ix) */ o.order_id, line_item_id, product_id, unit_price, quantity, order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_firs
t_name, cust_last_name, credit_limit, cust_email, order_date FROM orders o , order_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id = c.customer_id and o.order_status <= 4

gyk686gnaygs2          1.8       97.8        1.6        1.6       -0.2         30.0       30.0        220,441      311,130              0            0              0            0              0            0          0.0        0.0              5.0            5.0     1/  1/   1
select product_id, product_name, product_description, category_id, weight_class, supplier_id, product_status list_price, min_price, catalog_url from product_information where category_id = :1

8vvvyuun2urt6          0.4       98.2        0.3        1.9       -0.0         13.3       13.3        105,252      147,058              6            9              0            0              5            9          0.6        0.8              1.0            1.0
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY) values (:1 , :2 , :3 , :4 , :5 )

gshgncvvtv0c6          0.2       98.4        0.2        2.1       -0.0          6.0        5.8        124,883      176,186              0            0              0            0              0            0          0.0        0.0              1.0            1.0
insert into logon values(:1 ,:2 )

dt8dtzvsq5kj5          0.2       98.6        0.2        2.3       -0.0          7.1        7.1        105,252      147,059              0            0              0            0              0            0          0.0        0.0             10.0           10.0     1/  1/   1
select p.product_id, product_name, product_description, category_id, weight_class, supplier_id, product_status, list_price, min_price, catalog_url, quantity_on_hand, warehouse_id from product_information p, inventories i where i.produ
ct_id = :1 and i.product_id = p.product_id

9zd49du11u7cf          0.2       98.8        0.2        2.4       -0.0         19.0       18.8         36,852       51,948             18           25              1            1             17           24          1.9        1.9              1.0            1.0
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) values (:1 , :2 , :3 , :4 )

7v0pya6f6qc6s          0.2       99.0        0.2        2.6       -0.0          7.1        7.1        109,862      155,252              0            0              0            0              0            0          0.0        0.0             10.0           10.0     1/  1/   1
select p.product_id, product_name, product_description, category_id, weight_class, supplier_id, product_status, list_price, min_price, catalog_url, quantity_on_hand, warehouse_id from product_information p, inventories i where categor
y_id = :1 and i.product_id = p.product_id

gfqas5ahy1x56          0.1       99.1        0.1        2.7       -0.0         13.2       12.5         36,854       51,947              1            2              0            0              1            1          0.1        0.1              2.9            2.8     1/  1/   1
SELECT o.order_id, line_item_id, product_id, unit_price, quantity, order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_first_name, cust_last_name, credit_limit, cust_email FRO
M orders o , order_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id = c.customer_id and o.order_id = :1

82ud5h0qcg0bf          0.1       99.2        0.1        2.9       -0.0          4.0        4.0        124,882      176,182             15           21              0            0             15           20          1.6        1.5              1.0            1.0     1/  1/   1
select customer_id, cust_first_name ,cust_last_name ,nls_language ,nls_territory ,credit_limit ,cust_email ,account_mgr_id from customers where customer_id = :1

5g00dq4fxwnsw          0.1       99.4        0.1        3.0       -0.0          3.9        3.9        105,254      147,054              4            7              0            0              4            7          0.5        0.6              0.9            0.9     1/  1/   1
update inventories set quantity_on_hand = quantity_on_hand - :1 where product_id = :2 and warehouse_id = :3

2yp5w5a36s5xv          0.1       99.5        0.1        3.1       -0.0         10.1       10.3         36,853       51,945              3            6              0            0              3            6          0.3        0.5              1.0            1.0     1/  1/   1
update orders set order_mode = :1 , order_status = :2 , order_total = :3 where order_id = :4

                          --------------------------------------------------------------------------------------------------------------------

Top SQL Comparison by Physical Reads   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by 'Diff' column of '% Total Physical Reads' descending
-> '#Plans' column indicates the number of distinct execution plans for the statement in 1st and 2nd periods and in Both periods, combined
-> '1st Total' and '2nd Total' show respective running totals for '1st' and '2nd' columns of '% Total Physical Reads'
-> User I/O Class Wait Time as a % of DB time  First: 71.89%, Second: 74.56%
-> Physical Reads                              First:                      522,880, Second:                      774,075
-> Captured SQL Physical Reads                 First:                      521,300, Second:                      704,198
-> Captured SQL % of Total Physical Reads        First: 99.7%, Second: 90.97%
-> Common SQL % of Total Physical Reads          First: 90.49%, Second: 90.9%
-> 'N/A' indicates no data was captured for the statement in the period

                                       % Total Physical Reads                          Physical Reads per Exec          #Executions           Exec Time (ms) per Exec      CPU Time (ms) per Exec      I/O Time (ms) per Exec       #Rows Processed per Exec        #Plans
                --------------------------------------------------------------------   ---------------------   -------------------------   -------------------------   -------------------------   -------------------------   -----------------------------   ------------
SQL Id                     1st      1st Total            2nd      2nd Total     Diff          1st        2nd            1st          2nd            1st          2nd            1st          2nd            1st          2nd              1st            2nd   1st/2nd/Both
-------------   -------------- -------------- -------------- -------------- --------   ---------- ----------   ------------ ------------   ------------ ------------   ------------ ------------   ------------ ------------   -------------- --------------   ------------
9bz9sa0abpc48              9.0            9.0            N/A            N/A     -9.0          3.2        N/A         14,671          N/A             27          N/A              1          N/A             27          N/A              1.0            N/A
insert into customers (customer_id ,cust_first_name ,cust_last_name ,nls_language ,nls_territory ,credit_limit ,cust_email ,account_mgr_id ) values (:1 , :2 , :3 , :4 , :5 , :6 ,:7 , :8 )

82ud5h0qcg0bf             37.3           46.3           35.1           35.1     -2.1          1.6        1.5        124,882      176,182             15           21              0            0             15           20              1.0            1.0     1/  1/   1
select customer_id, cust_first_name ,cust_last_name ,nls_language ,nls_territory ,credit_limit ,cust_email ,account_mgr_id from customers where customer_id = :1

5g00dq4fxwnsw              9.2           55.5           10.7           45.8      1.5          0.5        0.6        105,254      147,054              4            7              0            0              4            7              0.9            0.9     1/  1/   1
update inventories set quantity_on_hand = quantity_on_hand - :1 where product_id = :2 and warehouse_id = :3

8vvvyuun2urt6             13.0           68.5           14.5           60.3      1.5          0.6        0.8        105,252      147,058              6            9              0            0              5            9              1.0            1.0
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY) values (:1 , :2 , :3 , :4 , :5 )

2yp5w5a36s5xv              2.1           70.6            3.3           63.7      1.2          0.3        0.5         36,853       51,945              3            6              0            0              3            6              1.0            1.0     1/  1/   1
update orders set order_mode = :1 , order_status = :2 , order_total = :3 where order_id = :4

g8rhybcumtwd6              1.5           72.1            0.8           64.5     -0.6          1.1        0.6          7,086       10,442            191          222            175          205             13           11             10.0           10.0     1/  1/   1
SELECT /*+ first_rows index(customers, customers_pk) index(orders, order_status_ix) */ o.order_id, line_item_id, product_id, unit_price, quantity, order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_firs
t_name, cust_last_name, credit_limit, cust_email, order_date FROM orders o , order_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id = c.customer_id and o.order_status <= 4

9zd49du11u7cf             13.5           85.6           12.9           77.5     -0.6          1.9        1.9         36,852       51,948             18           25              1            1             17           24              1.0            1.0
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) values (:1 , :2 , :3 , :4 )

d5j6fbqmu3gjp             12.5           98.2           12.2           89.6     -0.4          1.8        1.8         36,752       51,887             14           20              0            0             14           20              0.9            1.0     1/  1/   1
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_price, quantity, order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_first_name, cust_last_name, credit_limit, cust_email FROM orders o , o
rder_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id = c.customer_id and c.customer_id = :1

6k3uuf3g8pwh6              0.4           98.5            0.3           89.9     -0.1          0.3        0.2          7,082       10,442              3            4              0            0              3            3              1.0            1.0     1/  1/   1
update /*+ index(orders, order_pk) */ orders set order_status = :1 where order_id = :2

gfqas5ahy1x56              0.8           99.4            0.9           90.8      0.0          0.1        0.1         36,854       51,947              1            2              0            0              1            1              2.9            2.8     1/  1/   1
SELECT o.order_id, line_item_id, product_id, unit_price, quantity, order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_first_name, cust_last_name, credit_limit, cust_email FRO
M orders o , order_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id = c.customer_id and o.order_id = :1

9zus1m3s2675b              0.1           99.5            0.1           90.9      0.0        490.0      793.0              1            1          3,886        6,473            630        1,279          3,140        4,950              1.0            1.0
DECLARE job BINARY_INTEGER := :job; next_date TIMESTAMP WITH TIME ZONE := :mydate; broken BOOLEAN := FALSE; job_name VARCHAR2(30) := :job_name; job_subname VARCHAR2(30) := :job_subname; job_owner VARCHAR2(30) := :job_owner; job_start
TIMESTAMP WITH TIME ZONE := :job_start; job_scheduled_start TIMESTAMP WITH TIME ZONE := :job_scheduled_start; window_start TIMESTAMP WITH TIME ZONE := :window_start; window_end TIMESTAMP WITH TIME ZONE := :window_end; chain_id VARCHAR2(
14) := :chainid; credential_owner varchar2(30) := :credown; credential_name varchar2(30) := :crednam; destination_owner varchar2(30) := :destown; destination_name varchar2(30) := :destnam; job_dest_id varchar2(14) := :jdestid; log_i
d number := :log_id; BEGIN perfstat.statspack.snap(i_snap_level => 7); :mydate := next_date; IF broken THEN :b := 1; ELSE :b := 0; END IF; END;

                          --------------------------------------------------------------------------------------------------------------------

Top SQL Comparison by UnOptimized Read Requests   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by 'Diff' column of '% Total UnOptimized Read Requests descending
-> '%Optimized Reads' shows percentage of read requests for the statement that were optimized in 1st and 2nd periods
-> '#Plans' column indicates the number of distinct execution plans for the statement in 1st and 2nd periods and in Both periods, combined
-> '1st Total' and '2nd Total' show respective running totals for '1st' and '2nd' columns of '% Total UnOptimized Read Requests'
-> User I/O Class Wait Time as a % of DB time    First: 71.89%, Second: 74.56%
-> Physical Read Requests                        First:                      521,753, Second:                      773,429
-> Captured SQL Physical Read Requests           First:                      478,936, Second:                      703,831
-> Captured SQL %of Total Physical Read Requests First: 91.79%, Second: 91%
-> Common SQL % of Total Physical Read Requests  First: 90.65%, Second: 90.94%
-> UnOptimized Read Requests                     First:                      521,753, Second:                      773,429
-> Captured SQL UnOptimized Read Requests        First:                      478,936, Second:                      703,831
-> Captured SQL % of Total UnOptimized Read Reqs First: 91.79%, Second: 91%
-> Common SQL % of Total UnOptimized Read Reqs   First: 90.65%, Second: 90.94%
-> Optimized Read Requests                       First:                            1, Second:                            1
-> Captured SQL Optimized Read Requests          First:                            0, Second:                            0
-> Captured SQL % of Total Optimized Read Reqs   First: 0%, Second: 0%
-> Common SQL % of Total Optimized Read Reqas    First: 0%, Second: 0%
-> 'N/A' indicates no data was captured for the statement in the period

                                  % Total UnOptimized Read Requests                    Read Requests per Exec     Total Read Requests       %Optimized Reads           #Executions           Exec Time (ms) per Exec      CPU Time (ms) per Exec      I/O Time (ms) per Exec       #Rows Processed per Exec        #Plans
                --------------------------------------------------------------------   ---------------------   -----------------------   -------------------   -------------------------   -------------------------   -------------------------   -------------------------   -----------------------------   ------------
SQL Id                     1st      1st Total            2nd      2nd Total     Diff          1st        2nd           1st         2nd         1st       2nd            1st          2nd            1st          2nd            1st          2nd            1st          2nd              1st            2nd   1st/2nd/Both
-------------   -------------- -------------- -------------- -------------- --------   ---------- ----------   ----------- -----------   --------- ---------   ------------ ------------   ------------ ------------   ------------ ------------   ------------ ------------   -------------- --------------   ------------
82ud5h0qcg0bf             37.3           37.3           35.2           35.2     -2.2          1.6        1.5       194,866     271,994         0.0       0.0        124,882      176,182             15           21              0            0             15           20              1.0            1.0     1/  1/   1
select customer_id, cust_first_name ,cust_last_name ,nls_language ,nls_territory ,credit_limit ,cust_email ,account_mgr_id from customers where customer_id = :1

5g00dq4fxwnsw              9.2           46.6           10.7           45.9      1.5          0.5        0.6        48,066      82,831         0.0       0.0        105,254      147,054              4            7              0            0              4            7              0.9            0.9     1/  1/   1
update inventories set quantity_on_hand = quantity_on_hand - :1 where product_id = :2 and warehouse_id = :3

8vvvyuun2urt6             13.0           59.6           14.5           60.4      1.5          0.6        0.8        68,010     112,210         0.0       0.0        105,252      147,058              6            9              0            0              5            9              1.0            1.0
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY) values (:1 , :2 , :3 , :4 , :5 )

2yp5w5a36s5xv              2.1           61.7            3.3           63.7      1.2          0.3        0.5        11,197      25,832         0.0       0.0         36,853       51,945              3            6              0            0              3            6              1.0            1.0     1/  1/   1
update orders set order_mode = :1 , order_status = :2 , order_total = :3 where order_id = :4

9bz9sa0abpc48              1.1           62.8            N/A            N/A     -1.1          0.4        N/A         5,680         N/A         0.0       N/A         14,671          N/A             27          N/A              1          N/A             27          N/A              1.0            N/A
insert into customers (customer_id ,cust_first_name ,cust_last_name ,nls_language ,nls_territory ,credit_limit ,cust_email ,account_mgr_id ) values (:1 , :2 , :3 , :4 , :5 , :6 ,:7 , :8 )

g8rhybcumtwd6              1.5           64.3            0.8           64.6     -0.6          1.1        0.6         7,777       6,546         0.0       0.0          7,086       10,442            191          222            175          205             13           11             10.0           10.0     1/  1/   1
SELECT /*+ first_rows index(customers, customers_pk) index(orders, order_status_ix) */ o.order_id, line_item_id, product_id, unit_price, quantity, order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_firs
t_name, cust_last_name, credit_limit, cust_email, order_date FROM orders o , order_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id = c.customer_id and o.order_status <= 4

9zd49du11u7cf             13.5           77.9           13.0           77.5     -0.6          1.9        1.9        70,673     100,193         0.0       0.0         36,852       51,948             18           25              1            1             17           24              1.0            1.0
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) values (:1 , :2 , :3 , :4 )

d5j6fbqmu3gjp             12.6           90.4           12.2           89.7     -0.4          1.8        1.8        65,598      94,166         0.0       0.0         36,752       51,887             14           20              0            0             14           20              0.9            1.0     1/  1/   1
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_price, quantity, order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_first_name, cust_last_name, credit_limit, cust_email FROM orders o , o
rder_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id = c.customer_id and c.customer_id = :1

6k3uuf3g8pwh6              0.4           90.8            0.3           90.0     -0.1          0.3        0.2         1,942       2,130         0.0       0.0          7,082       10,442              3            4              0            0              3            3              1.0            1.0     1/  1/   1
update /*+ index(orders, order_pk) */ orders set order_status = :1 where order_id = :2

gfqas5ahy1x56              0.8           91.6            0.9           90.8      0.0          0.1        0.1         4,354       6,602         0.0       0.0         36,854       51,947              1            2              0            0              1            1              2.9            2.8     1/  1/   1
SELECT o.order_id, line_item_id, product_id, unit_price, quantity, order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_first_name, cust_last_name, credit_limit, cust_email FRO
M orders o , order_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id = c.customer_id and o.order_id = :1

9zus1m3s2675b              0.2           91.8            0.1           91.0     -0.0        815.0    1,126.0           815       1,126         0.0       0.0              1            1          3,886        6,473            630        1,279          3,140        4,950              1.0            1.0
DECLARE job BINARY_INTEGER := :job; next_date TIMESTAMP WITH TIME ZONE := :mydate; broken BOOLEAN := FALSE; job_name VARCHAR2(30) := :job_name; job_subname VARCHAR2(30) := :job_subname; job_owner VARCHAR2(30) := :job_owner; job_start
TIMESTAMP WITH TIME ZONE := :job_start; job_scheduled_start TIMESTAMP WITH TIME ZONE := :job_scheduled_start; window_start TIMESTAMP WITH TIME ZONE := :window_start; window_end TIMESTAMP WITH TIME ZONE := :window_end; chain_id VARCHAR2(
14) := :chainid; credential_owner varchar2(30) := :credown; credential_name varchar2(30) := :crednam; destination_owner varchar2(30) := :destown; destination_name varchar2(30) := :destnam; job_dest_id varchar2(14) := :jdestid; log_i
d number := :log_id; BEGIN perfstat.statspack.snap(i_snap_level => 7); :mydate := next_date; IF broken THEN :b := 1; ELSE :b := 0; END IF; END;

                          --------------------------------------------------------------------------------------------------------------------

Top SQL Comparison by Executions   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by 'Diff' column of '#Executions/sec (DB time)' descending
-> '#Plans' column indicates the number of distinct execution plans for the statement in 1st and 2nd periods and in Both periods, combined
-> Captured SQL Executions          First:                    1,229,352, Second:                    1,710,869
-> Captured SQL Elapsed Time        First:                        6,104.90 seconds, Second:                       11,256.73 seconds
-> Captured SQL Elapsed Time as a % of DB time         First: 95.32%, Second: 89.25%
-> Captured SQL Executions as a % of Total Executions  First: 99.92%, Second: 98.99%
-> Common SQL Executions as a % of Total Executions  First: 98.7%, Second: 98.85%
-> 'N/A' indicates no data was captured for the statement in the period

                    #Executions/sec (DB time)             #Executions           Exec Time (ms) per Exec      CPU Time (ms) per Exec      I/O Time (ms) per Exec    Physical Reads per Exec      #Rows Processed per Exec         #Plan
                --------------------------------   -------------------------   -------------------------   -------------------------   -------------------------   ---------------------   -----------------------------   ------------
SQL Id                 1st        2nd       Diff            1st          2nd            1st          2nd            1st          2nd            1st          2nd          1st        2nd              1st            2nd   1st/2nd/Both
-------------   ---------- ---------- ----------   ------------ ------------   ------------ ------------   ------------ ------------   ------------ ------------   ---------- ----------   -------------- --------------   ------------
gyk686gnaygs2         34.4       24.7       -9.8        220,441      311,130              0            0              0            0              0            0          0.0        0.0              5.0            5.0     1/  1/   1
select product_id, product_name, product_description, category_id, weight_class, supplier_id, product_status list_price, min_price, catalog_url from product_information where category_id = :1

82ud5h0qcg0bf         19.5       14.0       -5.5        124,882      176,182             15           21              0            0             15           20          1.6        1.5              1.0            1.0     1/  1/   1
select customer_id, cust_first_name ,cust_last_name ,nls_language ,nls_territory ,credit_limit ,cust_email ,account_mgr_id from customers where customer_id = :1

gshgncvvtv0c6         19.5       14.0       -5.5        124,883      176,186              0            0              0            0              0            0          0.0        0.0              1.0            1.0
insert into logon values(:1 ,:2 )

7v0pya6f6qc6s         17.2       12.3       -4.8        109,862      155,252              0            0              0            0              0            0          0.0        0.0             10.0           10.0     1/  1/   1
select p.product_id, product_name, product_description, category_id, weight_class, supplier_id, product_status, list_price, min_price, catalog_url, quantity_on_hand, warehouse_id from product_information p, inventories i where categor
y_id = :1 and i.product_id = p.product_id

5g00dq4fxwnsw         16.4       11.7       -4.8        105,254      147,054              4            7              0            0              4            7          0.5        0.6              0.9            0.9     1/  1/   1
update inventories set quantity_on_hand = quantity_on_hand - :1 where product_id = :2 and warehouse_id = :3

8vvvyuun2urt6         16.4       11.7       -4.8        105,252      147,058              6            9              0            0              5            9          0.6        0.8              1.0            1.0
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY) values (:1 , :2 , :3 , :4 , :5 )

982zxphp8ht6c         16.4       11.7       -4.8        105,251      147,057              0            0              0            0              0            0          0.0        0.0              1.0            1.0     1/  1/   1
select product_id, product_name, product_description, category_id, weight_class, supplier_id, product_status, list_price, min_price, catalog_url from product_information where product_id = :1

dt8dtzvsq5kj5         16.4       11.7       -4.8        105,252      147,059              0            0              0            0              0            0          0.0        0.0             10.0           10.0     1/  1/   1
select p.product_id, product_name, product_description, category_id, weight_class, supplier_id, product_status, list_price, min_price, catalog_url, quantity_on_hand, warehouse_id from product_information p, inventories i where i.produ
ct_id = :1 and i.product_id = p.product_id

2yp5w5a36s5xv          5.8        4.1       -1.6         36,853       51,945              3            6              0            0              3            6          0.3        0.5              1.0            1.0     1/  1/   1
update orders set order_mode = :1 , order_status = :2 , order_total = :3 where order_id = :4

gfqas5ahy1x56          5.8        4.1       -1.6         36,854       51,947              1            2              0            0              1            1          0.1        0.1              2.9            2.8     1/  1/   1
SELECT o.order_id, line_item_id, product_id, unit_price, quantity, order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_first_name, cust_last_name, credit_limit, cust_email FRO
M orders o , order_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id = c.customer_id and o.order_id = :1

9zd49du11u7cf          5.8        4.1       -1.6         36,852       51,948             18           25              1            1             17           24          1.9        1.9              1.0            1.0
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) values (:1 , :2 , :3 , :4 )

8uk8bquk453q8          5.8        4.1       -1.6         36,848       51,947              0            0              0            0              0            0          0.0        0.0              1.0            1.0     1/  1/   1
select orders_seq.nextval from dual

                          --------------------------------------------------------------------------------------------------------------------

Top SQL Comparison by Parse Calls   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of 'Diff' column of '% Total Parses' descending
-> '#Plans' column indicates the number of distinct execution plans for the statement in 1st and 2nd periods and in Both periods, combined
-> '1st Total' and '2nd Total' show respective running totals for '1st' and '2nd' columns of '% Total Parses'
-> Total Parse Time as a % of DB time   First: .42%, Second: .45%
-> Total Parses                         First:                          492, Second:                        1,437
-> Captured SQL Parses                  First:                          233, Second:                          746
-> Captured SQL Parses % of Total Parses  First: 47.36%, Second: 51.91%
-> Common SQL Parses % of Total Parses    First: 34.55%, Second: 39.81%
-> 'N/A' indicates no data was captured for the statement in the period

                                   % Total Parses                                Parses                     #Executions               #Plans
                ----------------------------------------------------   -------------------------   -----------------------------   ------------
SQL Id                 1st  1st Total        2nd  2nd Total     Diff            1st          2nd              1st            2nd   1st/2nd/Both
-------------   ---------- ---------- ---------- ---------- --------   ------------ ------------   -------------- --------------   ------------
350f5yrnnmshs         27.2       27.2        9.5        9.5    -17.7            134          137              134            137
lock table sys.mon_mods$ in exclusive mode nowait

b2gnxm5z6r51n          0.8       28.0       10.5       20.0      9.7              4          151                4            151
lock table sys.col_usage$ in exclusive mode nowait

9tgj4g8y4rwy8          N/A        N/A        1.6       21.6      1.6            N/A           23              N/A             96   /  1/   1
select type#,blocks,extents,minexts,maxexts,extsize,extpct,user#,iniexts,NVL(lists,65535),NVL(groups,65535),cachehint,hwmincr, NVL(spare1,0),NVL(scanhint,0),NVL(bitmapranges,0) from seg$ where ts#=:1 and file#=:2 and block#=:3

cm5vu20fhtnq1          N/A        N/A        1.2       22.8      1.2            N/A           17              N/A             30   /  1/   1
select /*+ connect_by_filtering */ privilege#,level from sysauth$ connect by grantee#=prior privilege# and privilege#>0 start with grantee#=:1 and privilege#>0

0k8522rmdzg4k          N/A        N/A        1.0       23.9      1.0            N/A           15              N/A             15   /  2/   2
select privilege# from sysauth$ where (grantee#=:1 or grantee#=1) and privilege#>0

0ws7ahf1d78qa          N/A        N/A        1.0       24.9      1.0            N/A           15              N/A             15   /  1/   1
select SYS_CONTEXT('USERENV', 'SERVER_HOST'), SYS_CONTEXT('USERENV', 'DB_UNIQUE_NAME'), SYS_CONTEXT('USERENV', 'INSTANCE_NAME'), SYS_CONTEXT('USERENV', 'SERVICE_NAME'), INSTANCE_NUMBER, STARTUP_TIME, SYS_CONTEXT('USERENV', 'DB_DOMAIN') from
 v$instance where INSTANCE_NAME=SYS_CONTEXT('USERENV', 'INSTANCE_NAME')

2yp5w5a36s5xv          0.0       28.0        1.0       26.0      1.0              0           15           36,853         51,945     1/  1/   1
update orders set order_mode = :1 , order_status = :2 , order_total = :3 where order_id = :4

459f3z9u4fb3u          N/A        N/A        1.0       27.0      1.0            N/A           15              N/A             15   /  1/   1
select value$ from props$ where name = 'GLOBAL_DB_NAME'

5d8b4p888x97a          0.0       28.0        1.0       28.0      1.0              0           15           14,671         20,502     1/  1/   1
select customer_seq.nextval from dual

0kkhhb2w93cx0          1.0       29.1        N/A        N/A     -1.0              5          N/A               10            N/A     1//   1
update seg$ set type#=:4,blocks=:5,extents=:6,minexts=:7,maxexts=:8,extsize=:9,extpct=:10,user#=:11,iniexts=:12,lists=decode(:13, 65535, NULL, :13),groups=decode(:14, 65535, NULL, :14), cachehint=:15, hwmincr=:16, spare1=DECODE(:17,0,NULL,:
17),scanhint=:18, bitmapranges=:19 where ts#=:1 and file#=:2 and block#=:3

1gfaj4z5hn1kf          0.4       29.5        N/A        N/A     -0.4              2          N/A                2            N/A     1//   1
delete from dependency$ where d_obj#=:1

20vv6ttajyjzq          0.4       29.9        N/A        N/A     -0.4              2          N/A                2            N/A     1//   1
delete from access$ where d_obj#=:1

2pff93c8c626v          0.4       30.3        N/A        N/A     -0.4              2          N/A                2            N/A     1//   1
select name, address, protocol, subscriber_type, subscriber_id from "SYS"."AQ$_SCHEDULER$_EVENT_QTAB_S" where queue_name = :1 and (bitand(subscriber_type, 4096) = 4096)

4m7m0t6fjcs5x          0.4       30.7        N/A        N/A     -0.4              2          N/A               10            N/A     1//   1
update seq$ set increment$=:2,minvalue=:3,maxvalue=:4,cycle#=:5,order$=:6,cache=:7,highwater=:8,audit$=:9,flags=:10 where obj#=:1

6abthk1u14yb7          0.4       31.1        N/A        N/A     -0.4              2          N/A                2            N/A     1//   1
SELECT VERSION FROM V$INSTANCE

6xvp6nxs4a9n4          0.4       31.5        N/A        N/A     -0.4              2          N/A               12            N/A     1//   1
select nvl(sum(space),0) from recyclebin$ where ts# = :1

bsa0wjtftg3uw          1.4       32.9        1.3       29.4     -0.1              7           19               88            111     1/  1/   1
select file# from file$ where ts#=:1

                          --------------------------------------------------------------------------------------------------------------------

Top SQL Comparison by Sharable Memory   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> SQL Statements appearing in the End Snapshot are compared
-> 'Sharable Memory Used' is computed for the End Snapshot
-> 'Sharble Memory Max' is computed for the whole interval
-> Ordered by absolute value of 'Diff' column of '% Total Sharable Memory' descending
-> '1st Total' and '2nd Total' show respective running totals for '1st' and '2nd' columns of '% Total Sharable Memory'
-> Shared Pool at End Snapshot First:                  272,629,760, Second:                  272,629,760
-> 'N/A' indicates no data was captured for the statement in the period

                               % Total Sharable Memory                       Sharable Memory Used              Sharable Memory Max                  #Executions
                ----------------------------------------------------   -------------------------------   -------------------------------   -----------------------------
SQL Id                 1st  1st Total        2nd  2nd Total     Diff               1st             2nd               1st             2nd              1st            2nd
-------------   ---------- ---------- ---------- ---------- --------   --------------- ---------------   --------------- ---------------   -------------- --------------
9dhn1b8d88dpf          N/A        N/A        0.1        0.1      0.1               N/A         288,434               N/A         288,434              N/A              1
select OBJOID, CLSOID, RUNTIME, PRI, JOBTYPE, SCHLIM, WT, INST, RUNNOW, ENQ_SCHLIM from ( select a.obj# OBJOID, a.class_oid CLSOID, decode(bitand(a.flags, 16384), 0, a.next_run_date, a.last_enabled_time) RUNTIME, (2*a.pr
iority + decode(bitand(a.job_status, 4), 0, 0, decode(a.running_instance, :1, -1, 1))) PRI, 1 JOBTYPE, decode(a.schedule_limit, NULL, decode(bitand(a.flags, 4194304), 4194304, p.schedule_limit, NULL),
 a.schedule_limit) SCHLIM, a.job_weight WT, decode(a.running_instance, NULL, 0, a.running_instance) INST, decode(bitand(a.flags, 16384), 0, 0, 1) RUNNOW, decode(bitand(a.job_status, 8388608), 0, 0, 1) ENQ_SCHLIM from sys.sched
uler$_job a, sys.scheduler$_program p, v$database v, v$instance i where a.program_oid = p.obj#(+) and bitand(a.job_status, 515) = 1 and bitand(a.flags, 1048576) = 0 and ((bitand(a.flags, 134217728 + 268435456)

bn4b3vjw2mj3u          N/A        N/A        0.1        0.2      0.1               N/A         178,288               N/A         178,288              N/A              4
SELECT OBJOID, CLSOID, DECODE(BITAND(FLAGS, 16384), 0, RUNTIME, LETIME), (2*PRI + DECODE(BITAND(STATUS, 4), 0, 0, decode(INST, :1, -1, 1))), JOBTYPE, SCHLIM, WT, INST, RUNNOW, ENQ_SCHLIM, INST_ID FROM ( s
elect a.obj# OBJOID, a.class_oid CLSOID, a.next_run_date RUNTIME, a.last_enabled_time LETIME, a.flags FLAGS, a.job_status STATUS, 1 JOBTYPE, a.priority PRI, decode(a.schedule_limit, NULL, decode(bitand
(a.flags, 4194304), 4194304, b.schedule_limit, NULL), a.schedule_limit) SCHLIM, a.job_weight WT, decode(a.running_instance, NULL, 0, a.running_instance) INST, decode(bitand(
a.flags, 16384), 0, 0, 1) RUNNOW, decode(bitand(a.job_status, 8388608), 0, 0, 1) ENQ_SCHLIM, a.instance_id INST_ID from sys.scheduler$_job a, sys.scheduler$_program b, v$database v , v$instance i where a.program_oid

c2p21x29vnybg          N/A        N/A        0.1        0.2      0.1               N/A         154,684               N/A         154,684              N/A              1
SELECT x.inst_id, x.sid_knst, x.serial_knst, x.capnum_knstcap, x.capname_knstcap, x.logminer_id_knstcap, x.startup_time_knstcap, case when (x.state_knstcap = 10 and d.loaded = 'ACTIVE') then d.c
urrent_state || ' ' || d.progress when (x.state_knstcap = 18) then 'WAIT FOR ' || x.subscriber_num || ' SUBSCRIBER(S) INITIALIZING' else DECODE(x.state_knstcap,
 0, 'INITIALIZING', 1,'CAPTURING CHANGES', 2, 'EVALUATING RULE', 3,'ENQUEUING MESSAGE', 4, 'SHUTTING DOWN', 5,'ABORTING', 6, 'CREATING LCR', 7,
 DECODE(x.missing_logfile_info_knstcap, NULL, 'WAITING FOR DICTIONARY REDO', 'WAITING FOR DICTIONARY REDO: ' || x.missing_logfile_info_knstcap),

8jhgd9rm6f17u          N/A        N/A        0.1        0.3      0.1               N/A         154,423               N/A         154,423              N/A              1
select SID, SERIAL#, CAPTURE#, CAPTURE_NAME, LOGMINER_ID, STARTUP_TIME, STATE, TOTAL_PREFILTER_DISCARDED, TOTAL_PREFILTER_KEPT, TOTAL_PREFILTER_EVALUATIONS,TOTAL_MESSAGES_CAPTURED, CAPTURE_TIME, CAPTURE_MESSAGE_NUMBER,
CAPTURE_MESSAGE_CREATE_TIME, TOTAL_MESSAGES_CREATED, TOTAL_FULL_EVALUATIONS, TOTAL_MESSAGES_ENQUEUED, ENQUEUE_TIME, ENQUEUE_MESSAGE_NUMBER, ENQUEUE_MESSAGE_CREATE_TIME, AVAILABLE_MESSAGE_NUMBER, AVAILABLE_MESSAGE
_CREATE_TIME, ELAPSED_CAPTURE_TIME, ELAPSED_RULE_TIME,ELAPSED_ENQUEUE_TIME, ELAPSED_LCR_TIME, ELAPSED_REDO_WAIT_TIME, ELAPSED_PAUSE_TIME, STATE_CHANGED_TIME, APPLY_NAME, APPLY_DBLINK, APPLY_MESSAGES_SENT, APPLY
_BYTES_SENT, OPTIMIZATION, PURPOSE, SGA_USED, SGA_ALLOCATED, BYTES_OF_REDO_MINED, SESSION_RESTART_SCN from GV$STREAMS_CAPTURE where INST_ID = USERENV('Instance')

6ajkhukk78nsr          0.0        0.0        0.0        0.3     -0.0           132,373          95,253           132,373          95,253                1              1
begin prvt_hdm.auto_execute( :dbid, :inst_num , :end_snap_id ); end;

6wm3n4d7bnddg          0.1        0.2        0.1        0.4     -0.0           321,554         312,970           321,554         312,970                1              1
 SELECT source, (case when time_secs < 1 then 1 else time_secs end) as time_secs, operation FROM ( SELECT 1 as source, trunc((sysdate - cast(ll.log_date as date)) * 86400) as time_secs,
 decode(ll.operation, 'OPEN', 0 , 1 ) as operation, ll.log_id as log_id FROM DBA_SCHEDULER_WINDOW_LOG ll , ( SELECT max(l.log_id) as max
_log_id FROM DBA_SCHEDULER_WINDOW_LOG l , DBA_SCHEDULER_WINGROUP_MEMBERS m WHERE l.window_name = m.window_name AND m.window_group_name = 'MAINTENANCE_WINDOW_
GROUP' AND l.operation in ('OPEN', 'CLOSE') AND CAST(l.log_date AS DATE) < ( SELECT cast(min(end_interval_time) as date) as btime FROM WRM$_SNAPSHOT bsi WHERE bsi.dbid = :dbid AND bsi.instance_n

7r7twx8dzdd8r          0.1        0.2        0.1        0.5     -0.0           182,732         178,660           182,732         178,660                1              1
INSERT INTO STATS$SEG_STAT_OBJ ( TS# , OBJ# , DATAOBJ# , DBID , OWNER , OBJECT_NAME , SUBOBJECT_NAME , OBJECT_TYPE , TABLESPACE_NAME ) SELECT /*+ ordered index(ss1) */ VS.TS# , VS.OBJ# , VS.DATAOBJ# , :B2 , VS.OWNER , VS.OBJECT_NAME , VS.SU
BOBJECT_NAME , VS.OBJECT_TYPE , VS.TABLESPACE_NAME FROM STATS$SEG_STAT SS1, V$SEGMENT_STATISTICS VS WHERE VS.DATAOBJ# = SS1.DATAOBJ# AND VS.OBJ# = SS1.OBJ# AND VS.TS# = SS1.TS# AND SS1.SNAP_ID = :B3 AND SS1.DBID = :B2 AND SS1.INSTANCE_NUMBE
R = :B1 AND VS.STATISTIC# = 0 AND NOT EXISTS (SELECT 1 FROM STATS$SEG_STAT_OBJ SS2 WHERE SS2.DATAOBJ# = SS1.DATAOBJ# AND SS2.OBJ# = SS1.OBJ# AND SS2.TS# = SS1.TS#) ORDER BY DATAOBJ#,OBJ#,TS#,DBID

317v5hnvvd49h          0.1        0.3        0.1        0.6      0.0           139,928         139,944           139,928         139,944                1              1
 UPDATE wrh$_seg_stat_obj ob SET (snap_id, owner, object_name, subobject_name, tablespace_name, object_type, index_type, base_obj#, base_object_name, base_object_owner) = (SELECT so.snap_id + 1,
 so.oj.owner_name, so.oj.object_name, so.oj.subobject_name, so.oj.tablespace_name, so.oj.object_type, index_type, coalesce(io.base_obj#, so.base_obj#), coalesce(io.base_object_name, so.base_object_n
ame), coalesce(io.base_object_owner, so.base_object_owner) FROM (SELECT dbid, ts#, obj#, dataobj#, object_type, base_obj#, base_object_name, base_object_owner, snap_id,
dbms_swrf_internal.awr_get_object_info( ts#, obj#, dataobj#, AWR_OBJECT_INFO_TYPE(owner, object_name, subobject_name, tablespace_name, object_type)) oj

7k6zct1sya530          0.1        0.3        0.1        0.6      0.0           150,925         150,941           150,925         150,941                1              1
insert into WRH$_STREAMS_APPLY_SUM (snap_id, dbid, instance_number, apply_name, startup_time, reader_total_messages_dequeued, reader_lag, coord_total_received, coord_total_applied, coord_total_rollbacks, coord_total_wait_deps
, coord_total_wait_cmts, coord_lwm_lag, server_total_messages_applied, server_elapsed_dequeue_time, server_elapsed_apply_time) select * from (select :snap_id, :dbid, :instance_number, ac.apply_name, ac.startup_time, a
r.total_messages_dequeued, ar.dequeue_time - ar.dequeued_message_create_time, ac.total_received, ac.total_applied, ac.total_rollbacks, ac.total_wait_deps, ac.total_wait_commits, ac.lwm_time - ac.l
wm_message_create_time, al.total_messages_applied, al.elapsed_dequeue_time, al.elapsed_apply_time from v$streams_apply_coordinator ac, v$streams_apply_reader ar, (select apply_name,

1bumcaqpc58vj          0.0        0.4        0.0        0.7      0.0           133,903         133,903           133,903         133,903                1              1
INSERT INTO STATS$STREAMS_CAPTURE ( SNAP_ID , DBID , INSTANCE_NUMBER , CAPTURE_NAME , STARTUP_TIME , TOTAL_MESSAGES_CAPTURED , TOTAL_MESSAGES_ENQUEUED , ELAPSED_CAPTURE_TIME , ELAPSED_RULE_TIME , ELAPSED_ENQUEUE_TIME , ELAPSED_LCR_TIME , EL
APSED_REDO_WAIT_TIME , ELAPSED_PAUSE_TIME ) SELECT :B3 , :B2 , :B1 , CAPTURE_NAME , STARTUP_TIME , TOTAL_MESSAGES_CAPTURED , TOTAL_MESSAGES_ENQUEUED , ELAPSED_CAPTURE_TIME , ELAPSED_RULE_TIME , ELAPSED_ENQUEUE_TIME , ELAPSED_LCR_TIME , ELAP
SED_REDO_WAIT_TIME , ELAPSED_PAUSE_TIME FROM V$STREAMS_CAPTURE

5dyhfnkzta2zm          0.1        0.4        0.1        0.7      0.0           153,605         153,605           153,605         153,605                1              1
WITH awr_evts as (SELECT e.event_id, e.wait_class FROM WRH$_EVENT_NAME e WHERE e.dbid = :dbid) ,en as (SELECT event_id, nvl(v.wait_class, awr_evts.wait_class) as wait_class FROM awr_evts FULL OUTER JOIN V$EVENT_NAME v USIN
G(event_id) UNION ALL SELECT 0 as event_id, 'CPU' as wait_class FROM DUAL ) SELECT * FROM ( SELECT count(*) as cnt , a.SQL_ID, sum(decode(a.wait_time, 0, 0, 1)) as on_cpu, sum(case when a.wait_time = 0 and e
n.wait_class = 'User I/O' then 1 else 0 end) as io_wait, sum(case when a.wait_time = 0 and en.wait_class = 'Cluster' then 1 else 0 end) as cl_wait, sum(decode(bitand(a.time_model,power(2, 4)),0,0,NULL
,0,1)) as in_parse, sum(decode(bitand(a.time_model,power(2, 14)),0,0,NULL,0,1)) as in_java, sum(decode(bitand(a.time_model,power(2, 11)+power(2, 12)), NULL,0,0,0,1)) as in_pls
Top SQL Comparison by Sharable Memory   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> SQL Statements appearing in the End Snapshot are compared
-> 'Sharable Memory Used' is computed for the End Snapshot
-> 'Sharble Memory Max' is computed for the whole interval
-> Ordered by absolute value of 'Diff' column of '% Total Sharable Memory' descending
-> '1st Total' and '2nd Total' show respective running totals for '1st' and '2nd' columns of '% Total Sharable Memory'
-> Shared Pool at End Snapshot First:                  272,629,760, Second:                  272,629,760
-> 'N/A' indicates no data was captured for the statement in the period

                               % Total Sharable Memory                       Sharable Memory Used              Sharable Memory Max                  #Executions
                ----------------------------------------------------   -------------------------------   -------------------------------   -----------------------------
SQL Id                 1st  1st Total        2nd  2nd Total     Diff               1st             2nd               1st             2nd              1st            2nd
-------------   ---------- ---------- ---------- ---------- --------   --------------- ---------------   --------------- ---------------   -------------- --------------

5h91zx386wbht          0.1        0.5        0.1        0.8      0.0           199,210         199,210           199,210         199,210                1              1
WITH awr_params as ( SELECT /*+ NO_MERGE(map) USE_HASH(map) */ p.parameter_hash as parameter_hash, max(map.parameter_name) as parameter_name, max (map.keh_id) as keh_id, max (case when p.snap_id = :bid then upper
(p.value) else null end) as first_value, max (case when p.snap_id = :eid then upper(p.value) else null end) as last_value, max (case when p.isdefault = 'TRUE' the
n upper(p.value) else null end) as default_value, max (upper(p.value)) as max_value, min (upper(p.value)) as min_value, max (case when p.snap_id = :bid then decode(p.ismodified, 'FALSE', 0
, 'MODIFIED', 1, 4) else null end) as first_is_mod, max (case when p.snap_id = :eid then decode(p.ismodified, 'FALSE', 0, 'MODIFIED', 1, 4) else null end) as last_is_mod FROM ( SELEC

6cp74g22fzahf          0.1        0.6        0.1        0.9      0.0           216,035         216,035           216,035         216,035                1              1
 WITH ash as (SELECT ash.event_id, sum(decode(ash.session_type, 1, 1, 0)) as cnt_fg, count(*) as cnt_total FROM WRH$_ACTIVE_SESSION_HISTORY ash WHERE ash.dbid = :dbid AND ash.instance_number = :inst AND ash.snap_id > :bid AND ash.s
nap_id <= :eid AND ash.wait_time = 0 GROUP BY ash.event_id ), evts as (SELECT event_id, sum(w_cnt) as w_cnt, sum(to_cnt) as to_cnt, sum(w_time) as w_time ,sum(w_cnt_fg) as w_cnt_fg, sum(to_cnt_fg) as to_cnt_fg, sum(w_time_fg) as w_
time_fg FROM (SELECT es.event_id as event_id, es.total_waits - nvl(bs.total_waits,0) as w_cnt, es.TOTAL_TIMEOUTS - nvl(bs.TOTAL_TIMEOUTS,0) as to_cnt, es.TIME_WAITED_MICRO - nvl(bs.TIME_WAITED_MICRO,0) as w_time ,es.total_waits_fg - n
vl(bs.total_waits_fg,0) as w_cnt_fg, es.TOTAL_TIMEOUTS_FG - nvl(bs.TOTAL_TIMEOUTS_FG,0) as to_cnt_fg, es.TIME_WAITED_MICRO_FG - nvl(bs.TIME_WAITED_MICRO_FG,0) as w_time_fg FROM WRH$_SYSTEM_EVENT es , WRH$_SYSTEM_EVENT bs WHERE es.d

dnhdv2yuma39z          0.1        0.7        0.1        0.9      0.0           146,496         146,496           146,496         146,496                1              1
INSERT INTO STATS$STREAMS_APPLY_SUM ( SNAP_ID , DBID , INSTANCE_NUMBER , APPLY_NAME , STARTUP_TIME , READER_TOTAL_MESSAGES_DEQUEUED , READER_ELAPSED_DEQUEUE_TIME , READER_ELAPSED_SCHEDULE_TIME , COORD_TOTAL_RECEIVED , COORD_TOTAL_APPLIED ,
COORD_TOTAL_WAIT_DEPS , COORD_TOTAL_WAIT_COMMITS , COORD_ELAPSED_SCHEDULE_TIME , SERVER_TOTAL_MESSAGES_APPLIED , SERVER_ELAPSED_DEQUEUE_TIME , SERVER_ELAPSED_APPLY_TIME ) SELECT :B3 , :B2 , :B1 , MAX(C.APPLY_NAME) , MAX(C.STARTUP_TIME) , MA
X(R.TOTAL_MESSAGES_DEQUEUED) , MAX(R.ELAPSED_DEQUEUE_TIME) , MAX(R.ELAPSED_SCHEDULE_TIME) , MAX(C.TOTAL_RECEIVED) , MAX(C.TOTAL_APPLIED) , MAX(C.TOTAL_WAIT_DEPS) , MAX(C.TOTAL_WAIT_COMMITS) , MAX(C.ELAPSED_SCHEDULE_TIME) , SUM(S.TOTAL_MESSA
GES_APPLIED) , SUM(S.ELAPSED_DEQUEUE_TIME) , SUM(S.ELAPSED_APPLY_TIME) FROM V$STREAMS_APPLY_COORDINATOR C , V$STREAMS_APPLY_READER R , V$STREAMS_APPLY_SERVER S WHERE C.APPLY_NAME = R.APPLY_NAME AND C.APPLY_NAME = S.APPLY_NAME GROUP BY C.APP

                          --------------------------------------------------------------------------------------------------------------------

Top SQL Comparison by Version Count   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> SQL Statements appearing in the End Snapshot are compared
-> 'Version Count' is computed for the End Snapshot
-> 'Version Count Max' is computed for the whole interval
-> Ordered by absolute value of 'Diff' column of 'Version Count' descending

                          Version Count              Version Count Max              #Executions
                --------------------------------   ---------------------   -----------------------------
SQL Id                 1st        2nd       Diff          1st        2nd              1st            2nd
-------------   ---------- ---------- ----------   ---------- ----------   -------------- --------------
0k8522rmdzg4k          N/A          4          4          N/A          4              N/A             15
select privilege# from sysauth$ where (grantee#=:1 or grantee#=1) and privilege#>0

5ur69atw3vfhj          N/A          4          4          N/A          4              N/A             15
select decode(failover_method, NULL, 0 , 'BASIC', 1, 'PRECONNECT', 2 , 'PREPARSE', 4 , 0), decode(failover_type, NULL, 1 , 'NONE', 1 , 'SESSION', 2, 'SELECT', 4, 1), failover_retries, failover_delay, flags from service$ where name = :1

b3zgx1xckrwxu          N/A          4          4          N/A          4              N/A              1
select host,userid,password,flag,authusr,authpwd, passwordx, authpwdx from link$ where owner#=:1 and name=:2

23buxzfxyp1vy            3        N/A         -3            3        N/A                1            N/A
 SELECT greatest(0, 1000*servicetime - req*:expio ) as impact FROM ( SELECT sum( case when iostat.snap_id = :eid then iostat.small_read_reqs else 0 end) - sum( case when iostat.snap_id = :bid
 then iostat.small_read_reqs else 0 end) as req, sum( case when iostat.snap_id = :eid then iostat.small_read_servicetime else 0 end) - sum
( case when iostat.snap_id = :bid then iostat.small_read_servicetime else 0 end) as servicetime FROM WRH$_IOSTAT_FILETYPE iostat, WRH$_IOSTAT_FILETYPE_NAME fn WHERE iostat.dbid
= fn.dbid AND iostat.filetype_id = fn.filetype_id AND (fn.filetype_name = 'Data File' OR fn.filetype_name = 'Temp File') AND iostat.dbid = :dbid AND iostat.instance_number = :inst AND iostat.snap_id IN (:bid, :eid) )

23nad9x295gkf            3        N/A         -3            3        N/A                1            N/A
SELECT (m.current_size / 1048576) as sizemb, case when cast(m.last_oper_time as timestamp) > s.end_interval_time then 1 else 0 end as changed, decode( m.component , 'shared pool', 1, 'streams pool', 2, 'DEFAULT b
uffer cache', 3, 'DEFAULT 2K buffer cache', 4, 'DEFAULT 4K buffer cache', 5, 'DEFAULT 8K buffer cache', 6, 'DEFAULT 16K buffer cache', 7, 'DEFAULT 32K buffer cache', 8, 'SGA Target', 9, 'PGA Target', 10, 'memory target', 11 ,
255) as comp_id FROM WRH$_MEM_DYNAMIC_COMP m , WRM$_SNAPSHOT s WHERE m.dbid = :dbid AND m.instance_number = :inst_num AND m.snap_id = :end_snap_id AND s.dbid = :dbid AND s.instance_number =
 :inst_num AND s.snap_id = :begin_snap_id

4g46czps3t55u            3        N/A         -3            3        N/A                1            N/A
 SELECT sum(case when snap_id = :begin_snap_id then value else 0 end) as begin_sga, sum(case when snap_id = :end_snap_id then value else 0 end) as end_sga FROM WRH$_SGA sga WHERE sga.dbi
d = :dbid AND sga.instance_number = :inst_num AND (sga.snap_id = :begin_snap_id OR sga.snap_id = :end_snap_id )

4kt3cun8s5fp5          N/A          3          3          N/A          3              N/A              2
select name,password,datats#,tempts#,type#,defrole,resource$, ptime, decode(defschclass,NULL,'DEFAULT_CONSUMER_GROUP',defschclass),spare1,spare4,ext_username,spare2 from user$ where user#=:1

4vs91dcv7u1p6          N/A          3          3          N/A          3              N/A             15
insert into sys.aud$( sessionid,entryid,statement,ntimestamp#, userid,userhost,terminal,action#,returncode, obj$creator,obj$name,auth$privileges,auth$grantee, new$owner,new$name,ses$actions,ses$tid,logoff$pread, logoff$lwrite,logoff$dead,co
mment$text,spare1,spare2, priv$used,clientid,sessioncpu,proxy$sid,user$guid, instance#,process#,xid,scn,auditid, sqlbind,sqltext,obj$edition,dbid) values(:1,:2,:3,SYS_EXTRACT_UTC(SYSTIMESTAMP), :4,:5,:6,:7,:8, :9,:10,:11,:12,
 :13,:14,:15,:16,:17, :18,:19,:20,:21,:22, :23,:24,:25,:26,:27, :28,:29,:30,:31,:32, :33,:34,:35,:36)

5uw1u291s3m0k            3        N/A         -3            3        N/A                1            N/A
SELECT case when cnt = 0 then 0 else (1000000 * total) / cnt end FROM ( SELECT SUM(m.num_interval) AS cnt, SUM(m.num_interval * m.average) AS total FROM WRH$_SYSMETRIC_SUMMARY m , WRH$_METRIC_NAME n WHERE m.dbi
d = :dbid and m.instance_number = :inst_num and m.snap_id > :begin_snap_id and m.snap_id <= :end_snap_id and m.metric_id = n.metric_id and n.dbid = :dbid
 and n.metric_name = 'Current OS Load' )

6sqdp7673k5x3            3        N/A         -3            3        N/A                1            N/A
UPDATE wri$_adv_addm_tasks SET actual_analysis = :aa, database_time = :dbt, active_sessions = round(:dbt / (1000000 * :sint), 2), perc_flush_time = round(:ft / :sint, 2), perc_mw_time = round(:mw / :sint, 2) W
HERE task_id = :tid

47mm81hm9sggy            3          3          0            3          3                1              1
 SELECT sum(case when a.session_type = 1 and a.wait_time = 0 then 1 else 0 end) as fgw, sum(case when a.session_type = 1 and a.wait_time <> 0 then 1 else 0 end) as fgc, sum(case when a.session_type <>
 1 and a.wait_time = 0 then 1 else 0 end) as bgw, sum(case when a.session_type <> 1 and a.wait_time <> 0 then 1 else 0 end) as bgc, sum(case when v.event_id is not null and a.ses
sion_type = 1 and a.wait_time = 0 then 1 else 0 end) as fgi FROM WRH$_ACTIVE_SESSION_HISTORY a , V$EVENT_NAME v WHERE a.event_id = v.event_id(+) AND v.wait_class(+) = 'Idle' AND a.dbid = :dbid AND a.instance_numb
er = :inst AND a.snap_id > :bid AND a.snap_id <= :eid

5dyhfnkzta2zm            3          3          0            3          3                1              1
WITH awr_evts as (SELECT e.event_id, e.wait_class FROM WRH$_EVENT_NAME e WHERE e.dbid = :dbid) ,en as (SELECT event_id, nvl(v.wait_class, awr_evts.wait_class) as wait_class FROM awr_evts FULL OUTER JOIN V$EVENT_NAME v USIN
G(event_id) UNION ALL SELECT 0 as event_id, 'CPU' as wait_class FROM DUAL ) SELECT * FROM ( SELECT count(*) as cnt , a.SQL_ID, sum(decode(a.wait_time, 0, 0, 1)) as on_cpu, sum(case when a.wait_time = 0 and e
n.wait_class = 'User I/O' then 1 else 0 end) as io_wait, sum(case when a.wait_time = 0 and en.wait_class = 'Cluster' then 1 else 0 end) as cl_wait, sum(decode(bitand(a.time_model,power(2, 4)),0,0,NULL
,0,1)) as in_parse, sum(decode(bitand(a.time_model,power(2, 14)),0,0,NULL,0,1)) as in_java, sum(decode(bitand(a.time_model,power(2, 11)+power(2, 12)), NULL,0,0,0,1)) as in_pls

5h91zx386wbht            3          3          0            3          3                1              1
WITH awr_params as ( SELECT /*+ NO_MERGE(map) USE_HASH(map) */ p.parameter_hash as parameter_hash, max(map.parameter_name) as parameter_name, max (map.keh_id) as keh_id, max (case when p.snap_id = :bid then upper
(p.value) else null end) as first_value, max (case when p.snap_id = :eid then upper(p.value) else null end) as last_value, max (case when p.isdefault = 'TRUE' the
n upper(p.value) else null end) as default_value, max (upper(p.value)) as max_value, min (upper(p.value)) as min_value, max (case when p.snap_id = :bid then decode(p.ismodified, 'FALSE', 0
, 'MODIFIED', 1, 4) else null end) as first_is_mod, max (case when p.snap_id = :eid then decode(p.ismodified, 'FALSE', 0, 'MODIFIED', 1, 4) else null end) as last_is_mod FROM ( SELEC

Top SQL Comparison by Version Count   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> SQL Statements appearing in the End Snapshot are compared
-> 'Version Count' is computed for the End Snapshot
-> 'Version Count Max' is computed for the whole interval
-> Ordered by absolute value of 'Diff' column of 'Version Count' descending

                          Version Count              Version Count Max              #Executions
                --------------------------------   ---------------------   -----------------------------
SQL Id                 1st        2nd       Diff          1st        2nd              1st            2nd
-------------   ---------- ---------- ----------   ---------- ----------   -------------- --------------
6ajkhukk78nsr            3          3          0            3          3                1              1
begin prvt_hdm.auto_execute( :dbid, :inst_num , :end_snap_id ); end;

6cp74g22fzahf            3          3          0            3          3                1              1
 WITH ash as (SELECT ash.event_id, sum(decode(ash.session_type, 1, 1, 0)) as cnt_fg, count(*) as cnt_total FROM WRH$_ACTIVE_SESSION_HISTORY ash WHERE ash.dbid = :dbid AND ash.instance_number = :inst AND ash.snap_id > :bid AND ash.s
nap_id <= :eid AND ash.wait_time = 0 GROUP BY ash.event_id ), evts as (SELECT event_id, sum(w_cnt) as w_cnt, sum(to_cnt) as to_cnt, sum(w_time) as w_time ,sum(w_cnt_fg) as w_cnt_fg, sum(to_cnt_fg) as to_cnt_fg, sum(w_time_fg) as w_
time_fg FROM (SELECT es.event_id as event_id, es.total_waits - nvl(bs.total_waits,0) as w_cnt, es.TOTAL_TIMEOUTS - nvl(bs.TOTAL_TIMEOUTS,0) as to_cnt, es.TIME_WAITED_MICRO - nvl(bs.TIME_WAITED_MICRO,0) as w_time ,es.total_waits_fg - n
vl(bs.total_waits_fg,0) as w_cnt_fg, es.TOTAL_TIMEOUTS_FG - nvl(bs.TOTAL_TIMEOUTS_FG,0) as to_cnt_fg, es.TIME_WAITED_MICRO_FG - nvl(bs.TIME_WAITED_MICRO_FG,0) as w_time_fg FROM WRH$_SYSTEM_EVENT es , WRH$_SYSTEM_EVENT bs WHERE es.d

                          --------------------------------------------------------------------------------------------------------------------

Top SQL Comparison by Cluster Wait Time   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of 'Diff' column of '% Total Cluster Wait' descending
-> '#Plans' column indicates the number of distinct execution plans for the statement in 1st and 2nd periods and in Both periods, combined
-> '1st Total' and '2nd Total' show respective running totals for '1st' and '2nd' columns of '% Total Cluster Wait'
-> DB time                             First:                        6,404.55 seconds, Second:                       12,612.51 seconds
-> Cluster Wait Time  First:                            0.00 seconds, Second:                            0.00 seconds
-> Cluster Wait Time as a % of DB time  First: %, Second: %
-> 'N/A' indicates no data was captured for the statement in the period

                                % Total Cluster Wait                      Cluster Wait Time (sec)      Cluster Wait Time per Exec (sec)            #Executions               #Plans
                ----------------------------------------------------   -----------------------------   -----------------------------   -----------------------------   ------------
SQL Id                 1st  1st Total        2nd  2nd Total     Diff              1st            2nd              1st            2nd              1st            2nd   1st/2nd/Both
-------------   ---------- ---------- ---------- ---------- --------   -------------- --------------   -------------- --------------   -------------- --------------   ------------
01gmsncqrjrfr          N/A        N/A        0.0        0.0      0.0              N/A            0.0              N/A            0.0              N/A              1   /  1/   1
insert into WRH$_BUFFERED_QUEUES (snap_id, dbid, instance_number, queue_schema, queue_name, startup_time, queue_id, num_msgs, spill_msgs, cnum_msgs, cspill_msgs, expired_msgs, oldest_msgid, oldest_msg_enqtm, queue_state, elap
sed_enqueue_time, elapsed_dequeue_time, elapsed_transformation_time, elapsed_rule_evaluation_time, enqueue_cpu_time, dequeue_cpu_time, last_enqueue_time, last_dequeue_time) select * from (select :snap_id, :dbid, :instance_nu
mber, qs.queue_schema, qs.queue_name, qs.startup_time, qs.queue_id, qs.num_msgs, qs.spill_msgs, qs.cnum_msgs, qs.cspill_msgs, qs.expired_msgs, qs.oldest_msgid, qs.oldest_msg_enqtm, qs.queue_state,
 qs.elapsed_enqueue_time, qs.elapsed_dequeue_time, qs.elapsed_transformation_time, qs.elapsed_rule_evaluation_time, qs.enqueue_cpu_time, qs.dequeue_cpu_time, qs.last_enqueue_time, qs.last_dequeue_time f

0bma28usvnqt1          N/A        N/A        0.0        0.0      0.0              N/A            0.0              N/A            0.0              N/A              1   /  1/   1
SELECT text.sql_id FROM WRH$_SQLTEXT text WHERE text.dbid = :dbid AND text.sql_id in (:sqlid0, :sqlid1, :sqlid2, :sqlid3, :sqlid4, :sqlid5, :sqlid6, :sqlid7)

0k8522rmdzg4k          N/A        N/A        0.0        0.0      0.0              N/A            0.0              N/A            0.0              N/A             15   /  2/   2
select privilege# from sysauth$ where (grantee#=:1 or grantee#=1) and privilege#>0

0kkhhb2w93cx0          0.0        0.0        N/A        N/A      0.0              0.0            N/A              0.0            N/A               10            N/A     1//   1
update seg$ set type#=:4,blocks=:5,extents=:6,minexts=:7,maxexts=:8,extsize=:9,extpct=:10,user#=:11,iniexts=:12,lists=decode(:13, 65535, NULL, :13),groups=decode(:14, 65535, NULL, :14), cachehint=:15, hwmincr=:16, spare1=DECODE(:17,0,NULL,:
17),scanhint=:18, bitmapranges=:19 where ts#=:1 and file#=:2 and block#=:3

0v3dvmc22qnam          N/A        N/A        0.0        0.0      0.0              N/A            0.0              N/A            0.0              N/A            195
insert into sys.col_usage$ (obj#, intcol#, equality_preds, equijoin_preds, nonequijoin_preds, range_preds, like_preds, null_preds, timestamp) values ( :objn, :coln, decode(bitand(:flag,1),0,0,1), decode(bitand(:flag,2),0,0,1), decod
e(bitand(:flag,4),0,0,1), decode(bitand(:flag,8),0,0,1), decode(bitand(:flag,16),0,0,1), decode(bitand(:flag,32),0,0,1), :time)

0ws7ahf1d78qa          N/A        N/A        0.0        0.0      0.0              N/A            0.0              N/A            0.0              N/A             15   /  1/   1
select SYS_CONTEXT('USERENV', 'SERVER_HOST'), SYS_CONTEXT('USERENV', 'DB_UNIQUE_NAME'), SYS_CONTEXT('USERENV', 'INSTANCE_NAME'), SYS_CONTEXT('USERENV', 'SERVICE_NAME'), INSTANCE_NUMBER, STARTUP_TIME, SYS_CONTEXT('USERENV', 'DB_DOMAIN') from
 v$instance where INSTANCE_NAME=SYS_CONTEXT('USERENV', 'INSTANCE_NAME')

14wnf35dahb7v          0.0        0.0        N/A        N/A      0.0              0.0            N/A              0.0            N/A                1            N/A     1//   1
SELECT A.ID,A.TYPE FROM SYS.WRI$_ADV_DEFINITIONS A WHERE A.NAME = :B1

18c2yb5aj919t          0.0        0.0        N/A        N/A      0.0              0.0            N/A              0.0            N/A                1            N/A     1//   1
 SELECT nvl(e1,0) as e1, nvl(e2,0) as e2, nvl(e3,0) as e3, nvl(e4,0) as e4, nvl(e5,0) as e5, nvl(e6,0) as e6 FROM (SELECT e.event_id as event_id, e.event_name as event_name FROM WRH$_EVENT_NAME e
 WHERE e.dbid = :dbid AND e.event_name in ('log file sync', 'gc buffer busy', 'gc buffer busy acquire', 'gc buffer busy release', 'Streams: resolve
low memory condition', 'Streams capture: resolve low memory condition') ) PIVOT (max(event_id) FOR event_name IN ('log file sync' as e1, 'gc buffer busy' as e2, 'gc buffer busy a
cquire' as e3, 'gc buffer busy release' as e4, 'Streams: resolve low memory condition' as e5, 'Streams capture: resolve low memory condition' as e6) )

1bumcaqpc58vj          0.0        0.0        0.0        0.0      0.0              0.0            0.0              0.0            0.0                1              1     1/  1/   1
INSERT INTO STATS$STREAMS_CAPTURE ( SNAP_ID , DBID , INSTANCE_NUMBER , CAPTURE_NAME , STARTUP_TIME , TOTAL_MESSAGES_CAPTURED , TOTAL_MESSAGES_ENQUEUED , ELAPSED_CAPTURE_TIME , ELAPSED_RULE_TIME , ELAPSED_ENQUEUE_TIME , ELAPSED_LCR_TIME , EL
APSED_REDO_WAIT_TIME , ELAPSED_PAUSE_TIME ) SELECT :B3 , :B2 , :B1 , CAPTURE_NAME , STARTUP_TIME , TOTAL_MESSAGES_CAPTURED , TOTAL_MESSAGES_ENQUEUED , ELAPSED_CAPTURE_TIME , ELAPSED_RULE_TIME , ELAPSED_ENQUEUE_TIME , ELAPSED_LCR_TIME , ELAP
SED_REDO_WAIT_TIME , ELAPSED_PAUSE_TIME FROM V$STREAMS_CAPTURE

1cq3qr774cu45          0.0        0.0        0.0        0.0      0.0              0.0            0.0              0.0            0.0                1              1     1/  1/   1
insert into WRH$_IOSTAT_FILETYPE (snap_id, dbid, instance_number, filetype_id, small_read_megabytes, small_write_megabytes, large_read_megabytes, large_write_megabytes, small_read_reqs, small_write_reqs, small_sync_read_r
eqs, large_read_reqs, large_write_reqs, small_read_servicetime, small_write_servicetime, small_sync_read_latency, large_read_servicetime, large_write_servicetime, retries_on_error) (select :snap_id, :dbid, :instan
ce_number, filetype_id, sum(small_read_megabytes) small_read_megabytes, sum(small_write_megabytes) small_write_megabytes, sum(large_read_megabytes) large_read_megabytes, sum(large_write_megabytes) large_write_megaby
tes, sum(small_read_reqs) small_read_reqs, sum(small_write_reqs) small_write_reqs, sum(small_sync_read_reqs) small_sync_read_reqs, sum(large_read_reqs) large_read_reqs, sum(large_write_reqs) large_write_reqs, s

1crajpb7j5tyz          0.0        0.0        0.0        0.0      0.0              0.0            0.0              0.0            0.0                1              1     1/  1/   1
INSERT INTO STATS$SGA_TARGET_ADVICE ( SNAP_ID , DBID , INSTANCE_NUMBER , SGA_SIZE , SGA_SIZE_FACTOR , ESTD_DB_TIME , ESTD_DB_TIME_FACTOR , ESTD_PHYSICAL_READS ) SELECT :B3 , :B2 , :B1 , SGA_SIZE , SGA_SIZE_FACTOR , ESTD_DB_TIME , ESTD_DB_TI
ME_FACTOR , ESTD_PHYSICAL_READS FROM V$SGA_TARGET_ADVICE

1gfaj4z5hn1kf          0.0        0.0        N/A        N/A      0.0              0.0            N/A              0.0            N/A                2            N/A     1//   1
delete from dependency$ where d_obj#=:1

1p36ta7p3d7fu          0.0        0.0        N/A        N/A      0.0              0.0            N/A              0.0            N/A                1            N/A     1//   1
select file#, block#, ts#, blocks from seg$ where type# = 3

20vv6ttajyjzq          0.0        0.0        N/A        N/A      0.0              0.0            N/A              0.0            N/A                2            N/A     1//   1
delete from access$ where d_obj#=:1

23buxzfxyp1vy          0.0        0.0        N/A        N/A      0.0              0.0            N/A              0.0            N/A                1            N/A     1//   1
 SELECT greatest(0, 1000*servicetime - req*:expio ) as impact FROM ( SELECT sum( case when iostat.snap_id = :eid then iostat.small_read_reqs else 0 end) - sum( case when iostat.snap_id = :bid
 then iostat.small_read_reqs else 0 end) as req, sum( case when iostat.snap_id = :eid then iostat.small_read_servicetime else 0 end) - sum
Top SQL Comparison by Cluster Wait Time   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of 'Diff' column of '% Total Cluster Wait' descending
-> '#Plans' column indicates the number of distinct execution plans for the statement in 1st and 2nd periods and in Both periods, combined
-> '1st Total' and '2nd Total' show respective running totals for '1st' and '2nd' columns of '% Total Cluster Wait'
-> DB time                             First:                        6,404.55 seconds, Second:                       12,612.51 seconds
-> Cluster Wait Time  First:                            0.00 seconds, Second:                            0.00 seconds
-> Cluster Wait Time as a % of DB time  First: %, Second: %
-> 'N/A' indicates no data was captured for the statement in the period

                                % Total Cluster Wait                      Cluster Wait Time (sec)      Cluster Wait Time per Exec (sec)            #Executions               #Plans
                ----------------------------------------------------   -----------------------------   -----------------------------   -----------------------------   ------------
SQL Id                 1st  1st Total        2nd  2nd Total     Diff              1st            2nd              1st            2nd              1st            2nd   1st/2nd/Both
-------------   ---------- ---------- ---------- ---------- --------   -------------- --------------   -------------- --------------   -------------- --------------   ------------
( case when iostat.snap_id = :bid then iostat.small_read_servicetime else 0 end) as servicetime FROM WRH$_IOSTAT_FILETYPE iostat, WRH$_IOSTAT_FILETYPE_NAME fn WHERE iostat.dbid
= fn.dbid AND iostat.filetype_id = fn.filetype_id AND (fn.filetype_name = 'Data File' OR fn.filetype_name = 'Temp File') AND iostat.dbid = :dbid AND iostat.instance_number = :inst AND iostat.snap_id IN (:bid, :eid) )

2yp5w5a36s5xv          0.0        0.0        0.0        0.0      0.0              0.0            0.0              0.0            0.0           36,853         51,945     1/  1/   1
update orders set order_mode = :1 , order_status = :2 , order_total = :3 where order_id = :4

317v5hnvvd49h          0.0        0.0        0.0        0.0      0.0              0.0            0.0              0.0            0.0                1              1     1/  1/   1
 UPDATE wrh$_seg_stat_obj ob SET (snap_id, owner, object_name, subobject_name, tablespace_name, object_type, index_type, base_obj#, base_object_name, base_object_owner) = (SELECT so.snap_id + 1,
 so.oj.owner_name, so.oj.object_name, so.oj.subobject_name, so.oj.tablespace_name, so.oj.object_type, index_type, coalesce(io.base_obj#, so.base_obj#), coalesce(io.base_object_name, so.base_object_n
ame), coalesce(io.base_object_owner, so.base_object_owner) FROM (SELECT dbid, ts#, obj#, dataobj#, object_type, base_obj#, base_object_name, base_object_owner, snap_id,
dbms_swrf_internal.awr_get_object_info( ts#, obj#, dataobj#, AWR_OBJECT_INFO_TYPE(owner, object_name, subobject_name, tablespace_name, object_type)) oj

                          --------------------------------------------------------------------------------------------------------------------

Key Instance Activity Stats   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by statistic name

                                                    Value                                per Second (DB time)                   per Second (Elapsed Time)                         per Trans
                                 -------------------------------------------   ---------------------------------------   ---------------------------------------   ---------------------------------------
Statistic                                     1st              2nd     %Diff              1st            2nd     %Diff              1st            2nd     %Diff              1st            2nd     %Diff
------------------------------   ---------------- ---------------- ---------   -------------- -------------- ---------   -------------- -------------- ---------   -------------- -------------- ---------
db block changes                        2,549,313        3,564,963      39.8            398.0          282.7     -29.0          2,827.7        3,948.6      39.6             13.9           13.8      -0.5
execute count                           1,230,380        1,728,268      40.5            192.1          137.0     -28.7          1,364.7        1,914.2      40.3              6.7            6.7       0.0
logons cumulative                              13               27     107.7              0.0            0.0       0.0              0.0            0.0     200.0              0.0            0.0       0.0
opened cursors cumulative               1,230,072        1,727,506      40.4            192.1          137.0     -28.7          1,364.4        1,913.4      40.2              6.7            6.7       0.0
parse count (total)                           492            1,437     192.1              0.1            0.1      37.5              0.5            1.6     189.1              0.0            0.0     100.0
parse time elapsed                          1,806            4,361     141.5              0.3            0.3      25.0              2.0            4.8     141.5              0.0            0.0     100.0
physical reads                            522,880          774,075      48.0             81.6           61.4     -24.8            580.0          857.4      47.8              2.8            3.0       5.3
physical writes                           340,400          521,944      53.3             53.1           41.4     -22.1            377.6          578.1      53.1              1.9            2.0       9.2
redo size                             354,549,884      498,530,952      40.6         55,359.1       39,526.7     -28.6        393,267.0      552,173.5      40.4          1,931.8        1,933.1       0.1
session logical reads                 366,396,963      586,033,175      59.9         57,208.9       46,464.5     -18.8        406,407.8      649,091.1      59.7          1,996.3        2,272.4      13.8
user calls                              2,611,214        3,657,716      40.1            407.7          290.0     -28.9          2,896.4        4,051.3      39.9             14.2           14.2      -0.4
user commits                              183,536          257,888      40.5             28.7           20.4     -28.6            203.6          285.6      40.3              1.0            1.0       0.0
workarea executions - optimal                 274            1,032     276.6              0.0            0.1     100.0              0.3            1.1     280.0              0.0            0.0       0.0
                          --------------------------------------------------------------------------------------------------------------------

Other Instance Activity Stats   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by statistic name

                                                    Value                                per Second (DB time)                   per Second (Elapsed Time)                         per Trans
                                 -------------------------------------------   ---------------------------------------   ---------------------------------------   ---------------------------------------
Statistic                                     1st              2nd     %Diff              1st            2nd     %Diff              1st            2nd     %Diff              1st            2nd     %Diff
------------------------------   ---------------- ---------------- ---------   -------------- -------------- ---------   -------------- -------------- ---------   -------------- -------------- ---------
Batched IO (bound) vector coun                451              433      -4.0              0.1            0.0     -57.1              0.5            0.5      -4.0              0.0            0.0       0.0
Batched IO block miss count                   643              768      19.4              0.1            0.1     -40.0              0.7            0.9      19.7              0.0            0.0       0.0
Batched IO buffer defrag count                  7                3     -57.1              0.0            0.0       0.0              0.0            0.0    -100.0              0.0            0.0       0.0
Batched IO double miss count                   90              123      36.7              0.0            0.0       0.0              0.1            0.1      40.0              0.0            0.0       0.0
Batched IO same unit count                    223              263      17.9              0.0            0.0     -33.3              0.2            0.3      16.0              0.0            0.0       0.0
Batched IO single block count                 481              494       2.7              0.1            0.0     -50.0              0.5            0.5       3.8              0.0            0.0       0.0
Batched IO vector block count                 123              126       2.4              0.0            0.0     -50.0              0.1            0.1       0.0              0.0            0.0       0.0
Batched IO vector read count                   60               62       3.3              0.0            0.0    -100.0              0.1            0.1       0.0              0.0            0.0       0.0
Block Cleanout Optim reference              3,558            6,675      87.6              0.6            0.5      -5.4              3.9            7.4      87.1              0.0            0.0      50.0
CPU used by this session                  162,156          274,380      69.2             25.3           21.8     -14.1            179.9          303.9      69.0              0.9            1.1      20.5
CPU used when call started                162,045          274,171      69.2             25.3           21.7     -14.1            179.7          303.7      68.9              0.9            1.1      20.5
CR blocks created                          43,727           76,368      74.6              6.8            6.1     -11.4             48.5           84.6      74.4              0.2            0.3      25.0
Cached Commit SCN referenced               34,730           41,731      20.2              5.4            3.3     -38.9             38.5           46.2      20.0              0.2            0.2     -15.8
Commit SCN cached                           6,504            8,609      32.4              1.0            0.7     -33.3              7.2            9.5      32.3              0.0            0.0     -25.0
DBWR checkpoint buffers writte             49,337           31,900     -35.3              7.7            2.5     -67.1             54.7           35.3     -35.4              0.3            0.1     -55.6
DBWR checkpoints                               11               14      27.3              0.0            0.0       0.0              0.0            0.0     100.0              0.0            0.0       0.0
DBWR thread checkpoint buffers             49,337           31,900     -35.3              7.7            2.5     -67.1             54.7           35.3     -35.4              0.3            0.1     -55.6
DBWR transaction table writes                 218              285      30.7              0.0            0.0     -33.3              0.2            0.3      33.3              0.0            0.0       0.0
DBWR undo block writes                     16,336           24,068      47.3              2.6            1.9     -25.1             18.1           26.7      47.1              0.1            0.1       0.0
HSC Heap Segment Block Changes            421,099          589,972      40.1             65.7           46.8     -28.9            467.1          653.5      39.9              2.3            2.3       0.0
Heap Segment Array Inserts                    169              173       2.4              0.0            0.0     -66.7              0.2            0.2       0.0              0.0            0.0       0.0
Heap Segment Array Updates                     15               21      40.0              0.0            0.0       0.0              0.0            0.0       0.0              0.0            0.0       0.0
IMU CR rollbacks                           13,396           18,373      37.2              2.1            1.5     -30.1             14.9           20.3      36.9              0.1            0.1       0.0
IMU Flushes                                23,259           29,871      28.4              3.6            2.4     -34.7             25.8           33.1      28.3              0.1            0.1      -7.7
IMU Redo allocation size              116,746,320      143,624,724      23.0         18,228.7       11,387.5     -37.5        129,495.1      159,078.9      22.8            636.1          556.9     -12.4
IMU commits                               154,026          168,153       9.2             24.0           13.3     -44.6            170.8          186.2       9.0              0.8            0.7     -22.6
IMU contention                             19,872           26,336      32.5              3.1            2.1     -32.6             22.0           29.2      32.4              0.1            0.1      -9.1
IMU pool not allocated                      6,258           59,912     857.4              1.0            4.8     384.7              6.9           66.4     856.2              0.0            0.2     666.7
IMU undo allocation size              373,604,528      376,000,264       0.6         58,334.2       29,811.7     -48.9        414,402.4      416,458.4       0.5          2,035.6        1,458.0     -28.4
IMU- failed to get a private s              6,258           59,912     857.4              1.0            4.8     384.7              6.9           66.4     856.2              0.0            0.2     666.7
Requests to/from client                 1,418,864        1,988,093      40.1            221.5          157.6     -28.8          1,573.8        2,202.0      39.9              7.7            7.7      -0.3
RowCR - row contention                        231              276      19.5              0.0            0.0     -50.0              0.3            0.3      19.2              0.0            0.0       0.0
RowCR attempts                            112,607          159,698      41.8             17.6           12.7     -28.0            124.9          176.9      41.6              0.6            0.6       1.6
RowCR hits                                111,471          156,900      40.8             17.4           12.4     -28.5            123.6          173.8      40.6              0.6            0.6       0.0
SMON posted for undo segment s                 24               26       8.3              0.0            0.0       0.0              0.0            0.0       0.0              0.0            0.0       0.0
SQL*Net roundtrips to/from cli          1,418,872        1,988,112      40.1            221.5          157.6     -28.8          1,573.8        2,202.0      39.9              7.7            7.7      -0.3
active txn count during cleano             55,655           60,690       9.0              8.7            4.8     -44.6             61.7           67.2       8.9              0.3            0.2     -20.0
background checkpoints complet                 11               14      27.3              0.0            0.0       0.0              0.0            0.0     100.0              0.0            0.0       0.0
background checkpoints started                 11               14      27.3              0.0            0.0       0.0              0.0            0.0     100.0              0.0            0.0       0.0
background timeouts                         4,682            4,699       0.4              0.7            0.4     -49.3              5.2            5.2       0.2              0.0            0.0     -33.3
branch node splits                              3                4      33.3              0.0            0.0       0.0              0.0            0.0       0.0              0.0            0.0       0.0
buffer is not pinned count            177,662,097      285,236,508      60.6         27,740.0       22,615.4     -18.5        197,062.9      315,928.3      60.3            968.0        1,106.0      14.3
buffer is pinned count                179,300,974      287,542,236      60.4         27,995.9       22,798.2     -18.6        198,880.8      318,482.1      60.1            976.9        1,115.0      14.1
bytes received via SQL*Net fro        346,648,249      485,538,094      40.1         54,125.3       38,496.6     -28.9        384,502.5      537,782.6      39.9          1,888.7        1,882.7      -0.3
bytes sent via SQL*Net to clie        767,717,895    1,076,635,526      40.2        119,870.7       85,362.5     -28.8        851,553.3    1,192,482.8      40.0          4,182.9        4,174.8      -0.2
calls to get snapshot scn: kcm          1,133,782        1,594,652      40.6            177.0          126.4     -28.6          1,257.6        1,766.2      40.4              6.2            6.2       0.0
calls to kcmgas                           235,694          349,201      48.2             36.8           27.7     -24.8            261.4          386.8      47.9              1.3            1.4       5.5
calls to kcmgcs                           726,676        1,018,866      40.2            113.5           80.8     -28.8            806.0        1,128.5      40.0              4.0            4.0      -0.3
cell physical IO interconnect       7,982,754,816   11,859,735,552      48.6      1,246,419.4      940,315.5     -24.6      8,854,478.2   13,135,857.9      48.4         43,494.2       45,987.9       5.7
change write time                           1,300            2,200      69.2              0.2            0.2     -15.0              1.4            2.4      69.4              0.0            0.0       0.0
cleanout - number of ktugct ca             32,874           46,800      42.4              5.1            3.7     -27.7             36.5           51.8      42.2              0.2            0.2       0.0
cleanouts and rollbacks - cons             23,363           33,596      43.8              3.6            2.7     -27.1             25.9           37.2      43.6              0.1            0.1       0.0
cleanouts only - consistent re              1,731              987     -43.0              0.3            0.1     -70.4              1.9            1.1     -43.2              0.0            0.0    -100.0
cluster key scan block gets                    60            3,867   6,345.0              0.0            0.3   3,000.0              0.1            4.3   6,014.3              0.0            0.0     100.0
cluster key scans                              60            3,164   5,173.3              0.0            0.3   2,400.0              0.1            3.5   4,900.0              0.0            0.0     100.0
commit batch/immediate perform                 18               33      83.3              0.0            0.0       0.0              0.0            0.0     100.0              0.0            0.0       0.0
commit batch/immediate request                 18               33      83.3              0.0            0.0       0.0              0.0            0.0     100.0              0.0            0.0       0.0
commit cleanout failures: buff                  9               39     333.3              0.0            0.0       0.0              0.0            0.0     300.0              0.0            0.0       0.0
commit cleanout failures: call                 94              227     141.5              0.0            0.0     100.0              0.1            0.3     150.0              0.0            0.0       0.0
commit cleanout failures: cann              4,927            7,538      53.0              0.8            0.6     -22.1              5.5            8.3      52.7              0.0            0.0       0.0
Other Instance Activity Stats   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by statistic name

                                                    Value                                per Second (DB time)                   per Second (Elapsed Time)                         per Trans
                                 -------------------------------------------   ---------------------------------------   ---------------------------------------   ---------------------------------------
Statistic                                     1st              2nd     %Diff              1st            2nd     %Diff              1st            2nd     %Diff              1st            2nd     %Diff
------------------------------   ---------------- ---------------- ---------   -------------- -------------- ---------   -------------- -------------- ---------   -------------- -------------- ---------
commit cleanouts                          757,256        1,058,902      39.8            118.2           84.0     -29.0            839.9        1,172.8      39.6              4.1            4.1      -0.5
commit cleanouts successfully             752,226        1,051,088      39.7            117.5           83.3     -29.0            834.4        1,164.2      39.5              4.1            4.1      -0.5
commit immediate performed                     18               33      83.3              0.0            0.0       0.0              0.0            0.0     100.0              0.0            0.0       0.0
commit immediate requested                     18               33      83.3              0.0            0.0       0.0              0.0            0.0     100.0              0.0            0.0       0.0
commit txn count during cleano             47,753           72,206      51.2              7.5            5.7     -23.3             53.0           80.0      51.0              0.3            0.3       7.7
consistent changes                        100,357          173,518      72.9             15.7           13.8     -12.2            111.3          192.2      72.6              0.5            0.7      21.8
consistent gets                       362,913,878      581,211,846      60.2         56,665.0       46,082.2     -18.7        402,544.4      643,751.0      59.9          1,977.3        2,253.7      14.0
consistent gets - examination         236,188,959      379,363,286      60.6         36,878.3       30,078.3     -18.4        261,981.0      420,183.2      60.4          1,286.9        1,471.0      14.3
consistent gets from cache            362,913,875      581,211,847      60.2         56,665.0       46,082.2     -18.7        402,544.4      643,751.0      59.9          1,977.3        2,253.7      14.0
consistent gets from cache (fa        126,504,818      201,512,179      59.3         19,752.3       15,977.2     -19.1        140,319.2      223,195.1      59.1            689.3          781.4      13.4
cursor authentications                          5               47     840.0              0.0            0.0       0.0              0.0            0.1     400.0              0.0            0.0       0.0
data blocks consistent reads -             90,673          160,463      77.0             14.2           12.7     -10.2            100.6          177.7      76.7              0.5            0.6      26.5
db block gets                           3,483,003        4,822,132      38.4            543.8          382.3     -29.7          3,863.3        5,341.0      38.2             19.0           18.7      -1.5
db block gets direct                           27               60     122.2              0.0            0.0       0.0              0.0            0.1     133.3              0.0            0.0       0.0
db block gets from cache                3,482,976        4,822,072      38.4            543.8          382.3     -29.7          3,863.3        5,340.9      38.2             19.0           18.7      -1.5
db block gets from cache (fast          1,190,104        1,653,627      38.9            185.8          131.1     -29.4          1,320.1        1,831.6      38.7              6.5            6.4      -1.1
deferred (CURRENT) block clean            265,326          371,815      40.1             41.4           29.5     -28.8            294.3          411.8      39.9              1.4            1.4      -0.7
dirty buffers inspected                   209,279          363,770      73.8             32.7           28.8     -11.8            232.1          402.9      73.6              1.1            1.4      23.7
enqueue conversions                           579              563      -2.8              0.1            0.0     -55.6              0.6            0.6      -3.1              0.0            0.0       0.0
enqueue releases                          443,391          619,926      39.8             69.2           49.2     -29.0            491.8          686.6      39.6              2.4            2.4      -0.8
enqueue requests                          443,403          619,934      39.8             69.2           49.2     -29.0            491.8          686.6      39.6              2.4            2.4      -0.8
enqueue waits                                 691            1,266      83.2              0.1            0.1      -9.1              0.8            1.4      81.8              0.0            0.0       0.0
free buffer inspected                     568,832          865,517      52.2             88.8           68.6     -22.7            630.9          958.6      51.9              3.1            3.4       8.4
free buffer requested                     584,574          878,713      50.3             91.3           69.7     -23.7            648.4          973.3      50.1              3.2            3.4       6.9
heap block compress                           576              865      50.2              0.1            0.1     -22.2              0.6            1.0      50.0              0.0            0.0       0.0
hot buffers moved to head of L            267,499          478,074      78.7             41.8           37.9      -9.3            296.7          529.5      78.5              1.5            1.9      26.7
immediate (CR) block cleanout              25,094           34,583      37.8              3.9            2.7     -30.1             27.8           38.3      37.6              0.1            0.1      -7.1
immediate (CURRENT) block clea             29,435           40,597      37.9              4.6            3.2     -30.0             32.6           45.0      37.7              0.2            0.2       0.0
index fast full scans (full)                    2                2       0.0              0.0            0.0       0.0              0.0            0.0       0.0              0.0            0.0       0.0
index fetch by key                     58,944,680       94,692,078      60.6          9,203.6        7,507.8     -18.4         65,381.5      104,881.1      60.4            321.2          367.2      14.3
index scans kdiixs1                    58,760,496       94,436,438      60.7          9,174.8        7,487.5     -18.4         65,177.2      104,597.9      60.5            320.2          366.2      14.4
leaf node 90-10 splits                         20               18     -10.0              0.0            0.0       0.0              0.0            0.0       0.0              0.0            0.0       0.0
leaf node splits                            1,611            1,958      21.5              0.3            0.2     -36.0              1.8            2.2      21.2              0.0            0.0       0.0
lob writes                                     80              110      37.5              0.0            0.0       0.0              0.1            0.1      33.3              0.0            0.0       0.0
lob writes unaligned                           80              110      37.5              0.0            0.0       0.0              0.1            0.1      33.3              0.0            0.0       0.0
logical read bytes from cache    3.0015229460E+12 4.8007900856E+12      59.9    468,654,797.6  380,637,283.7     -18.8   3.32929172E+09 5.31736108E+09      59.7     16,353,864.9   18,615,794.8      13.8
max cf enq hold time                           10               30     200.0              0.0            0.0       0.0              0.0            0.0     200.0              0.0            0.0       0.0
messages received                         207,981          288,184      38.6             32.5           22.8     -29.6            230.7          319.2      38.4              1.1            1.1      -0.9
messages sent                             207,981          288,184      38.6             32.5           22.8     -29.6            230.7          319.2      38.4              1.1            1.1      -0.9
min active SCN optimization ap            159,883          225,820      41.2             25.0           17.9     -28.3            177.3          250.1      41.0              0.9            0.9       1.1
no work - consistent read gets        125,842,864      200,598,432      59.4         19,649.0       15,904.7     -19.1        139,585.0      222,183.1      59.2            685.7          777.9      13.4
non-idle wait count                     2,527,015        3,587,074      41.9            394.6          284.4     -27.9          2,803.0        3,973.0      41.7             13.8           13.9       1.0
parse count (hard)                              5              332   6,540.0              0.0            0.0     100.0              0.0            0.4   3,600.0              0.0            0.0       0.0
parse time cpu                              1,883            3,139      66.7              0.3            0.2     -13.8              2.1            3.5      66.5              0.0            0.0       0.0
physical read IO requests                 521,753          773,429      48.2             81.5           61.3     -24.7            578.7          856.7      48.0              2.8            3.0       5.6
physical read bytes                 4,283,432,960    6,341,222,400      48.0        668,810.9      502,772.6     -24.8      4,751,187.4    7,023,545.8      47.8         23,338.4       24,589.1       5.4
physical read total IO request            524,482          776,320      48.0             81.9           61.6     -24.8            581.8          859.9      47.8              2.9            3.0       5.2
physical read total bytes           4,327,405,568    6,387,666,944      47.6        675,676.8      506,455.0     -25.0      4,799,961.8    7,074,987.9      47.4         23,578.0       24,769.2       5.1
physical read total multi bloc                  5                2     -60.0              0.0            0.0       0.0              0.0            0.0    -100.0              0.0            0.0       0.0
physical reads cache                      522,825          773,993      48.0             81.6           61.4     -24.8            579.9          857.3      47.8              2.8            3.0       5.3
physical reads cache prefetch               1,170              676     -42.2              0.2            0.1     -72.2              1.3            0.7     -42.3              0.0            0.0    -100.0
physical reads direct                          55               82      49.1              0.0            0.0       0.0              0.1            0.1      50.0              0.0            0.0       0.0
physical write IO requests                236,463          383,680      62.3             36.9           30.4     -17.6            262.3          425.0      62.0              1.3            1.5      15.5
physical write bytes                2,788,556,800    4,275,765,248      53.3        435,402.5      339,010.0     -22.1      3,093,069.5    4,735,842.9      53.1         15,193.5       16,579.9       9.1
physical write total IO reques            597,121          876,098      46.7             93.2           69.5     -25.5            662.3          970.4      46.5              3.3            3.4       4.6
physical write total bytes          3,655,349,248    5,472,060,416      49.7        570,742.6      433,859.9     -24.0      4,054,516.4    6,060,860.9      49.5         19,916.3       21,218.7       6.5
physical write total multi blo              1,099              362     -67.1              0.2            0.0     -82.4              1.2            0.4     -67.2              0.0            0.0    -100.0
physical writes direct                         82              130      58.5              0.0            0.0       0.0              0.1            0.1      55.6              0.0            0.0       0.0
physical writes from cache                340,318          521,814      53.3             53.1           41.4     -22.1            377.5          578.0      53.1              1.9            2.0       9.2
physical writes non checkpoint            268,955          426,917      58.7             42.0           33.8     -19.4            298.3          472.9      58.5              1.5            1.7      12.9
Other Instance Activity Stats   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by statistic name

                                                    Value                                per Second (DB time)                   per Second (Elapsed Time)                         per Trans
                                 -------------------------------------------   ---------------------------------------   ---------------------------------------   ---------------------------------------
Statistic                                     1st              2nd     %Diff              1st            2nd     %Diff              1st            2nd     %Diff              1st            2nd     %Diff
------------------------------   ---------------- ---------------- ---------   -------------- -------------- ---------   -------------- -------------- ---------   -------------- -------------- ---------
pinned buffers inspected                       39               95     143.6              0.0            0.0       0.0              0.0            0.1     175.0              0.0            0.0       0.0
prefetched blocks aged out bef                  1                2     100.0              0.0            0.0       0.0              0.0            0.0       0.0              0.0            0.0       0.0
recursive calls                           193,830          289,598      49.4             30.3           23.0     -24.1            215.0          320.8      49.2              1.1            1.1       5.7
recursive cpu usage                         1,536            2,360      53.6              0.2            0.2     -20.8              1.7            2.6      53.5              0.0            0.0       0.0
redo blocks checksummed by FG             292,518          296,116       1.2             45.7           23.5     -48.6            324.5          328.0       1.1              1.6            1.1     -27.7
redo blocks written                       826,743        1,147,045      38.7            129.1           90.9     -29.5            917.0        1,270.5      38.5              4.5            4.4      -1.1
redo buffer allocation retries                174              443     154.6              0.0            0.0      33.3              0.2            0.5     157.9              0.0            0.0       0.0
redo entries                              649,827        1,192,536      83.5            101.5           94.6      -6.8            720.8        1,320.9      83.3              3.5            4.6      30.5
redo log space requests                       176              471     167.6              0.0            0.0      33.3              0.2            0.5     160.0              0.0            0.0       0.0
redo ordering marks                         6,115           11,159      82.5              1.0            0.9      -7.4              6.8           12.4      82.3              0.0            0.0      33.3
redo size for direct writes                   208              780     275.0              0.0            0.1     100.0              0.2            0.9     273.9              0.0            0.0       0.0
redo subscn max counts                     16,125           28,537      77.0              2.5            2.3     -10.3             17.9           31.6      76.7              0.1            0.1      22.2
redo synch long waits                         187              847     352.9              0.0            0.1     133.3              0.2            0.9     347.6              0.0            0.0       0.0
redo synch time                             9,601           26,962     180.8              1.5            2.1      42.7             10.6           29.9     180.4              0.1            0.1     100.0
redo synch time (usec)                 96,015,263      269,626,508     180.8         14,991.7       21,377.7      42.6        106,500.2      298,638.7     180.4            523.1        1,045.5      99.9
redo synch writes                         183,545          257,926      40.5             28.7           20.5     -28.6            203.6          285.7      40.3              1.0            1.0       0.0
redo wastage                           55,374,424       70,121,084      26.6          8,646.1        5,559.6     -35.7         61,421.4       77,666.2      26.4            301.7          271.9      -9.9
redo write time                             5,260           12,621     139.9              0.8            1.0      22.0              5.8           14.0     139.8              0.0            0.0      66.7
redo writes                               178,894          242,728      35.7             27.9           19.2     -31.1            198.4          268.8      35.5              1.0            0.9      -3.1
rollback changes - undo record                 48              125     160.4              0.0            0.0       0.0              0.1            0.1     180.0              0.0            0.0       0.0
rollbacks only - consistent re             19,770           41,584     110.3              3.1            3.3       6.8             21.9           46.1     110.0              0.1            0.2      45.5
rows fetched via callback              58,794,764       94,478,496      60.7          9,180.2        7,490.9     -18.4         65,215.2      104,644.5      60.5            320.3          366.4      14.4
session pga memory                      5,621,280       36,228,832     544.5            877.7        2,872.5     227.3          6,235.1       40,127.1     543.6             30.6          140.5     358.6
session pga memory max                 12,223,360       59,462,688     386.5          1,908.5        4,714.6     147.0         13,558.2       65,860.9     385.8             66.6          230.6     246.2
session uga memory                  4,295,894,744    4,302,374,568       0.2        670,756.7      341,119.7     -49.1      4,765,010.0    4,765,315.4       0.0         23,406.3       16,683.1     -28.7
session uga memory max                 25,936,856       49,050,984      89.1          4,049.8        3,889.1      -4.0         28,769.2       54,328.9      88.8            141.3          190.2      34.6
shared hash latch upgrades - n            309,676          428,124      38.2             48.4           33.9     -29.8            343.5          474.2      38.1              1.7            1.7      -1.8
shared hash latch upgrades - w                 30               54      80.0              0.0            0.0       0.0              0.0            0.1     100.0              0.0            0.0       0.0
sorts (memory)                                445            2,106     373.3              0.1            0.2     142.9              0.5            2.3     375.5              0.0            0.0     100.0
sorts (rows)                               16,322           27,417      68.0              2.5            2.2     -14.9             18.1           30.4      67.8              0.1            0.1      22.2
summed dirty queue length               1,935,798        3,184,848      64.5            302.3          252.5     -16.5          2,147.2        3,527.5      64.3             10.5           12.3      17.1
switch current to new buffer                  342              712     108.2              0.1            0.1      20.0              0.4            0.8     107.9              0.0            0.0       0.0
table fetch by rowid                  119,629,777      191,823,399      60.3         18,678.9       15,209.0     -18.6        132,693.4      212,463.8      60.1            651.8          743.8      14.1
table scan blocks gotten                6,180,629        8,684,649      40.5            965.0          688.6     -28.6          6,855.6        9,619.1      40.3             33.7           33.7       0.0
table scan rows gotten                220,747,132      310,139,845      40.5         34,467.2       24,589.9     -28.7        244,852.9      343,511.3      40.3          1,202.7        1,202.6      -0.0
table scans (short tables)                220,455          309,789      40.5             34.4           24.6     -28.6            244.5          343.1      40.3              1.2            1.2       0.0
total cf enq hold time                      3,250            4,930      51.7              0.5            0.4     -23.5              3.6            5.5      51.7              0.0            0.0       0.0
total number of cf enq holders                 79               90      13.9              0.0            0.0       0.0              0.1            0.1      11.1              0.0            0.0       0.0
total number of times SMON pos                 28               41      46.4              0.0            0.0       0.0              0.0            0.0      66.7              0.0            0.0       0.0
transaction rollbacks                          15               32     113.3              0.0            0.0       0.0              0.0            0.0     100.0              0.0            0.0       0.0
undo change vector size               119,248,856      164,305,732      37.8         18,619.4       13,027.2     -30.0        132,270.9      181,985.2      37.6            649.7          637.1      -1.9
write clones created in foregr                123              670     444.7              0.0            0.1     150.0              0.1            0.7     428.6              0.0            0.0       0.0
                          --------------------------------------------------------------------------------------------------------------------

IOStat by Function - Data Rate per Second   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Total Reads includes all Functions: Buffer Cache, Direct Reads, ARCH, Data Pump, Others, RMAN, Recovry, Streams/AQ and XDB
-> Total Writes includes all Functions: DBWR, Direct Writes,  LGWR, ARCH, Data Pump, Others, RMAN, Recovry, Streams/AQ and XDB

            Total Reads                    Buffer Cache Reads                  Direct Reads                       Total Writes                           DBWR                         Direct Writes                        LGWR
----------------------------------   ------------------------------   ------------------------------   ----------------------------------   ------------------------------   ------------------------------   ------------------------------
         1st          2nd    %Diff          1st        2nd    %Diff          1st        2nd    %Diff            1st          2nd    %Diff          1st        2nd    %Diff          1st        2nd    %Diff          1st        2nd    %Diff
------------ ------------ --------   ---------- ---------- --------   ---------- ---------- --------   ------------ ------------ --------   ---------- ---------- --------   ---------- ---------- --------   ---------- ---------- --------
         4.6          6.8     47.6          4.5        6.7     48.1          0.0        0.0      0.0            3.9          5.8     49.6          2.9        4.5     53.6          0.0        0.0      0.0          0.9        1.2     38.9
                          --------------------------------------------------------------------------------------------------------------------

IOStat by Function - Requests per Second   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Total Reads includes all Functions: Buffer Cache, Direct Reads, ARCH, Data Pump, Others, RMAN, Recovry, Streams/AQ and XDB
-> Total Writes includes all Functions: DBWR, Direct Writes,  LGWR, ARCH, Data Pump, Others, RMAN, Recovry, Streams/AQ and XDB

            Total Reads                    Buffer Cache Reads                  Direct Reads                       Total Writes                           DBWR                         Direct Writes                        LGWR
----------------------------------   ------------------------------   ------------------------------   ----------------------------------   ------------------------------   ------------------------------   ------------------------------
         1st          2nd    %Diff          1st        2nd    %Diff          1st        2nd    %Diff            1st          2nd    %Diff          1st        2nd    %Diff          1st        2nd    %Diff          1st        2nd    %Diff
------------ ------------ --------   ---------- ---------- --------   ---------- ---------- --------   ------------ ------------ --------   ---------- ---------- --------   ---------- ---------- --------   ---------- ---------- --------
       581.9        861.5     48.0        578.8      858.2     48.3          0.1        0.1     33.3          662.4        972.5     46.8        262.2      425.9     62.4          0.0        0.0     25.0        399.0      545.4     36.7
                          --------------------------------------------------------------------------------------------------------------------

IOStat by File Type - Data Rate per Second   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Total Reads  includes all Filetypes: Data File, Temp File, Archive Log, Backups, Control File, Data Pump Dump File, Flashback Log, Log File, Other, etc
-> Total Writes includes all Filetypes: Data File, Temp File, Log File, Archive Log, Backup, Control File, Data Pump Dump File, Flasbachk Log, Log File, Other, etc

            Total Reads                      Data File Reads                  Temp File Reads                     Total Writes                     Data File Writes                 Temp File Writes                  Log File Writes
----------------------------------   ------------------------------   ------------------------------   ----------------------------------   ------------------------------   ------------------------------   ------------------------------
         1st          2nd    %Diff          1st        2nd    %Diff          1st        2nd    %Diff            1st          2nd    %Diff          1st        2nd    %Diff          1st        2nd    %Diff          1st        2nd    %Diff
------------ ------------ --------   ---------- ---------- --------   ---------- ---------- --------   ------------ ------------ --------   ---------- ---------- --------   ---------- ---------- --------   ---------- ---------- --------
         4.6          6.8     47.6          4.5        6.7     48.1          0.0        0.0      0.0            3.9          5.8     49.6          3.0        4.5     53.2          0.0        0.0      0.0          0.9        1.2     37.8
                          --------------------------------------------------------------------------------------------------------------------

IOStat by File Type - Requests per Second   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Total Reads  includes all Filetypes: Data File, Temp File, Archive Log, Backups, Control File, Data Pump Dump File, Flashback Log, Log File, Other, etc
-> Total Writes includes all Filetypes: Data File, Temp File, Log File, Archive Log, Backup, Control File, Data Pump Dump File, Flasbachk Log, Log File, Other, etc

            Total Reads                      Data File Reads                  Temp File Reads                     Total Writes                     Data File Writes                 Temp File Writes                  Log File Writes
----------------------------------   ------------------------------   ------------------------------   ----------------------------------   ------------------------------   ------------------------------   ------------------------------
         1st          2nd    %Diff          1st        2nd    %Diff          1st        2nd    %Diff            1st          2nd    %Diff          1st        2nd    %Diff          1st        2nd    %Diff          1st        2nd    %Diff
------------ ------------ --------   ---------- ---------- --------   ---------- ---------- --------   ------------ ------------ --------   ---------- ---------- --------   ---------- ---------- --------   ---------- ---------- --------
       581.9        861.5     48.0        578.9      858.3     48.3          0.0        0.0      0.0          662.4        972.3     46.8        262.3      425.8     62.3          0.0        0.0      0.0        398.8      545.1     36.7
                          --------------------------------------------------------------------------------------------------------------------

Tablespace IO Stats   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of 'Diff' of IOs per second descending (IOs per sec: Avg Reads/Sec + Avg Writes/Sec)
-> Only contains tablespaces with at least 100 IOs
-> 'N/A' indicates the tablespace did not exist in the database for the period

Tablespace
------------------------------
        Avg Reads / Sec                   Avg Writes / Sec                    Reads               Avg Read Time (ms)      Avg Blocks / Read               Writes                   Buffer Waits         Avg Buf Wait Time (ms)            IOs per second
-------------------------------   -------------------------------   -------------------------   ---------------------   ---------------------   -------------------------   -------------------------   ---------------------   --------------------------------
       1st        2nd     %Diff          1st        2nd     %Diff            1st          2nd          1st        2nd          1st        2nd            1st          2nd            1st          2nd          1st        2nd          1st        2nd       Diff
---------- ---------- ---------   ---------- ---------- ---------   ------------ ------------   ---------- ----------   ---------- ----------   ------------ ------------   ------------ ------------   ---------- ----------   ---------- ---------- ----------
SOE
     576.6      852.4      47.8        260.2      420.9      61.8        519,831      769,580          8.8       12.1          1.0        1.0        234,576      379,976          3,270        5,012          8.4       10.3        836.8    1,273.2      436.5
UNDOTBS1
       0.1        0.1      11.1          1.5        3.1     106.6             83           89          6.0       10.7          1.0        1.0          1,363        2,817             52          113          0.2        0.3          1.6        3.2        1.6
SYSTEM
       0.3        1.3     415.4          0.0        0.0      33.3            230        1,214         10.5        9.3          3.3        1.3             26           32              1           63          0.0        2.4          0.3        1.4        1.1
SYSAUX
       1.6        1.5      -9.8          0.6        0.7      19.6          1,475        1,333          6.4        6.9          1.4        1.2            502          609              0            0          0.0        0.0          2.2        2.2       -0.0
                          --------------------------------------------------------------------------------------------------------------------

Top File Comparison by IO   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of 'Diff' of IOs per second descending (IOs per sec: Avg Reads/Sec + Avg Writes/Sec)
-> Only contains files with at least 100 IOs

Tablespace                     Filename
------------------------------ --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        Avg Reads / Sec                   Avg Writes / Sec                    Reads               Avg Read Time (ms)      Avg Blocks / Read               Writes                   Buffer Waits         Avg Buf Wait Time (ms)            IOs per second
-------------------------------   -------------------------------   -------------------------   ---------------------   ---------------------   -------------------------   -------------------------   ---------------------   --------------------------------
       1st        2nd     %Diff          1st        2nd     %Diff            1st          2nd          1st        2nd          1st        2nd            1st          2nd            1st          2nd          1st        2nd          1st        2nd       Diff
---------- ---------- ---------   ---------- ---------- ---------   ------------ ------------   ---------- ----------   ---------- ----------   ------------ ------------   ------------ ------------   ---------- ----------   ---------- ---------- ----------
SOE                            +DATA/dbm11203/datafile/soe.486.836957131
     576.6      852.4      47.8        260.2      420.9      61.8        519,831      769,580          8.8       12.1          1.0        1.0        234,576      379,976          3,270        5,012          8.4       10.3        836.8    1,273.2      436.5
UNDOTBS1                       +DATA/dbm11203/datafile/undotbs1.461.772715929
       0.1        0.1      11.1          1.5        3.1     106.6             83           89          6.0       10.7          1.0        1.0          1,363        2,817             52          113          0.2        0.3          1.6        3.2        1.6
SYSTEM                         +DATA/dbm11203/datafile/system.459.772715923
       0.3        1.3     415.4          0.0        0.0      33.3            230        1,214         10.5        9.3          3.3        1.3             26           32              1           63          0.0        2.4          0.3        1.4        1.1
SYSAUX                         +DATA/dbm11203/datafile/sysaux.460.772715927
       1.6        1.5      -9.8          0.6        0.7      19.6          1,475        1,333          6.4        6.9          1.4        1.2            502          609              0            0          0.0        0.0          2.2        2.2       -0.0
                          --------------------------------------------------------------------------------------------------------------------

Top File Comparison by Read Time   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by files with greatest 'Read Time % of DB time' from either period, descending
-> Only contains files with at least 100 IOs

Tablespace                     Filename
------------------------------ --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Read Time % of DB time     Avg Read Time (ms)              Reads               Avg Reads per Sec      Avg Blocks per Read              Writes              Avg Writes per Sec           Buffer Waits         Avg Buf Wait Time (ms)
--------------------   ---------------------   -------------------------   ---------------------   ---------------------   -------------------------   ---------------------   -------------------------   ---------------------
   1st    2nd   Diff          1st        2nd            1st          2nd          1st        2nd          1st        2nd            1st          2nd          1st        2nd            1st          2nd          1st        2nd
------ ------ ------   ---------- ----------   ------------ ------------   ---------- ----------   ---------- ----------   ------------ ------------   ---------- ----------   ------------ ------------   ---------- ----------
SOE                            +DATA/dbm11203/datafile/soe.486.836957131
  71.3   73.9    2.6          8.8       12.1        519,831      769,580        576.6      852.4          1.0        1.0        234,576      379,976        260.2      420.9          3,270        5,012          0.8        1.0
SYSAUX                         +DATA/dbm11203/datafile/sysaux.460.772715927
   0.1    0.1   -0.1          6.4        6.9          1,475        1,333          1.6        1.5          1.4        1.2            502          609          0.6        0.7              0            0          0.0        0.0
SYSTEM                         +DATA/dbm11203/datafile/system.459.772715923
   0.0    0.1    0.1         10.5        9.3            230        1,214          0.3        1.3          3.3        1.3             26           32          0.0        0.0              1           63          0.0        0.2
UNDOTBS1                       +DATA/dbm11203/datafile/undotbs1.461.772715929
   0.0    0.0   -0.0          6.0       10.7             83           89          0.1        0.1          1.0        1.0          1,363        2,817          1.5        3.1             52          113          0.0        0.0
                          --------------------------------------------------------------------------------------------------------------------

Top File Comparison by Buffer Waits   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by files with greatest 'Wait Time % of DB time' from either period descending
-> Contains only entries with at least 1 second of wait time

Tablespace                     Filename
------------------------------ --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Wait Time % of DB time           Buffer Waits         Avg Buf Wait Time (ms)             Reads               Avg Reads per Sec       Avg Read Time (ms)     Avg Blocks per Read              Writes                Avg Writes per Sec
------------------------   -------------------------   ---------------------   -------------------------   ---------------------   ---------------------   ---------------------   -------------------------   -------------------------
     1st      2nd   Diff            1st          2nd          1st        2nd            1st          2nd          1st        2nd          1st        2nd          1st        2nd            1st          2nd            1st          2nd
-------- -------- ------   ------------ ------------   ---------- ----------   ------------ ------------   ---------- ----------   ---------- ----------   ---------- ----------   ------------ ------------   ------------ ------------
SOE                            +DATA/dbm11203/datafile/soe.486.836957131
     0.4      0.4   -0.0          3,270        5,012          0.8        1.0        519,831      769,580        576.6      852.4          8.8       12.1          1.0        1.0        234,576      379,976            260          421
                          --------------------------------------------------------------------------------------------------------------------

Instance Recovery Stats   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> B: Begin Snapshot,  E: End snapshot

                                                                                                                          Estimated
                                                                                                    Log Ckpt     Optimal    Cluster
        Target     Estimated Recovery     Actual       Target       Log File Siz Log Ckpt Tim        Interval   Log File  Available
        MTTR(s)      MTTR(s) Estimated IO Redo Blocks  Redo Blocks  Redo Blocks  Redo Blocks  Redo Blocks      Size (Mb)  Time (s)
-- ------------ ------------ ------------ ------------ ------------ ------------ ------------ --------------- ---------- ----------
B1            0           19       20,987      167,937      165,888      165,888      445,422
E1            0           19       21,454      167,685      165,888      165,888      384,637

B2            0           18       16,165      167,866      165,888      165,888      417,367
E2            0           18       16,018      169,373      165,888      165,888      413,717
                          --------------------------------------------------------------------------------------------------------------------

PGA Aggregate Summary   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> PGA Cache Hit % - percentage of W/A (Work Area) data processed  in-memory only

         PGA Cache Hit %                  W/A Bytes/Sec (DB time)              W/A MB Processed       Read/Written W/A Bytes/Sec (DB time)      Read/Written W/A MB
--------------------------------   ------------------------------------   -------------------------   ------------------------------------   -------------------------
       1st        2nd       Diff            1st          2nd      %Diff            1st          2nd            1st          2nd      %Diff            1st          2nd
---------- ---------- ----------   ------------ ------------ ----------   ------------ ------------   ------------ ------------ ----------   ------------ ------------
     100.0      100.0        0.0         11,684        6,084      -47.9             71           73              0            0        0.0              0            0
                          --------------------------------------------------------------------------------------------------------------------

PGA Aggr Target Stats   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> B1: 1st Begin Snap   E1: 1st End Snap   B2: 2nd Begin Snap   E2: 2nd End Snap
-> Data shown in the table represent actual values, i.e. not diffed over the interval
-> Auto PGA Target - actual workarea memory target
-> W/A PGA Used    - amount of memory used for all Workareas (manual + auto)
-> %PGA W/A Mem    - percentage of PGA memory allocated to workareas
-> %Auto W/A Mem   - percentage of workarea memory controlled by Auto Mem Mgmt
-> %Man W/A Mem    - percentage of workarea memory under manual control

   PGA Aggr Target(M) Auto PGA Target(M) PGA Mem Alloc(M) W/A PGA Used(M) %PGA W/A Mem %Auto W/A Mem %Man W/A Mem Global Mem Bound(K)
-- ------------------ ------------------ ---------------- --------------- ------------ ------------- ------------ -------------------
B1                128                  8            178.2             0.0          0.0           0.0          0.0              26,214
E1                128                  8            181.2             0.0          0.0           0.0          0.0              26,214

B2                128                  8            184.9             0.0          0.0           0.0          0.0              26,214
E2                128                  8            217.0             0.0          0.0           0.0          0.0              26,214
                          --------------------------------------------------------------------------------------------------------------------

Buffer Wait Statistics   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of 'Diff' column of 'Wait Time % of DB time' descending

                          Wait Time % of DB time             Total Wait Time (s)                   # Waits                         Avg Wait Time (ms)
                     --------------------------------   -----------------------------   -----------------------------   ----------------------------------------
Class                       1st        2nd       Diff              1st            2nd              1st            2nd              1st            2nd      %Diff
------------------   ---------- ---------- ----------   -------------- --------------   -------------- --------------   -------------- -------------- ----------
data block                  0.0        0.0       -0.0             27.4           51.6            3,275          5,028              0.1            0.1       25.0
segment header              0.0        0.0        0.0              0.0            0.1                0             22              0.0            0.0      100.0
3rd level bmb               0.0        0.0        0.0              0.0            0.0                0             11              0.0            0.0      100.0
2nd level bmb               0.0        0.0        0.0              0.0            0.0                0              9              0.0            0.0      100.0
undo header                 0.0        0.0        0.0              0.0            0.0               28             44              0.0            0.0        0.0
undo block                  0.0        0.0       -0.0              0.0            0.0               24             69              0.0            0.0        0.0
1st level bmb               0.0        0.0        0.0              0.0            0.0                0              2              0.0            0.0        0.0
                          --------------------------------------------------------------------------------------------------------------------

Enqueue Activity   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of 'Diff' Column of 'Wait Time % of DB time ' descending
-> Contains only entries with total wait time above 1 second

                                                    Wait Time % of DB time          Wait Time                   Requests                Successful Gets             Failed Gets                 Waits                Avg Wait Time (ms)
                                                     --------------------   -----------------------   -------------------------   -------------------------   ---------------------   -----------------------   -------------------------
Enqueue Type (Request Reason)                           1st    2nd   Diff           1st         2nd            1st          2nd            1st          2nd          1st        2nd           1st         2nd            1st          2nd
--------------------------------------------------   ------ ------ ------   ----------- -----------   ------------ ------------   ------------ ------------   ---------- ----------   ----------- -----------   ------------ ------------
TX-Transaction (row lock contention)                    0.0    0.0    0.0             1           2            686        1,236            686        1,236            0          0           684       1,230            1.2          1.8
                          --------------------------------------------------------------------------------------------------------------------

Undo Segment Summary   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Min/Max TR (mins) - Min and Max Tuned Retention (minutes)
-> STO - Snapshot Too Old count,  OOS - Out of Space count
-> Undo segment block stats:
-> uS - unexpired Stolen,   uR - unexpired Released,   uU - unexpired reUsed
-> eS - expired   Stolen,   eR - expired   Released,   eU - expired   reUsed

   Num Undo       Number of  Max Qry   Max Tx Min/Max   STO/     uS/uR/uU/
 Blocks (K)    Transactions  Len (s) Concurcy TR (mins) OOS      eS/eR/eU
 ---------- --------------- -------- -------- --------- ----- ---------------
1st        31.8         369,847      939       20 19.6/29.7 0/0   0/0/0/0/0/0
2nd        41.5         489,055      938       31 19.6/29.6 0/0   0/0/0/0/0/0
                          --------------------------------------------------------------------------------------------------------------------

Latch Sleep Breakdown   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of 'Diff' Column of '% of Total Sleeps' descending

                                        % of Total Sleeps           Get Requests                 Misses                Spin Gets                  Sleeps                      Wait Time (cs)
                                      --------------------   -------------------------   ---------------------   ---------------------   -----------------------   -----------------------------------
Latch Name                               1st    2nd   Diff            1st          2nd          1st        2nd          1st        2nd           1st         2nd           1st         2nd        Diff
-----------------------------------   ------ ------ ------   ------------ ------------   ---------- ----------   ---------- ----------   ----------- -----------   ----------- ----------- -----------
In memory undo latch                    21.5   13.0   -8.5      1,305,440    1,391,681          277        395          120        140           158         257        19,007      45,258      26,251
cache buffers chains                    61.1   68.4    7.3    505,924,400  804,374,724      239,995  1,488,116      239,545  1,486,761           450       1,355        55,570     338,795     283,225
simulator hash latch                     3.0    5.1    2.1     21,646,930   34,366,849        1,507      4,316        1,485      4,217            22         100         9,841     100,030      90,189
session idle bit                         4.3    2.7   -1.6      5,405,487    7,568,121          438      1,281          406      1,227            32          54         5,565      26,212      20,647
object queue header operation            1.9    2.7    0.8      2,330,854    3,523,023          450      1,146          436      1,093            14          54         3,496      16,294      12,798
redo allocation                          1.5    2.2    0.7        900,547    1,141,712          316      1,022          305        978            11          44         1,762      12,289      10,527
shared pool                              0.0    0.7    0.7          2,350       32,027            3         56            3         50             0          14             0      17,883      17,883
enqueue hash chains                      1.9    1.4   -0.5        888,071    1,240,957          227        459          213        431            14          28         3,154       8,762       5,608
row cache objects                        0.0    0.4    0.4          8,350       55,238            2         60            2         52             0           8             0       2,242       2,242
mostly latch-free SCN                    1.8    1.5   -0.3        182,081      247,788          635        958          622        929            13          29         4,930       4,677        -253
cache buffers lru chain                  1.4    1.2   -0.2        451,916      703,390          181        432          171        410            10          23           894       5,537       4,643
DML lock allocation                      0.5    0.4   -0.2        498,223      698,726           43         84           39         77             4           7           640       2,291       1,651
messages                                 0.3    0.2   -0.1        616,540      852,994          115        253          113        250             2           3           338         569         231
undo global data                         0.4    0.3   -0.1      1,065,491    1,411,978           73        266           70        260             3           6           675       1,061         386
Consistent RBA                           0.0    0.1    0.1        178,907      242,581            0          3            0          1             0           2             0       1,663       1,663
redo writing                             0.0    0.1    0.1        566,775      775,992           19         49           19         47             0           2             0         698         698
sequence cache                           0.0    0.1    0.1        154,907      216,625           23         95           23         93             0           2             0         111         111
session allocation                       0.0    0.1    0.1        183,644      257,900           19         57           19         55             0           2             0         335         335
checkpoint queue latch                   0.1    0.1   -0.1      1,348,925    2,062,780           41        124           40        123             1           1           134          35         -99
ASM map operation hash table             0.0    0.1    0.1      2,245,333    3,306,049            1         14            1         13             0           1             0         243         243
post/wait queue                          0.0    0.1    0.1        271,590      373,240           31         49           31         48             0           1             0         410         410
simulator lru latch                      0.4    0.5    0.0         20,843       32,455          148        413          145        404             3           9         3,967       9,434       5,467
                          --------------------------------------------------------------------------------------------------------------------

Latch Wait Time Breakdown   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of  'Diff' Column of 'Wait Time (cs)' descending

                                                 Wait Time (cs)                    Get Requests                 Misses                Spin Gets                  Sleeps             % of Total Sleeps
                                      -----------------------------------   -------------------------   ---------------------   ---------------------   -----------------------   --------------------
Latch Name                                    1st         2nd        Diff            1st          2nd          1st        2nd          1st        2nd           1st         2nd      1st    2nd   Diff
-----------------------------------   ----------- ----------- -----------   ------------ ------------   ---------- ----------   ---------- ----------   ----------- -----------   ------ ------ ------
cache buffers chains                       55,570     338,795     283,225    505,924,400  804,374,724      239,995  1,488,116      239,545  1,486,761           450       1,355     61.1   68.4    7.3
simulator hash latch                        9,841     100,030      90,189     21,646,930   34,366,849        1,507      4,316        1,485      4,217            22         100      3.0    5.1    2.1
In memory undo latch                       19,007      45,258      26,251      1,305,440    1,391,681          277        395          120        140           158         257     21.5   13.0   -8.5
session idle bit                            5,565      26,212      20,647      5,405,487    7,568,121          438      1,281          406      1,227            32          54      4.3    2.7   -1.6
shared pool                                     0      17,883      17,883          2,350       32,027            3         56            3         50             0          14      0.0    0.7    0.7
object queue header operation               3,496      16,294      12,798      2,330,854    3,523,023          450      1,146          436      1,093            14          54      1.9    2.7    0.8
redo allocation                             1,762      12,289      10,527        900,547    1,141,712          316      1,022          305        978            11          44      1.5    2.2    0.7
enqueue hash chains                         3,154       8,762       5,608        888,071    1,240,957          227        459          213        431            14          28      1.9    1.4   -0.5
simulator lru latch                         3,967       9,434       5,467         20,843       32,455          148        413          145        404             3           9      0.4    0.5    0.0
cache buffers lru chain                       894       5,537       4,643        451,916      703,390          181        432          171        410            10          23      1.4    1.2   -0.2
row cache objects                               0       2,242       2,242          8,350       55,238            2         60            2         52             0           8      0.0    0.4    0.4
Consistent RBA                                  0       1,663       1,663        178,907      242,581            0          3            0          1             0           2      0.0    0.1    0.1
DML lock allocation                           640       2,291       1,651        498,223      698,726           43         84           39         77             4           7      0.5    0.4   -0.2
redo writing                                    0         698         698        566,775      775,992           19         49           19         47             0           2      0.0    0.1    0.1
post/wait queue                                 0         410         410        271,590      373,240           31         49           31         48             0           1      0.0    0.1    0.1
undo global data                              675       1,061         386      1,065,491    1,411,978           73        266           70        260             3           6      0.4    0.3   -0.1
session allocation                              0         335         335        183,644      257,900           19         57           19         55             0           2      0.0    0.1    0.1
mostly latch-free SCN                       4,930       4,677        -253        182,081      247,788          635        958          622        929            13          29      1.8    1.5   -0.3
ASM map operation hash table                    0         243         243      2,245,333    3,306,049            1         14            1         13             0           1      0.0    0.1    0.1
messages                                      338         569         231        616,540      852,994          115        253          113        250             2           3      0.3    0.2   -0.1
sequence cache                                  0         111         111        154,907      216,625           23         95           23         93             0           2      0.0    0.1    0.1
checkpoint queue latch                        134          35         -99      1,348,925    2,062,780           41        124           40        123             1           1      0.1    0.1   -0.1
                          --------------------------------------------------------------------------------------------------------------------

Top Segments Comparison by Logical Reads   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of 'Diff' column of '% of Total Logical Reads'
-> Top    5 Segments from each period are compared
-> Total Logical Reads                   First:                  366,396,963, Second:                  586,033,175
-> Captured Logical Reads                First:                  365,671,472, Second:                  582,824,944
-> Captured Logical Reads as % of Total  First: 99.8%, Second: 99.45%
-> 'N/A' indicates no data was captured for the segment in the period

                                                                                                                                              % of Total Logical Reads                        Logical Reads              % of Captured Logical Reads
                                                                                                                                    --------------------------------------------   -----------------------------------   ----------------------
Owner                          Tablespace                     Object Name                    Subobject Name                 Type        1st  1st Total     2nd  2nd Total   Diff            1st          2nd     %Diff       1st     2nd   Diff
------------------------------ ------------------------------ ------------------------------ ------------------------------ -----   ------- ---------- ------- ---------- ------   ------------ ------------ ---------   ------- ------- ------
SOE                            SOE                            PRODUCT_INFORMATION                                           TABLE       1.9        1.9     1.7        1.7   -0.2      6,935,312    9,718,816      40.1       1.9     1.7   -0.2
SOE                            SOE                            CUSTOMERS                                                     TABLE      15.9       17.8    16.1       17.7    0.1     58,425,952   94,131,216      61.1      16.0    16.2    0.2
SOE                            SOE                            CUSTOMERS_PK                                                  INDEX      32.0       49.9    32.1       49.8    0.0    117,354,960  187,892,784      60.1      32.1    32.2    0.1
SOE                            SOE                            ITEM_ORDER_IX                                                 INDEX      32.1       82.0    32.1       81.9   -0.0    117,716,448  188,119,184      59.8      32.2    32.3    0.1
SOE                            SOE                            ORDERS                                                        TABLE      16.0       98.0    16.0       97.9   -0.0     58,667,760   93,754,880      59.8      16.0    16.1    0.0
                          --------------------------------------------------------------------------------------------------------------------

Top Segments Comparison by Physical Reads   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of 'Diff' column of '% of Total Physical Reads'
-> Top    5 Segments from each period are compared
-> Total Physical Reads                   First:                      522,880, Second:                      774,075
-> Captured Physical Reads                First:                      520,824, Second:                      769,360
-> Captured Physical Reads as % of Total  First: 99.61%, Second: 99.39%
-> 'N/A' indicates no data was captured for the segment in the period

                                                                                                                                              % of Total Physical Reads                       Physical Reads             % of Captured Physical Reads
                                                                                                                                    --------------------------------------------   -----------------------------------   ----------------------
Owner                          Tablespace                     Object Name                    Subobject Name                 Type        1st  1st Total     2nd  2nd Total   Diff            1st          2nd     %Diff       1st     2nd   Diff
------------------------------ ------------------------------ ------------------------------ ------------------------------ -----   ------- ---------- ------- ---------- ------   ------------ ------------ ---------   ------- ------- ------
SOE                            SOE                            CUSTOMERS_PK                                                  INDEX      19.8       19.8    18.1       18.1   -1.7        103,490      140,248      35.5      19.9    18.2   -1.6
SOE                            SOE                            INVENTORIES                                                   TABLE       9.1       28.9    10.5       28.7    1.4         47,667       81,655      71.3       9.2    10.6    1.5
SOE                            SOE                            CUSTOMERS                                                     TABLE      20.5       49.4    19.2       47.9   -1.3        107,285      148,566      38.5      20.6    19.3   -1.3
SOE                            SOE                            ORD_CUSTOMER_IX                                               INDEX      12.6       62.0    12.0       59.9   -0.6         65,816       92,874      41.1      12.6    12.1   -0.6
SOE                            SOE                            ITEM_ORDER_IX                                                 INDEX       8.9       70.9     8.4       68.2   -0.5         46,285       64,684      39.8       8.9     8.4   -0.5
                          --------------------------------------------------------------------------------------------------------------------

Top Segments Comparison by Physical Read Requests   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of 'Diff' column of '% of Total Physical Read Requests'
-> Top    5 Segments from each period are compared
-> Total Physical Read Requests                First:                      521,753, Second:                      773,429
-> Captured Physical Read Requests             First:                      520,016, Second:                      768,919
-> Captured Phys. Read Requests as % of Total  First: 99.67%, Second: 99.42%
-> 'N/A' indicates no data was captured for the segment in the period

                                                                                                                                              % of Total Read Requests                        Read Requests              % of Captured Read Requests
                                                                                                                                    --------------------------------------------   -----------------------------------   ----------------------
Owner                          Tablespace                     Object Name                    Subobject Name                 Type        1st  1st Total     2nd  2nd Total   Diff            1st          2nd     %Diff       1st     2nd   Diff
------------------------------ ------------------------------ ------------------------------ ------------------------------ -----   ------- ---------- ------- ---------- ------   ------------ ------------ ---------   ------- ------- ------
SOE                            SOE                            CUSTOMERS_PK                                                  INDEX      19.8       19.8    18.1       18.1   -1.7        103,490      140,249      35.5      19.9    18.2   -1.7
SOE                            SOE                            INVENTORIES                                                   TABLE       9.1       29.0    10.6       28.7    1.4         47,667       81,655      71.3       9.2    10.6    1.5
SOE                            SOE                            CUSTOMERS                                                     TABLE      20.6       49.5    19.2       47.9   -1.4        107,283      148,563      38.5      20.6    19.3   -1.3
SOE                            SOE                            ORD_CUSTOMER_IX                                               INDEX      12.6       62.1    12.0       59.9   -0.6         65,816       92,874      41.1      12.7    12.1   -0.6
SOE                            SOE                            ITEM_ORDER_IX                                                 INDEX       8.9       71.0     8.4       68.3   -0.5         46,285       64,682      39.7       8.9     8.4   -0.5
                          --------------------------------------------------------------------------------------------------------------------

Top Segments Comparison by UnOptimized Read Requests   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of 'Diff' column of '% of Total UnOptimized Requests'
-> Top    5 Segments from each period are compared
-> Total UnOptimized Read Requests               First:                      521,753, Second:                      773,429
-> Captured UnOptimized Read Requests            First:                      520,016, Second:                      768,919
-> Captured UnOptimized Read Reqs as % of Total  First: 99.67%, Second: 99.42%
-> 'N/A' indicates no data was captured for the segment in the period

                                                                                                                                           % of Total UnOptimized Requests                 UnOptimized Requests          % of Captured UnOptimized Reqs
                                                                                                                                    --------------------------------------------   -----------------------------------   ----------------------
Owner                          Tablespace                     Object Name                    Subobject Name                 Type        1st  1st Total     2nd  2nd Total   Diff            1st          2nd     %Diff       1st     2nd   Diff
------------------------------ ------------------------------ ------------------------------ ------------------------------ -----   ------- ---------- ------- ---------- ------   ------------ ------------ ---------   ------- ------- ------
SOE                            SOE                            CUSTOMERS_PK                                                  INDEX      19.8       19.8    18.1       18.1   -1.7        103,490      140,249      35.5      19.9    18.2   -1.7
SOE                            SOE                            INVENTORIES                                                   TABLE       9.1       29.0    10.6       28.7    1.4         47,667       81,655      71.3       9.2    10.6    1.5
SOE                            SOE                            CUSTOMERS                                                     TABLE      20.6       49.5    19.2       47.9   -1.4        107,283      148,563      38.5      20.6    19.3   -1.3
SOE                            SOE                            ORD_CUSTOMER_IX                                               INDEX      12.6       62.1    12.0       59.9   -0.6         65,816       92,874      41.1      12.7    12.1   -0.6
SOE                            SOE                            ITEM_ORDER_IX                                                 INDEX       8.9       71.0     8.4       68.3   -0.5         46,285       64,682      39.7       8.9     8.4   -0.5
                          --------------------------------------------------------------------------------------------------------------------

Top Segments Comparison by Optimized Read Requests   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of 'Diff' column of '% of Total Optimized Read Requestss'
-> Top    5 Segments from each period are compared
-> Total Physical Read Requests                First:                            1, Second:                            1
-> Captured Physical Read Requests             First:                            1, Second:                            1
-> Captured Phys. Read Requests as % of Total  First: 0%, Second: 0%
-> 'N/A' indicates no data was captured for the segment in the period

                                                                                                                                         % of Total Optimized Read Requests                 Optimized Requests           % of Captured Optimized Reqs
                                                                                                                                    --------------------------------------------   -----------------------------------   ----------------------
Owner                          Tablespace                     Object Name                    Subobject Name                 Type        1st  1st Total     2nd  2nd Total   Diff            1st          2nd     %Diff       1st     2nd   Diff
------------------------------ ------------------------------ ------------------------------ ------------------------------ -----   ------- ---------- ------- ---------- ------   ------------ ------------ ---------   ------- ------- ------
SYS                            SYSTEM                         AUD$                                                          TABLE       N/A        N/A     0.0        0.0    0.0            N/A            0       N/A       N/A     0.0    0.0
SYS                            SYSTEM                         CCOL$                                                         TABLE       N/A        N/A     0.0        0.0    0.0            N/A            0       N/A       N/A     0.0    0.0
SYS                            SYSTEM                         I_CCOL2                                                       INDEX       N/A        N/A     0.0        0.0    0.0            N/A            0       N/A       N/A     0.0    0.0
SYS                            SYSTEM                         I_HH_OBJ#_INTCOL#                                             INDEX       N/A        N/A     0.0        0.0    0.0            N/A            0       N/A       N/A     0.0    0.0
SYS                            SYSTEM                         I_JOB_NEXT                                                    INDEX       0.0        0.0     N/A        N/A    0.0              0          N/A     100.0       0.0     N/A    0.0
SYS                            SYSTEM                         I_OBJ1                                                        INDEX       N/A        N/A     0.0        0.0    0.0            N/A            0       N/A       N/A     0.0    0.0
SYS                            SYSTEM                         OBJ$                                                          TABLE       0.0        0.0     N/A        N/A    0.0              0          N/A     100.0       0.0     N/A    0.0
SYS                            SYSTEM                         SCHEDULER$_JOB                                                TABLE       0.0        0.0     0.0        0.0    0.0              0            0       0.0       0.0     0.0    0.0
SYS                            SYSAUX                         SMON_SCN_TIME                                                 TABLE       0.0        0.0     N/A        N/A    0.0              0          N/A     100.0       0.0     N/A    0.0
SYS                            SYSAUX                         WRI$_ADV_MESSAGE_GROUPS                                       TABLE       0.0        0.0     N/A        N/A    0.0              0          N/A     100.0       0.0     N/A    0.0
                          --------------------------------------------------------------------------------------------------------------------

Top Segments Comparison by Direct Physical Reads   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of 'Diff' column of '% of Total Direct Reads'
-> Top    5 Segments from each period are compared
-> Total Direct Reads                   First:                           55, Second:                           82
-> Captured Direct Reads                First:                            1, Second:                            1
-> Captured Direct Reads as % of Total  First: 0%, Second: 0%
-> 'N/A' indicates no data was captured for the segment in the period

                                                                                                                                               % of Total Direct Reads                         Direct Reads              % of Captured Direct Reads
                                                                                                                                    --------------------------------------------   -----------------------------------   ----------------------
Owner                          Tablespace                     Object Name                    Subobject Name                 Type        1st  1st Total     2nd  2nd Total   Diff            1st          2nd     %Diff       1st     2nd   Diff
------------------------------ ------------------------------ ------------------------------ ------------------------------ -----   ------- ---------- ------- ---------- ------   ------------ ------------ ---------   ------- ------- ------
SYS                            SYSTEM                         AUD$                                                          TABLE       N/A        N/A     0.0        0.0    0.0            N/A            0       N/A       N/A     0.0    0.0
SYS                            SYSTEM                         CCOL$                                                         TABLE       N/A        N/A     0.0        0.0    0.0            N/A            0       N/A       N/A     0.0    0.0
SYS                            SYSTEM                         I_CCOL2                                                       INDEX       N/A        N/A     0.0        0.0    0.0            N/A            0       N/A       N/A     0.0    0.0
SYS                            SYSTEM                         I_HH_OBJ#_INTCOL#                                             INDEX       N/A        N/A     0.0        0.0    0.0            N/A            0       N/A       N/A     0.0    0.0
SYS                            SYSTEM                         I_JOB_NEXT                                                    INDEX       0.0        0.0     N/A        N/A    0.0              0          N/A     100.0       0.0     N/A    0.0
SYS                            SYSTEM                         I_OBJ1                                                        INDEX       N/A        N/A     0.0        0.0    0.0            N/A            0       N/A       N/A     0.0    0.0
SYS                            SYSTEM                         OBJ$                                                          TABLE       0.0        0.0     N/A        N/A    0.0              0          N/A     100.0       0.0     N/A    0.0
SYS                            SYSTEM                         SCHEDULER$_JOB                                                TABLE       0.0        0.0     0.0        0.0    0.0              0            0       0.0       0.0     0.0    0.0
SYS                            SYSAUX                         SMON_SCN_TIME                                                 TABLE       0.0        0.0     N/A        N/A    0.0              0          N/A     100.0       0.0     N/A    0.0
SYS                            SYSAUX                         WRI$_ADV_MESSAGE_GROUPS                                       TABLE       0.0        0.0     N/A        N/A    0.0              0          N/A     100.0       0.0     N/A    0.0
                          --------------------------------------------------------------------------------------------------------------------

Top Segments Comparison by Physical Writes   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of 'Diff' column of '% of Total Physical Writes'
-> Top    5 Segments from each period are compared
-> Total Physical Writes                   First:                      340,400, Second:                      521,944
-> Captured Physical Writes                First:                      322,986, Second:                      495,807
-> Captured Physical Writes as % of Total  First: 94.88%, Second: 94.99%
-> 'N/A' indicates no data was captured for the segment in the period

                                                                                                                                             % of Total Physical Writes                      Physical Writes             % of Captured Physical Writes
                                                                                                                                    --------------------------------------------   -----------------------------------   ----------------------
Owner                          Tablespace                     Object Name                    Subobject Name                 Type        1st  1st Total     2nd  2nd Total   Diff            1st          2nd     %Diff       1st     2nd   Diff
------------------------------ ------------------------------ ------------------------------ ------------------------------ -----   ------- ---------- ------- ---------- ------   ------------ ------------ ---------   ------- ------- ------
SOE                            SOE                            ITEM_PRODUCT_IX                                               INDEX       8.8        8.8    12.1       12.1    3.3         29,854       63,064     111.2       9.2    12.7    3.5
SOE                            SOE                            ORDER_PK                                                      INDEX      10.8       19.6     9.9       22.0   -0.9         36,810       51,587      40.1      11.4    10.4   -1.0
SOE                            SOE                            ITEM_ORDER_IX                                                 INDEX       9.6       29.2     8.7       30.7   -0.9         32,622       45,517      39.5      10.1     9.2   -0.9
SOE                            SOE                            ORDER_ITEMS_PK                                                INDEX       9.6       38.7     8.7       39.4   -0.8         32,536       45,490      39.8      10.1     9.2   -0.9
SOE                            SOE                            ORD_CUSTOMER_IX                                               INDEX      10.4       49.1     9.6       49.0   -0.8         35,321       50,087      41.8      10.9    10.1   -0.8
SOE                            SOE                            ORD_WAREHOUSE_IX                                              INDEX       8.2       57.3     8.9       57.9    0.7         27,818       46,483      67.1       8.6     9.4    0.8
SOE                            SOE                            INVENTORIES                                                   TABLE      20.1       77.4    20.1       78.0   -0.0         68,342      104,693      53.2      21.2    21.1   -0.0
                          --------------------------------------------------------------------------------------------------------------------

Top Segments Comparison by Physical Write Requests   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of 'Diff' column of '% of Total Write Requests'

                                                                                                                                              % of Total Write Requests                       Write Requests             % of Captured Write Requests
                                                                                                                                    --------------------------------------------   -----------------------------------   ----------------------
Owner                          Tablespace                     Object Name                    Subobject Name                 Type        1st  1st Total     2nd  2nd Total   Diff            1st          2nd     %Diff       1st     2nd   Diff
------------------------------ ------------------------------ ------------------------------ ------------------------------ -----   ------- ---------- ------- ---------- ------   ------------ ------------ ---------   ------- ------- ------
SOE                            SOE                            INVENTORIES                                                   TABLE      15.6       15.6    17.8       17.8    2.2         36,889       68,215      84.9      15.7    18.0    2.2
SOE                            SOE                            ORDER_PK                                                      INDEX      14.6       30.2    13.1       30.8   -1.5         34,555       50,136      45.1      14.7    13.2   -1.5
SOE                            SOE                            ORD_CUSTOMER_IX                                               INDEX      13.7       43.9    12.3       43.2   -1.4         32,424       47,348      46.0      13.8    12.5   -1.4
SOE                            SOE                            ITEM_ORDER_IX                                                 INDEX      12.5       56.4    11.2       54.4   -1.3         29,477       42,964      45.8      12.6    11.3   -1.3
SOE                            SOE                            ORDER_ITEMS_PK                                                INDEX      12.7       69.1    11.5       65.9   -1.2         30,019       44,184      47.2      12.8    11.6   -1.2
                          --------------------------------------------------------------------------------------------------------------------

Top Segments Comparison by Direct Physical Writes   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of 'Diff' column of '% of Total Direct Writes'
-> Top    5 Segments from each period are compared
-> Total Direct Writes                   First:                           82, Second:                          130
-> Captured Direct Writes                First:                           27, Second:                           59
-> Captured Direct Writes as % of Total  First: 32.93%, Second: 45.38%
-> 'N/A' indicates no data was captured for the segment in the period

                                                                                                                                              % of Total Direct Writes                        Direct Writes              % of Captured Direct Writes
                                                                                                                                    --------------------------------------------   -----------------------------------   ----------------------
Owner                          Tablespace                     Object Name                    Subobject Name                 Type        1st  1st Total     2nd  2nd Total   Diff            1st          2nd     %Diff       1st     2nd   Diff
------------------------------ ------------------------------ ------------------------------ ------------------------------ -----   ------- ---------- ------- ---------- ------   ------------ ------------ ---------   ------- ------- ------
SYS                            SYSAUX                         SYS_LOB0000006339C00038$$                                     LOB         0.0        0.0     9.2        9.2    9.2              0           12     100.0       0.0    20.3   20.3
SYS                            SYSAUX                         WRH$_ACTIVE_SESSION_HISTORY    WRH$_ACTIVE_2532911053_1819    TABLE      32.9       32.9    36.2       45.4    3.2             27           47      74.1     100.0    79.7  -20.3
SYS                            SYSTEM                         CCOL$                                                         TABLE       N/A        N/A     0.0       45.4    0.0            N/A            0       N/A       N/A     0.0    0.0
SYS                            SYSTEM                         I_CCOL2                                                       INDEX       N/A        N/A     0.0       45.4    0.0            N/A            0       N/A       N/A     0.0    0.0
SYS                            SYSTEM                         I_JOB_NEXT                                                    INDEX       0.0       32.9     N/A        N/A    0.0              0          N/A     100.0       0.0     N/A    0.0
SYS                            SYSTEM                         I_OBJ1                                                        INDEX       N/A        N/A     0.0       45.4    0.0            N/A            0       N/A       N/A     0.0    0.0
SYS                            SYSTEM                         OBJ$                                                          TABLE       0.0       32.9     N/A        N/A    0.0              0          N/A     100.0       0.0     N/A    0.0
SYS                            SYSAUX                         SMON_SCN_TIME                                                 TABLE       0.0       32.9     N/A        N/A    0.0              0          N/A     100.0       0.0     N/A    0.0
SYS                            SYSAUX                         WRI$_ADV_MESSAGE_GROUPS                                       TABLE       0.0       32.9     N/A        N/A    0.0              0          N/A     100.0       0.0     N/A    0.0
                          --------------------------------------------------------------------------------------------------------------------

Top Segments Comparison by Table Scans   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of 'Diff' column of '% of Total Table Scans'
-> Top    5 Segments from each period are compared
-> Total Table Scans                   First:                            2, Second:                            2
-> Captured Table Scans                First:                            1, Second:                            1
-> Captured Table Scans as % of Total  First: 0%, Second: 0%
-> 'N/A' indicates no data was captured for the segment in the period

                                                                                                                                               % of Total Table Scans                          Table Scans               % of Captured Table Scans
                                                                                                                                    --------------------------------------------   -----------------------------------   ----------------------
Owner                          Tablespace                     Object Name                    Subobject Name                 Type        1st  1st Total     2nd  2nd Total   Diff            1st          2nd     %Diff       1st     2nd   Diff
------------------------------ ------------------------------ ------------------------------ ------------------------------ -----   ------- ---------- ------- ---------- ------   ------------ ------------ ---------   ------- ------- ------
SYS                            SYSTEM                         AUD$                                                          TABLE       N/A        N/A     0.0        0.0    0.0            N/A            0       N/A       N/A     0.0    0.0
SYS                            SYSTEM                         CCOL$                                                         TABLE       N/A        N/A     0.0        0.0    0.0            N/A            0       N/A       N/A     0.0    0.0
SYS                            SYSTEM                         I_CCOL2                                                       INDEX       N/A        N/A     0.0        0.0    0.0            N/A            0       N/A       N/A     0.0    0.0
SYS                            SYSTEM                         I_HH_OBJ#_INTCOL#                                             INDEX       N/A        N/A     0.0        0.0    0.0            N/A            0       N/A       N/A     0.0    0.0
SYS                            SYSTEM                         I_JOB_NEXT                                                    INDEX       0.0        0.0     N/A        N/A    0.0              0          N/A     100.0       0.0     N/A    0.0
SYS                            SYSTEM                         I_OBJ1                                                        INDEX       N/A        N/A     0.0        0.0    0.0            N/A            0       N/A       N/A     0.0    0.0
SYS                            SYSTEM                         OBJ$                                                          TABLE       0.0        0.0     N/A        N/A    0.0              0          N/A     100.0       0.0     N/A    0.0
SYS                            SYSTEM                         SCHEDULER$_JOB                                                TABLE       0.0        0.0     0.0        0.0    0.0              0            0       0.0       0.0     0.0    0.0
SYS                            SYSAUX                         SMON_SCN_TIME                                                 TABLE       0.0        0.0     N/A        N/A    0.0              0          N/A     100.0       0.0     N/A    0.0
SYS                            SYSAUX                         WRI$_ADV_MESSAGE_GROUPS                                       TABLE       0.0        0.0     N/A        N/A    0.0              0          N/A     100.0       0.0     N/A    0.0
                          --------------------------------------------------------------------------------------------------------------------

Top Segments Comparison by DB Block Changes   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of 'Diff' column of '% of Total Block Changes'
-> Top    5 Segments from each period are compared
-> Total DB Block Changes                   First:                    2,549,313, Second:                    3,564,963
-> Captured DB Block Changes                First:                      516,016, Second:                    1,028,592
-> Captured DB Block Changes as % of Total  First: 20.24%, Second: 28.85%
-> 'N/A' indicates no data was captured for the segment in the period

                                                                                                                                              % of Total Block Changes                       DB Block Changes            % of Captured Block Changes
                                                                                                                                    --------------------------------------------   -----------------------------------   ----------------------
Owner                          Tablespace                     Object Name                    Subobject Name                 Type        1st  1st Total     2nd  2nd Total   Diff            1st          2nd     %Diff       1st     2nd   Diff
------------------------------ ------------------------------ ------------------------------ ------------------------------ -----   ------- ---------- ------- ---------- ------   ------------ ------------ ---------   ------- ------- ------
SOE                            SOE                            ORDERS                                                        TABLE       2.8        2.8     4.5        4.5    1.7         70,528      158,800     125.2      13.7    15.4    1.8
SOE                            SOE                            ORD_WAREHOUSE_IX                                              INDEX       3.1        5.9     4.4        8.9    1.3         79,824      158,336      98.4      15.5    15.4   -0.1
SOE                            SOE                            ITEM_ORDER_IX                                                 INDEX       2.5        8.4     3.6       12.5    1.1         63,184      129,296     104.6      12.2    12.6    0.3
SOE                            SOE                            INVENTORIES                                                   TABLE       2.5       10.9     3.0       15.5    0.4         64,816      106,592      64.5      12.6    10.4   -2.2
SOE                            SOE                            ORDER_ITEMS                                                   TABLE       3.6       14.5     3.6       19.1    0.0         91,216      128,960      41.4      17.7    12.5   -5.1
                          --------------------------------------------------------------------------------------------------------------------

Top Segments by Row Lock Waits   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of 'Diff' column'


      of '% of Captured'
-> Top    5 Segments from each period are compared
-> TX Row Lock Waits                      First:                          684, Second:                        1,230
-> Total TX Row Lock Wait Time            First:                            0.80 seconds, Second:                            2.20 seconds
-> TX Row Lock Wait Time as % of DB time  First: .01%, Second: .02%
-> Captured Row Lock Waits                First:                        1,203, Second:                        1,643
-> 'N/A' indicates no data was captured for the segment in the period

                                                                                                                                         % of Total                   Row Lock Waits                            % of Captured
                                                                                                                                    --------------------   -----------------------------------   ------------------------------------------
Owner                          Tablespace                     Object Name                    Subobject Name                 Type       1st    2nd   Diff            1st          2nd     %Diff      1st  1st Total    2nd  2nd Total   Diff
------------------------------ ------------------------------ ------------------------------ ------------------------------ -----   ------ ------ ------   ------------ ------------ ---------   ------ ---------- ------ ---------- ------
SOE                            SOE                            ORDERS                                                        TABLE    100.1   99.8   -0.4            685        1,227      79.1     56.9       56.9   74.7       74.7   17.7
SOE                            SOE                            ORD_ORDER_DATE_IX                                             INDEX     42.7   11.7  -31.0            292          144     -50.7     24.3       81.2    8.8       83.4  -15.5
SOE                            SOE                            ORD_WAREHOUSE_IX                                              INDEX      5.1    8.5    3.3             35          104     197.1      2.9       84.1    6.3       89.8    3.4
SOE                            SOE                            ITEM_PRODUCT_IX                                               INDEX     14.0    6.4   -7.6             96           79     -17.7      8.0       92.1    4.8       94.6   -3.2
SOE                            SOE                            CUST_LNAME_IX                                                 INDEX      3.5    N/A   -3.5             24          N/A       N/A      2.0       94.1    N/A        N/A   -2.0
SOE                            SOE                            CUST_ACCOUNT_MANAGER_IX                                       INDEX      N/A    1.8    1.8            N/A           22       N/A      N/A        N/A    1.3       95.9    1.3
                          --------------------------------------------------------------------------------------------------------------------

Top Segments by ITL Waits   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)

                  No data exists for this section of the report.
                          --------------------------------------------------------------------------------------------------------------------

Top Segments by Buffer Busy Waits   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by absolute value of 'Diff' column of '% of Total Buffer Busy Waits'
-> Top    5 Segments from each period are compared
-> Total Buffer Busy Waits                First:                          376, Second:                          638
-> Buffer Busy Wait Time                  First:                            0.19 seconds, Second:                            0.23 seconds
-> Buffer Busy Wait Time as % of DB time  First: 0%, Second: 0%
-> Captured Buffer Busy Waits             First:                          346, Second:                          563
-> 'N/A' indicates no data was captured for the segment in the period

                                                                                                                                             % of Total Buffer Busy Waits                    Buffer Busy Waits            % of Captured Buffer Busy Waits
                                                                                                                                    ---------------------------------------------   -----------------------------------   ----------------------
Owner                          Tablespace                     Object Name                    Subobject Name                 Type         1st  1st Total     2nd  2nd Total   Diff            1st          2nd     %Diff       1st     2nd   Diff
------------------------------ ------------------------------ ------------------------------ ------------------------------ -----   -------- ---------- ------- ---------- ------   ------------ ------------ ---------   ------- ------- ------
SOE                            SOE                            ORDERS                                                        TABLE      88.83       88.8    81.8       81.8   -7.0            334          522      56.3      96.5    92.7   -3.8
SOE                            SOE                            ORD_ORDER_DATE_IX                                             INDEX       0.80       89.6     2.0       83.9    1.2              3           13     333.3       0.9     2.3    1.4
SOE                            SOE                            CUSTOMERS_PK                                                  INDEX       1.06       90.7     0.0       83.9   -1.1              4            0    -100.0       1.2     0.0   -1.2
SYS                            SYSTEM                         AUD$                                                          TABLE        N/A        N/A     0.9       84.8    0.9            N/A            6       N/A       N/A     1.1    1.1
SOE                            SOE                            ORDER_ITEMS                                                   TABLE       0.27       91.0     0.8       85.6    0.5              1            5     400.0       0.3     0.9    0.6
SOE                            SOE                            ORDER_PK                                                      INDEX       0.53       91.5     0.8       86.4    0.3              2            5     150.0       0.6     0.9    0.3
SOE                            SOE                            ITEM_ORDER_IX                                                 INDEX       0.53       92.0     0.5       86.8   -0.1              2            3      50.0       0.6     0.5   -0.0
                          --------------------------------------------------------------------------------------------------------------------

Top Segments by GC Buffer Busy Waits   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)

                  No data exists for this section of the report.
                          --------------------------------------------------------------------------------------------------------------------

Dictionary Cache Statistics   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by Cache

                             Get Requests per Sec (DB time)     Get Requests per Sec (Elapsed Time)          Get Requests            Pct Miss      Scan Requests       Pct Miss          Mod Reqs            Final Usage
                            --------------------------------   ------------------------------------   -------------------------   -------------   ---------------   -------------   -----------------   ---------------------
Cache                              1st        2nd      %Diff            1st          2nd      %Diff            1st          2nd      1st    2nd       1st     2nd      1st    2nd        1st      2nd          1st        2nd
-------------------------   ---------- ---------- ----------   ------------ ------------ ----------   ------------ ------------   ------ ------   ------- -------   ------ ------   -------- --------   ---------- ----------
dc_awr_control                     0.0        0.0        0.0            0.0          0.0        0.0             19           19      0.0    0.0         0       0      0.0    0.0          2        2            1          1
dc_global_oids                     0.0        0.0        0.0            0.0          0.1      500.0              7           53      0.0    5.7         0       0      0.0    0.0          0        0           24         24
dc_histogram_data                  0.0        0.2    2,100.0            0.1          3.1    3,311.1             78        2,769     44.9   15.3         0       0      0.0    0.0          0        0        2,000      2,149
dc_histogram_defs                  0.0        0.4    4,200.0            0.0          6.0   11,840.0             41        5,387     12.2   29.0         0       0      0.0    0.0          0        0        2,024      2,942
dc_object_grants                   0.0        0.0        0.0            0.0          0.0        0.0              0            2      0.0   50.0         0       0      0.0    0.0          0        0            5         10
dc_objects                         0.0        0.2      450.0            0.3          3.1    1,124.0            229        2,759      0.4    7.3         0       0      0.0    0.0          1        1        1,501      1,264
dc_profiles                        0.0        0.0        0.0            0.0          0.0      100.0              2           17      0.0    0.0         0       0      0.0    0.0          0        0            1          1
dc_rollback_segments               0.2        0.1      -46.7            1.1          1.2       10.3            963        1,068      0.0    0.0         0       0      0.0    0.0          0        0           78         78
dc_segments                        0.0        0.1      400.0            0.1          1.4      969.2            121        1,253      0.0    8.7         0       0      0.0    0.0         10       15          614        463
dc_sequences                       0.0        0.0        0.0            0.0          0.0      100.0             10           14      0.0   42.9         0       0      0.0    0.0         10       14            5          7
dc_tablespaces                     0.1        0.2      175.0            0.6          3.1      448.2            506        2,769      0.0    0.0         0       0      0.0    0.0          0        0            7          7
dc_users                           0.0        0.2      475.0            0.3          3.3    1,161.5            234        2,960      0.0    0.7         0       0      0.0    0.0          0        0           46         22
global database name               0.1        0.0      -50.0            0.7          0.7        2.9            612          629      0.0    0.0         0       0      0.0    0.0          0        0            1          1
outstanding_alerts                 0.0        0.0        0.0            0.0          0.0        0.0              8            8      0.0    0.0         0       0      0.0    0.0          0        0            4          4
sch_lj_oids                        0.0        0.0        0.0            0.0          0.0        0.0              2            2      0.0    0.0         0       0      0.0    0.0          0        0            1          1
                          --------------------------------------------------------------------------------------------------------------------

Library Cache Activity   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by Namespace

                   Get Requests per Sec (DB Time)      Get Requests per Sec (Elapsed Time)           Get Requests            Pct Miss              Pin Requests              Pct Miss            Reloads            Invalidations
                  --------------------------------   --------------------------------------   -------------------------   -------------   -----------------------------   -------------   ---------------------   -----------------
Namespace                1st        2nd      %Diff            1st          2nd        %Diff            1st          2nd      1st    2nd              1st            2nd      1st    2nd          1st        2nd        1st      2nd
---------------   ---------- ---------- ----------   ------------ ------------ ------------   ------------ ------------   ------ ------   -------------- --------------   ------ ------   ---------- ----------   -------- --------
ACCOUNT_STATUS           0.0        0.0        0.0            0.0          0.0        100.0              0           30      N/A    3.3                0              0      N/A    N/A            0          0          0        0
BODY                     0.0        0.0        0.0            0.0          0.0         50.0             15           30      0.0    6.7               44             59      0.0    5.1            0          1          0        0
CLUSTER                  0.0        0.0        0.0            0.0          0.0        100.0              2           36      0.0    2.8                2             36      0.0    2.8            0          0          0        0
DBLINK                   0.0        0.0        0.0            0.0          0.0        100.0              1           31      0.0    3.2                0              0      N/A    N/A            0          0          0        0
EDITION                  0.0        0.0        0.0            0.0          0.0        200.0              8           23      0.0    0.0                8             38      0.0    7.9            0          0          0        0
INDEX                    0.0        0.0        0.0            0.0          0.0        100.0              0           15      N/A    6.7                0             15      N/A    6.7            0          0          0        0
QUEUE                    0.0        0.0      -50.0            0.3          0.3          0.0            262          266      0.0    0.0              262            266      0.0    0.0            0          0          0        0
SCHEMA                   0.0        0.0      100.0            0.0          0.2        100.0              1          160      0.0    0.0                0              0      N/A    N/A            0          0          0        0
SQL AREA                 0.1        0.1      100.0            0.4          1.6        297.6            372        1,470      1.1    8.9        1,230,463      1,728,755     -0.0    0.0            1        211          0        0
SQL AREA BUILD           0.0        0.0      100.0            0.0          0.4      3,800.0              5          350    100.0   83.7                0              0      N/A    N/A            0          0          0        0
SQL AREA STATS           0.0        0.0      100.0            0.0          0.3      3,200.0              5          300     80.0   54.0                5            300     80.0   54.0            0          0          0        0
TABLE/PROCEDURE          0.0        0.1      100.0            0.0          1.6      5,100.0             27        1,405      0.0    8.8          103,351        147,455      0.0    0.7            1        468          0        0
                          --------------------------------------------------------------------------------------------------------------------

Process Memory Summary   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> All rows below contain absolute values (i.e. not diffed over the interval)
-> Max Alloc is Maximum PGA Allocation size at snapshot time
-> Hist Max Alloc is the Historical Max Allocation for still-connected processes
-> ordered by Category

                                                        1st                                               2nd                              % Diff of
                                  -----------------------------------------------   -----------------------------------------------   -------------------
Category   Summary                       Begin Value          End Value     %Diff          Begin Value          End Value     %Diff   Begin Val End Value
---------- --------------------   ------------------ ------------------ ---------   ------------------ ------------------ ---------   --------- ---------
Freeable   Alloc (KB)                       24,128.0           24,704.0       2.4             25,984.0           26,816.0       3.2         7.7       8.5
           Used (KB)                             0.0                0.0       0.0                  0.0                0.0       0.0         0.0       0.0
           Avg Alloc (KB)                      832.0              796.9      -4.2                812.0              812.6       0.1        -2.4       2.0
           Std Dev Alloc (KB)                  466.2              434.0      -6.9                429.3              438.3       2.1        -7.9       1.0
           Max Alloc (KB)                    1,792.0            1,152.0     -35.7              1,152.0            1,152.0       0.0       -35.7       0.0
           Hist Max Alloc (KB)                   N/A                N/A       N/A                  N/A                N/A       N/A         N/A       N/A
           Num Procs                            29.0               31.0       6.9                 32.0               33.0       3.1        10.3       6.5
           Num Alloc                            29.0               31.0       6.9                 32.0               33.0       3.1        10.3       6.5
Other      Alloc (KB)                      155,103.9          157,590.9       1.6            158,156.2          189,296.6      19.7         2.0      20.1
           Used (KB)                             N/A                N/A       N/A                  N/A                N/A       N/A         N/A       N/A
           Avg Alloc (KB)                    2,674.2            2,671.0      -0.1              2,680.6            2,558.1      -4.6         0.2      -4.2
           Std Dev Alloc (KB)                2,474.6            2,455.5      -0.8              2,469.1            2,220.2     -10.1        -0.2      -9.6
           Max Alloc (KB)                   14,328.0           14,648.0       0.0             14,648.0           14,648.0       0.0         2.2       2.2
           Hist Max Alloc (KB)              25,912.0           25,912.0       0.0             25,912.0           25,912.0       0.0         0.0       0.0
           Num Procs                            58.0               59.0       1.7                 59.0               74.0      25.4         1.7      25.4
           Num Alloc                            58.0               59.0       1.7                 59.0               74.0      25.4         1.7      25.4
PL/SQL     Alloc (KB)                        2,467.1            2,469.1       0.1              4,171.0            4,537.9       8.8        69.1      83.8
           Used (KB)                         2,139.1            2,139.4       0.0              2,469.0            2,745.8      11.2        15.4      28.3
           Avg Alloc (KB)                       42.5               41.8      -1.6                 70.7               61.3     -13.3        66.2      46.5
           Std Dev Alloc (KB)                  181.4              179.9      -0.8                377.2              336.7     -10.7       107.9      87.2
           Max Alloc (KB)                    1,377.0            2,903.6       0.0              2,903.6            2,903.6       0.0       110.9     110.9
           Hist Max Alloc (KB)               1,751.8            1,751.8       0.0              3,820.8            3,820.8       0.0       118.1     118.1
           Num Procs                            58.0               59.0       1.7                 59.0               74.0      25.4         1.7      25.4
           Num Alloc                            58.0               59.0       1.7                 59.0               74.0      25.4         1.7      25.4
SQL        Alloc (KB)                          839.4              833.3      -0.7              1,070.3            1,605.1      50.0        27.5      92.6
           Used (KB)                            94.6               92.4      -2.3                133.2              117.4     -11.9        40.9      27.0
           Avg Alloc (KB)                       21.0               20.3      -3.1                 26.1               29.2      11.8        24.4      43.6
           Std Dev Alloc (KB)                   29.9               30.0       0.4                 35.7               32.5      -8.9        19.2       8.2
           Max Alloc (KB)                      165.8              153.8       0.0                153.8              153.8       0.0        -7.2      -7.2
           Hist Max Alloc (KB)               9,671.6            9,671.6       0.0              5,335.1            5,335.1       0.0       -44.8     -44.8
           Num Procs                            40.0               41.0       2.5                 41.0               55.0      34.1         2.5      34.1
           Num Alloc                            36.0               36.0       0.0                 37.0               51.0      37.8         2.8      41.7
                          --------------------------------------------------------------------------------------------------------------------

SGA Memory Summary   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)

                                                       1st                                               2nd                              % Diff of
                                 -----------------------------------------------   -----------------------------------------------   -------------------
SGA regions                        Begin Value (KB)     End Value (KB)     %Diff     Begin Value (KB)     End Value (KB)     %Diff   Begin Val End Value
------------------------------   ------------------ ------------------ ---------   ------------------ ------------------ ---------   --------- ---------
Database Buffers                          745,472.0          745,472.0       0.0            745,472.0          745,472.0       0.0         0.0       0.0
Fixed Size                                  2,182.8            2,182.8       0.0              2,182.8            2,182.8       0.0         0.0       0.0
Redo Buffers                                9,508.0            9,508.0       0.0              9,508.0            9,508.0       0.0         0.0       0.0
Variable Size                             286,721.2          286,721.2       0.0            286,721.2          286,721.2       0.0         0.0       0.0
                          --------------------------------------------------------------------------------------------------------------------

SGA Breakdown Difference   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> ordered by Pool, Name

                                                            1st                                           2nd                                  %Diff of
                                        -------------------------------------------   -------------------------------------------   -----------------------------
Pool   Name                                  Begin Value        End Value     %Diff        Begin Value        End Value     %Diff     Begin Values     End Values
------ ------------------------------   ---------------- ---------------- ---------   ---------------- ---------------- ---------   -------------- --------------
java p free memory                             4,194,304        4,194,304       0.0          4,194,304        4,194,304       0.0              0.0            0.0
large  ASM map operations hashta                 393,216          393,216       0.0            393,216          393,216       0.0              0.0            0.0
large  PX msg pool                             3,894,304        3,894,304       0.0          3,894,304        3,894,304       0.0              0.0            0.0
large  free memory                             4,101,088        4,101,088       0.0          4,101,088        4,101,088       0.0              0.0            0.0
shared ASH buffers                            16,777,216       16,777,216       0.0         16,777,216       16,777,216       0.0              0.0            0.0
shared KCB Table Scan Buffer                   3,981,120        3,981,120       0.0          3,981,120        3,981,120       0.0              0.0            0.0
shared KGLH0                                  19,337,416       19,329,344      -0.0         19,305,408       17,465,064      -9.5             -0.2           -9.6
shared KGLHD                                   3,996,784        4,004,704       0.2          4,035,656        3,361,472     -16.7              1.0          -16.1
shared KGLS                                    4,575,608        4,579,656       0.1          5,113,408        5,132,424       0.4             11.8           12.1
shared KGLSG                                   5,266,008        5,266,008       0.0          5,266,008        5,266,008       0.0              0.0            0.0
shared KKSSP                                   2,854,688        2,894,984       1.4          2,916,088        3,738,216      28.2              2.2           29.1
shared KSFD SGA I/O b                          3,977,144        3,977,144       0.0          3,977,144        3,977,144       0.0              0.0            0.0
shared PLMCD                                   3,354,032        3,354,032       0.0          4,258,776              N/A       N/A             27.0            N/A
shared SQLA                                   23,338,816       23,407,920       0.3         45,819,296       22,795,944     -50.2             96.3           -2.6
shared db_block_hash_buckets                   5,836,800        5,836,800       0.0          5,836,800        5,836,800       0.0              0.0            0.0
shared dbwriter coalesce buffer                3,979,264        3,979,264       0.0          3,979,264        3,979,264       0.0              0.0            0.0
shared dirty object counts array               4,194,304        4,194,304       0.0          4,194,304        4,194,304       0.0              0.0            0.0
shared event statistics per sess               3,245,824        3,245,824       0.0          3,245,824        3,245,824       0.0              0.0            0.0
shared free memory                            91,372,768       91,214,776      -0.2         69,082,344       94,734,712      37.1            -24.4            3.9
shared kglsim hash table bkts                  4,194,304        4,194,304       0.0          4,194,304        4,194,304       0.0              0.0            0.0
shared ksunfy : SSO free list                  3,025,600        3,025,600       0.0          3,025,600        3,025,600       0.0              0.0            0.0
shared private strands                         3,677,184        3,677,184       0.0          3,677,184        3,677,184       0.0              0.0            0.0
shared row cache                               7,593,704        7,593,704       0.0          7,593,704        7,593,704       0.0              0.0            0.0
shared write state object                      3,853,680        3,853,680       0.0          3,853,680        3,853,680       0.0              0.0            0.0
stream free memory                             8,376,440        8,376,440       0.0          8,376,440        8,376,440       0.0              0.0            0.0
       buffer_cache                          763,363,328      763,363,328       0.0        763,363,328      763,363,328       0.0              0.0            0.0
       fixed_sga                               2,235,208        2,235,208       0.0          2,235,208        2,235,208       0.0              0.0            0.0
       log_buffer                              9,736,192        9,736,192       0.0          9,736,192        9,736,192       0.0              0.0            0.0
                          --------------------------------------------------------------------------------------------------------------------

Streams by CPU Time   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by Absolute value of '%Diff' column of 'CPU Time'
-> CPU and I/O Time in seconds

                                      CPU Time (sec)                     User I/O Time (sec)                 System I/O Time (sec)
                            ----------------------------------   ----------------------------------   ----------------------------------
Session Type                         1st          2nd    %Diff            1st          2nd    %Diff            1st          2nd    %Diff
-------------------------   ------------ ------------ --------   ------------ ------------ --------   ------------ ------------ --------
QMON Coordinator                     0.0          0.0    199.8            0.0          0.0      0.0            0.0          0.0      0.0
QMON Slaves                          0.0          0.0     26.3            0.0          0.1    181.9            0.0          0.0      0.0
                          --------------------------------------------------------------------------------------------------------------------

Streams by IO Time   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Ordered by Absolute value of 'Total %Diff' column of 'IO Time'
-> CPU and I/O Time in seconds

                                                                 IO Time (sec)                                                 CPU Time (sec)
                            --------------------------------------------------------------------------------------   ----------------------------------
Session Type                    1st User   1st System    1st Total     2nd User   2nd System    2nd Total Total %D            1st          2nd    %Diff
-------------------------   ------------ ------------ ------------ ------------ ------------ ------------ --------   ------------ ------------ --------
QMON Slaves                          0.0          0.0          0.0          0.1          0.0          0.1    181.9            0.0          0.0     26.3
QMON Coordinator                     0.0          0.0          0.0          0.0          0.0          0.0      0.0            0.0          0.0    199.8
                          --------------------------------------------------------------------------------------------------------------------

Streams Capture   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)

                  No data exists for this section of the report.
                          --------------------------------------------------------------------------------------------------------------------

Streams Capture Rate   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)

                  No data exists for this section of the report.
                          --------------------------------------------------------------------------------------------------------------------

Streams Apply   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)

                  No data exists for this section of the report.
                          --------------------------------------------------------------------------------------------------------------------

Streams Apply Rate   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)

                  No data exists for this section of the report.
                          --------------------------------------------------------------------------------------------------------------------

Buffered Queues   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Queue Name prefixed by * indicates queue (re)started between Begin/End snapshots
-> Ordered by absolute value of '%Diff' column of 'Enq Msgs', descending

                                                                                              Enq Msgs                      Enq Msgs/sec                      Deq Msgs                      Deq Msgs/sec                     Spill Msgs                    Spill Msgs/sec              %Spill Msgs
                                                                                   ------------------------------   ----------------------------   ------------------------------   ----------------------------   ------------------------------   ----------------------------   -------------------
          1st        2nd    %Diff         1st       2nd    %Diff          1st        2nd    %Diff         1st       2nd    %Diff          1st        2nd    %Diff         1st       2nd    %Diff         1st       2nd
   ---------- ---------- --------   --------- --------- --------   ---------- ---------- --------   --------- --------- --------   ---------- ---------- --------   --------- --------- --------   --------- ---------
SYS.SCHEDULER$_EVENT_QUEUE(12613)
            0          0      0.0         0.0       0.0      0.0            0          0      0.0         0.0       0.0      0.0            0          0      0.0         0.0       0.0      0.0         N/A       N/A
                          --------------------------------------------------------------------------------------------------------------------

Buffered Subscribers   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)

                  No data exists for this section of the report.
                          --------------------------------------------------------------------------------------------------------------------

Rule Set by Evaluations   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)

                  No data exists for this section of the report.
                          --------------------------------------------------------------------------------------------------------------------

Rule Set by Elapsed Time   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)

                  No data exists for this section of the report.
                          --------------------------------------------------------------------------------------------------------------------

Persistent Queues   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)

                  No data exists for this section of the report.
                          --------------------------------------------------------------------------------------------------------------------

Persistent Queues Rate   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)

                  No data exists for this section of the report.
                          --------------------------------------------------------------------------------------------------------------------

Persistent Queue Subscribers   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)

                  No data exists for this section of the report.
                          --------------------------------------------------------------------------------------------------------------------

Shared Servers Activity   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Values represent averages for all samples

             Avg Total Connections                             Avg Active Connections                           Avg Total Shared Servers                         Avg Active Shared Servers                           Avg Total Dispatchers                             Avg Active Dispatchers
-----------------------------------------------   -----------------------------------------------   -----------------------------------------------   -----------------------------------------------   -----------------------------------------------   -----------------------------------------------
         1st          2nd         Diff    %Diff            1st          2nd         Diff    %Diff            1st          2nd         Diff    %Diff            1st          2nd         Diff    %Diff            1st          2nd         Diff    %Diff            1st          2nd         Diff    %Diff
------------ ------------ ------------ --------   ------------ ------------ ------------ --------   ------------ ------------ ------------ --------   ------------ ------------ ------------ --------   ------------ ------------ ------------ --------   ------------ ------------ ------------ --------
           0            0            0      0.0              0            0            0      0.0              0            0            0      0.0              0            0            0      0.0              0            0            0      0.0              0            0            0      0.0
                          --------------------------------------------------------------------------------------------------------------------

Shared Servers Rates   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)

           Common Queue Per Sec                      Dispatcher Queue Per Sec                    Server Messages Per Sec                        Server KB Per Sec                       Common Queue Total                 Dispatcher Queue Total                Server Total Messages                   Server Total KB
-----------------------------------------   -----------------------------------------   -----------------------------------------   -----------------------------------------   ----------------------------------   ----------------------------------   ----------------------------------   ---------------------------------
       1st        2nd       Diff    %Diff          1st        2nd       Diff    %Diff          1st        2nd       Diff    %Diff          1st        2nd       Diff    %Diff            1st          2nd    %Diff            1st          2nd    %Diff            1st          2nd    %Diff            1st          2nd    %Dif
---------- ---------- ---------- --------   ---------- ---------- ---------- --------   ---------- ---------- ---------- --------   ---------- ---------- ---------- --------   ------------ ------------ --------   ------------ ------------ --------   ------------ ------------ --------   ------------ ------------ -------
        .0         .0         .0      0.0           .0         .0         .0      0.0           .0         .0         .0      0.0           .0         .0         .0      0.0              0            0      0.0              0            0      0.0              0            0      0.0              0            0      0.
                          --------------------------------------------------------------------------------------------------------------------

Shared Servers Utilization   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)

                  No data exists for this section of the report.
                          --------------------------------------------------------------------------------------------------------------------

Shared Servers Common Queue   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)

                  No data exists for this section of the report.
                          --------------------------------------------------------------------------------------------------------------------

Shared Servers Dispatchers   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)

Avg Connections (per Dispatcher)            Avg %Busy                    Avg %Idle                     Total Queued (all Dispatchers)                        Average Queued per Dispatcher                    Average Queued Wait (ms)
------------------------------   --------------------------   --------------------------   --------------------------------------------------   --------------------------------------------------   --------------------------------------
       1st        2nd    %Diff        1st      2nd     Diff        1st      2nd     Diff                    1st                  2nd    %Diff                    1st                  2nd    %Diff              1st            2nd    %Diff
---------- ---------- --------   -------- -------- --------   -------- -------- --------   -------------------- -------------------- --------   -------------------- -------------------- --------   -------------- -------------- --------
       N/A        N/A      N/A        N/A      N/A      0.0        N/A      N/A      0.0                    N/A                  N/A      N/A                    N/A                  N/A      N/A              N/A            N/A      N/A
                          --------------------------------------------------------------------------------------------------------------------

Dynamic Remastering Stats   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)

                  No data exists for this section of the report.
                          --------------------------------------------------------------------------------------------------------------------

init.ora Parameters   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> Only explicitly set parameters are included
-> Parameters values for the Begin Snapshot are shown only if they differ from those for the Bnd snapshot
-> Parameters values for the second period are shown only if they differ from those for the first period
-> Value '(DEFAULT)' indicates that parameter was not set for the period

                                                                                               1st Period                                                          2nd Period
                                                                   -----------------------------------------------------------------   -----------------------------------------------------------------
Parameter Name                                                     Begin Snap Value                 End Snap Value                     Begin Snap Value                 End Snap Value
----------------------------------------------------------------   -------------------------------- --------------------------------   -------------------------------- --------------------------------
audit_file_dest                                                                                     /u00/app/oracle/admin/DBM11203/a
audit_trail                                                                                         DB
control_files                                                                                       +DATA/dbm11203/controlfile/curre
core_dump_dest                                                                                      /u00/app/oracle/diag/rdbms/dbm11
cursor_sharing                                                                                      EXACT
db_block_size                                                                                       8192
db_create_file_dest                                                                                 +DATA
db_domain                                                                                           antognini.ch
db_name                                                                                             DBM11203
db_recovery_file_dest                                                                               +FRA
db_recovery_file_dest_size                                                                          2147483648
diagnostic_dest                                                                                     /u00/app/oracle
local_listener                                                                                      (DESCRIPTION=(ADDRESS=(PROTOCOL=
log_buffer                                                                                          8183808
open_cursors                                                                                        30
optimizer_dynamic_sampling                                                                          2
optimizer_mode                                                                                      ALL_ROWS
pga_aggregate_target                                                                                134217728
plsql_warnings                                                                                      DISABLE:ALL
processes                                                                                           150
query_rewrite_enabled                                                                               TRUE
remote_login_passwordfile                                                                           EXCLUSIVE
result_cache_max_size                                                                               2031616
sga_target                                                                                          1073741824
skip_unusable_indexes                                                                               TRUE
undo_tablespace                                                                                     UNDOTBS1
user_dump_dest                                                                                      /u00/app/oracle/diag/rdbms/dbm11
                          --------------------------------------------------------------------------------------------------------------------

init.ora Multi-Valued Parameters   First DB/Inst: DBM11203/DBM11203 Snaps: 1822-1823 (Elapsed time: 901.55 sec  DB time: 6404.55 sec),  Second DB/Inst: DBM11203/DBM11203 Snaps: 1826-1827 (Elapsed time: 902.852 sec  DB time: 12612.51 sec)
-> This section only displays parameters that have more one value
-> Only explicitly set parameters are included
-> Parameters values for the Begin Snapshot are shown only if they differ from those for the End snapshot
-> Parameters values for the second period are shown only if they differ from those for the first period
-> Value '(DEFAULT)' indicates that parameter was not set for the period
-> Value '(NULL)' in the Begin/End snapshot indicates that the parameter value was not set for that period

                                                                                                                               1st Period                                                                                                                          2nd Period
                                                                   ---------------------------------------------------------------------------------------------------------------------------------   -------------------------------------------------------------------------------------------------------------------------
Parameter Name                                                     Begin Snap Value                                                 End Snap Value                                                     Begin Snap Value                                                 End Snap Value
----------------------------------------------------------------   ---------------------------------------------------------------- ----------------------------------------------------------------   ---------------------------------------------------------------- --------------------------------------------------------
control_files                                                                                                                       +DATA/dbm11203/controlfile/current.455.772715921
                                                                                                                                    +FRA/dbm11203/controlfile/current.332.772715921
                          --------------------------------------------------------------------------------------------------------------------

