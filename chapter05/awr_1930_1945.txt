
WORKLOAD REPOSITORY report for

DB Name         DB Id    Instance     Inst Num Startup Time    Release     RAC
------------ ----------- ------------ -------- --------------- ----------- ---
DBM11203      2532911053 DBM11203            1 23-Apr-14 16:33 11.2.0.3.0  NO

Host Name        Platform                         CPUs Cores Sockets Memory(GB)
---------------- -------------------------------- ---- ----- ------- ----------
helicon          Linux x86 64-bit                    8     8       2       7.79

              Snap Id      Snap Time      Sessions Curs/Sess
            --------- ------------------- -------- ---------
Begin Snap:      1826 23-Apr-14 19:30:10        59       1.7
  End Snap:      1827 23-Apr-14 19:45:13        74       1.8
   Elapsed:               15.05 (mins)
   DB Time:              210.21 (mins)

Cache Sizes                       Begin        End
~~~~~~~~~~~                  ---------- ----------
               Buffer Cache:       728M       728M  Std Block Size:         8K
           Shared Pool Size:       260M       260M      Log Buffer:     9,508K

Load Profile              Per Second    Per Transaction   Per Exec   Per Call
~~~~~~~~~~~~         ---------------    --------------- ---------- ----------
      DB Time(s):               14.0                0.1       0.01       0.00
       DB CPU(s):                3.2                0.0       0.00       0.00
       Redo size:          552,173.5            1,933.1
   Logical reads:          649,091.1            2,272.4
   Block changes:            3,948.6               13.8
  Physical reads:              857.4                3.0
 Physical writes:              578.1                2.0
      User calls:            4,051.3               14.2
          Parses:                1.6                0.0
     Hard parses:                0.4                0.0
W/A MB processed:                0.1                0.0
          Logons:                0.0                0.0
        Executes:            1,914.2                6.7
       Rollbacks:                0.0                0.0
    Transactions:              285.6

Instance Efficiency Percentages (Target 100%)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            Buffer Nowait %:  100.00       Redo NoWait %:   99.96
            Buffer  Hit   %:   99.87    In-memory Sort %:  100.00
            Library Hit   %:   99.92        Soft Parse %:   76.90
         Execute to Parse %:   99.92         Latch Hit %:   99.83
Parse CPU to Parse Elapsd %:   71.98     % Non-Parse CPU:   98.91

 Shared Pool Statistics        Begin    End
                              ------  ------
             Memory Usage %:   74.66   65.25
    % SQL with executions>1:   79.00   70.05
  % Memory for SQL w/exec>1:   68.33   61.00

Top 5 Timed Foreground Events
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                                           Avg
                                                          wait   % DB
Event                                 Waits     Time(s)   (ms)   time Wait Class
------------------------------ ------------ ----------- ------ ------ ----------
db file sequential read             770,898       9,336     12   74.0 User I/O
DB CPU                                            2,877          22.8
log file sync                       256,683         267      1    2.1 Commit
read by other session                 4,219          51     12     .4 User I/O
log file switch (private stran          266          12     45     .1 Configurat
Host CPU (CPUs:    8 Cores:    8 Sockets:    2)
~~~~~~~~         Load Average
               Begin       End     %User   %System      %WIO     %Idle
           --------- --------- --------- --------- --------- ---------
                8.37     14.07      39.6       1.4      30.5      58.1

Instance CPU
~~~~~~~~~~~~
              % of total CPU for Instance:      41.4
              % of busy  CPU for Instance:      98.9
  %DB time waiting for CPU - Resource Mgr:       0.0

Memory Statistics
~~~~~~~~~~~~~~~~~                       Begin          End
                  Host Mem (MB):      7,974.6      7,974.6
                   SGA use (MB):      1,024.0      1,024.0
                   PGA use (MB):        184.9        217.0
    % Host Mem used for SGA+PGA:        15.16        15.56

Time Model Statistics            DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Total time in database user-calls (DB Time): 12612.5s
-> Statistics including the word "background" measure background process
   time, and so do not contribute to the DB time statistic
-> Ordered by % or DB time desc, Statistic name

Statistic Name                                       Time (s) % of DB Time
------------------------------------------ ------------------ ------------
sql execute elapsed time                             12,024.6         95.3
DB CPU                                                2,876.5         22.8
parse time elapsed                                       57.1           .5
connection management call elapsed time                   7.4           .1
hard parse elapsed time                                   3.6           .0
hard parse (sharing criteria) elapsed time                0.5           .0
hard parse (bind mismatch) elapsed time                   0.5           .0
PL/SQL compilation elapsed time                           0.3           .0
PL/SQL execution elapsed time                             0.0           .0
repeated bind elapsed time                                0.0           .0
sequence load elapsed time                                0.0           .0
DB time                                              12,612.5
background elapsed time                                 221.9
background cpu time                                      62.1
          -------------------------------------------------------------

Operating System Statistics       DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> *TIME statistic values are diffed.
   All others display actual values.  End Value is displayed if different
-> ordered by statistic type (CPU Use, Virtual Memory, Hardware Config), Name

Statistic                                  Value        End Value
------------------------- ---------------------- ----------------
BUSY_TIME                                297,133
IDLE_TIME                                412,759
IOWAIT_TIME                              216,362
NICE_TIME                                     99
SYS_TIME                                  10,170
USER_TIME                                281,270
LOAD                                           8               14
PHYSICAL_MEMORY_BYTES              8,361,992,192
NUM_CPUS                                       8
NUM_CPU_CORES                                  8
NUM_CPU_SOCKETS                                2
GLOBAL_RECEIVE_SIZE_MAX                4,194,304
GLOBAL_SEND_SIZE_MAX                   1,048,576
TCP_RECEIVE_SIZE_DEFAULT                  87,380
TCP_RECEIVE_SIZE_MAX                     174,760
TCP_RECEIVE_SIZE_MIN                       4,096
TCP_SEND_SIZE_DEFAULT                     16,384
TCP_SEND_SIZE_MAX                        131,072
TCP_SEND_SIZE_MIN                          4,096
          -------------------------------------------------------------

Operating System Statistics - DetailDB/Inst: DBM11203/DBM11203  Snaps: 1826-18

Snap Time           Load    %busy    %user     %sys    %idle  %iowait
--------------- -------- -------- -------- -------- -------- --------
23-Apr 19:30:10      8.4      N/A      N/A      N/A      N/A      N/A
23-Apr 19:45:13     14.1     41.9     39.6      1.4     58.1     30.5
          -------------------------------------------------------------

Foreground Wait Class             DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> s  - second, ms - millisecond -    1000th of a second
-> ordered by wait time desc, waits desc
-> %Timeouts: value of 0 indicates value was < .5%.  Value of null is truly 0
-> Captured Time accounts for         99.7%  of Total DB time      12,612.51 (s)
-> Total FG Wait Time:             9,692.09 (s)  DB CPU time:       2,876.51 (s)

                                                                  Avg
                                      %Time       Total Wait     wait
Wait Class                      Waits -outs         Time (s)     (ms)  %DB time
-------------------- ---------------- ----- ---------------- -------- ---------
User I/O                      775,292     0            9,388       12      74.4
DB CPU                                                 2,877               22.8
Commit                        256,683     0              267        1       2.1
Configuration                     418     0               19       46       0.2
Concurrency                     2,706     0               11        4       0.1
Network                     1,986,310     0                4        0       0.0
Application                     1,230     0                2        2       0.0
Other                             291     3                1        2       0.0
System I/O                        364     0                0        0       0.0
          -------------------------------------------------------------

Foreground Wait Events           DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> s  - second, ms - millisecond -    1000th of a second
-> Only events with Total Wait Time (s) >= .001 are shown
-> ordered by wait time desc, waits desc (idle events last)
-> %Timeouts: value of 0 indicates value was < .5%.  Value of null is truly 0

                                                             Avg
                                        %Time Total Wait    wait    Waits   % DB
Event                             Waits -outs   Time (s)    (ms)     /txn   time
-------------------------- ------------ ----- ---------- ------- -------- ------
db file sequential read         770,898     0      9,336      12      3.0   74.0
log file sync                   256,683     0        267       1      1.0    2.1
read by other session             4,219     0         51      12      0.0     .4
log file switch (private s          266     0         12      45      0.0     .1
cursor: pin S wait on X              74     0          8     104      0.0     .1
log file switch (checkpoin          148     0          7      47      0.0     .1
SQL*Net message to client     1,986,310     0          4       0      7.7     .0
enq: TX - row lock content        1,230     0          2       2      0.0     .0
library cache lock                   50     0          1      21      0.0     .0
library cache load lock              27     0          1      19      0.0     .0
enq: TX - index contention           32     0          1      16      0.0     .0
library cache: mutex X              217     0          0       2      0.0     .0
latch: cache buffers chain        1,325     0          0       0      0.0     .0
kksfbc child completion               6   100          0      51      0.0     .0
db file parallel read                28     0          0      11      0.0     .0
cursor: pin S                        64     0          0       4      0.0     .0
buffer busy waits                   635     0          0       0      0.0     .0
control file sequential re          364     0          0       0      0.0     .0
latch free                          193     0          0       1      0.0     .0
enq: HW - contention                  4     0          0      28      0.0     .0
enq: TX - contention                  1     0          0      69      0.0     .0
latch: In memory undo latc          254     0          0       0      0.0     .0
row cache lock                       11     0          0       3      0.0     .0
latch: shared pool                    9     0          0       2      0.0     .0
latch: object queue header           46     0          0       0      0.0     .0
db file scattered read                2     0          0       7      0.0     .0
Disk file operations I/O            145     0          0       0      0.0     .0
latch: enqueue hash chains           28     0          0       0      0.0     .0
enq: CU - contention                  1     0          0       4      0.0     .0
latch: row cache objects              8     0          0       0      0.0     .0
latch: redo allocation                5     0          0       0      0.0     .0
latch: undo global data               6     0          0       0      0.0     .0
SQL*Net message from clien    1,986,307     0     22,827      11      7.7
jobq slave wait                     120   100         60     501      0.0
          -------------------------------------------------------------

Background Wait Events           DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> ordered by wait time desc, waits desc (idle events last)
-> Only events with Total Wait Time (s) >= .001 are shown
-> %Timeouts: value of 0 indicates value was < .5%.  Value of null is truly 0

                                                             Avg
                                        %Time Total Wait    wait    Waits   % bg
Event                             Waits -outs   Time (s)    (ms)     /txn   time
-------------------------- ------------ ----- ---------- ------- -------- ------
log file parallel write         242,545     0        105       0      0.9   47.3
db file parallel write           39,266     0         23       1      0.2   10.3
control file sequential re        2,471     0         14       6      0.0    6.4
db file sequential read           1,658     0         14       9      0.0    6.4
db file scattered read               86     0          1      11      0.0     .4
log file sequential read             56     0          1      10      0.0     .3
direct path read                     32     0          0      15      0.0     .2
os thread startup                    11     0          0      38      0.0     .2
control file parallel writ          663     0          0       1      0.0     .2
ASM file metadata operatio          542     0          0       1      0.0     .1
LGWR wait for redo copy           2,634     0          0       0      0.0     .1
ADR block file read                  16     0          0       7      0.0     .0
latch: cache buffers chain           18     0          0       1      0.0     .0
latch: redo allocation               39     0          0       0      0.0     .0
reliable message                     58     0          0       0      0.0     .0
latch free                           11     0          0       1      0.0     .0
db file async I/O submit          2,564     0          0       0      0.0     .0
CSS initialization                    1     0          0       7      0.0     .0
direct path write                    27     0          0       0      0.0     .0
log file single write                56     0          0       0      0.0     .0
latch: cache buffers lru c           22     0          0       0      0.0     .0
Disk file operations I/O             51     0          0       0      0.0     .0
ADR block file write                  5     0          0       0      0.0     .0
CSS operation: action                 1     0          0       2      0.0     .0
latch: object queue header            7     0          0       0      0.0     .0
rdbms ipc message               246,243     2     12,462      51      1.0
class slave wait                    267     0      3,621   13561      0.0
Space Manager: slave idle           454    91      2,158    4754      0.0
DIAG idle wait                    1,807   100      1,810    1001      0.0
smon timer                           41     0        906   22092      0.0
ASM background timer                181     0        906    5003      0.0
wait for unread message on          904   100        905    1002      0.0
pmon timer                          363    69        904    2490      0.0
Streams AQ: qmn coordinato          290    44        902    3111      0.0
Streams AQ: qmn slave idle          129     0        902    6993      0.0
SQL*Net message from clien           45     0          0       5      0.0
KSV master wait                      86     0          0       0      0.0
          -------------------------------------------------------------

Wait Event Histogram             DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Units for Total Waits column: K is 1000, M is 1000000, G is 1000000000
-> % of Waits: value of .0 indicates value was <.05%; value of null is truly 0
-> % of Waits: column heading of <=1s is truly <1024ms, >1s is truly >=1024ms
-> Ordered by Event (idle events last)

                                                    % of Waits
                                 -----------------------------------------------
                           Total
Event                      Waits  <1ms  <2ms  <4ms  <8ms <16ms <32ms  <=1s   >1s
-------------------------- ----- ----- ----- ----- ----- ----- ----- ----- -----
ADR block file read           16  75.0              12.5              12.5
ADR block file write           5 100.0
ADR file lock                  6 100.0
ASM file metadata operatio   545  91.7   4.0   3.3    .4    .2    .2    .2
CSS initialization             1                   100.0
CSS operation: action          1       100.0
CSS operation: query           6 100.0
Disk file operations I/O     196 100.0
LGWR wait for redo copy     2638  99.6    .2    .2          .1
SQL*Net message to client  1991. 100.0    .0    .0    .0
asynch descriptor resize      61 100.0
buffer busy waits            639  98.0    .6    .8    .2    .2          .3
control file parallel writ   663  91.3   3.9   2.7   1.2    .6    .2    .2
control file sequential re  2835  72.2    .6   2.8   9.5   7.8   3.9   3.2
cursor: pin S                 64  56.3   6.3   4.7        31.3   1.6
cursor: pin S wait on X       74   2.7   1.4         1.4  17.6  13.5  63.5
db file async I/O submit    2565 100.0
db file parallel read         28               7.1  35.7  46.4   7.1   3.6
db file parallel write     39.3K  95.0    .4    .3    .5   3.8    .0    .0
db file scattered read        88  13.6  11.4   9.1  23.9  25.0  11.4   5.7
db file sequential read    774.4   2.1   2.0  14.1  39.4  25.7  10.1   6.7
direct path read              32   6.3   6.3  21.9  15.6  18.8  25.0   6.3
direct path write             27  96.3         3.7
enq: CU - contention           1             100.0
enq: HW - contention           4  25.0                          50.0  25.0
enq: TX - contention           1                                     100.0
enq: TX - index contention    32  25.0   3.1   9.4  15.6  18.8  12.5  15.6
enq: TX - row lock content  1236  84.7   4.1   3.1   3.7   1.7   1.9    .8
kksfbc child completion        6                                     100.0
latch free                   204  93.6   2.9          .5   2.0   1.0
latch: In memory undo latc   253  97.2   1.6   1.2
latch: cache buffers chain  1349  94.5   2.9   2.1    .2    .2          .1
latch: cache buffers lru c    22 100.0
latch: checkpoint queue la     1 100.0
latch: enqueue hash chains    28  96.4   3.6
latch: messages                3 100.0
latch: object queue header    54  96.3   1.9   1.9
latch: redo allocation        45  97.8         2.2
latch: redo writing            2 100.0
latch: row cache objects       8 100.0
latch: session allocation      2 100.0
latch: shared pool             9  44.4  11.1  22.2  22.2
latch: undo global data        6 100.0
library cache load lock       27  11.1         3.7        22.2  55.6   7.4
library cache lock            50  58.0   2.0   2.0        16.0   2.0  20.0
library cache: mutex X       217  82.9   2.3    .5        11.5   1.8    .9
log file parallel write    243.1  92.7   3.2   2.2   1.0    .6    .2    .0
log file sequential read      56  26.8   7.1  14.3  16.1  23.2   5.4   7.1
log file single write         56 100.0
log file switch (checkpoin   148               2.0   2.7  11.5  16.2  67.6
log file switch (private s   265   1.5   1.1   1.9   4.2   7.2  21.5  62.6
log file sync              257.3  85.4   5.7   3.9   2.2   2.1    .7    .1
os thread startup             11                                     100.0
read by other session       4227   3.9   5.2  15.5  33.7  22.0  11.8   7.7
reliable message              58 100.0
row cache lock                11   9.1        90.9
ASM background timer         181                                           100.0
DIAG idle wait              1811                                      99.9    .1
KSV master wait               86  98.8         1.2
SQL*Net message from clien 1991.  26.6    .2    .2    .1  46.2  26.1    .7
Wait Event Histogram             DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Units for Total Waits column: K is 1000, M is 1000000, G is 1000000000
-> % of Waits: value of .0 indicates value was <.05%; value of null is truly 0
-> % of Waits: column heading of <=1s is truly <1024ms, >1s is truly >=1024ms
-> Ordered by Event (idle events last)

                                                    % of Waits
                                 -----------------------------------------------
                           Total
Event                      Waits  <1ms  <2ms  <4ms  <8ms <16ms <32ms  <=1s   >1s
-------------------------- ----- ----- ----- ----- ----- ----- ----- ----- -----
Space Manager: slave idle    457                                       3.1  96.9
Streams AQ: qmn coordinato   292  55.1          .3                          44.5
Streams AQ: qmn slave idle   130                                           100.0
class slave wait             267  35.6          .4    .7   3.4   5.6  22.1  32.2
jobq slave wait              120                                     100.0
pmon timer                   364    .3                .5   1.1        11.0  87.1
rdbms ipc message          246.8  31.4  17.5  21.8  18.4   7.6    .7   1.5    .9
smon timer                    42  14.3                                 7.1  78.6
wait for unread message on   905                                     100.0
          -------------------------------------------------------------

Wait Event Histogram Detail (64 msec to 2 sec)DB/Inst: DBM11203/DBM11203  Sna
-> Units for Total Waits column: K is 1000, M is 1000000, G is 1000000000
-> Units for % of Total Waits:
   ms is milliseconds
   s is 1024 milliseconds (approximately 1 second)
-> % of Total Waits: total waits for all wait classes, including Idle
-> % of Total Waits: value of .0 indicates value was <.05%;
   value of null is truly 0
-> Ordered by Event (only non-idle events are displayed)

                                                 % of Total Waits
                                 -----------------------------------------------
                           Waits
                           64ms
Event                      to 2s <32ms <64ms <1/8s <1/4s <1/2s   <1s   <2s  >=2s
-------------------------- ----- ----- ----- ----- ----- ----- ----- ----- -----
ADR block file read            2  87.5  12.5
ASM file metadata operatio     1  99.8          .2
buffer busy waits              2  99.7    .3
control file parallel writ     1  99.8    .2
control file sequential re    92  96.8   1.8   1.0    .5
cursor: pin S wait on X       47  36.5  28.4        28.4   6.8
db file parallel read          1  96.4   3.6
db file parallel write         7 100.0    .0    .0    .0
db file scattered read         5  94.3   4.5   1.1
db file sequential read    51.5K  93.3   4.4   2.1    .2    .0
direct path read               2  93.8   3.1   3.1
enq: HW - contention           1  75.0  25.0
enq: TX - contention           1             100.0
enq: TX - index contention     5  84.4   9.4   6.3
enq: TX - row lock content    10  99.2    .6    .2
kksfbc child completion        6       100.0
latch: cache buffers chain     1  99.9    .1
library cache load lock        2  92.6   7.4
library cache lock            10  80.0  16.0               4.0
library cache: mutex X         2  99.1    .9
log file parallel write       18 100.0    .0    .0
log file sequential read       4  92.9   3.6   3.6
log file switch (checkpoin   100  32.4  44.6  23.0
log file switch (private s   166  37.4  42.3  20.4
log file sync                236  99.9    .1    .0    .0
os thread startup             11       100.0
read by other session        327  92.3   5.7   1.9    .1
          -------------------------------------------------------------

Wait Event Histogram Detail (4 sec to 2 min)DB/Inst: DBM11203/DBM11203  Snaps

                  No data exists for this section of the report.
          -------------------------------------------------------------

Wait Event Histogram Detail (4 min to 1 hr)DB/Inst: DBM11203/DBM11203  Snaps:

                  No data exists for this section of the report.
          -------------------------------------------------------------

Service Statistics               DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> ordered by DB Time

                                                           Physical      Logical
Service Name                  DB Time (s)   DB CPU (s)    Reads (K)    Reads (K)
---------------------------- ------------ ------------ ------------ ------------
DBM11203.antognini.ch              12,579        2,870          770      585,661
SYS$USERS                              10            1            1           16
SYS$BACKGROUND                          0            0            2           31
          -------------------------------------------------------------

Service Wait Class Stats          DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Wait Class info for services in the Service Statistics section.
-> Total Waits and Time Waited displayed for the following wait
   classes:  User I/O, Concurrency, Administrative, Network
-> Time Waited (Wt Time) in seconds

Service Name
----------------------------------------------------------------
 User I/O  User I/O  Concurcy  Concurcy     Admin     Admin   Network   Network
Total Wts   Wt Time Total Wts   Wt Time Total Wts   Wt Time Total Wts   Wt Time
--------- --------- --------- --------- --------- --------- --------- ---------
DBM11203.antognini.ch
   774230      9380      2706        11         0         0   1985735         4
SYS$USERS
      824         6         0         0         0         0         0         0
SYS$BACKGROUND
     1837        15        33         0         0         0         0         0
          -------------------------------------------------------------

SQL ordered by Elapsed Time      DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Resources reported for PL/SQL code includes the resources used by all SQL
   statements called by the code.
-> % Total DB Time is the Elapsed Time of the SQL statement divided
   into the Total Database Time multiplied by 100
-> %Total - Elapsed Time  as a percentage of Total DB time
-> %CPU   - CPU Time      as a percentage of Elapsed Time
-> %IO    - User I/O Time as a percentage of Elapsed Time
-> Captured SQL account for   89.3% of Total DB Time (s):          12,613
-> Captured PL/SQL account for    0.1% of Total DB Time (s):          12,613

        Elapsed                  Elapsed Time
        Time (s)    Executions  per Exec (s)  %Total   %CPU    %IO    SQL Id
---------------- -------------- ------------- ------ ------ ------ -------------
         3,625.7        176,182          0.02   28.7    1.4   98.8 82ud5h0qcg0bf
Module: Swingbench User Thread
select customer_id, cust_first_name ,cust_last_name ,nls_language ,nls_territory
 ,credit_limit ,cust_email ,account_mgr_id from customers where customer_id = :
1

         2,314.7         10,442          0.22   18.4   92.6    5.1 g8rhybcumtwd6
Module: Swingbench User Thread
SELECT /*+ first_rows index(customers, customers_pk) index(orders, order_status
_ix) */ o.order_id, line_item_id, product_id, unit_price, quantity, order_mode,
 order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_firs
t_name, cust_last_name, credit_limit, cust_email, order_date FROM orders o , ord

         1,327.3        147,058          0.01   10.5    3.9   95.7 8vvvyuun2urt6
Module: Swingbench User Thread
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY
) values (:1 , :2 , :3 , :4 , :5 )

         1,290.3         51,948          0.02   10.2    2.7   97.1 9zd49du11u7cf
Module: Swingbench User Thread
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) values (:1 ,
 :2 , :3 , :4 )

         1,038.3         51,887          0.02    8.2    2.0   98.1 d5j6fbqmu3gjp
Module: Swingbench User Thread
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_price, quantity,
 order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_i
d, cust_first_name, cust_last_name, credit_limit, cust_email FROM orders o , o
rder_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id =

         1,011.0        147,054          0.01    8.0    2.6   97.3 5g00dq4fxwnsw
Module: Swingbench User Thread
update inventories set quantity_on_hand = quantity_on_hand - :1 where product_i
d = :2 and warehouse_id = :3

           323.4         51,945          0.01    2.6    6.0   93.6 2yp5w5a36s5xv
Module: Swingbench User Thread
update orders set order_mode = :1 , order_status = :2 , order_total = :3 where
order_id = :4

            84.9         51,947          0.00     .7   14.3   85.0 gfqas5ahy1x56
Module: Swingbench User Thread
SELECT o.order_id, line_item_id, product_id, unit_price, quantity, or
der_mode, order_status, order_total, sales_rep_id, promotion_id, c.cus
tomer_id, cust_first_name, cust_last_name, credit_limit, cust_email FRO
M orders o , order_items oi, customers c WHERE o.order_id = oi.order_i

            84.6        311,130          0.00     .7   87.0     .0 gyk686gnaygs2
Module: Swingbench User Thread
select product_id, product_name, product_description, category_id, weight_class,
 supplier_id, product_status list_price, min_price, catalog_url from product_
information where category_id = :1

            42.7        176,186          0.00     .3   65.9   15.2 gshgncvvtv0c6
Module: Swingbench User Thread
insert into logon values(:1 ,:2 )

          -------------------------------------------------------------

SQL ordered by CPU Time          DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Resources reported for PL/SQL code includes the resources used by all SQL
   statements called by the code.
-> %Total - CPU Time      as a percentage of Total DB CPU
-> %CPU   - CPU Time      as a percentage of Elapsed Time
-> %IO    - User I/O Time as a percentage of Elapsed Time
-> Captured SQL account for   87.7% of Total CPU Time (s):           2,877
-> Captured PL/SQL account for    0.1% of Total CPU Time (s):           2,877

    CPU                   CPU per           Elapsed
  Time (s)  Executions    Exec (s) %Total   Time (s)   %CPU    %IO    SQL Id
---------- ------------ ---------- ------ ---------- ------ ------ -------------
   2,144.4       10,442       0.21   74.5    2,314.7   92.6    5.1 g8rhybcumtwd6
Module: Swingbench User Thread
SELECT /*+ first_rows index(customers, customers_pk) index(orders, order_status
_ix) */ o.order_id, line_item_id, product_id, unit_price, quantity, order_mode,
 order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_firs
t_name, cust_last_name, credit_limit, cust_email, order_date FROM orders o , ord

      73.6      311,130       0.00    2.6       84.6   87.0     .0 gyk686gnaygs2
Module: Swingbench User Thread
select product_id, product_name, product_description, category_id, weight_class,
 supplier_id, product_status list_price, min_price, catalog_url from product_
information where category_id = :1

      52.2      176,182       0.00    1.8    3,625.7    1.4   98.8 82ud5h0qcg0bf
Module: Swingbench User Thread
select customer_id, cust_first_name ,cust_last_name ,nls_language ,nls_territory
 ,credit_limit ,cust_email ,account_mgr_id from customers where customer_id = :
1

      51.7      147,058       0.00    1.8    1,327.3    3.9   95.7 8vvvyuun2urt6
Module: Swingbench User Thread
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY
) values (:1 , :2 , :3 , :4 , :5 )

      34.5       51,948       0.00    1.2    1,290.3    2.7   97.1 9zd49du11u7cf
Module: Swingbench User Thread
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) values (:1 ,
 :2 , :3 , :4 )

      28.1      176,186       0.00    1.0       42.7   65.9   15.2 gshgncvvtv0c6
Module: Swingbench User Thread
insert into logon values(:1 ,:2 )

      26.4      147,054       0.00    0.9    1,011.0    2.6   97.3 5g00dq4fxwnsw
Module: Swingbench User Thread
update inventories set quantity_on_hand = quantity_on_hand - :1 where product_i
d = :2 and warehouse_id = :3

      21.2       51,887       0.00    0.7    1,038.3    2.0   98.1 d5j6fbqmu3gjp
Module: Swingbench User Thread
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_price, quantity,
 order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_i
d, cust_first_name, cust_last_name, credit_limit, cust_email FROM orders o , o
rder_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id =

      19.3       51,945       0.00    0.7      323.4    6.0   93.6 2yp5w5a36s5xv
Module: Swingbench User Thread
update orders set order_mode = :1 , order_status = :2 , order_total = :3 where
order_id = :4

      18.7      155,252       0.00    0.6       20.7   90.3     .0 7v0pya6f6qc6s
Module: Swingbench User Thread
select p.product_id, product_name, product_description, category_id, weight_cla
ss, supplier_id, product_status, list_price, min_price, catalog_url, quantity_o
n_hand, warehouse_id from product_information p, inventories i where categor
y_id = :1 and i.product_id = p.product_id

          -------------------------------------------------------------

SQL ordered by User I/O Wait TimeDB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Resources reported for PL/SQL code includes the resources used by all SQL
   statements called by the code.
-> %Total - User I/O Time as a percentage of Total User I/O Wait time
-> %CPU   - CPU Time      as a percentage of Elapsed Time
-> %IO    - User I/O Time as a percentage of Elapsed Time
-> Captured SQL account for   92.0% of Total User I/O Wait Time (s):           9
-> Captured PL/SQL account for    0.1% of Total User I/O Wait Time (s):

  User I/O                UIO per           Elapsed
  Time (s)  Executions    Exec (s) %Total   Time (s)   %CPU    %IO    SQL Id
---------- ------------ ---------- ------ ---------- ------ ------ -------------
   3,580.9      176,182       0.02   38.1    3,625.7    1.4   98.8 82ud5h0qcg0bf
Module: Swingbench User Thread
select customer_id, cust_first_name ,cust_last_name ,nls_language ,nls_territory
 ,credit_limit ,cust_email ,account_mgr_id from customers where customer_id = :
1

   1,270.5      147,058       0.01   13.5    1,327.3    3.9   95.7 8vvvyuun2urt6
Module: Swingbench User Thread
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY
) values (:1 , :2 , :3 , :4 , :5 )

   1,253.4       51,948       0.02   13.3    1,290.3    2.7   97.1 9zd49du11u7cf
Module: Swingbench User Thread
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) values (:1 ,
 :2 , :3 , :4 )

   1,018.7       51,887       0.02   10.8    1,038.3    2.0   98.1 d5j6fbqmu3gjp
Module: Swingbench User Thread
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_price, quantity,
 order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_i
d, cust_first_name, cust_last_name, credit_limit, cust_email FROM orders o , o
rder_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id =

     983.4      147,054       0.01   10.5    1,011.0    2.6   97.3 5g00dq4fxwnsw
Module: Swingbench User Thread
update inventories set quantity_on_hand = quantity_on_hand - :1 where product_i
d = :2 and warehouse_id = :3

     302.8       51,945       0.01    3.2      323.4    6.0   93.6 2yp5w5a36s5xv
Module: Swingbench User Thread
update orders set order_mode = :1 , order_status = :2 , order_total = :3 where
order_id = :4

     118.1       10,442       0.01    1.3    2,314.7   92.6    5.1 g8rhybcumtwd6
Module: Swingbench User Thread
SELECT /*+ first_rows index(customers, customers_pk) index(orders, order_status
_ix) */ o.order_id, line_item_id, product_id, unit_price, quantity, order_mode,
 order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_firs
t_name, cust_last_name, credit_limit, cust_email, order_date FROM orders o , ord

      72.2       51,947       0.00    0.8       84.9   14.3   85.0 gfqas5ahy1x56
Module: Swingbench User Thread
SELECT o.order_id, line_item_id, product_id, unit_price, quantity, or
der_mode, order_status, order_total, sales_rep_id, promotion_id, c.cus
tomer_id, cust_first_name, cust_last_name, credit_limit, cust_email FRO
M orders o , order_items oi, customers c WHERE o.order_id = oi.order_i

      31.8       10,442       0.00    0.3       38.6   10.1   82.4 6k3uuf3g8pwh6
Module: Swingbench User Thread
update /*+ index(orders, order_pk) */ orders set order_status = :1 where order_
id = :2

       6.5      176,186       0.00    0.1       42.7   65.9   15.2 gshgncvvtv0c6
Module: Swingbench User Thread
insert into logon values(:1 ,:2 )

          -------------------------------------------------------------

SQL ordered by Gets              DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Resources reported for PL/SQL code includes the resources used by all SQL
   statements called by the code.
-> %Total - Buffer Gets   as a percentage of Total Buffer Gets
-> %CPU   - CPU Time      as a percentage of Elapsed Time
-> %IO    - User I/O Time as a percentage of Elapsed Time
-> Total Buffer Gets:     586,033,175
-> Captured SQL account for    3.2% of Total

     Buffer                 Gets              Elapsed
      Gets   Executions   per Exec   %Total   Time (s)  %CPU   %IO    SQL Id
----------- ----------- ------------ ------ ---------- ----- ----- -------------
  9,341,219     311,130         30.0    1.6       84.6    87     0 gyk686gnaygs2
Module: Swingbench User Thread
select product_id, product_name, product_description, category_id, weight_class,
 supplier_id, product_status list_price, min_price, catalog_url from product_
information where category_id = :1

  1,952,469     147,058         13.3    0.3    1,327.3   3.9  95.7 8vvvyuun2urt6
Module: Swingbench User Thread
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY
) values (:1 , :2 , :3 , :4 , :5 )

  1,095,476     155,252          7.1    0.2       20.7  90.3     0 7v0pya6f6qc6s
Module: Swingbench User Thread
select p.product_id, product_name, product_description, category_id, weight_cla
ss, supplier_id, product_status, list_price, min_price, catalog_url, quantity_o
n_hand, warehouse_id from product_information p, inventories i where categor
y_id = :1 and i.product_id = p.product_id

  1,038,463     147,059          7.1    0.2       18.4  91.9     1 dt8dtzvsq5kj5
Module: Swingbench User Thread
select p.product_id, product_name, product_description, category_id, weight_cla
ss, supplier_id, product_status, list_price, min_price, catalog_url, quantity_
on_hand, warehouse_id from product_information p, inventories i where i.produ
ct_id = :1 and i.product_id = p.product_id

  1,021,987     176,186          5.8    0.2       42.7  65.9  15.2 gshgncvvtv0c6
Module: Swingbench User Thread
insert into logon values(:1 ,:2 )

    975,049      51,948         18.8    0.2    1,290.3   2.7  97.1 9zd49du11u7cf
Module: Swingbench User Thread
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) values (:1 ,
 :2 , :3 , :4 )

    705,177     176,182          4.0    0.1    3,625.7   1.4  98.8 82ud5h0qcg0bf
Module: Swingbench User Thread
select customer_id, cust_first_name ,cust_last_name ,nls_language ,nls_territory
 ,credit_limit ,cust_email ,account_mgr_id from customers where customer_id = :
1

    649,927      51,947         12.5    0.1       84.9  14.3    85 gfqas5ahy1x56
Module: Swingbench User Thread
SELECT o.order_id, line_item_id, product_id, unit_price, quantity, or
der_mode, order_status, order_total, sales_rep_id, promotion_id, c.cus
tomer_id, cust_first_name, cust_last_name, credit_limit, cust_email FRO
M orders o , order_items oi, customers c WHERE o.order_id = oi.order_i

    577,327     147,054          3.9    0.1    1,011.0   2.6  97.3 5g00dq4fxwnsw
Module: Swingbench User Thread
update inventories set quantity_on_hand = quantity_on_hand - :1 where product_i
d = :2 and warehouse_id = :3

    534,761      51,945         10.3    0.1      323.4     6  93.6 2yp5w5a36s5xv
Module: Swingbench User Thread
update orders set order_mode = :1 , order_status = :2 , order_total = :3 where
order_id = :4

          -------------------------------------------------------------

SQL ordered by Reads             DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> %Total - Physical Reads as a percentage of Total Disk Reads
-> %CPU   - CPU Time      as a percentage of Elapsed Time
-> %IO    - User I/O Time as a percentage of Elapsed Time
-> Total Disk Reads:         774,075
-> Captured SQL account for   91.0% of Total

   Physical              Reads              Elapsed
      Reads  Executions per Exec   %Total   Time (s)   %CPU    %IO    SQL Id
----------- ----------- ---------- ------ ---------- ------ ------ -------------
    271,995     176,182        1.5   35.1    3,625.7    1.4   98.8 82ud5h0qcg0bf
Module: Swingbench User Thread
select customer_id, cust_first_name ,cust_last_name ,nls_language ,nls_territory
 ,credit_limit ,cust_email ,account_mgr_id from customers where customer_id = :
1

    112,200     147,058        0.8   14.5    1,327.3    3.9   95.7 8vvvyuun2urt6
Module: Swingbench User Thread
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY
) values (:1 , :2 , :3 , :4 , :5 )

    100,191      51,948        1.9   12.9    1,290.3    2.7   97.1 9zd49du11u7cf
Module: Swingbench User Thread
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) values (:1 ,
 :2 , :3 , :4 )

     94,162      51,887        1.8   12.2    1,038.3    2.0   98.1 d5j6fbqmu3gjp
Module: Swingbench User Thread
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_price, quantity,
 order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_i
d, cust_first_name, cust_last_name, credit_limit, cust_email FROM orders o , o
rder_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id =

     82,827     147,054        0.6   10.7    1,011.0    2.6   97.3 5g00dq4fxwnsw
Module: Swingbench User Thread
update inventories set quantity_on_hand = quantity_on_hand - :1 where product_i
d = :2 and warehouse_id = :3

     25,831      51,945        0.5    3.3      323.4    6.0   93.6 2yp5w5a36s5xv
Module: Swingbench User Thread
update orders set order_mode = :1 , order_status = :2 , order_total = :3 where
order_id = :4

      6,602      51,947        0.1    0.9       84.9   14.3   85.0 gfqas5ahy1x56
Module: Swingbench User Thread
SELECT o.order_id, line_item_id, product_id, unit_price, quantity, or
der_mode, order_status, order_total, sales_rep_id, promotion_id, c.cus
tomer_id, cust_first_name, cust_last_name, credit_limit, cust_email FRO
M orders o , order_items oi, customers c WHERE o.order_id = oi.order_i

      6,537      10,442        0.6    0.8    2,314.7   92.6    5.1 g8rhybcumtwd6
Module: Swingbench User Thread
SELECT /*+ first_rows index(customers, customers_pk) index(orders, order_status
_ix) */ o.order_id, line_item_id, product_id, unit_price, quantity, order_mode,
 order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_firs
t_name, cust_last_name, credit_limit, cust_email, order_date FROM orders o , ord

      2,130      10,442        0.2    0.3       38.6   10.1   82.4 6k3uuf3g8pwh6
Module: Swingbench User Thread
update /*+ index(orders, order_pk) */ orders set order_status = :1 where order_
id = :2

        793           1      793.0    0.1        6.5   19.8   76.5 9zus1m3s2675b
Module: DBMS_SCHEDULER
DECLARE job BINARY_INTEGER := :job; next_date TIMESTAMP WITH TIME ZONE := :myda
te; broken BOOLEAN := FALSE; job_name VARCHAR2(30) := :job_name; job_subname
VARCHAR2(30) := :job_subname; job_owner VARCHAR2(30) := :job_owner; job_start
TIMESTAMP WITH TIME ZONE := :job_start; job_scheduled_start TIMESTAMP WITH TIME

          -------------------------------------------------------------

SQL ordered by Physical Reads (UnOptimized)DB/Inst: DBM11203/DBM11203  Snaps:
-> UnOptimized Read Reqs = Physical Read Reqts - Optimized Read Reqs
-> %Opt   - Optimized Reads as percentage of SQL Read Requests
-> %Total - UnOptimized Read Reqs as a percentage of Total UnOptimized Read Reqs
-> Total Physical Read Requests:         773,429
-> Captured SQL account for   91.0% of Total
-> Total UnOptimized Read Requests:         773,429
-> Captured SQL account for   91.0% of Total
-> Total Optimized Read Requests:               1
-> Captured SQL account for    0.0% of Total

UnOptimized   Physical              UnOptimized
  Read Reqs   Read Reqs Executions Reqs per Exe   %Opt %Total    SQL Id
----------- ----------- ---------- ------------ ------ ------ -------------
    271,994     271,994    176,182          1.5    0.0   35.2 82ud5h0qcg0bf
Module: Swingbench User Thread
select customer_id, cust_first_name ,cust_last_name ,nls_language ,nls_territory
 ,credit_limit ,cust_email ,account_mgr_id from customers where customer_id = :
1

    112,210     112,210    147,058          0.8    0.0   14.5 8vvvyuun2urt6
Module: Swingbench User Thread
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY
) values (:1 , :2 , :3 , :4 , :5 )

    100,193     100,193     51,948          1.9    0.0   13.0 9zd49du11u7cf
Module: Swingbench User Thread
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) values (:1 ,
 :2 , :3 , :4 )

     94,166      94,166     51,887          1.8    0.0   12.2 d5j6fbqmu3gjp
Module: Swingbench User Thread
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_price, quantity,
 order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_i
d, cust_first_name, cust_last_name, credit_limit, cust_email FROM orders o , o
rder_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id =

     82,831      82,831    147,054          0.6    0.0   10.7 5g00dq4fxwnsw
Module: Swingbench User Thread
update inventories set quantity_on_hand = quantity_on_hand - :1 where product_i
d = :2 and warehouse_id = :3

     25,832      25,832     51,945          0.5    0.0    3.3 2yp5w5a36s5xv
Module: Swingbench User Thread
update orders set order_mode = :1 , order_status = :2 , order_total = :3 where
order_id = :4

      6,602       6,602     51,947          0.1    0.0    0.9 gfqas5ahy1x56
Module: Swingbench User Thread
SELECT o.order_id, line_item_id, product_id, unit_price, quantity, or
der_mode, order_status, order_total, sales_rep_id, promotion_id, c.cus
tomer_id, cust_first_name, cust_last_name, credit_limit, cust_email FRO
M orders o , order_items oi, customers c WHERE o.order_id = oi.order_i

      6,546       6,546     10,442          0.6    0.0    0.8 g8rhybcumtwd6
Module: Swingbench User Thread
SELECT /*+ first_rows index(customers, customers_pk) index(orders, order_status
_ix) */ o.order_id, line_item_id, product_id, unit_price, quantity, order_mode,
 order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_firs
t_name, cust_last_name, credit_limit, cust_email, order_date FROM orders o , ord

      2,130       2,130     10,442          0.2    0.0    0.3 6k3uuf3g8pwh6
Module: Swingbench User Thread
update /*+ index(orders, order_pk) */ orders set order_status = :1 where order_
id = :2

      1,126       1,126          1      1,126.0    0.0    0.1 9zus1m3s2675b
Module: DBMS_SCHEDULER
DECLARE job BINARY_INTEGER := :job; next_date TIMESTAMP WITH TIME ZONE := :myda
te; broken BOOLEAN := FALSE; job_name VARCHAR2(30) := :job_name; job_subname
VARCHAR2(30) := :job_subname; job_owner VARCHAR2(30) := :job_owner; job_start
TIMESTAMP WITH TIME ZONE := :job_start; job_scheduled_start TIMESTAMP WITH TIME

          -------------------------------------------------------------

SQL ordered by Executions        DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> %CPU   - CPU Time      as a percentage of Elapsed Time
-> %IO    - User I/O Time as a percentage of Elapsed Time
-> Total Executions:       1,728,268
-> Captured SQL account for   99.0% of Total

                                              Elapsed
 Executions   Rows Processed  Rows per Exec   Time (s)  %CPU   %IO    SQL Id
------------ --------------- -------------- ---------- ----- ----- -------------
     311,130       1,565,811            5.0       84.6    87     0 gyk686gnaygs2
Module: Swingbench User Thread
select product_id, product_name, product_description, category_id, weight_class,
 supplier_id, product_status list_price, min_price, catalog_url from product_
information where category_id = :1

     176,186         176,180            1.0       42.7  65.9  15.2 gshgncvvtv0c6
Module: Swingbench User Thread
insert into logon values(:1 ,:2 )

     176,182         176,167            1.0    3,625.7   1.4  98.8 82ud5h0qcg0bf
Module: Swingbench User Thread
select customer_id, cust_first_name ,cust_last_name ,nls_language ,nls_territory
 ,credit_limit ,cust_email ,account_mgr_id from customers where customer_id = :
1

     155,252       1,552,490           10.0       20.7  90.3     0 7v0pya6f6qc6s
Module: Swingbench User Thread
select p.product_id, product_name, product_description, category_id, weight_cla
ss, supplier_id, product_status, list_price, min_price, catalog_url, quantity_o
n_hand, warehouse_id from product_information p, inventories i where categor
y_id = :1 and i.product_id = p.product_id

     147,059       1,470,490           10.0       18.4  91.9     1 dt8dtzvsq5kj5
Module: Swingbench User Thread
select p.product_id, product_name, product_description, category_id, weight_cla
ss, supplier_id, product_status, list_price, min_price, catalog_url, quantity_
on_hand, warehouse_id from product_information p, inventories i where i.produ
ct_id = :1 and i.product_id = p.product_id

     147,058         147,055            1.0    1,327.3   3.9  95.7 8vvvyuun2urt6
Module: Swingbench User Thread
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY
) values (:1 , :2 , :3 , :4 , :5 )

     147,057         147,059            1.0       12.2  92.2     0 982zxphp8ht6c
Module: Swingbench User Thread
select product_id, product_name, product_description, category_id, weight_class,
 supplier_id, product_status, list_price, min_price, catalog_url from product_i
nformation where product_id = :1

     147,054         132,584            0.9    1,011.0   2.6  97.3 5g00dq4fxwnsw
Module: Swingbench User Thread
update inventories set quantity_on_hand = quantity_on_hand - :1 where product_i
d = :2 and warehouse_id = :3

      51,948          51,947            1.0    1,290.3   2.7  97.1 9zd49du11u7cf
Module: Swingbench User Thread
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) values (:1 ,
 :2 , :3 , :4 )

      51,947          51,947            1.0        5.4  89.3     0 8uk8bquk453q8
Module: Swingbench User Thread
select orders_seq.nextval from dual

      51,947         147,038            2.8       84.9  14.3    85 gfqas5ahy1x56
Module: Swingbench User Thread
SELECT o.order_id, line_item_id, product_id, unit_price, quantity, or
der_mode, order_status, order_total, sales_rep_id, promotion_id, c.cus
tomer_id, cust_first_name, cust_last_name, credit_limit, cust_email FRO
SQL ordered by Executions        DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> %CPU   - CPU Time      as a percentage of Elapsed Time
-> %IO    - User I/O Time as a percentage of Elapsed Time
-> Total Executions:       1,728,268
-> Captured SQL account for   99.0% of Total

                                              Elapsed
 Executions   Rows Processed  Rows per Exec   Time (s)  %CPU   %IO    SQL Id
------------ --------------- -------------- ---------- ----- ----- -------------
M orders o , order_items oi, customers c WHERE o.order_id = oi.order_i

      51,945          51,945            1.0      323.4     6  93.6 2yp5w5a36s5xv
Module: Swingbench User Thread
update orders set order_mode = :1 , order_status = :2 , order_total = :3 where
order_id = :4

      51,887          49,896            1.0    1,038.3     2  98.1 d5j6fbqmu3gjp
Module: Swingbench User Thread
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_price, quantity,
 order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_i
d, cust_first_name, cust_last_name, credit_limit, cust_email FROM orders o , o
rder_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id =

      20,502          20,502            1.0        2.1  90.5     0 5d8b4p888x97a
Module: Swingbench User Thread
select customer_seq.nextval from dual

          -------------------------------------------------------------

SQL ordered by Parse Calls       DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Total Parse Calls:           1,437
-> Captured SQL account for   51.9% of Total

                            % Total
 Parse Calls  Executions     Parses    SQL Id
------------ ------------ --------- -------------
         151          151     10.51 b2gnxm5z6r51n
lock table sys.col_usage$ in exclusive mode nowait

         137          137      9.53 350f5yrnnmshs
lock table sys.mon_mods$ in exclusive mode nowait

          23           96      1.60 9tgj4g8y4rwy8
select type#,blocks,extents,minexts,maxexts,extsize,extpct,user#,iniexts,NVL(lis
ts,65535),NVL(groups,65535),cachehint,hwmincr, NVL(spare1,0),NVL(scanhint,0),NVL
(bitmapranges,0) from seg$ where ts#=:1 and file#=:2 and block#=:3

          19          111      1.32 bsa0wjtftg3uw
select file# from file$ where ts#=:1

          17           30      1.18 cm5vu20fhtnq1
select /*+ connect_by_filtering */ privilege#,level from sysauth$ connect by gra
ntee#=prior privilege# and privilege#>0 start with grantee#=:1 and privilege#>0

          15           15      1.04 0k8522rmdzg4k
select privilege# from sysauth$ where (grantee#=:1 or grantee#=1) and privilege#
>0

          15           15      1.04 0ws7ahf1d78qa
select SYS_CONTEXT('USERENV', 'SERVER_HOST'), SYS_CONTEXT('USERENV', 'DB_UNIQUE_
NAME'), SYS_CONTEXT('USERENV', 'INSTANCE_NAME'), SYS_CONTEXT('USERENV', 'SERVICE
_NAME'), INSTANCE_NUMBER, STARTUP_TIME, SYS_CONTEXT('USERENV', 'DB_DOMAIN') from
 v$instance where INSTANCE_NAME=SYS_CONTEXT('USERENV', 'INSTANCE_NAME')

          15       51,945      1.04 2yp5w5a36s5xv
Module: Swingbench User Thread
update orders set order_mode = :1 , order_status = :2 , order_total = :3 where
order_id = :4

          15           15      1.04 459f3z9u4fb3u
select value$ from props$ where name = 'GLOBAL_DB_NAME'

          15       20,502      1.04 5d8b4p888x97a
Module: Swingbench User Thread
select customer_seq.nextval from dual

          15      147,054      1.04 5g00dq4fxwnsw
Module: Swingbench User Thread
update inventories set quantity_on_hand = quantity_on_hand - :1 where product_i
d = :2 and warehouse_id = :3

          15           15      1.04 5ur69atw3vfhj
select decode(failover_method, NULL, 0 , 'BASIC', 1, 'PRECONNECT', 2 , 'PREPARSE
', 4 , 0), decode(failover_type, NULL, 1 , 'NONE', 1 , 'SESSION', 2, 'SELECT',
4, 1), failover_retries, failover_delay, flags from service$ where name = :1

          15       10,442      1.04 6k3uuf3g8pwh6
Module: Swingbench User Thread
update /*+ index(orders, order_pk) */ orders set order_status = :1 where order_
id = :2

          15      155,252      1.04 7v0pya6f6qc6s
Module: Swingbench User Thread
select p.product_id, product_name, product_description, category_id, weight_cla
ss, supplier_id, product_status, list_price, min_price, catalog_url, quantity_o
n_hand, warehouse_id from product_information p, inventories i where categor
SQL ordered by Parse Calls       DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Total Parse Calls:           1,437
-> Captured SQL account for   51.9% of Total

                            % Total
 Parse Calls  Executions     Parses    SQL Id
------------ ------------ --------- -------------
y_id = :1 and i.product_id = p.product_id

          15      176,182      1.04 82ud5h0qcg0bf
Module: Swingbench User Thread
select customer_id, cust_first_name ,cust_last_name ,nls_language ,nls_territory
 ,credit_limit ,cust_email ,account_mgr_id from customers where customer_id = :
1

          15       51,947      1.04 8uk8bquk453q8
Module: Swingbench User Thread
select orders_seq.nextval from dual

          15      147,058      1.04 8vvvyuun2urt6
Module: Swingbench User Thread
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY
) values (:1 , :2 , :3 , :4 , :5 )

          15      147,057      1.04 982zxphp8ht6c
Module: Swingbench User Thread
select product_id, product_name, product_description, category_id, weight_class,
 supplier_id, product_status, list_price, min_price, catalog_url from product_i
nformation where product_id = :1

          15       51,948      1.04 9zd49du11u7cf
Module: Swingbench User Thread
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) values (:1 ,
 :2 , :3 , :4 )

          15       51,887      1.04 d5j6fbqmu3gjp
Module: Swingbench User Thread
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_price, quantity,
 order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_i
d, cust_first_name, cust_last_name, credit_limit, cust_email FROM orders o , o
rder_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id =

          15      147,059      1.04 dt8dtzvsq5kj5
Module: Swingbench User Thread
select p.product_id, product_name, product_description, category_id, weight_cla
ss, supplier_id, product_status, list_price, min_price, catalog_url, quantity_
on_hand, warehouse_id from product_information p, inventories i where i.produ
ct_id = :1 and i.product_id = p.product_id

          15           15      1.04 g4rkmp4240p84
Module: Swingbench User Thread
BEGIN dbms_application_info.set_client_info('Swingbench Load Generator'); END;

          15       10,442      1.04 g8rhybcumtwd6
Module: Swingbench User Thread
SELECT /*+ first_rows index(customers, customers_pk) index(orders, order_status
_ix) */ o.order_id, line_item_id, product_id, unit_price, quantity, order_mode,
 order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_firs
t_name, cust_last_name, credit_limit, cust_email, order_date FROM orders o , ord

          15       51,947      1.04 gfqas5ahy1x56
Module: Swingbench User Thread
SELECT o.order_id, line_item_id, product_id, unit_price, quantity, or
der_mode, order_status, order_total, sales_rep_id, promotion_id, c.cus
tomer_id, cust_first_name, cust_last_name, credit_limit, cust_email FRO
M orders o , order_items oi, customers c WHERE o.order_id = oi.order_i

SQL ordered by Parse Calls       DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Total Parse Calls:           1,437
-> Captured SQL account for   51.9% of Total

                            % Total
 Parse Calls  Executions     Parses    SQL Id
------------ ------------ --------- -------------
          15      176,186      1.04 gshgncvvtv0c6
Module: Swingbench User Thread
insert into logon values(:1 ,:2 )

          15      311,130      1.04 gyk686gnaygs2
Module: Swingbench User Thread
select product_id, product_name, product_description, category_id, weight_class,
 supplier_id, product_status list_price, min_price, catalog_url from product_
information where category_id = :1

          -------------------------------------------------------------

SQL ordered by Sharable Memory   DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827

                  No data exists for this section of the report.
          -------------------------------------------------------------

SQL ordered by Version Count     DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827

                  No data exists for this section of the report.
          -------------------------------------------------------------

Instance Activity Stats          DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Ordered by statistic name

Statistic                                     Total     per Second     per Trans
-------------------------------- ------------------ -------------- -------------
Batched IO (bound) vector count                 433            0.5           0.0
Batched IO (full) vector count                    0            0.0           0.0
Batched IO block miss count                     768            0.9           0.0
Batched IO buffer defrag count                    3            0.0           0.0
Batched IO double miss count                    123            0.1           0.0
Batched IO same unit count                      263            0.3           0.0
Batched IO single block count                   494            0.6           0.0
Batched IO vector block count                   126            0.1           0.0
Batched IO vector read count                     62            0.1           0.0
Block Cleanout Optim referenced               6,675            7.4           0.0
CCursor + sql area evicted                       17            0.0           0.0
CPU used by this session                    274,380          303.9           1.1
CPU used when call started                  274,171          303.7           1.1
CR blocks created                            76,368           84.6           0.3
Cached Commit SCN referenced                 41,731           46.2           0.2
Commit SCN cached                             8,609            9.5           0.0
DB time                                   1,258,062        1,393.4           4.9
DBWR checkpoint buffers written              31,900           35.3           0.1
DBWR checkpoints                                 14            0.0           0.0
DBWR thread checkpoint buffers w             31,900           35.3           0.1
DBWR transaction table writes                   285            0.3           0.0
DBWR undo block writes                       24,068           26.7           0.1
HSC Heap Segment Block Changes              589,972          653.5           2.3
Heap Segment Array Inserts                      173            0.2           0.0
Heap Segment Array Updates                       21            0.0           0.0
IMU CR rollbacks                             18,373           20.4           0.1
IMU Flushes                                  29,871           33.1           0.1
IMU Redo allocation size                143,624,724      159,078.9         556.9
IMU commits                                 168,153          186.3           0.7
IMU contention                               26,336           29.2           0.1
IMU ktichg flush                                  0            0.0           0.0
IMU pool not allocated                       59,912           66.4           0.2
IMU recursive-transaction flush                   0            0.0           0.0
IMU undo allocation size                376,000,264      416,458.4       1,458.0
IMU- failed to get a private str             59,912           66.4           0.2
LOB table id lookup cache misses                  0            0.0           0.0
PX local messages recv'd                          0            0.0           0.0
PX local messages sent                            0            0.0           0.0
Requests to/from client                   1,988,093        2,202.0           7.7
RowCR - row contention                          276            0.3           0.0
RowCR attempts                              159,698          176.9           0.6
RowCR hits                                  156,900          173.8           0.6
SMON posted for undo segment shr                 26            0.0           0.0
SQL*Net roundtrips to/from clien          1,988,112        2,202.0           7.7
active txn count during cleanout             60,690           67.2           0.2
application wait time                           220            0.2           0.0
background checkpoints completed                 14            0.0           0.0
background checkpoints started                   14            0.0           0.0
background timeouts                           4,699            5.2           0.0
branch node splits                                4            0.0           0.0
buffer is not pinned count              285,236,508      315,928.3       1,106.1
buffer is pinned count                  287,542,236      318,482.1       1,115.0
bytes received via SQL*Net from         485,538,094      537,782.6       1,882.8
bytes sent via SQL*Net to client      1,076,635,526    1,192,482.9       4,174.8
calls to get snapshot scn: kcmgs          1,594,652        1,766.2           6.2
calls to kcmgas                             349,201          386.8           1.4
calls to kcmgcs                           1,018,866        1,128.5           4.0
cell physical IO interconnect by     11,859,735,552   13,135,857.9      45,987.9
change write time                             2,200            2.4           0.0
cleanout - number of ktugct call             46,800           51.8           0.2
Instance Activity Stats          DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Ordered by statistic name

Statistic                                     Total     per Second     per Trans
-------------------------------- ------------------ -------------- -------------
cleanouts and rollbacks - consis             33,596           37.2           0.1
cleanouts only - consistent read                987            1.1           0.0
cluster key scan block gets                   3,867            4.3           0.0
cluster key scans                             3,164            3.5           0.0
commit batch/immediate performed                 33            0.0           0.0
commit batch/immediate requested                 33            0.0           0.0
commit cleanout failures: block                  10            0.0           0.0
commit cleanout failures: buffer                 39            0.0           0.0
commit cleanout failures: callba                227            0.3           0.0
commit cleanout failures: cannot              7,538            8.4           0.0
commit cleanouts                          1,058,902        1,172.8           4.1
commit cleanouts successfully co          1,051,088        1,164.2           4.1
commit immediate performed                       33            0.0           0.0
commit immediate requested                       33            0.0           0.0
commit txn count during cleanout             72,206           80.0           0.3
concurrency wait time                         1,154            1.3           0.0
consistent changes                          173,518          192.2           0.7
consistent gets                         581,211,846      643,751.0       2,253.7
consistent gets - examination           379,363,286      420,183.3       1,471.0
consistent gets direct                           12            0.0           0.0
consistent gets from cache              581,211,847      643,751.0       2,253.7
consistent gets from cache (fast        201,512,179      223,195.1         781.4
cursor authentications                           47            0.1           0.0
data blocks consistent reads - u            160,463          177.7           0.6
db block changes                          3,564,963        3,948.6          13.8
db block gets                             4,822,132        5,341.0          18.7
db block gets direct                             60            0.1           0.0
db block gets from cache                  4,822,072        5,340.9          18.7
db block gets from cache (fastpa          1,653,627        1,831.6           6.4
deferred (CURRENT) block cleanou            371,815          411.8           1.4
dirty buffers inspected                     363,770          402.9           1.4
enqueue conversions                             563            0.6           0.0
enqueue releases                            619,926          686.6           2.4
enqueue requests                            619,934          686.6           2.4
enqueue timeouts                                  0            0.0           0.0
enqueue waits                                 1,266            1.4           0.0
execute count                             1,728,268        1,914.2           6.7
file io service time                              0            0.0           0.0
file io wait time                    15,397,986,732   17,054,829.3      59,708.0
free buffer inspected                       865,517          958.7           3.4
free buffer requested                       878,713          973.3           3.4
heap block compress                             865            1.0           0.0
hot buffers moved to head of LRU            478,074          529.5           1.9
immediate (CR) block cleanout ap             34,583           38.3           0.1
immediate (CURRENT) block cleano             40,597           45.0           0.2
in call idle wait time                    2,555,428        2,830.4           9.9
index crx upgrade (positioned)                   24            0.0           0.0
index fast full scans (full)                      2            0.0           0.0
index fetch by key                       94,692,078      104,881.1         367.2
index scans kdiixs1                      94,436,438      104,597.9         366.2
leaf node 90-10 splits                           18            0.0           0.0
leaf node splits                              1,958            2.2           0.0
lob reads                                         0            0.0           0.0
lob writes                                      110            0.1           0.0
lob writes unaligned                            110            0.1           0.0
logical read bytes from cache     4,800,790,085,632 5.31736108E+09  18,615,794.8
logons cumulative                                27            0.0           0.0
max cf enq hold time                             30            0.0           0.0
messages received                           288,184          319.2           1.1
messages sent                               288,184          319.2           1.1
Instance Activity Stats          DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Ordered by statistic name

Statistic                                     Total     per Second     per Trans
-------------------------------- ------------------ -------------- -------------
min active SCN optimization appl            225,820          250.1           0.9
no buffer to keep pinned count                    3            0.0           0.0
no work - consistent read gets          200,598,432      222,183.1         777.9
non-idle wait count                       3,587,074        3,973.1          13.9
non-idle wait time                          986,124        1,092.2           3.8
opened cursors cumulative                 1,727,506        1,913.4           6.7
parse count (describe)                            7            0.0           0.0
parse count (failures)                            0            0.0           0.0
parse count (hard)                              332            0.4           0.0
parse count (total)                           1,437            1.6           0.0
parse time cpu                                3,139            3.5           0.0
parse time elapsed                            4,361            4.8           0.0
physical read IO requests                   773,429          856.7           3.0
physical read bytes                   6,341,222,400    7,023,545.8      24,589.1
physical read total IO requests             776,320          859.9           3.0
physical read total bytes             6,387,666,944    7,074,987.9      24,769.2
physical read total multi block                   2            0.0           0.0
physical reads                              774,075          857.4           3.0
physical reads cache                        773,993          857.3           3.0
physical reads cache prefetch                   676            0.8           0.0
physical reads direct                            82            0.1           0.0
physical reads direct temporary                   0            0.0           0.0
physical reads prefetch warmup                    0            0.0           0.0
physical write IO requests                  383,680          425.0           1.5
physical write bytes                  4,275,765,248    4,735,842.9      16,579.9
physical write total IO requests            876,098          970.4           3.4
physical write total bytes            5,472,060,416    6,060,860.9      21,218.8
physical write total multi block                362            0.4           0.0
physical writes                             521,944          578.1           2.0
physical writes direct                          130            0.1           0.0
physical writes direct (lob)                     13            0.0           0.0
physical writes direct temporary                  0            0.0           0.0
physical writes from cache                  521,814          578.0           2.0
physical writes non checkpoint              426,917          472.9           1.7
pinned buffers inspected                         95            0.1           0.0
pinned cursors current                            5            0.0           0.0
prefetch warmup blocks aged out                   0            0.0           0.0
prefetched blocks aged out befor                  2            0.0           0.0
process last non-idle time                      520            0.6           0.0
recovery blocks read                              0            0.0           0.0
recursive calls                             289,598          320.8           1.1
recursive cpu usage                           2,360            2.6           0.0
redo KB read                                      0            0.0           0.0
redo blocks checksummed by FG (e            296,116          328.0           1.2
redo blocks read for recovery                     0            0.0           0.0
redo blocks written                       1,147,045        1,270.5           4.5
redo buffer allocation retries                  443            0.5           0.0
redo entries                              1,192,536        1,320.9           4.6
redo k-bytes read for recovery                    0            0.0           0.0
redo log space requests                         471            0.5           0.0
redo log space wait time                      1,869            2.1           0.0
redo ordering marks                          11,159           12.4           0.0
redo size                               498,530,952      552,173.5       1,933.1
redo size for direct writes                     780            0.9           0.0
redo subscn max counts                       28,537           31.6           0.1
redo synch long waits                           847            0.9           0.0
redo synch time                              26,962           29.9           0.1
redo synch time (usec)                  269,626,508      298,638.7       1,045.5
redo synch writes                           257,926          285.7           1.0
redo wastage                             70,121,084       77,666.2         271.9
Instance Activity Stats          DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Ordered by statistic name

Statistic                                     Total     per Second     per Trans
-------------------------------- ------------------ -------------- -------------
redo write time                              12,621           14.0           0.1
redo writes                                 242,728          268.9           0.9
rollback changes - undo records                 125            0.1           0.0
rollbacks only - consistent read             41,584           46.1           0.2
rows fetched via callback                94,478,496      104,644.5         366.4
session connect time                              0            0.0           0.0
session cursor cache hits                    90,015           99.7           0.4
session logical reads                   586,033,175      649,091.1       2,272.4
shared hash latch upgrades - no             428,124          474.2           1.7
shared hash latch upgrades - wai                 54            0.1           0.0
sorts (memory)                                2,106            2.3           0.0
sorts (rows)                                 27,417           30.4           0.1
sql area evicted                                310            0.3           0.0
sql area purged                                   0            0.0           0.0
summed dirty queue length                 3,184,848        3,527.5          12.4
switch current to new buffer                    712            0.8           0.0
table fetch by rowid                    191,823,399      212,463.8         743.8
table fetch continued row                       165            0.2           0.0
table scan blocks gotten                  8,684,649        9,619.1          33.7
table scan rows gotten                  310,139,845      343,511.3       1,202.6
table scans (long tables)                         0            0.0           0.0
table scans (short tables)                  309,789          343.1           1.2
temp space allocated (bytes)                      0            0.0           0.0
total cf enq hold time                        4,930            5.5           0.0
total number of cf enq holders                   90            0.1           0.0
total number of times SMON poste                 41            0.1           0.0
transaction rollbacks                            32            0.0           0.0
undo change vector size                 164,305,732      181,985.2         637.1
user I/O wait time                          941,289        1,042.6           3.7
user calls                                3,657,716        4,051.3          14.2
user commits                                257,888          285.6           1.0
workarea executions - optimal                 1,032            1.1           0.0
write clones created in foregrou                670            0.7           0.0
          -------------------------------------------------------------

Instance Activity Stats - Absolute ValuesDB/Inst: DBM11203/DBM11203  Snaps: 1
-> Statistics with absolute values (should not be diffed)

Statistic                            Begin Value       End Value
-------------------------------- --------------- ---------------
logons current                                59              74
session uga memory max               389,241,744     438,292,728
session pga memory                   189,926,704     226,155,536
session pga memory max               346,674,448     406,137,136
session cursor cache count                 3,445           4,082
session uga memory                47,278,308,064  51,580,682,632
opened cursors current                       101             132
          -------------------------------------------------------------

Instance Activity Stats - Thread ActivityDB/Inst: DBM11203/DBM11203  Snaps: 18
-> Statistics identified by '(derived)' come from sources other than SYSSTAT

Statistic                                     Total  per Hour
-------------------------------- ------------------ ---------
log switches (derived)                           14     55.82
          -------------------------------------------------------------

IOStat by Function summary        DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> 'Data' columns suffixed with M,G,T,P are in multiples of 1024
    other columns suffixed with K,M,G,T,P are in multiples of 1000
-> ordered by (Data Read + Write) desc

                Reads:   Reqs   Data    Writes:  Reqs   Data    Waits:    Avg
Function Name   Data    per sec per sec Data    per sec per sec Count    Tm(ms)
--------------- ------- ------- ------- ------- ------- ------- ------- -------
Buffer Cache Re    5.9G   858.2 6.70984      0M     0.0      0M  774.8K    11.7
DBWR                 0M     0.0      0M      4G   425.9 4.52565       0     N/A
LGWR                 6M     0.5 .006645    1.1G   545.4 1.24715  243.9K     0.3
Others              38M     2.8 .042088     16M     1.1 .017721    3004     4.2
Direct Writes        0M     0.0      0M      1M     0.0 .001107       0     N/A
Streams AQ           1M     0.0 .001107      0M     0.0      0M       8    17.1
Direct Reads         0M     0.1      0M      0M     0.0      0M       0     N/A
TOTAL:               6G   861.5 6.75969    5.1G   972.5 5.79164 1021.6K     8.9
          -------------------------------------------------------------

IOStat by Filetype summary        DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> 'Data' columns suffixed with M,G,T,P are in multiples of 1024
    other columns suffixed with K,M,G,T,P are in multiples of 1000
-> Small Read and Large Read are average service times, in milliseconds
-> Ordered by (Data Read + Write) desc

                Reads:   Reqs   Data    Writes:  Reqs   Data      Small   Large
Filetype Name   Data    per sec per sec Data    per sec per sec    Read    Read
--------------- ------- ------- ------- ------- ------- ------- ------- -------
Data File          5.9G   858.3 6.70984      4G   425.8 4.52344    11.7    10.5
Log File             0M     0.1      0M    1.1G   545.1 1.24272     9.8     N/A
Control File        44M     3.1 .048734     21M     1.5 .023259     4.9     N/A
Temp File            0M     0.0      0M      0M     0.0      0M    12.0     N/A
TOTAL:               6G   861.5 6.75858    5.1G   972.3 5.78943    11.6    10.5
          -------------------------------------------------------------

IOStat by Function/Filetype summaryDB/Inst: DBM11203/DBM11203  Snaps: 1826-182
-> 'Data' columns suffixed with M,G,T,P are in multiples of 1024
    other columns suffixed with K,M,G,T,P are in multiples of 1000
-> Ordered by (Data Read + Write) desc for each function

 Reads:   Reqs   Data    Writes:  Reqs   Data    Waits:    Avg
 Data    per sec per sec Data    per sec per sec Count    Tm(ms)
 ------- ------- ------- ------- ------- ------- ------- -------
Buffer Cache Reads
    5.9G   858.7 6.71427      0M     0.0      0M  775.2K    11.7
 Buffer Cache Reads (Data File)
    5.9G   858.7 6.71427      0M     0.0      0M  775.2K    11.7
DBWR
      0M     0.0      0M      4G   426.2 4.52898       0     N/A
 DBWR (Data File)
      0M     0.0      0M      4G   426.2 4.52898       0     N/A
LGWR
      6M     0.5 .006645    1.1G   545.7 1.24715     469     4.2
 LGWR (Log File)
      0M     0.1      0M    1.1G   545.3 1.24272     112     4.9
 LGWR (Control File)
      6M     0.4 .006645      4M     0.3 .004430     357     4.0
Others
     39M     2.8 .043196     16M     1.1 .017721    2495     5.0
 Others (Control File)
     39M     2.7 .043196     16M     1.1 .017721    2478     5.0
 Others (Data File)
      0M     0.0      0M      0M     0.0      0M      17     6.1
Direct Writes
      0M     0.0      0M      1M     0.0 .001107       0     N/A
 Direct Writes (Data File)
      0M     0.0      0M      1M     0.0 .001107       0     N/A
Streams AQ
      1M     0.0 .001107      0M     0.0      0M       8    17.1
 Streams AQ (Data File)
      1M     0.0 .001107      0M     0.0      0M       8    17.1
Direct Reads
      0M     0.1      0M      0M     0.0      0M       0     N/A
 Direct Reads (Data File)
      0M     0.1      0M      0M     0.0      0M       0     N/A
TOTAL:
      6G   862.0 6.76522    5.1G   973.1 5.79496  778.2K    11.6
          -------------------------------------------------------------

Tablespace IO Stats              DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> ordered by IOs (Reads + Writes) desc

Tablespace
------------------------------
                 Av       Av     Av                       Av     Buffer  Av Buf
         Reads Reads/s  Rd(ms) Blks/Rd       Writes Writes/s      Waits  Wt(ms)
-------------- ------- ------- ------- ------------ -------- ---------- -------
SOE
       769,580     852    12.1     1.0      379,976      421      5,012    10.3
UNDOTBS1
            89       0    10.7     1.0        2,817        3        113     0.3
SYSAUX
         1,333       1     6.9     1.2          609        1          0     0.0
SYSTEM
         1,214       1     9.3     1.3           32        0         63     2.4
USERS
            14       0     0.0     1.0           14        0          0     0.0
TEMP
             2       0    15.0     1.0            4        0          0     0.0
          -------------------------------------------------------------

File IO Stats                    DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> ordered by Tablespace, File

Tablespace               Filename
------------------------ ----------------------------------------------------
                 Av       Av     Av                       Av     Buffer  Av Buf
         Reads Reads/s  Rd(ms) Blks/Rd       Writes Writes/s      Waits  Wt(ms)
-------------- ------- ------- ------- ------------ -------- ---------- -------
SOE                      +DATA/dbm11203/datafile/soe.486.836957131
       769,580     852    12.1     1.0      379,976      421      5,012    10.3
SYSAUX                   +DATA/dbm11203/datafile/sysaux.460.772715927
         1,333       1     6.9     1.2          609        1          0     0.0
SYSTEM                   +DATA/dbm11203/datafile/system.459.772715923
         1,214       1     9.3     1.3           32        0         63     2.4
TEMP                     +DATA/dbm11203/tempfile/temp.462.772715931
             2       0    15.0     1.0            4        0          0     N/A
UNDOTBS1                 +DATA/dbm11203/datafile/undotbs1.461.772715929
            89       0    10.7     1.0        2,817        3        113     0.3
USERS                    +DATA/dbm11203/datafile/users.463.772715939
            14       0     0.0     1.0           14        0          0     0.0
          -------------------------------------------------------------

Buffer Pool Statistics           DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Standard block size Pools  D: default,  K: keep,  R: recycle
-> Default Pools for other block sizes: 2k, 4k, 8k, 16k, 32k

                                                            Free   Writ   Buffer
     Number of Pool       Buffer     Physical    Physical   Buff   Comp     Busy
P      Buffers Hit%         Gets        Reads      Writes   Wait   Wait    Waits
--- ---------- ---- ------------ ------------ ----------- ------ ------ --------
D       89,362  100  582,128,444      773,555     521,818      0      0    5,181
          -------------------------------------------------------------

Checkpoint Activity               DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Total Physical Writes:                      521,944

                                          Other    Autotune      Thread
       MTTR    Log Size    Log Ckpt    Settings        Ckpt        Ckpt
     Writes      Writes      Writes      Writes      Writes      Writes
----------- ----------- ----------- ----------- ----------- -----------
          0      28,544           0           0           0       3,356
          -------------------------------------------------------------

Instance Recovery Stats           DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> B: Begin Snapshot,  E: End Snapshot

                                                                            Estd
  Targt  Estd                                     Log Ckpt Log Ckpt    Opt   RAC
  MTTR   MTTR Recovery  Actual   Target   Log Sz   Timeout Interval    Log Avail
   (s)    (s) Estd IOs RedoBlks RedoBlks RedoBlks RedoBlks RedoBlks  Sz(M)  Time
- ----- ----- -------- -------- -------- -------- -------- -------- ------ -----
B     0    18    16165   167866   165888   165888   417367      N/A    N/A   N/A
E     0    18    16018   169373   165888   165888   413717      N/A    N/A   N/A
          -------------------------------------------------------------

MTTR Advisory                           DB/Inst: DBM11203/DBM11203  Snap: 1827

                  No data exists for this section of the report.
          -------------------------------------------------------------

Buffer Pool Advisory                    DB/Inst: DBM11203/DBM11203  Snap: 1827
-> Only rows with estimated physical reads >0 are displayed
-> ordered by Block Size, Buffers For Estimate

                                    Est
                                   Phys      Estimated                  Est
    Size for   Size      Buffers   Read     Phys Reads     Est Phys %DBtime
P    Est (M) Factor  (thousands) Factor    (thousands)    Read Time for Rds
--- -------- ------ ------------ ------ -------------- ------------ -------
D         72     .1            9  364.2      2,505,397            1 2.4E+07
D        144     .2           18  276.1      1,898,816            1 1.8E+07
D        216     .3           27  153.0      1,052,319            1 1.0E+07
D        288     .4           35    9.9         68,368            1 6.5E+05
D        360     .5           44    1.4          9,753            1 9.2E+04
D        432     .6           53    1.3          8,678            1 8.2E+04
D        504     .7           62    1.2          8,011            1 7.5E+04
D        576     .8           71    1.1          7,550            1 7.1E+04
D        648     .9           80    1.0          7,186            1 6.8E+04
D        720    1.0           88    1.0          6,906            1 6.5E+04
D        728    1.0           89    1.0          6,878            1 6.5E+04
D        792    1.1           97    1.0          6,672            1 6.3E+04
D        864    1.2          106    0.9          6,474            1 6.1E+04
D        936    1.3          115    0.9          6,297            1 5.9E+04
D      1,008    1.4          124    0.9          6,133            1 5.8E+04
D      1,080    1.5          133    0.9          5,980            1 5.6E+04
D      1,152    1.6          141    0.9          5,848            1 5.5E+04
D      1,224    1.7          150    0.8          5,729            1 5.4E+04
D      1,296    1.8          159    0.8          5,559            1 5.2E+04
D      1,368    1.9          168    0.7          4,879            1 4.6E+04
D      1,440    2.0          177    0.6          4,241            1 4.0E+04
          -------------------------------------------------------------

PGA Aggr Summary                 DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> PGA cache hit % - percentage of W/A (WorkArea) data processed only in-memory

PGA Cache Hit %   W/A MB Processed  Extra W/A MB Read/Written
--------------- ------------------ --------------------------
          100.0                 73                          0
          -------------------------------------------------------------



Warning:  pga_aggregate_target was set too low for current workload, as this
          value was exceeded during this interval.  Use the PGA Advisory view
          to help identify a different value for pga_aggregate_target.
PGA Aggr Target Stats             DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> B: Begin Snap   E: End Snap (rows dentified with B or E contain data
   which is absolute i.e. not diffed over the interval)
-> Auto PGA Target - actual workarea memory target
-> W/A PGA Used    - amount of memory used for all Workareas (manual + auto)
-> %PGA W/A Mem    - percentage of PGA memory allocated to workareas
-> %Auto W/A Mem   - percentage of workarea memory controlled by Auto Mem Mgmt
-> %Man W/A Mem    - percentage of workarea memory under manual control

                                                %PGA  %Auto   %Man
    PGA Aggr   Auto PGA   PGA Mem    W/A PGA     W/A    W/A    W/A Global Mem
   Target(M)  Target(M)  Alloc(M)    Used(M)     Mem    Mem    Mem   Bound(K)
- ---------- ---------- ---------- ---------- ------ ------ ------ ----------
B        128          8      184.9        0.0     .0     .0     .0     26,214
E        128          8      217.0        0.0     .0     .0     .0     26,214
          -------------------------------------------------------------

PGA Aggr Target Histogram         DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Optimal Executions are purely in-memory operations

  Low     High
Optimal Optimal    Total Execs  Optimal Execs 1-Pass Execs M-Pass Execs
------- ------- -------------- -------------- ------------ ------------
     2K      4K            947            947            0            0
    64K    128K              9              9            0            0
   128K    256K              3              3            0            0
   512K   1024K             55             55            0            0
     1M      2M              6              6            0            0
     4M      8M              4              4            0            0
          -------------------------------------------------------------

PGA Memory Advisory                     DB/Inst: DBM11203/DBM11203  Snap: 1827
-> When using Auto Memory Mgmt, minimally choose a pga_aggregate_target value
   where Estd PGA Overalloc Count is 0

                                       Estd Extra    Estd P Estd PGA
PGA Target    Size           W/A MB   W/A MB Read/    Cache Overallo    Estd
  Est (MB)   Factr        Processed Written to Disk   Hit %    Count    Time
---------- ------- ---------------- ---------------- ------ -------- -------
        16     0.1          1,680.1             31.7   98.0       11 2.8E+06
        32     0.3          1,680.1             31.7   98.0       11 2.8E+06
        64     0.5          1,680.1             31.7   98.0       11 2.8E+06
        96     0.8          1,680.1             31.7   98.0       11 2.8E+06
       128     1.0          1,680.1              0.0  100.0       11 2.8E+06
       154     1.2          1,680.1              0.0  100.0        1 2.8E+06
       179     1.4          1,680.1              0.0  100.0        0 2.8E+06
       205     1.6          1,680.1              0.0  100.0        0 2.8E+06
       230     1.8          1,680.1              0.0  100.0        0 2.8E+06
       256     2.0          1,680.1              0.0  100.0        0 2.8E+06
       384     3.0          1,680.1              0.0  100.0        0 2.8E+06
       512     4.0          1,680.1              0.0  100.0        0 2.8E+06
       768     6.0          1,680.1              0.0  100.0        0 2.8E+06
     1,024     8.0          1,680.1              0.0  100.0        0 2.8E+06
          -------------------------------------------------------------

Shared Pool Advisory                   DB/Inst: DBM11203/DBM11203  Snap: 1827
-> SP: Shared Pool     Est LC: Estimated Library Cache   Factr: Factor
-> Note there is often a 1:Many correlation between a single logical object
   in the Library Cache, and the physical number of memory objects associated
   with it.  Therefore comparing the number of Lib Cache objects (e.g. in
   v$librarycache), with the number of Lib Cache Memory Objects is invalid.

                                       Est LC Est LC  Est LC Est LC
  Shared    SP   Est LC                  Time   Time    Load   Load       Est LC
    Pool  Size     Size       Est LC    Saved  Saved    Time   Time      Mem Obj
 Size(M) Factr      (M)      Mem Obj      (s)  Factr     (s)  Factr     Hits (K)
-------- ----- -------- ------------ -------- ------ ------- ------ ------------
     232    .9       22        1,535   15,516    1.0     845    2.1        5,793
     236    .9       25        1,690   15,588    1.0     773    1.9        5,795
     240    .9       28        1,864   15,693    1.0     668    1.7        5,797
     244    .9       31        1,997   15,733    1.0     628    1.6        5,797
     248   1.0       35        2,156   15,783    1.0     578    1.5        5,798
     252   1.0       39        2,270   15,833    1.0     528    1.3        5,799
     256   1.0       42        2,301   15,897    1.0     464    1.2        5,800
     260   1.0       45        2,501   15,964    1.0     397    1.0        5,804
     264   1.0       49        2,660   15,967    1.0     394    1.0        5,804
     268   1.0       53        2,851   15,967    1.0     394    1.0        5,804
     272   1.0       56        2,959   15,969    1.0     392    1.0        5,804
     276   1.1       60        3,188   15,969    1.0     392    1.0        5,804
     280   1.1       64        3,394   15,970    1.0     391    1.0        5,804
     284   1.1       68        3,600   15,970    1.0     391    1.0        5,804
     288   1.1       72        3,806   15,970    1.0     391    1.0        5,804
     292   1.1       76        4,012   15,970    1.0     391    1.0        5,804
     296   1.1       80        4,271   15,970    1.0     391    1.0        5,804
     316   1.2       99        5,445   15,970    1.0     391    1.0        5,804
     344   1.3      126        6,320   15,971    1.0     390    1.0        5,805
     372   1.4      126        6,329   15,971    1.0     390    1.0        5,805
     400   1.5      126        6,329   15,971    1.0     390    1.0        5,805
     428   1.6      126        6,329   15,971    1.0     390    1.0        5,805
     456   1.8      126        6,329   15,971    1.0     390    1.0        5,805
     484   1.9      126        6,329   15,971    1.0     390    1.0        5,805
     512   2.0      126        6,329   15,971    1.0     390    1.0        5,805
     540   2.1      126        6,329   15,971    1.0     390    1.0        5,805
          -------------------------------------------------------------

SGA Target Advisory                     DB/Inst: DBM11203/DBM11203  Snap: 1827

SGA Target   SGA Size       Est DB     Est Physical
  Size (M)     Factor     Time (s)            Reads
---------- ---------- ------------ ----------------
       512        0.5   10,148,365    1,079,936,247
       768        0.8      101,251        8,232,006
     1,024        1.0       88,590        6,856,577
     1,280        1.3       83,170        6,303,251
     1,536        1.5       77,634        5,712,900
     1,792        1.8       64,931        4,358,040
     2,048        2.0       64,931        4,358,040
          -------------------------------------------------------------

Streams Pool Advisory                   DB/Inst: DBM11203/DBM11203  Snap: 1827

  Size for      Size   Est Spill   Est Spill Est Unspill Est Unspill
  Est (MB)    Factor       Count    Time (s)       Count    Time (s)
---------- --------- ----------- ----------- ----------- -----------
         4       0.5           0           0           0           0
         8       1.0           0           0           0           0
        12       1.5           0           0           0           0
        16       2.0           0           0           0           0
        20       2.5           0           0           0           0
        24       3.0           0           0           0           0
        28       3.5           0           0           0           0
        32       4.0           0           0           0           0
        36       4.5           0           0           0           0
        40       5.0           0           0           0           0
        44       5.5           0           0           0           0
        48       6.0           0           0           0           0
        52       6.5           0           0           0           0
        56       7.0           0           0           0           0
        60       7.5           0           0           0           0
        64       8.0           0           0           0           0
        68       8.5           0           0           0           0
        72       9.0           0           0           0           0
        76       9.5           0           0           0           0
        80      10.0           0           0           0           0
          -------------------------------------------------------------

Java Pool Advisory                      DB/Inst: DBM11203/DBM11203  Snap: 1827

                  No data exists for this section of the report.
          -------------------------------------------------------------

Buffer Wait Statistics            DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> ordered by wait time desc, waits desc

Class                    Waits Total Wait Time (s)  Avg Time (ms)
------------------ ----------- ------------------- --------------
data block               5,028                  52             10
segment header              22                   0              4
3rd level bmb               11                   0              4
2nd level bmb                9                   0              3
undo header                 44                   0              0
undo block                  69                   0              0
1st level bmb                2                   0              0
          -------------------------------------------------------------

Enqueue Activity                 DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> only enqueues with waits are shown
-> Enqueue stats gathered prior to 10g should not be compared with 10g data
-> ordered by Wait Time desc, Waits desc

Enqueue Type (Request Reason)
------------------------------------------------------------------------------
    Requests    Succ Gets Failed Gets       Waits  Wt Time (s) Av Wt Time(ms)
------------ ------------ ----------- ----------- ------------ --------------
TX-Transaction (row lock contention)
       1,236        1,236           0       1,230            2           1.80
TX-Transaction (index contention)
         415          415           0          32            0          15.00
HW-Segment High Water Mark
         346          346           0           4            0          27.50
TX-Transaction
     260,161      260,162           0           1            0          70.00
CU-Cursor
         349          349           0           1            0          10.00
          -------------------------------------------------------------

Undo Segment Summary             DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Min/Max TR (mins) - Min and Max Tuned Retention (minutes)
-> STO - Snapshot Too Old count,  OOS - Out of Space count
-> Undo segment block stats:
-> uS - unexpired Stolen,   uR - unexpired Released,   uU - unexpired reUsed
-> eS - expired   Stolen,   eR - expired   Released,   eU - expired   reUsed

Undo   Num Undo       Number of  Max Qry   Max Tx Min/Max   STO/     uS/uR/uU/
 TS# Blocks (K)    Transactions  Len (s) Concurcy TR (mins) OOS      eS/eR/eU
---- ---------- --------------- -------- -------- --------- ----- --------------
   2       26.6         313,610      938       31 19.6/29.6 0/0   0/0/0/0/0/0
          -------------------------------------------------------------

Undo Segment Stats                DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Most recent 35 Undostat rows, ordered by Time desc

                Num Undo    Number of Max Qry  Max Tx Tun Ret STO/    uS/uR/uU/
End Time          Blocks Transactions Len (s)   Concy  (mins) OOS     eS/eR/eU
------------ ----------- ------------ ------- ------- ------- ----- ------------
23-Apr 19:43      14,853      175,772     336      31      20 0/0   0/0/0/0/0/0
23-Apr 19:33      11,722      137,838     938      27      30 0/0   0/0/0/0/0/0
          -------------------------------------------------------------

Latch Activity                   DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> "Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
   willing-to-wait latch get requests
-> "NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
-> "Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                                    Get    Get   Slps   Time       NoWait NoWait
Latch Name                     Requests   Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
AQ deq hash table latch               2    0.0             0            0    N/A
ASM Keyed state latch                37    0.0             0            0    N/A
ASM allocation                      172    0.0             0            0    N/A
ASM db client latch                 698    0.0             0            0    N/A
ASM map operation freeli             70    1.4    0.0      0            0    N/A
ASM map operation hash t      3,306,049    0.0    0.1      0            0    N/A
ASM network background l            453    0.0             0            0    N/A
ASM network state latch             293    0.0             0            0    N/A
AWR Alerted Metric Eleme          6,989    0.0             0            0    N/A
Change Notification Hash            302    0.0             0            0    N/A
Consistent RBA                  242,581    0.0    0.7      0            0    N/A
DML lock allocation             698,726    0.0    0.1      0            0    N/A
Event Group Locks                    55    0.0             0            0    N/A
FOB s.o list latch                  270    0.0             0            0    N/A
File State Object Pool P              2    0.0             0            0    N/A
I/O Staticstics latch                 2    0.0             0            0    N/A
IPC stats buffer allocat              2    0.0             0            0    N/A
In memory undo latch          1,391,681    0.0    0.7      0      257,954    0.0
JS Sh mem access                      4    0.0             0            0    N/A
JS mem alloc latch                    2    0.0             0            0    N/A
JS queue access latch                 4    0.0             0            0    N/A
JS queue state obj latch          5,502    0.0             0            0    N/A
JS slv state obj latch                6    0.0             0            0    N/A
KFC FX Hash Latch                     2    0.0             0            0    N/A
KFC Hash Latch                        2    0.0             0            0    N/A
KFCL LE Freelist                      2    0.0             0            0    N/A
KFK SGA Libload latch               217    0.0             0            0    N/A
KFMD SGA                              1    0.0             0            0    N/A
KGNFS-NFS:SHM structure               2    0.0             0            0    N/A
KGNFS-NFS:SVR LIST                    2    0.0             0            0    N/A
KJC message pool free li              2    0.0             0            0    N/A
KJCT flow control latch               2    0.0             0            0    N/A
KMG MMAN ready and start            302    0.0             0            0    N/A
KTF sga latch                         5    0.0             0          303    0.0
KWQMN job cache list lat              1    0.0             0            0    N/A
KWQP Prop Status                    117    0.0             0            0    N/A
KWQS pqueue ctx latch                 2    0.0             0            0    N/A
Locator state objects po              2    0.0             0            0    N/A
Lsod array latch                    266    0.0             0            0    N/A
MQL Tracking Latch                    0    N/A             0           18    0.0
Memory Management Latch               2    0.0             0          302    0.0
Memory Queue                        120    0.0             0            0    N/A
Memory Queue Message Sub              2    0.0             0            0    N/A
Memory Queue Message Sub              2    0.0             0            0    N/A
Memory Queue Message Sub              2    0.0             0            0    N/A
Memory Queue Message Sub              2    0.0             0            0    N/A
Memory Queue Subscriber               2    0.0             0            0    N/A
MinActiveScn Latch                   10    0.0             0            0    N/A
Mutex                                 2    0.0             0            0    N/A
Mutex Stats                           2    0.0             0            0    N/A
OS process                          116    0.0             0            0    N/A
OS process allocation             1,881    0.0             0            0    N/A
OS process: request allo             37    0.0             0            0    N/A
PL/SQL warning settings              81    0.0             0            0    N/A
PX hash array latch                   2    0.0             0            0    N/A
QMT                                   2    0.0             0            0    N/A
Real-time plan statistic            496    0.0             0            0    N/A
SGA IO buffer pool latch             13    0.0             0           13    0.0
SGA blob parent                       2    0.0             0            0    N/A
SGA bucket locks                      2    0.0             0            0    N/A
Latch Activity                   DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> "Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
   willing-to-wait latch get requests
-> "NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
-> "Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                                    Get    Get   Slps   Time       NoWait NoWait
Latch Name                     Requests   Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
SGA heap locks                        2    0.0             0            0    N/A
SGA pool locks                        2    0.0             0            0    N/A
SQL memory manager latch              2    0.0             0          298    0.0
SQL memory manager worka         20,358    0.0             0            0    N/A
Shared B-Tree                       722    0.0             0            0    N/A
Streams Generic                       2    0.0             0            0    N/A
Testing                               2    0.0             0            0    N/A
Token Manager                         2    0.0             0            0    N/A
WCR: sync                             2    0.0             0            0    N/A
Write State Object Pool               2    0.0             0            0    N/A
X$KSFQP                               1    0.0             0            0    N/A
XDB NFS Security Latch                2    0.0             0            0    N/A
XDB unused session pool               2    0.0             0            0    N/A
XDB used session pool                 2    0.0             0            0    N/A
active checkpoint queue          44,120    0.0             0            0    N/A
active service list               1,837    0.1    0.0      0        2,231    0.0
begin backup scn array               15    0.0             0            0    N/A
bq:time manger info latc             32    0.0             0            0    N/A
buffer pool                           2    0.0             0            0    N/A
bufq statistics                     118    0.0             0            0    N/A
business card                         2    0.0             0            0    N/A
cache buffer handles             19,007    0.1    0.0      0            0    N/A
cache buffers chains        804,374,724    0.2    0.0      0      879,973    0.0
cache buffers lru chain         703,390    0.1    0.1      0    1,452,909    0.1
cache table scan latch               88    0.0             0           88    0.0
call allocation                   1,019    0.0             0            0    N/A
cas latch                             2    0.0             0            0    N/A
change notification clie              2    0.0             0            0    N/A
channel handle pool latc             39    0.0             0            0    N/A
channel operations paren          6,981    0.0             0            0    N/A
checkpoint queue latch        2,062,780    0.0    0.0      0      515,051    0.0
client/application info             152    0.0             0            0    N/A
compile environment latc             27    0.0             0            0    N/A
corrupted undo seg latch            407    0.0             0            0    N/A
cp cmon/server latch                  2    0.0             0            0    N/A
cp pool latch                         2    0.0             0            0    N/A
cp server hash latch                  2    0.0             0            0    N/A
cp sga latch                        113    0.0             0            0    N/A
cvmap freelist lock                   2    0.0             0            0    N/A
deferred cleanup latch              113    0.0             0            0    N/A
dml lock allocation                 113    0.0             0            0    N/A
done queue latch                      2    0.0             0            0    N/A
dummy allocation                     41    0.0             0            0    N/A
enqueue freelist latch                2    0.0             0       19,901    0.0
enqueue hash chains           1,240,957    0.0    0.1      0            2    0.0
enqueues                             41    0.0             0            0    N/A
fifth spare latch                     2    0.0             0            0    N/A
file cache latch                    235    0.0             0            0    N/A
flashback copy                        2    0.0             0            0    N/A
fourth Audit Vault latch              2    0.0             0            0    N/A
gc element                            2    0.0             0            0    N/A
gcs commit scn state                  2    0.0             0            0    N/A
gcs partitioned table ha              2    0.0             0            0    N/A
gcs pcm hashed value buc              2    0.0             0            0    N/A
gcs resource freelist                 2    0.0             0            0    N/A
gcs resource hash                     2    0.0             0            0    N/A
gcs resource scan list                2    0.0             0            0    N/A
gcs shadows freelist                  2    0.0             0            0    N/A
ges domain table                      2    0.0             0            0    N/A
ges enqueue table freeli              2    0.0             0            0    N/A
Latch Activity                   DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> "Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
   willing-to-wait latch get requests
-> "NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
-> "Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                                    Get    Get   Slps   Time       NoWait NoWait
Latch Name                     Requests   Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
ges group table                       2    0.0             0            0    N/A
ges process hash list                 2    0.0             0            0    N/A
ges process parent latch              2    0.0             0            0    N/A
ges resource hash list                2    0.0             0            0    N/A
ges resource scan list                2    0.0             0            0    N/A
ges resource table freel              2    0.0             0            0    N/A
ges value block free lis              2    0.0             0            0    N/A
global KZLD latch for me             15    0.0             0            0    N/A
global tx hash mapping                2    0.0             0            0    N/A
granule operation                     2    0.0             0            0    N/A
hash table column usage             292    0.0             0       12,291    0.0
hash table modification               2    0.0             0            0    N/A
heartbeat check                       2    0.0             0            0    N/A
internal temp table obje              3    0.0             0            0    N/A
intra txn parallel recov              2    0.0             0            0    N/A
io pool granule metadata              2    0.0             0            0    N/A
job workq parent latch                3    0.0             0            1    0.0
job_queue_processes free              4    0.0             0            0    N/A
job_queue_processes para            198    0.0             0            0    N/A
k2q lock allocation                   2    0.0             0            0    N/A
kcbtsemkid latch                     14    0.0             0            0    N/A
kdlx hb parent latch                  2    0.0             0            0    N/A
kgb parent                            2    0.0             0            0    N/A
kgnfs mount latch                     2    0.0             0            0    N/A
kokc descriptor allocati              8    0.0             0            0    N/A
ksfv messages                         2    0.0             0            0    N/A
ksim group membership ca              2    0.0             0            0    N/A
kss move lock                        20    0.0             0            0    N/A
ksuosstats global area               97    0.0             0            0    N/A
ksv allocation latch                149    0.0             0            0    N/A
ksv class latch                     816    0.4    0.0      0            0    N/A
ksv instance latch                    4    0.0             0            0    N/A
ksv msg queue latch                   2    0.0             0            0    N/A
ksz_so allocation latch              37    0.0             0            0    N/A
ktm global data                     157    0.0             0            0    N/A
kwqbsn:qsga                         561    0.0             0            0    N/A
lgwr LWN SCN                    244,261    0.0    0.0      0            0    N/A
list of block allocation             99    0.0             0            0    N/A
loader state object free            238    0.0             0            0    N/A
lob segment dispenser la              2    0.0             0            0    N/A
lob segment hash table l              4    0.0             0            0    N/A
lob segment query latch               2    0.0             0            0    N/A
lock DBA buffer during m              2    0.0             0            0    N/A
logical standby cache                 2    0.0             0            0    N/A
logminer context allocat              3    0.0             0            0    N/A
logminer work area                    2    0.0             0            0    N/A
longop free list parent               2    0.0             0            0    N/A
mapped buffers lru chain              2    0.0             0            0    N/A
message pool operations             245    0.0             0            0    N/A
messages                        852,994    0.0    0.0      0            0    N/A
mostly latch-free SCN           247,788    0.4    0.0      0            0    N/A
msg queue latch                       2    0.0             0            0    N/A
multiblock read objects             306    0.0             0            0    N/A
name-service namespace b              2    0.0             0            0    N/A
ncodef allocation latch             113    0.0             0            0    N/A
object queue header heap        353,981    0.0             0        1,847    0.0
object queue header oper      3,523,023    0.0    0.0      0            0    N/A
object stats modificatio            337    0.0             0            0    N/A
parallel query alloc buf            122    0.0             0            0    N/A
parallel query stats                  2    0.0             0            0    N/A
Latch Activity                   DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> "Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
   willing-to-wait latch get requests
-> "NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
-> "Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                                    Get    Get   Slps   Time       NoWait NoWait
Latch Name                     Requests   Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
parameter list                      140    2.1    0.0      0            0    N/A
parameter table manageme             86    0.0             0            0    N/A
peshm                                 2    0.0             0            0    N/A
pesom_free_list                       2    0.0             0            0    N/A
pesom_hash_node                       2    0.0             0            0    N/A
post/wait queue                 373,240    0.0    0.0      0      258,758    0.1
process allocation                   48    0.0             0           26    0.0
process group creation               37    0.0             0            0    N/A
process queue                         2    0.0             0            0    N/A
process queue reference               2    0.0             0            0    N/A
qmn task queue latch                845    0.0             0            0    N/A
query server freelists                2    0.0             0            0    N/A
queued dump request                   3    0.0             0            0    N/A
queuing load statistics               2    0.0             0            0    N/A
recovery domain hash lis              2    0.0             0            0    N/A
redo allocation               1,141,712    0.1    0.0      0    1,190,515    0.4
redo copy                             2    0.0             0    1,192,298    0.3
redo writing                    775,992    0.0    0.0      0            0    N/A
resmgr group change latc             17    5.9    0.0      0            0    N/A
resmgr:active threads                41    0.0             0            0    N/A
resmgr:actses change gro             27    0.0             0            0    N/A
resmgr:actses change sta              2    0.0             0            0    N/A
resmgr:free threads list             39    0.0             0            0    N/A
resmgr:plan CPU method                2    0.0             0            0    N/A
resmgr:resource group CP              2    0.0             0            0    N/A
resmgr:schema config                  2    0.0             0            0    N/A
resmgr:session queuing                2    0.0             0            0    N/A
rm cas latch                          2    0.0             0            0    N/A
row cache objects                55,238    0.1    0.1      0          688    0.0
rules engine rule set st            200    0.0             0            0    N/A
second Audit Vault latch              2    0.0             0            0    N/A
second spare latch                    2    0.0             0            0    N/A
sequence cache                  216,625    0.0    0.0      0            0    N/A
session allocation              257,900    0.0    0.0      0      257,892    0.0
session idle bit              7,568,121    0.0    0.0      0            0    N/A
session queue latch                   2    0.0             0            0    N/A
session state list latch             66    0.0             0            0    N/A
session switching                   126    0.0             0            0    N/A
session timer                       363    0.0             0            0    N/A
shared pool                      32,027    0.2    0.3      0            0    N/A
shared pool sim alloc                15    0.0             0            0    N/A
shared pool simulator             2,248    0.0             0            0    N/A
sim partition latch                   2    0.0             0            0    N/A
simulator hash latch         34,366,849    0.0    0.0      0            0    N/A
simulator lru latch              32,455    1.3    0.0      0   34,281,500    1.4
sort extent pool                    169    0.0             0            0    N/A
space background state o              4    0.0             0            0    N/A
space background task la          1,531    0.5    0.0      0          611    0.0
state object free list                2    0.0             0            0    N/A
statistics aggregation              336    0.0             0            0    N/A
tablespace key chain                  2    0.0             0            0    N/A
temp lob duration state               2    0.0             0            0    N/A
test excl. parent l0                  2    0.0             0            0    N/A
test excl. parent2 l0                 2    0.0             0            0    N/A
third spare latch                     2    0.0             0            0    N/A
threshold alerts latch               38    0.0             0            0    N/A
trace latch                          11    0.0             0            0    N/A
transaction allocation              108    0.0             0            0    N/A
undo global data              1,411,978    0.0    0.0      0            0    N/A
virtual circuit buffers               2    0.0             0            0    N/A
Latch Activity                   DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> "Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
   willing-to-wait latch get requests
-> "NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
-> "Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                                    Get    Get   Slps   Time       NoWait NoWait
Latch Name                     Requests   Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
virtual circuit holder                2    0.0             0            0    N/A
virtual circuit queues                2    0.0             0            0    N/A
          -------------------------------------------------------------

Latch Sleep Breakdown            DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> ordered by misses desc

                                       Get                                 Spin
Latch Name                        Requests       Misses      Sleeps        Gets
-------------------------- --------------- ------------ ----------- -----------
cache buffers chains           804,374,724    1,488,116       1,355   1,486,761
simulator hash latch            34,366,849        4,316         100       4,217
session idle bit                 7,568,121        1,281          54       1,227
object queue header operat       3,523,023        1,146          54       1,093
redo allocation                  1,141,712        1,022          44         978
mostly latch-free SCN              247,788          958          29         929
enqueue hash chains              1,240,957          459          28         431
cache buffers lru chain            703,390          432          23         410
simulator lru latch                 32,455          413           9         404
In memory undo latch             1,391,681          395         257         140
undo global data                 1,411,978          266           6         260
messages                           852,994          253           3         250
checkpoint queue latch           2,062,780          124           1         123
sequence cache                     216,625           95           2          93
DML lock allocation                698,726           84           7          77
row cache objects                   55,238           60           8          52
session allocation                 257,900           57           2          55
shared pool                         32,027           56          14          50
post/wait queue                    373,240           49           1          48
redo writing                       775,992           49           2          47
ASM map operation hash tab       3,306,049           14           1          13
Consistent RBA                     242,581            3           2           1
          -------------------------------------------------------------

Latch Miss Sources               DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> only latches with sleeps are shown
-> ordered by name, sleeps desc

                                                     NoWait              Waiter
Latch Name               Where                       Misses     Sleeps   Sleeps
------------------------ -------------------------- ------- ---------- --------
ASM map operation hash t kffmDoDone_1                     0          1        0
DML lock allocation      ktaiam                           0          7        6
In memory undo latch     ktiFlush: child                  0        185       77
In memory undo latch     kticmt: child                    0         82       35
In memory undo latch     ktichg: child                    0         11      134
cache buffers chains     kcbchg1: mod cr pin              0        334      146
cache buffers chains     kcbgtcr: fast path (cr pin       0        287      443
cache buffers chains     kcbget: fast exchange            0        267       16
cache buffers chains     kcbgtcr: kslbegin shared         0        242       65
cache buffers chains     kcbgtcr: fast path               0        178      556
cache buffers chains     kcbgtcr_2                        0        163       89
cache buffers chains     kcbgtcr_1                        0         65        0
cache buffers chains     kcbgcur_4                        0         59        4
cache buffers chains     kcbgcur_2                        0         45       13
cache buffers chains     kcbzgb: scan from tail. no       0         30        0
cache buffers chains     kcbgtcr: kslbegin excl           0         28       35
cache buffers chains     kcbrls: fast release             0         25      255
cache buffers chains     kcbzwb                           0         25       21
cache buffers chains     kcbnew: new latch again          0         19        2
cache buffers chains     kcbget: fast path                0          9        1
cache buffers chains     kcbnlc                           0          8        8
cache buffers chains     kcbchg1: aux pin                 0          7        6
cache buffers chains     kcbzib: finish processing        0          7        4
cache buffers chains     kcbbic2                          0          6        1
cache buffers chains     kcb_pre_apply: kcbhq61           0          5        9
cache buffers chains     kcb_post_apply: kcbhq62          0          4        1
cache buffers chains     kcbchg1: clear MS bit            0          3       13
cache buffers chains     kcbzib: exchange rls             0          3        8
cache buffers chains     kcbzpbuf                         0          3        9
cache buffers chains     kcbbic1                          0          2        4
cache buffers chains     kcbget: release shr              0          2        6
cache buffers chains     kcbnew_1                         0          2        0
cache buffers chains     kcbzibmlt: multi-block rea       0          2        0
cache buffers chains     kcbget: pin buffer               0          1        0
cache buffers chains     kcbrls_2                         0          1       28
cache buffers lru chain  kcbzgws                          0         22        0
cache buffers lru chain  kcbzgb                           0          1        0
checkpoint queue latch   kcbklbc_cql                      0          1        0
enqueue hash chains      ksqgtl3                          0         19       12
enqueue hash chains      ksqrcl                           0          8       15
enqueue hash chains      ksqcmi: get hash chain lat       0          1        1
lgwr LWN SCN             kcs023                           0         15        0
messages                 ksaamb: after wakeup             0          3        1
mostly latch-free SCN    kcslcu3                          0         14       29
mostly latch-free SCN    kcsnew_scn_rba                   0          2        0
object queue header oper kcbo_switch_cq                   0         14       30
object queue header oper kcbo_switch_mq_bg                0         13        2
object queue header oper kcbo_unlink_q                    0         13       17
object queue header oper kcbo_link_q                      0         11        2
object queue header oper kcbo_check_flist                 0          3        3
object queue header oper kcbo_switch_q_bg                 0          2        2
post/wait queue          ksliwat:add:nowait               0          1        0
redo allocation          kcrfw_redo_gen: redo alloc       0         39        0
redo allocation          kcrf_pvt_strand_bind             0          3        4
redo allocation          kcrf_pvt_strand_unbind           0          1        0
redo allocation          kcrfw_redo_gen: redo alloc       0          1        0
redo writing             kcrfw_cal_target_rba             0          1        0
redo writing             kcrfwcr                          0          1        1
row cache objects        kqreqd                           0          3        1
row cache objects        kqreqd: reget                    0          3        0
Latch Miss Sources               DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> only latches with sleeps are shown
-> ordered by name, sleeps desc

                                                     NoWait              Waiter
Latch Name               Where                       Misses     Sleeps   Sleeps
------------------------ -------------------------- ------- ---------- --------
row cache objects        kqrpre: find obj                 0          1        2
row cache objects        kqrso                            0          1        0
sequence cache           kdnssd                           0          2        0
session allocation       ksucri_int : SSO                 0          1        0
session allocation       ksuxds                           0          1        2
session idle bit         ksupuc: set busy                 0         35       22
session idle bit         ksupuc: clear busy               0         16       30
session idle bit         ksuxds                           0          3        2
shared pool              kghalo                           0         12        6
shared pool              kghupr1                          0          2       13
simulator hash latch     kcbsacc: lookup dba              0        100      100
simulator lru latch      kcbs_simulate: simulate se       0          9        0
undo global data         ktubnd_4                         0          2        0
undo global data         ktudba: KSLBEGIN                 0          2        1
undo global data         ktudnx:child                     0          2        2
          -------------------------------------------------------------

Mutex Sleep Summary               DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> ordered by number of sleeps desc

                                                                         Wait
Mutex Type            Location                               Sleeps    Time (ms)
--------------------- -------------------------------- ------------ ------------
Cursor Pin            kkslce [KKSCHLPIN2]                     5,901            0
Cursor Pin            kksfbc [KKSCHLPIN1]                        82            0
Library Cache         kglpin1   4                                76            0
Library Cache         kglpndl1  95                               65            0
Library Cache         kglhdgn2 106                               51            0
Library Cache         kgllkc1   57                               33            0
Library Cache         kglllal3 111                               32            0
Library Cache         kglpnal1  90                               31            0
Cursor Pin            kksLockDelete [KKSCHLPIN6]                 20            0
Library Cache         kgllkdl1  85                                8            0
Library Cache         kglhdgn1  62                                7            0
Library Cache         kgllkal3  82                                7            0
Library Cache         kglget2   2                                 6            0
Library Cache         kglUpgradeLock 119                          4            0
Library Cache         kglini1   32                                3            0
Library Cache         kgllldl2 112                                3            0
Library Cache         kglobld1  75                                1            0
          -------------------------------------------------------------

Parent Latch Statistics          DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827

                  No data exists for this section of the report.
          -------------------------------------------------------------

Child Latch Statistics            DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827

                  No data exists for this section of the report.
          -------------------------------------------------------------

Segments by Logical Reads        DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Total Logical Reads:     586,033,175
-> Captured Segments account for   99.5% of Total

           Tablespace                      Subobject  Obj.       Logical
Owner         Name    Object Name            Name     Type         Reads  %Total
---------- ---------- -------------------- ---------- ----- ------------ -------
SOE        SOE        ITEM_ORDER_IX                   INDEX  188,119,184   32.10
SOE        SOE        CUSTOMERS_PK                    INDEX  187,892,784   32.06
SOE        SOE        CUSTOMERS                       TABLE   94,131,216   16.06
SOE        SOE        ORDERS                          TABLE   93,754,880   16.00
SOE        SOE        PRODUCT_INFORMATION             TABLE    9,718,816    1.66
          -------------------------------------------------------------

Segments by Physical Reads        DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Total Physical Reads:         774,075
-> Captured Segments account for   99.4% of Total

           Tablespace                      Subobject  Obj.      Physical
Owner         Name    Object Name            Name     Type         Reads  %Total
---------- ---------- -------------------- ---------- ----- ------------ -------
SOE        SOE        CUSTOMERS                       TABLE      148,566   19.19
SOE        SOE        CUSTOMERS_PK                    INDEX      140,248   18.12
SOE        SOE        ORD_CUSTOMER_IX                 INDEX       92,874   12.00
SOE        SOE        INVENTORIES                     TABLE       81,655   10.55
SOE        SOE        ITEM_ORDER_IX                   INDEX       64,684    8.36
          -------------------------------------------------------------

Segments by Physical Read RequestsDB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Total Physical Read Requests:         773,429
-> Captured Segments account for   99.4% of Total

           Tablespace                      Subobject  Obj.     Phys Read
Owner         Name    Object Name            Name     Type      Requests  %Total
---------- ---------- -------------------- ---------- ----- ------------ -------
SOE        SOE        CUSTOMERS                       TABLE      148,563   19.21
SOE        SOE        CUSTOMERS_PK                    INDEX      140,249   18.13
SOE        SOE        ORD_CUSTOMER_IX                 INDEX       92,874   12.01
SOE        SOE        INVENTORIES                     TABLE       81,655   10.56
SOE        SOE        ITEM_ORDER_IX                   INDEX       64,682    8.36
          -------------------------------------------------------------

Segments by UnOptimized Reads     DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Total UnOptimized Read Requests:         773,429
-> Captured Segments account for   99.4% of Total

           Tablespace                      Subobject  Obj.   UnOptimized
Owner         Name    Object Name            Name     Type         Reads  %Total
---------- ---------- -------------------- ---------- ----- ------------ -------
SOE        SOE        CUSTOMERS                       TABLE      148,563   19.21
SOE        SOE        CUSTOMERS_PK                    INDEX      140,249   18.13
SOE        SOE        ORD_CUSTOMER_IX                 INDEX       92,874   12.01
SOE        SOE        INVENTORIES                     TABLE       81,655   10.56
SOE        SOE        ITEM_ORDER_IX                   INDEX       64,682    8.36
          -------------------------------------------------------------

Segments by Optimized Reads       DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827

                  No data exists for this section of the report.
          -------------------------------------------------------------

Segments by Direct Physical Reads DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827

                  No data exists for this section of the report.
          -------------------------------------------------------------

Segments by Physical Writes       DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Total Physical Writes:         521,944
-> Captured Segments account for   95.0% of Total

           Tablespace                      Subobject  Obj.      Physical
Owner         Name    Object Name            Name     Type        Writes  %Total
---------- ---------- -------------------- ---------- ----- ------------ -------
SOE        SOE        INVENTORIES                     TABLE      104,693   20.06
SOE        SOE        ITEM_PRODUCT_IX                 INDEX       63,064   12.08
SOE        SOE        ORDER_PK                        INDEX       51,587    9.88
SOE        SOE        ORD_CUSTOMER_IX                 INDEX       50,087    9.60
SOE        SOE        ORD_WAREHOUSE_IX                INDEX       46,483    8.91
          -------------------------------------------------------------

Segments by Physical Write RequestsDB/Inst: DBM11203/DBM11203  Snaps: 1826-182
-> Total Physical Write Requestss:         383,680
-> Captured Segments account for   98.9% of Total

           Tablespace                      Subobject  Obj.    Phys Write
Owner         Name    Object Name            Name     Type      Requests  %Total
---------- ---------- -------------------- ---------- ----- ------------ -------
SOE        SOE        INVENTORIES                     TABLE       68,215   17.78
SOE        SOE        ORDER_PK                        INDEX       50,136   13.07
SOE        SOE        ORD_CUSTOMER_IX                 INDEX       47,348   12.34
SOE        SOE        ORDER_ITEMS_PK                  INDEX       44,184   11.52
SOE        SOE        ITEM_ORDER_IX                   INDEX       42,964   11.20
          -------------------------------------------------------------

Segments by Direct Physical WritesDB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Total Direct Physical Writes:             130
-> Captured Segments account for   45.4% of Total

           Tablespace                      Subobject  Obj.        Direct
Owner         Name    Object Name            Name     Type        Writes  %Total
---------- ---------- -------------------- ---------- ----- ------------ -------
SYS        SYSAUX     WRH$_ACTIVE_SESSION_ 11053_1819 TABLE           47   36.15
SYS        SYSAUX     SYS_LOB0000006339C00            LOB             12    9.23
          -------------------------------------------------------------

Segments by Table Scans           DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827

                  No data exists for this section of the report.
          -------------------------------------------------------------

Segments by DB Blocks Changes     DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> % of Capture shows % of DB Block Changes for each top segment compared
-> with total DB Block Changes for all segments captured by the Snapshot

           Tablespace                      Subobject  Obj.      DB Block    % of
Owner         Name    Object Name            Name     Type       Changes Capture
---------- ---------- -------------------- ---------- ----- ------------ -------
SOE        SOE        ORDERS                          TABLE      158,800   15.44
SOE        SOE        ORD_WAREHOUSE_IX                INDEX      158,336   15.39
SOE        SOE        ITEM_ORDER_IX                   INDEX      129,296   12.57
SOE        SOE        ORDER_ITEMS                     TABLE      128,960   12.54
SOE        SOE        INVENTORIES                     TABLE      106,592   10.36
          -------------------------------------------------------------

Segments by Row Lock Waits       DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> % of Capture shows % of row lock waits for each top segment compared
-> with total row lock waits for all segments captured by the Snapshot

                                                                     Row
           Tablespace                      Subobject  Obj.          Lock    % of
Owner         Name    Object Name            Name     Type         Waits Capture
---------- ---------- -------------------- ---------- ----- ------------ -------
SOE        SOE        ORDERS                          TABLE        1,227   74.68
SOE        SOE        ORD_ORDER_DATE_IX               INDEX          144    8.76
SOE        SOE        ORD_WAREHOUSE_IX                INDEX          104    6.33
SOE        SOE        ITEM_PRODUCT_IX                 INDEX           79    4.81
SOE        SOE        CUST_ACCOUNT_MANAGER            INDEX           22    1.34
          -------------------------------------------------------------

Segments by ITL Waits             DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827

                  No data exists for this section of the report.
          -------------------------------------------------------------

Segments by Buffer Busy Waits     DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> % of Capture shows % of Buffer Busy Waits for each top segment compared
-> with total Buffer Busy Waits for all segments captured by the Snapshot

                                                                  Buffer
           Tablespace                      Subobject  Obj.          Busy    % of
Owner         Name    Object Name            Name     Type         Waits Capture
---------- ---------- -------------------- ---------- ----- ------------ -------
SOE        SOE        ORDERS                          TABLE          522   92.72
SOE        SOE        ORD_ORDER_DATE_IX               INDEX           13    2.31
SYS        SYSTEM     AUD$                            TABLE            6    1.07
SOE        SOE        ORDER_ITEMS                     TABLE            5     .89
SOE        SOE        ORDER_PK                        INDEX            5     .89
          -------------------------------------------------------------

Dictionary Cache Stats           DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> "Pct Misses"  should be very low (< 2% in most cases)
-> "Final Usage" is the number of cache entries being used

                                   Get    Pct    Scan   Pct      Mod      Final
Cache                         Requests   Miss    Reqs  Miss     Reqs      Usage
------------------------- ------------ ------ ------- ----- -------- ----------
dc_awr_control                      19    0.0       0   N/A        2          1
dc_global_oids                      53    5.7       0   N/A        0         24
dc_histogram_data                2,769   15.3       0   N/A        0      2,149
dc_histogram_defs                5,387   29.0       0   N/A        0      2,942
dc_object_grants                     2   50.0       0   N/A        0         10
dc_objects                       2,759    7.3       0   N/A        1      1,264
dc_profiles                         17    0.0       0   N/A        0          1
dc_rollback_segments             1,068    0.0       0   N/A        0         78
dc_segments                      1,253    8.7       0   N/A       15        463
dc_sequences                        14   42.9       0   N/A       14          7
dc_tablespaces                   2,769    0.0       0   N/A        0          7
dc_users                         2,960    0.7       0   N/A        0         22
global database name               629    0.0       0   N/A        0          1
outstanding_alerts                   8    0.0       0   N/A        0          4
sch_lj_oids                          2    0.0       0   N/A        0          1
          -------------------------------------------------------------

Library Cache Activity            DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> "Pct Misses"  should be very low

                         Get    Pct            Pin    Pct             Invali-
Namespace           Requests   Miss       Requests   Miss    Reloads  dations
--------------- ------------ ------ -------------- ------ ---------- --------
ACCOUNT_STATUS            30    3.3              0    N/A          0        0
BODY                      30    6.7             59    5.1          1        0
CLUSTER                   36    2.8             36    2.8          0        0
DBLINK                    31    3.2              0    N/A          0        0
EDITION                   23    0.0             38    7.9          0        0
INDEX                     15    6.7             15    6.7          0        0
QUEUE                    266    0.0            266    0.0          0        0
SCHEMA                   160    0.0              0    N/A          0        0
SQL AREA               1,470    8.9      1,728,755    0.0        211        0
SQL AREA BUILD           350   83.7              0    N/A          0        0
SQL AREA STATS           300   54.0            300   54.0          0        0
TABLE/PROCEDURE        1,405    8.8        147,455    0.7        468        0
          -------------------------------------------------------------

Memory Dynamic Components        DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Min/Max sizes since instance startup
-> Oper Types/Modes: INItializing,GROw,SHRink,STAtic/IMMediate,DEFerred
-> ordered by Component

                 Begin Snap     Current         Min         Max   Oper Last Op
Component         Size (Mb)   Size (Mb)   Size (Mb)   Size (Mb)  Count Typ/Mod
--------------- ----------- ----------- ----------- ----------- ------ -------
ASM Buffer Cach         .00         .00         .00         .00      0 STA/
DEFAULT 16K buf         .00         .00         .00         .00      0 STA/
DEFAULT 2K buff         .00         .00         .00         .00      0 STA/
DEFAULT 32K buf         .00         .00         .00         .00      0 STA/
DEFAULT 4K buff         .00         .00         .00         .00      0 STA/
DEFAULT 8K buff         .00         .00         .00         .00      0 STA/
DEFAULT buffer       728.00      728.00      728.00      740.00      0 SHR/IMM
KEEP buffer cac         .00         .00         .00         .00      0 STA/
PGA Target           128.00      128.00      128.00      128.00      0 STA/
RECYCLE buffer          .00         .00         .00         .00      0 STA/
SGA Target         1,024.00    1,024.00    1,024.00    1,024.00      0 STA/
Shared IO Pool          .00         .00         .00         .00      0 STA/
java pool              4.00        4.00        4.00        4.00      0 STA/
large pool             8.00        8.00         .00        8.00      0 GRO/IMM
shared pool          260.00      260.00      260.00      260.00      0 STA/
streams pool           8.00        8.00         .00        8.00      0 GRO/IMM
          -------------------------------------------------------------

Memory Resize Operations Summary  DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827

                  No data exists for this section of the report.
          -------------------------------------------------------------

Memory Resize Ops                 DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827

                  No data exists for this section of the report.
          -------------------------------------------------------------

Process Memory Summary           DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> B: Begin Snap   E: End Snap
-> All rows below contain absolute values (i.e. not diffed over the interval)
-> Max Alloc is Maximum PGA Allocation size at snapshot time
-> Hist Max Alloc is the Historical Max Allocation for still-connected processes
-> ordered by Begin/End snapshot, Alloc (MB) desc

                                                            Hist
                                    Avg  Std Dev     Max     Max
               Alloc      Used    Alloc    Alloc   Alloc   Alloc    Num    Num
  Category      (MB)      (MB)     (MB)     (MB)    (MB)    (MB)   Proc  Alloc
- -------- --------- --------- -------- -------- ------- ------- ------ ------
B Other        154.4       N/A      2.6      2.4      14      25     59     59
  Freeable      25.4        .0       .8       .4       1     N/A     32     32
  PL/SQL         4.1       2.4       .1       .4       3       4     59     59
  SQL            1.0        .1       .0       .0       0       5     41     37
E Other        184.9       N/A      2.5      2.2      14      25     74     74
  Freeable      26.2        .0       .8       .4       1     N/A     33     33
  PL/SQL         4.4       2.7       .1       .3       3       4     74     74
  SQL            1.6        .1       .0       .0       0       5     55     51
          -------------------------------------------------------------

SGA Memory Summary                DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827

                                                      End Size (Bytes)
SGA regions                     Begin Size (Bytes)      (if different)
------------------------------ ------------------- -------------------
Database Buffers                       763,363,328
Fixed Size                               2,235,208
Redo Buffers                             9,736,192
Variable Size                          293,602,488
                               -------------------
sum                                  1,068,937,216
          -------------------------------------------------------------

SGA breakdown difference          DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> ordered by Pool, Name
-> N/A value for Begin MB or End MB indicates the size of that Pool/Name was
   insignificant, or zero in that snapshot

Pool   Name                                 Begin MB         End MB  % Diff
------ ------------------------------ -------------- -------------- -------
java   free memory                               4.0            4.0    0.00
large  ASM map operations hashta                  .4             .4    0.00
large  PX msg pool                               3.7            3.7    0.00
large  free memory                               3.9            3.9    0.00
shared ASH buffers                              16.0           16.0    0.00
shared KCB Table Scan Buffer                     3.8            3.8    0.00
shared KGLH0                                    18.4           16.7   -9.53
shared KGLHD                                     3.8            3.2  -16.71
shared KGLS                                      4.9            4.9    0.37
shared KGLSG                                     5.0            5.0    0.00
shared KKSSP                                     2.8            3.6   28.19
shared KSFD SGA I/O b                            3.8            3.8    0.00
shared PLMCD                                     4.1            N/A -100.00
shared SQLA                                     43.7           21.7  -50.25
shared db_block_hash_buckets                     5.6            5.6    0.00
shared dbwriter coalesce buffer                  3.8            3.8    0.00
shared dirty object counts array                 4.0            4.0    0.00
shared event statistics per sess                 3.1            3.1    0.00
shared free memory                              65.9           90.3   37.13
shared kglsim hash table bkts                    4.0            4.0    0.00
shared ksunfy : SSO free list                    2.9            2.9    0.00
shared private strands                           3.5            3.5    0.00
shared row cache                                 7.2            7.2    0.00
shared write state object                        3.7            3.7    0.00
stream free memory                               8.0            8.0    0.00
       buffer_cache                            728.0          728.0    0.00
       fixed_sga                                 2.1            2.1    0.00
       log_buffer                                9.3            9.3    0.00
          -------------------------------------------------------------

Streams CPU/IO Usage             DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Streams processes ordered by CPU Time, descending

                                                     User IO       SYS IO
Session Type         First Logon    CPU time(s) Wait time(s) Wait time(s)
-------------------- ------------- ------------ ------------ ------------
QMON Slaves          0423 16:34:10          0.0          0.1          0.0
QMON Coordinator     0423 16:34:00          0.0          0.0          0.0
          -------------------------------------------------------------

Streams Capture                   DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827

                  No data exists for this section of the report.
          -------------------------------------------------------------

Streams Capture Rate              DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827

                  No data exists for this section of the report.
          -------------------------------------------------------------

Streams Apply                     DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827

                  No data exists for this section of the report.
          -------------------------------------------------------------

Streams Apply Rate                DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827

                  No data exists for this section of the report.
          -------------------------------------------------------------

Buffered Queues                   DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Ordered by Queue Name
-> * indicates queue (re)started between Begin/End snaps

        Enq        Enq        Deq        Deq   Spill     Spill     %Spill
       Msgs   Msgs/sec       Msgs   Msgs/sec    Msgs  Msgs/sec       Msgs
 ---------- ---------- ---------- ---------- ------- --------- ----------
SYS.SCHEDULER$_EVENT_QUEUE(12613)
          0       0.00          0       0.00       0      0.00        N/A
          -------------------------------------------------------------

Buffered Queue Subscribers        DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827

                  No data exists for this section of the report.
          -------------------------------------------------------------

Rule Set                          DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827

                  No data exists for this section of the report.
          -------------------------------------------------------------

Persistent Queues                 DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827

                  No data exists for this section of the report.
          -------------------------------------------------------------

Persistent Queues Rate            DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827

                  No data exists for this section of the report.
          -------------------------------------------------------------

Persistent Queue Subscribers      DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827

                  No data exists for this section of the report.
          -------------------------------------------------------------

Resource Limit Stats                   DB/Inst: DBM11203/DBM11203  Snap: 1827

                  No data exists for this section of the report.
          -------------------------------------------------------------

Shared Servers Activity           DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> Values represent averages for all samples

   Avg Total   Avg Active    Avg Total   Avg Active    Avg Total   Avg Active
 Connections  Connections Shared Srvrs Shared Srvrs  Dispatchers  Dispatchers
------------ ------------ ------------ ------------ ------------ ------------
           0            0            0            0            0            0
          -------------------------------------------------------------

Shared Servers Rates              DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827

  Common     Disp                        Common       Disp     Server
   Queue    Queue   Server    Server      Queue      Queue      Total     Server
 Per Sec  Per Sec Msgs/Sec    KB/Sec      Total      Total       Msgs  Total(KB)
-------- -------- -------- --------- ---------- ---------- ---------- ----------
       0        0        0       0.0          0          0          0          0
          -------------------------------------------------------------

Shared Servers Utilization        DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827

                  No data exists for this section of the report.
          -------------------------------------------------------------

Shared Servers Common Queue       DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827

                  No data exists for this section of the report.
          -------------------------------------------------------------

Shared Servers Dispatchers        DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827

                  No data exists for this section of the report.
          -------------------------------------------------------------

init.ora Parameters              DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827

                                                                End value
Parameter Name                Begin value                       (if different)
----------------------------- --------------------------------- --------------
audit_file_dest               /u00/app/oracle/admin/DBM11203/ad
audit_trail                   DB
control_files                 +DATA/dbm11203/controlfile/curren
core_dump_dest                /u00/app/oracle/diag/rdbms/dbm112
cursor_sharing                EXACT
db_block_size                 8192
db_create_file_dest           +DATA
db_domain                     antognini.ch
db_name                       DBM11203
db_recovery_file_dest         +FRA
db_recovery_file_dest_size    2147483648
diagnostic_dest               /u00/app/oracle
local_listener                (DESCRIPTION=(ADDRESS=(PROTOCOL=t
log_buffer                    8183808
open_cursors                  30
optimizer_dynamic_sampling    2
optimizer_mode                ALL_ROWS
pga_aggregate_target          134217728
plsql_warnings                DISABLE:ALL
processes                     150
query_rewrite_enabled         TRUE
remote_login_passwordfile     EXCLUSIVE
result_cache_max_size         2031616
sga_target                    1073741824
skip_unusable_indexes         TRUE
undo_tablespace               UNDOTBS1
user_dump_dest                /u00/app/oracle/diag/rdbms/dbm112
          -------------------------------------------------------------

init.ora Multi-Valued Parameters DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827
-> This section only displays parameters that have more one value
->'(NULL)' indicates a missing parameter value
-> A blank in the End Snapshot indicates the same value as the BeginSnapshot

                                                                End value
Parameter Name                Begin value                       (if different)
----------------------------- --------------------------------- --------------
control_files                 +DATA/dbm11203/controlfile/curren
                              +FRA/dbm11203/controlfile/current
          -------------------------------------------------------------

Dynamic Remastering Stats         DB/Inst: DBM11203/DBM11203  Snaps: 1826-1827

                  No data exists for this section of the report.
          -------------------------------------------------------------

End of Report
