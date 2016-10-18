
WORKLOAD REPOSITORY report for

DB Name         DB Id    Instance     Inst Num Startup Time    Release     RAC
------------ ----------- ------------ -------- --------------- ----------- ---
DBM11203      2532911053 DBM11203            1 23-Apr-14 16:33 11.2.0.3.0  NO

Host Name        Platform                         CPUs Cores Sockets Memory(GB)
---------------- -------------------------------- ---- ----- ------- ----------
helicon          Linux x86 64-bit                    8     8       2       7.79

              Snap Id      Snap Time      Sessions Curs/Sess
            --------- ------------------- -------- ---------
Begin Snap:      1822 23-Apr-14 18:30:05        58       1.5
  End Snap:      1823 23-Apr-14 18:45:06        59       1.5
   Elapsed:               15.03 (mins)
   DB Time:              106.74 (mins)

Cache Sizes                       Begin        End
~~~~~~~~~~~                  ---------- ----------
               Buffer Cache:       728M       728M  Std Block Size:         8K
           Shared Pool Size:       260M       260M      Log Buffer:     9,508K

Load Profile              Per Second    Per Transaction   Per Exec   Per Call
~~~~~~~~~~~~         ---------------    --------------- ---------- ----------
      DB Time(s):                7.1                0.0       0.01       0.00
       DB CPU(s):                1.9                0.0       0.00       0.00
       Redo size:          393,267.0            1,931.8
   Logical reads:          406,407.8            1,996.3
   Block changes:            2,827.7               13.9
  Physical reads:              580.0                2.9
 Physical writes:              377.6                1.9
      User calls:            2,896.4               14.2
          Parses:                0.6                0.0
     Hard parses:                0.0                0.0
W/A MB processed:                0.1                0.0
          Logons:                0.0                0.0
        Executes:            1,364.7                6.7
       Rollbacks:                0.0                0.0
    Transactions:              203.6

Instance Efficiency Percentages (Target 100%)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            Buffer Nowait %:  100.00       Redo NoWait %:   99.97
            Buffer  Hit   %:   99.86    In-memory Sort %:  100.00
            Library Hit   %:  100.02        Soft Parse %:   98.98
         Execute to Parse %:   99.96         Latch Hit %:   99.96
Parse CPU to Parse Elapsd %:  104.26     % Non-Parse CPU:   98.89

 Shared Pool Statistics        Begin    End
                              ------  ------
             Memory Usage %:   66.48   66.54
    % SQL with executions>1:   76.23   75.09
  % Memory for SQL w/exec>1:   60.16   60.10

Top 5 Timed Foreground Events
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                                           Avg
                                                          wait   % DB
Event                                 Waits     Time(s)   (ms)   time Wait Class
------------------------------ ------------ ----------- ------ ------ ----------
db file sequential read             520,207       4,568      9   71.3 User I/O
DB CPU                                            1,701          26.6
log file sync                       182,738          94      1    1.5 Commit
read by other session                 2,753          27     10     .4 User I/O
SQL*Net message to client         1,418,459           2      0     .0 Network
Host CPU (CPUs:    8 Cores:    8 Sockets:    2)
~~~~~~~~         Load Average
               Begin       End     %User   %System      %WIO     %Idle
           --------- --------- --------- --------- --------- ---------
                6.93      7.23      23.8       0.9      21.8      74.8

Instance CPU
~~~~~~~~~~~~
              % of total CPU for Instance:      24.8
              % of busy  CPU for Instance:      98.4
  %DB time waiting for CPU - Resource Mgr:       0.0

Memory Statistics
~~~~~~~~~~~~~~~~~                       Begin          End
                  Host Mem (MB):      7,974.6      7,974.6
                   SGA use (MB):      1,024.0      1,024.0
                   PGA use (MB):        178.2        181.2
    % Host Mem used for SGA+PGA:        15.08        15.11

Time Model Statistics            DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> Total time in database user-calls (DB Time): 6404.5s
-> Statistics including the word "background" measure background process
   time, and so do not contribute to the DB time statistic
-> Ordered by % or DB time desc, Statistic name

Statistic Name                                       Time (s) % of DB Time
------------------------------------------ ------------------ ------------
sql execute elapsed time                              6,114.4         95.5
DB CPU                                                1,701.4         26.6
parse time elapsed                                       26.9           .4
sequence load elapsed time                                0.1           .0
PL/SQL execution elapsed time                             0.0           .0
repeated bind elapsed time                                0.0           .0
DB time                                               6,404.5
background elapsed time                                 107.5
background cpu time                                      38.7
          -------------------------------------------------------------

Operating System Statistics       DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> *TIME statistic values are diffed.
   All others display actual values.  End Value is displayed if different
-> ordered by statistic type (CPU Use, Virtual Memory, Hardware Config), Name

Statistic                                  Value        End Value
------------------------- ---------------------- ----------------
BUSY_TIME                                176,851
IDLE_TIME                                524,631
IOWAIT_TIME                              152,976
NICE_TIME                                     35
SYS_TIME                                   6,268
USER_TIME                                166,878
LOAD                                           7                7
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

Operating System Statistics - DetailDB/Inst: DBM11203/DBM11203  Snaps: 1822-18

Snap Time           Load    %busy    %user     %sys    %idle  %iowait
--------------- -------- -------- -------- -------- -------- --------
23-Apr 18:30:05      6.9      N/A      N/A      N/A      N/A      N/A
23-Apr 18:45:06      7.2     25.2     23.8      0.9     74.8     21.8
          -------------------------------------------------------------

Foreground Wait Class             DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> s  - second, ms - millisecond -    1000th of a second
-> ordered by wait time desc, waits desc
-> %Timeouts: value of 0 indicates value was < .5%.  Value of null is truly 0
-> Captured Time accounts for         99.9%  of Total DB time       6,404.55 (s)
-> Total FG Wait Time:             4,698.18 (s)  DB CPU time:       1,701.44 (s)

                                                                  Avg
                                      %Time       Total Wait     wait
Wait Class                      Waits -outs         Time (s)     (ms)  %DB time
-------------------- ---------------- ----- ---------------- -------- ---------
User I/O                      523,015     0            4,595        9      71.7
DB CPU                                                 1,701               26.6
Commit                        182,738     0               94        1       1.5
Configuration                     173     0                5       28       0.1
Network                     1,418,459     0                2        0       0.0
Application                       684     0                1        1       0.0
Concurrency                     1,038     0                0        0       0.0
System I/O                        356     0                0        0       0.0
Other                             102     3                0        0       0.0
          -------------------------------------------------------------

Foreground Wait Events           DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> s  - second, ms - millisecond -    1000th of a second
-> Only events with Total Wait Time (s) >= .001 are shown
-> ordered by wait time desc, waits desc (idle events last)
-> %Timeouts: value of 0 indicates value was < .5%.  Value of null is truly 0

                                                             Avg
                                        %Time Total Wait    wait    Waits   % DB
Event                             Waits -outs   Time (s)    (ms)     /txn   time
-------------------------- ------------ ----- ---------- ------- -------- ------
db file sequential read         520,207     0      4,568       9      2.8   71.3
log file sync                   182,738     0         94       1      1.0    1.5
read by other session             2,753     0         27      10      0.0     .4
SQL*Net message to client     1,418,459     0          2       0      7.7     .0
log file switch (checkpoin           73     0          2      34      0.0     .0
log file switch (private s          100     0          2      24      0.0     .0
enq: TX - row lock content          684     0          1       1      0.0     .0
db file parallel read                41     0          0      10      0.0     .0
buffer busy waits                   369     0          0       1      0.0     .0
enq: TX - index contention            7     0          0      16      0.0     .0
control file sequential re          356     0          0       0      0.0     .0
latch: cache buffers chain          448     0          0       0      0.0     .0
cursor: pin S                        27     0          0       2      0.0     .0
latch free                           71     0          0       0      0.0     .0
latch: In memory undo latc          155     0          0       0      0.0     .0
db file scattered read                2     0          0       7      0.0     .0
library cache: mutex X               32     0          0       0      0.0     .0
latch: enqueue hash chains           14     0          0       0      0.0     .0
latch: object queue header           10     0          0       0      0.0     .0
SQL*Net message from clien    1,418,463     0     16,141      11      7.7
jobq slave wait                     120   100         60     501      0.0
          -------------------------------------------------------------

Background Wait Events           DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> ordered by wait time desc, waits desc (idle events last)
-> Only events with Total Wait Time (s) >= .001 are shown
-> %Timeouts: value of 0 indicates value was < .5%.  Value of null is truly 0

                                                             Avg
                                        %Time Total Wait    wait    Waits   % bg
Event                             Waits -outs   Time (s)    (ms)     /txn   time
-------------------------- ------------ ----- ---------- ------- -------- ------
log file parallel write         178,859     0         39       0      1.0   36.1
db file parallel write           25,152     0         14       1      0.1   13.4
db file sequential read           1,159     0          7       6      0.0    6.8
control file sequential re        2,324     0          5       2      0.0    4.8
db file scattered read              119     0          1      12      0.0    1.4
os thread startup                    12     0          0      35      0.0     .4
direct path read                     18     0          0      19      0.0     .3
log file sequential read             44     0          0       5      0.0     .2
ASM file metadata operatio          541     0          0       0      0.0     .2
control file parallel writ          616     0          0       0      0.0     .1
ADR block file read                  16     0          0       5      0.0     .1
LGWR wait for redo copy             826     0          0       0      0.0     .1
enq: JS - queue lock                  1     0          0      51      0.0     .0
reliable message                     87     0          0       0      0.0     .0
Disk file operations I/O             66     0          0       0      0.0     .0
CSS initialization                    1     0          0       5      0.0     .0
db file async I/O submit          1,555     0          0       0      0.0     .0
latch free                            3     0          0       1      0.0     .0
log file single write                44     0          0       0      0.0     .0
ADR block file write                  5     0          0       1      0.0     .0
read by other session                 1     0          0       3      0.0     .0
latch: redo allocation               12     0          0       0      0.0     .0
direct path write                    12     0          0       0      0.0     .0
CSS operation: action                 1     0          0       1      0.0     .0
rdbms ipc message               184,586     2     12,525      68      1.0
class slave wait                    235     0      3,606   15344      0.0
Space Manager: slave idle           607    94      2,935    4836      0.0
DIAG idle wait                    1,800   100      1,802    1001      0.0
Streams AQ: qmn coordinato          301    43        903    3001      0.0
Streams AQ: qmn slave idle          129     0        903    7001      0.0
wait for unread message on          900   100        901    1001      0.0
ASM background timer                180     0        900    5000      0.0
pmon timer                          314    91        900    2865      0.0
smon timer                           30     3        899   29983      0.0
KSV master wait                      75     0          0       0      0.0
          -------------------------------------------------------------

Wait Event Histogram             DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> Units for Total Waits column: K is 1000, M is 1000000, G is 1000000000
-> % of Waits: value of .0 indicates value was <.05%; value of null is truly 0
-> % of Waits: column heading of <=1s is truly <1024ms, >1s is truly >=1024ms
-> Ordered by Event (idle events last)

                                                    % of Waits
                                 -----------------------------------------------
                           Total
Event                      Waits  <1ms  <2ms  <4ms  <8ms <16ms <32ms  <=1s   >1s
-------------------------- ----- ----- ----- ----- ----- ----- ----- ----- -----
ADR block file read           16  75.0              12.5   6.3         6.3
ADR block file write           5  80.0  20.0
ADR file lock                  6 100.0
ASM file metadata operatio   545  96.1   2.4    .7    .4    .2          .2
CSS initialization             1                   100.0
CSS operation: action          1 100.0
CSS operation: query           6 100.0
Disk file operations I/O      78 100.0
LGWR wait for redo copy      824  99.8    .1    .1
SQL*Net message to client  1419K 100.0          .0
asynch descriptor resize      25 100.0
buffer busy waits            373  97.9    .8    .3                .5    .5
control file parallel writ   616  99.5          .5
control file sequential re  2680  91.2    .1   1.2   3.6   2.6    .4    .9
cursor: pin S                 26  80.8         3.8        15.4
db file async I/O submit    1557 100.0
db file parallel read         41               7.3  48.8  36.6   4.9   2.4
db file parallel write     25.2K  95.4    .4    .3    .4   3.4    .0    .0
db file scattered read       121  15.7   4.1   9.1  37.2  19.0   6.6   8.3
db file sequential read    521.6   2.1   2.9  19.8  49.1  18.3   4.4   3.4
direct path read              18  11.1               5.6  50.0  27.8   5.6
direct path write             12 100.0
enq: JS - queue lock           1                                     100.0
enq: TX - index contention     7        14.3        42.9  14.3  14.3  14.3
enq: TX - row lock content   679  94.0   1.8   1.2   1.0    .9    .4    .7
latch free                    74  93.2   5.4   1.4
latch: In memory undo latc   157  97.5   1.9    .6
latch: cache buffers chain   448  96.7   2.0   1.3
latch: cache buffers lru c     9 100.0
latch: checkpoint queue la     1 100.0
latch: enqueue hash chains    14 100.0
latch: messages                2 100.0
latch: object queue header    14  92.9   7.1
latch: redo allocation        11 100.0
latch: undo global data        3 100.0
library cache: mutex X        32  96.9                     3.1
log file parallel write    178.9  98.7    .3    .3    .2    .3    .2    .0
log file sequential read      44  36.4   9.1   4.5  25.0  20.5   4.5
log file single write         44 100.0
log file switch (checkpoin    73   1.4         1.4   2.7  11.0  21.9  61.6
log file switch (private s   100         1.0   2.0   8.0  14.0  48.0  27.0
log file sync              182.8  96.3   1.2    .8    .4    .8    .3    .0
os thread startup             12                                     100.0
read by other session       2744   4.9   6.1  19.7  39.9  16.5   7.5   5.2
reliable message              87 100.0
ASM background timer         181                                           100.0
DIAG idle wait              1802                                     100.0
KSV master wait               75 100.0
SQL*Net message from clien 1419K  26.8    .1    .1    .0  47.1  25.2    .6
Space Manager: slave idle    608    .2                      .2    .5    .7  98.5
Streams AQ: qmn coordinato   301  57.1                                      42.9
Streams AQ: qmn slave idle   129                                           100.0
class slave wait             235  36.2          .4   4.7   4.7  11.1  11.1  31.9
jobq slave wait              120                                     100.0
pmon timer                   315    .3                                 3.2  96.5
rdbms ipc message          184.7  21.6  14.4  20.9  22.8  14.7   2.6   1.8   1.3
smon timer                    30                                      13.3  86.7
wait for unread message on   901                                     100.0
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
ADR block file read            1  93.8   6.3
ASM file metadata operatio     1  99.8          .2
buffer busy waits              2  99.5    .5
control file sequential re    24  99.1    .2    .3    .3    .0
db file parallel read          1  97.6   2.4
db file parallel write         5 100.0    .0    .0
db file scattered read        10  91.7   5.0   2.5    .8
db file sequential read    17.6K  96.6   2.1   1.1    .2    .0
direct path read               1  94.4         5.6
enq: JS - queue lock           1       100.0
enq: TX - index contention     1  85.7  14.3
enq: TX - row lock content     5  99.3    .4    .1    .1
log file parallel write       13 100.0    .0    .0    .0
log file switch (checkpoin    45  38.4  61.6
log file switch (private s    27  73.0  27.0
log file sync                 70 100.0    .0    .0    .0
os thread startup             12       100.0
read by other session        143  94.8   3.5   1.6    .1
          -------------------------------------------------------------

Wait Event Histogram Detail (4 sec to 2 min)DB/Inst: DBM11203/DBM11203  Snaps

                  No data exists for this section of the report.
          -------------------------------------------------------------

Wait Event Histogram Detail (4 min to 1 hr)DB/Inst: DBM11203/DBM11203  Snaps:

                  No data exists for this section of the report.
          -------------------------------------------------------------

Service Statistics               DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> ordered by DB Time

                                                           Physical      Logical
Service Name                  DB Time (s)   DB CPU (s)    Reads (K)    Reads (K)
---------------------------- ------------ ------------ ------------ ------------
DBM11203.antognini.ch               6,397        1,702          520      366,686
SYS$USERS                               6            1            1            4
SYS$BACKGROUND                          0            0            2           12
          -------------------------------------------------------------

Service Wait Class Stats          DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
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
   522509      4592      1038         0         0         0   1418453         2
SYS$USERS
      491         3         0         0         0         0         0         0
SYS$BACKGROUND
     1370         9        22         0         0         0         0         0
          -------------------------------------------------------------

SQL ordered by Elapsed Time      DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> Resources reported for PL/SQL code includes the resources used by all SQL
   statements called by the code.
-> % Total DB Time is the Elapsed Time of the SQL statement divided
   into the Total Database Time multiplied by 100
-> %Total - Elapsed Time  as a percentage of Total DB time
-> %CPU   - CPU Time      as a percentage of Elapsed Time
-> %IO    - User I/O Time as a percentage of Elapsed Time
-> Captured SQL account for   95.3% of Total DB Time (s):           6,405
-> Captured PL/SQL account for    0.1% of Total DB Time (s):           6,405

        Elapsed                  Elapsed Time
        Time (s)    Executions  per Exec (s)  %Total   %CPU    %IO    SQL Id
---------------- -------------- ------------- ------ ------ ------ -------------
         1,863.0        124,882          0.01   29.1    1.7   98.6 82ud5h0qcg0bf
Module: Swingbench User Thread
select customer_id, cust_first_name ,cust_last_name ,nls_language ,nls_territory
 ,credit_limit ,cust_email ,account_mgr_id from customers where customer_id = :
1

         1,350.7          7,086          0.19   21.1   91.8    6.7 g8rhybcumtwd6
Module: Swingbench User Thread
SELECT /*+ first_rows index(customers, customers_pk) index(orders, order_status
_ix) */ o.order_id, line_item_id, product_id, unit_price, quantity, order_mode,
 order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_firs
t_name, cust_last_name, credit_limit, cust_email, order_date FROM orders o , ord

           651.8         36,852          0.02   10.2    3.2   96.9 9zd49du11u7cf
Module: Swingbench User Thread
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) values (:1 ,
 :2 , :3 , :4 )

           587.1        105,252          0.01    9.2    5.2   94.6 8vvvyuun2urt6
Module: Swingbench User Thread
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY
) values (:1 , :2 , :3 , :4 , :5 )

           527.9         36,752          0.01    8.2    2.4   97.8 d5j6fbqmu3gjp
Module: Swingbench User Thread
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_price, quantity,
 order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_i
d, cust_first_name, cust_last_name, credit_limit, cust_email FROM orders o , o
rder_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id =

           433.8        105,254          0.00    6.8    3.5   96.7 5g00dq4fxwnsw
Module: Swingbench User Thread
update inventories set quantity_on_hand = quantity_on_hand - :1 where product_i
d = :2 and warehouse_id = :3

           399.5         14,671          0.03    6.2    2.6   97.5 9bz9sa0abpc48
Module: Swingbench User Thread
insert into customers (customer_id ,cust_first_name ,cust_last_name ,nls_languag
e ,nls_territory ,credit_limit ,cust_email ,account_mgr_id ) values (:1 , :2 ,
 :3 , :4 , :5 , :6 ,:7 , :8 )

           104.4         36,853          0.00    1.6   10.4   89.4 2yp5w5a36s5xv
Module: Swingbench User Thread
update orders set order_mode = :1 , order_status = :2 , order_total = :3 where
order_id = :4

            52.4        220,441          0.00     .8   89.3     .0 gyk686gnaygs2
Module: Swingbench User Thread
select product_id, product_name, product_description, category_id, weight_class,
 supplier_id, product_status list_price, min_price, catalog_url from product_
information where category_id = :1

            44.4         36,854          0.00     .7   18.1   81.1 gfqas5ahy1x56
Module: Swingbench User Thread
SELECT o.order_id, line_item_id, product_id, unit_price, quantity, or
der_mode, order_status, order_total, sales_rep_id, promotion_id, c.cus
tomer_id, cust_first_name, cust_last_name, credit_limit, cust_email FRO
M orders o , order_items oi, customers c WHERE o.order_id = oi.order_i

          -------------------------------------------------------------

SQL ordered by CPU Time          DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> Resources reported for PL/SQL code includes the resources used by all SQL
   statements called by the code.
-> %Total - CPU Time      as a percentage of Total DB CPU
-> %CPU   - CPU Time      as a percentage of Elapsed Time
-> %IO    - User I/O Time as a percentage of Elapsed Time
-> Captured SQL account for   87.1% of Total CPU Time (s):           1,701
-> Captured PL/SQL account for    0.0% of Total CPU Time (s):           1,701

    CPU                   CPU per           Elapsed
  Time (s)  Executions    Exec (s) %Total   Time (s)   %CPU    %IO    SQL Id
---------- ------------ ---------- ------ ---------- ------ ------ -------------
   1,239.6        7,086       0.17   72.9    1,350.7   91.8    6.7 g8rhybcumtwd6
Module: Swingbench User Thread
SELECT /*+ first_rows index(customers, customers_pk) index(orders, order_status
_ix) */ o.order_id, line_item_id, product_id, unit_price, quantity, order_mode,
 order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_firs
t_name, cust_last_name, credit_limit, cust_email, order_date FROM orders o , ord

      46.8      220,441       0.00    2.7       52.4   89.3     .0 gyk686gnaygs2
Module: Swingbench User Thread
select product_id, product_name, product_description, category_id, weight_class,
 supplier_id, product_status list_price, min_price, catalog_url from product_
information where category_id = :1

      32.1      124,882       0.00    1.9    1,863.0    1.7   98.6 82ud5h0qcg0bf
Module: Swingbench User Thread
select customer_id, cust_first_name ,cust_last_name ,nls_language ,nls_territory
 ,credit_limit ,cust_email ,account_mgr_id from customers where customer_id = :
1

      30.4      105,252       0.00    1.8      587.1    5.2   94.6 8vvvyuun2urt6
Module: Swingbench User Thread
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY
) values (:1 , :2 , :3 , :4 , :5 )

      20.6       36,852       0.00    1.2      651.8    3.2   96.9 9zd49du11u7cf
Module: Swingbench User Thread
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) values (:1 ,
 :2 , :3 , :4 )

      17.0      124,883       0.00    1.0       23.3   73.0   12.3 gshgncvvtv0c6
Module: Swingbench User Thread
insert into logon values(:1 ,:2 )

      15.0      105,254       0.00    0.9      433.8    3.5   96.7 5g00dq4fxwnsw
Module: Swingbench User Thread
update inventories set quantity_on_hand = quantity_on_hand - :1 where product_i
d = :2 and warehouse_id = :3

      12.8       36,752       0.00    0.7      527.9    2.4   97.8 d5j6fbqmu3gjp
Module: Swingbench User Thread
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_price, quantity,
 order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_i
d, cust_first_name, cust_last_name, credit_limit, cust_email FROM orders o , o
rder_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id =

      11.9      109,862       0.00    0.7       12.9   92.7     .0 7v0pya6f6qc6s
Module: Swingbench User Thread
select p.product_id, product_name, product_description, category_id, weight_cla
ss, supplier_id, product_status, list_price, min_price, catalog_url, quantity_o
n_hand, warehouse_id from product_information p, inventories i where categor
y_id = :1 and i.product_id = p.product_id

      10.8      105,252       0.00    0.6       11.8   92.1    1.1 dt8dtzvsq5kj5
Module: Swingbench User Thread
select p.product_id, product_name, product_description, category_id, weight_cla
ss, supplier_id, product_status, list_price, min_price, catalog_url, quantity_
on_hand, warehouse_id from product_information p, inventories i where i.produ
ct_id = :1 and i.product_id = p.product_id

          -------------------------------------------------------------

SQL ordered by User I/O Wait TimeDB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> Resources reported for PL/SQL code includes the resources used by all SQL
   statements called by the code.
-> %Total - User I/O Time as a percentage of Total User I/O Wait time
-> %CPU   - CPU Time      as a percentage of Elapsed Time
-> %IO    - User I/O Time as a percentage of Elapsed Time
-> Captured SQL account for   99.8% of Total User I/O Wait Time (s):           4
-> Captured PL/SQL account for    0.1% of Total User I/O Wait Time (s):

  User I/O                UIO per           Elapsed
  Time (s)  Executions    Exec (s) %Total   Time (s)   %CPU    %IO    SQL Id
---------- ------------ ---------- ------ ---------- ------ ------ -------------
   1,836.5      124,882       0.01   39.9    1,863.0    1.7   98.6 82ud5h0qcg0bf
Module: Swingbench User Thread
select customer_id, cust_first_name ,cust_last_name ,nls_language ,nls_territory
 ,credit_limit ,cust_email ,account_mgr_id from customers where customer_id = :
1

     631.9       36,852       0.02   13.7      651.8    3.2   96.9 9zd49du11u7cf
Module: Swingbench User Thread
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) values (:1 ,
 :2 , :3 , :4 )

     555.6      105,252       0.01   12.1      587.1    5.2   94.6 8vvvyuun2urt6
Module: Swingbench User Thread
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY
) values (:1 , :2 , :3 , :4 , :5 )

     516.4       36,752       0.01   11.2      527.9    2.4   97.8 d5j6fbqmu3gjp
Module: Swingbench User Thread
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_price, quantity,
 order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_i
d, cust_first_name, cust_last_name, credit_limit, cust_email FROM orders o , o
rder_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id =

     419.6      105,254       0.00    9.1      433.8    3.5   96.7 5g00dq4fxwnsw
Module: Swingbench User Thread
update inventories set quantity_on_hand = quantity_on_hand - :1 where product_i
d = :2 and warehouse_id = :3

     389.6       14,671       0.03    8.5      399.5    2.6   97.5 9bz9sa0abpc48
Module: Swingbench User Thread
insert into customers (customer_id ,cust_first_name ,cust_last_name ,nls_languag
e ,nls_territory ,credit_limit ,cust_email ,account_mgr_id ) values (:1 , :2 ,
 :3 , :4 , :5 , :6 ,:7 , :8 )

      93.3       36,853       0.00    2.0      104.4   10.4   89.4 2yp5w5a36s5xv
Module: Swingbench User Thread
update orders set order_mode = :1 , order_status = :2 , order_total = :3 where
order_id = :4

      90.0        7,086       0.01    2.0    1,350.7   91.8    6.7 g8rhybcumtwd6
Module: Swingbench User Thread
SELECT /*+ first_rows index(customers, customers_pk) index(orders, order_status
_ix) */ o.order_id, line_item_id, product_id, unit_price, quantity, order_mode,
 order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_firs
t_name, cust_last_name, credit_limit, cust_email, order_date FROM orders o , ord

      36.0       36,854       0.00    0.8       44.4   18.1   81.1 gfqas5ahy1x56
Module: Swingbench User Thread
SELECT o.order_id, line_item_id, product_id, unit_price, quantity, or
der_mode, order_status, order_total, sales_rep_id, promotion_id, c.cus
tomer_id, cust_first_name, cust_last_name, credit_limit, cust_email FRO
M orders o , order_items oi, customers c WHERE o.order_id = oi.order_i

      20.4        7,082       0.00    0.4       24.0   10.1   84.9 6k3uuf3g8pwh6
Module: Swingbench User Thread
update /*+ index(orders, order_pk) */ orders set order_status = :1 where order_
id = :2

          -------------------------------------------------------------

SQL ordered by Gets              DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> Resources reported for PL/SQL code includes the resources used by all SQL
   statements called by the code.
-> %Total - Buffer Gets   as a percentage of Total Buffer Gets
-> %CPU   - CPU Time      as a percentage of Elapsed Time
-> %IO    - User I/O Time as a percentage of Elapsed Time
-> Total Buffer Gets:     366,396,963
-> Captured SQL account for   99.8% of Total

     Buffer                 Gets              Elapsed
      Gets   Executions   per Exec   %Total   Time (s)  %CPU   %IO    SQL Id
----------- ----------- ------------ ------ ---------- ----- ----- -------------
3.51655E+08       7,086     49,626.7   96.0    1,350.7  91.8   6.7 g8rhybcumtwd6
Module: Swingbench User Thread
SELECT /*+ first_rows index(customers, customers_pk) index(orders, order_status
_ix) */ o.order_id, line_item_id, product_id, unit_price, quantity, order_mode,
 order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_firs
t_name, cust_last_name, credit_limit, cust_email, order_date FROM orders o , ord

  6,619,177     220,441         30.0    1.8       52.4  89.3     0 gyk686gnaygs2
Module: Swingbench User Thread
select product_id, product_name, product_description, category_id, weight_class,
 supplier_id, product_status list_price, min_price, catalog_url from product_
information where category_id = :1

  1,398,081     105,252         13.3    0.4      587.1   5.2  94.6 8vvvyuun2urt6
Module: Swingbench User Thread
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY
) values (:1 , :2 , :3 , :4 , :5 )

    775,085     109,862          7.1    0.2       12.9  92.7     0 7v0pya6f6qc6s
Module: Swingbench User Thread
select p.product_id, product_name, product_description, category_id, weight_cla
ss, supplier_id, product_status, list_price, min_price, catalog_url, quantity_o
n_hand, warehouse_id from product_information p, inventories i where categor
y_id = :1 and i.product_id = p.product_id

    747,326     124,883          6.0    0.2       23.3    73  12.3 gshgncvvtv0c6
Module: Swingbench User Thread
insert into logon values(:1 ,:2 )

    743,176     105,252          7.1    0.2       11.8  92.1   1.1 dt8dtzvsq5kj5
Module: Swingbench User Thread
select p.product_id, product_name, product_description, category_id, weight_cla
ss, supplier_id, product_status, list_price, min_price, catalog_url, quantity_
on_hand, warehouse_id from product_information p, inventories i where i.produ
ct_id = :1 and i.product_id = p.product_id

    699,930      36,852         19.0    0.2      651.8   3.2  96.9 9zd49du11u7cf
Module: Swingbench User Thread
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) values (:1 ,
 :2 , :3 , :4 )

    500,271     124,882          4.0    0.1    1,863.0   1.7  98.6 82ud5h0qcg0bf
Module: Swingbench User Thread
select customer_id, cust_first_name ,cust_last_name ,nls_language ,nls_territory
 ,credit_limit ,cust_email ,account_mgr_id from customers where customer_id = :
1

    487,652      36,854         13.2    0.1       44.4  18.1  81.1 gfqas5ahy1x56
Module: Swingbench User Thread
SELECT o.order_id, line_item_id, product_id, unit_price, quantity, or
der_mode, order_status, order_total, sales_rep_id, promotion_id, c.cus
tomer_id, cust_first_name, cust_last_name, credit_limit, cust_email FRO
M orders o , order_items oi, customers c WHERE o.order_id = oi.order_i

    412,977     105,254          3.9    0.1      433.8   3.5  96.7 5g00dq4fxwnsw
Module: Swingbench User Thread
update inventories set quantity_on_hand = quantity_on_hand - :1 where product_i
d = :2 and warehouse_id = :3

          -------------------------------------------------------------

SQL ordered by Reads             DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> %Total - Physical Reads as a percentage of Total Disk Reads
-> %CPU   - CPU Time      as a percentage of Elapsed Time
-> %IO    - User I/O Time as a percentage of Elapsed Time
-> Total Disk Reads:         522,880
-> Captured SQL account for   99.7% of Total

   Physical              Reads              Elapsed
      Reads  Executions per Exec   %Total   Time (s)   %CPU    %IO    SQL Id
----------- ----------- ---------- ------ ---------- ------ ------ -------------
    194,859     124,882        1.6   37.3    1,863.0    1.7   98.6 82ud5h0qcg0bf
Module: Swingbench User Thread
select customer_id, cust_first_name ,cust_last_name ,nls_language ,nls_territory
 ,credit_limit ,cust_email ,account_mgr_id from customers where customer_id = :
1

     70,671      36,852        1.9   13.5      651.8    3.2   96.9 9zd49du11u7cf
Module: Swingbench User Thread
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) values (:1 ,
 :2 , :3 , :4 )

     68,008     105,252        0.6   13.0      587.1    5.2   94.6 8vvvyuun2urt6
Module: Swingbench User Thread
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY
) values (:1 , :2 , :3 , :4 , :5 )

     65,599      36,752        1.8   12.5      527.9    2.4   97.8 d5j6fbqmu3gjp
Module: Swingbench User Thread
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_price, quantity,
 order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_i
d, cust_first_name, cust_last_name, credit_limit, cust_email FROM orders o , o
rder_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id =

     48,065     105,254        0.5    9.2      433.8    3.5   96.7 5g00dq4fxwnsw
Module: Swingbench User Thread
update inventories set quantity_on_hand = quantity_on_hand - :1 where product_i
d = :2 and warehouse_id = :3

     47,096      14,671        3.2    9.0      399.5    2.6   97.5 9bz9sa0abpc48
Module: Swingbench User Thread
insert into customers (customer_id ,cust_first_name ,cust_last_name ,nls_languag
e ,nls_territory ,credit_limit ,cust_email ,account_mgr_id ) values (:1 , :2 ,
 :3 , :4 , :5 , :6 ,:7 , :8 )

     11,197      36,853        0.3    2.1      104.4   10.4   89.4 2yp5w5a36s5xv
Module: Swingbench User Thread
update orders set order_mode = :1 , order_status = :2 , order_total = :3 where
order_id = :4

      7,773       7,086        1.1    1.5    1,350.7   91.8    6.7 g8rhybcumtwd6
Module: Swingbench User Thread
SELECT /*+ first_rows index(customers, customers_pk) index(orders, order_status
_ix) */ o.order_id, line_item_id, product_id, unit_price, quantity, order_mode,
 order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_firs
t_name, cust_last_name, credit_limit, cust_email, order_date FROM orders o , ord

      4,354      36,854        0.1    0.8       44.4   18.1   81.1 gfqas5ahy1x56
Module: Swingbench User Thread
SELECT o.order_id, line_item_id, product_id, unit_price, quantity, or
der_mode, order_status, order_total, sales_rep_id, promotion_id, c.cus
tomer_id, cust_first_name, cust_last_name, credit_limit, cust_email FRO
M orders o , order_items oi, customers c WHERE o.order_id = oi.order_i

      1,942       7,082        0.3    0.4       24.0   10.1   84.9 6k3uuf3g8pwh6
Module: Swingbench User Thread
update /*+ index(orders, order_pk) */ orders set order_status = :1 where order_
id = :2

          -------------------------------------------------------------

SQL ordered by Physical Reads (UnOptimized)DB/Inst: DBM11203/DBM11203  Snaps:
-> UnOptimized Read Reqs = Physical Read Reqts - Optimized Read Reqs
-> %Opt   - Optimized Reads as percentage of SQL Read Requests
-> %Total - UnOptimized Read Reqs as a percentage of Total UnOptimized Read Reqs
-> Total Physical Read Requests:         521,753
-> Captured SQL account for   91.8% of Total
-> Total UnOptimized Read Requests:         521,753
-> Captured SQL account for   91.8% of Total
-> Total Optimized Read Requests:               1
-> Captured SQL account for    0.0% of Total

UnOptimized   Physical              UnOptimized
  Read Reqs   Read Reqs Executions Reqs per Exe   %Opt %Total    SQL Id
----------- ----------- ---------- ------------ ------ ------ -------------
    194,866     194,866    124,882          1.6    0.0   37.3 82ud5h0qcg0bf
Module: Swingbench User Thread
select customer_id, cust_first_name ,cust_last_name ,nls_language ,nls_territory
 ,credit_limit ,cust_email ,account_mgr_id from customers where customer_id = :
1

     70,673      70,673     36,852          1.9    0.0   13.5 9zd49du11u7cf
Module: Swingbench User Thread
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) values (:1 ,
 :2 , :3 , :4 )

     68,010      68,010    105,252          0.6    0.0   13.0 8vvvyuun2urt6
Module: Swingbench User Thread
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY
) values (:1 , :2 , :3 , :4 , :5 )

     65,598      65,598     36,752          1.8    0.0   12.6 d5j6fbqmu3gjp
Module: Swingbench User Thread
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_price, quantity,
 order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_i
d, cust_first_name, cust_last_name, credit_limit, cust_email FROM orders o , o
rder_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id =

     48,066      48,066    105,254          0.5    0.0    9.2 5g00dq4fxwnsw
Module: Swingbench User Thread
update inventories set quantity_on_hand = quantity_on_hand - :1 where product_i
d = :2 and warehouse_id = :3

     11,197      11,197     36,853          0.3    0.0    2.1 2yp5w5a36s5xv
Module: Swingbench User Thread
update orders set order_mode = :1 , order_status = :2 , order_total = :3 where
order_id = :4

      7,777       7,777      7,086          1.1    0.0    1.5 g8rhybcumtwd6
Module: Swingbench User Thread
SELECT /*+ first_rows index(customers, customers_pk) index(orders, order_status
_ix) */ o.order_id, line_item_id, product_id, unit_price, quantity, order_mode,
 order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_firs
t_name, cust_last_name, credit_limit, cust_email, order_date FROM orders o , ord

      5,680       5,680     14,671          0.4    0.0    1.1 9bz9sa0abpc48
Module: Swingbench User Thread
insert into customers (customer_id ,cust_first_name ,cust_last_name ,nls_languag
e ,nls_territory ,credit_limit ,cust_email ,account_mgr_id ) values (:1 , :2 ,
 :3 , :4 , :5 , :6 ,:7 , :8 )

      4,354       4,354     36,854          0.1    0.0    0.8 gfqas5ahy1x56
Module: Swingbench User Thread
SELECT o.order_id, line_item_id, product_id, unit_price, quantity, or
der_mode, order_status, order_total, sales_rep_id, promotion_id, c.cus
tomer_id, cust_first_name, cust_last_name, credit_limit, cust_email FRO
M orders o , order_items oi, customers c WHERE o.order_id = oi.order_i

      1,942       1,942      7,082          0.3    0.0    0.4 6k3uuf3g8pwh6
Module: Swingbench User Thread
update /*+ index(orders, order_pk) */ orders set order_status = :1 where order_
id = :2

          -------------------------------------------------------------

SQL ordered by Executions        DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> %CPU   - CPU Time      as a percentage of Elapsed Time
-> %IO    - User I/O Time as a percentage of Elapsed Time
-> Total Executions:       1,230,380
-> Captured SQL account for   99.9% of Total

                                              Elapsed
 Executions   Rows Processed  Rows per Exec   Time (s)  %CPU   %IO    SQL Id
------------ --------------- -------------- ---------- ----- ----- -------------
     220,441       1,109,622            5.0       52.4  89.3     0 gyk686gnaygs2
Module: Swingbench User Thread
select product_id, product_name, product_description, category_id, weight_class,
 supplier_id, product_status list_price, min_price, catalog_url from product_
information where category_id = :1

     124,883         124,881            1.0       23.3    73  12.3 gshgncvvtv0c6
Module: Swingbench User Thread
insert into logon values(:1 ,:2 )

     124,882         124,877            1.0    1,863.0   1.7  98.6 82ud5h0qcg0bf
Module: Swingbench User Thread
select customer_id, cust_first_name ,cust_last_name ,nls_language ,nls_territory
 ,credit_limit ,cust_email ,account_mgr_id from customers where customer_id = :
1

     109,862       1,098,610           10.0       12.9  92.7     0 7v0pya6f6qc6s
Module: Swingbench User Thread
select p.product_id, product_name, product_description, category_id, weight_cla
ss, supplier_id, product_status, list_price, min_price, catalog_url, quantity_o
n_hand, warehouse_id from product_information p, inventories i where categor
y_id = :1 and i.product_id = p.product_id

     105,254          94,702            0.9      433.8   3.5  96.7 5g00dq4fxwnsw
Module: Swingbench User Thread
update inventories set quantity_on_hand = quantity_on_hand - :1 where product_i
d = :2 and warehouse_id = :3

     105,252         105,252            1.0      587.1   5.2  94.6 8vvvyuun2urt6
Module: Swingbench User Thread
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY
) values (:1 , :2 , :3 , :4 , :5 )

     105,252       1,052,500           10.0       11.8  92.1   1.1 dt8dtzvsq5kj5
Module: Swingbench User Thread
select p.product_id, product_name, product_description, category_id, weight_cla
ss, supplier_id, product_status, list_price, min_price, catalog_url, quantity_
on_hand, warehouse_id from product_information p, inventories i where i.produ
ct_id = :1 and i.product_id = p.product_id

     105,251         105,250            1.0        7.7  93.2     0 982zxphp8ht6c
Module: Swingbench User Thread
select product_id, product_name, product_description, category_id, weight_class,
 supplier_id, product_status, list_price, min_price, catalog_url from product_i
nformation where product_id = :1

      36,854         105,235            2.9       44.4  18.1  81.1 gfqas5ahy1x56
Module: Swingbench User Thread
SELECT o.order_id, line_item_id, product_id, unit_price, quantity, or
der_mode, order_status, order_total, sales_rep_id, promotion_id, c.cus
tomer_id, cust_first_name, cust_last_name, credit_limit, cust_email FRO
M orders o , order_items oi, customers c WHERE o.order_id = oi.order_i

      36,853          36,853            1.0      104.4  10.4  89.4 2yp5w5a36s5xv
Module: Swingbench User Thread
update orders set order_mode = :1 , order_status = :2 , order_total = :3 where
order_id = :4

      36,852          36,852            1.0      651.8   3.2  96.9 9zd49du11u7cf
Module: Swingbench User Thread
SQL ordered by Executions        DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> %CPU   - CPU Time      as a percentage of Elapsed Time
-> %IO    - User I/O Time as a percentage of Elapsed Time
-> Total Executions:       1,230,380
-> Captured SQL account for   99.9% of Total

                                              Elapsed
 Executions   Rows Processed  Rows per Exec   Time (s)  %CPU   %IO    SQL Id
------------ --------------- -------------- ---------- ----- ----- -------------
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) values (:1 ,
 :2 , :3 , :4 )

      36,848          36,848            1.0        3.4  88.3   2.8 8uk8bquk453q8
Module: Swingbench User Thread
select orders_seq.nextval from dual

      36,752          34,058            0.9      527.9   2.4  97.8 d5j6fbqmu3gjp
Module: Swingbench User Thread
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_price, quantity,
 order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_i
d, cust_first_name, cust_last_name, credit_limit, cust_email FROM orders o , o
rder_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id =

      14,671          14,671            1.0        1.3  89.8     0 5d8b4p888x97a
Module: Swingbench User Thread
select customer_seq.nextval from dual

      14,671          14,671            1.0      399.5   2.6  97.5 9bz9sa0abpc48
Module: Swingbench User Thread
insert into customers (customer_id ,cust_first_name ,cust_last_name ,nls_languag
e ,nls_territory ,credit_limit ,cust_email ,account_mgr_id ) values (:1 , :2 ,
 :3 , :4 , :5 , :6 ,:7 , :8 )

          -------------------------------------------------------------

SQL ordered by Parse Calls       DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> Total Parse Calls:             492
-> Captured SQL account for   47.4% of Total

                            % Total
 Parse Calls  Executions     Parses    SQL Id
------------ ------------ --------- -------------
         134          134     27.24 350f5yrnnmshs
lock table sys.mon_mods$ in exclusive mode nowait

           7           88      1.42 bsa0wjtftg3uw
select file# from file$ where ts#=:1

           5           10      1.02 0kkhhb2w93cx0
update seg$ set type#=:4,blocks=:5,extents=:6,minexts=:7,maxexts=:8,extsize=:9,e
xtpct=:10,user#=:11,iniexts=:12,lists=decode(:13, 65535, NULL, :13),groups=decod
e(:14, 65535, NULL, :14), cachehint=:15, hwmincr=:16, spare1=DECODE(:17,0,NULL,:
17),scanhint=:18, bitmapranges=:19 where ts#=:1 and file#=:2 and block#=:3

           4            4      0.81 b2gnxm5z6r51n
lock table sys.col_usage$ in exclusive mode nowait

           2            2      0.41 1gfaj4z5hn1kf
delete from dependency$ where d_obj#=:1

           2            2      0.41 20vv6ttajyjzq
delete from access$ where d_obj#=:1

           2            2      0.41 2pff93c8c626v
select name, address, protocol, subscriber_type, subscriber_id from "SYS"."AQ$_
SCHEDULER$_EVENT_QTAB_S" where queue_name = :1 and (bitand(subscriber_type, 40
96) = 4096)

           2           10      0.41 4m7m0t6fjcs5x
update seq$ set increment$=:2,minvalue=:3,maxvalue=:4,cycle#=:5,order$=:6,cache=
:7,highwater=:8,audit$=:9,flags=:10 where obj#=:1

           2            2      0.41 6abthk1u14yb7
SELECT VERSION FROM V$INSTANCE

           2           12      0.41 6xvp6nxs4a9n4
select nvl(sum(space),0) from recyclebin$ where ts# = :1

          -------------------------------------------------------------

SQL ordered by Sharable Memory   DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823

                  No data exists for this section of the report.
          -------------------------------------------------------------

SQL ordered by Version Count     DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823

                  No data exists for this section of the report.
          -------------------------------------------------------------

Instance Activity Stats          DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> Ordered by statistic name

Statistic                                     Total     per Second     per Trans
-------------------------------- ------------------ -------------- -------------
Batched IO (bound) vector count                 451            0.5           0.0
Batched IO (full) vector count                    0            0.0           0.0
Batched IO block miss count                     643            0.7           0.0
Batched IO buffer defrag count                    7            0.0           0.0
Batched IO double miss count                     90            0.1           0.0
Batched IO same unit count                      223            0.3           0.0
Batched IO single block count                   481            0.5           0.0
Batched IO vector block count                   123            0.1           0.0
Batched IO vector read count                     60            0.1           0.0
Block Cleanout Optim referenced               3,558            4.0           0.0
CCursor + sql area evicted                        0            0.0           0.0
CPU used by this session                    162,156          179.9           0.9
CPU used when call started                  162,045          179.7           0.9
CR blocks created                            43,727           48.5           0.2
Cached Commit SCN referenced                 34,730           38.5           0.2
Commit SCN cached                             6,504            7.2           0.0
DB time                                     641,440          711.5           3.5
DBWR checkpoint buffers written              49,337           54.7           0.3
DBWR checkpoints                                 11            0.0           0.0
DBWR thread checkpoint buffers w             49,337           54.7           0.3
DBWR transaction table writes                   218            0.2           0.0
DBWR undo block writes                       16,336           18.1           0.1
HSC Heap Segment Block Changes              421,099          467.1           2.3
Heap Segment Array Inserts                      169            0.2           0.0
Heap Segment Array Updates                       15            0.0           0.0
IMU CR rollbacks                             13,396           14.9           0.1
IMU Flushes                                  23,259           25.8           0.1
IMU Redo allocation size                116,746,320      129,495.1         636.1
IMU commits                                 154,026          170.9           0.8
IMU contention                               19,872           22.0           0.1
IMU pool not allocated                        6,258            6.9           0.0
IMU recursive-transaction flush                   0            0.0           0.0
IMU undo allocation size                373,604,528      414,402.5       2,035.6
IMU- failed to get a private str              6,258            6.9           0.0
LOB table id lookup cache misses                  0            0.0           0.0
PX local messages recv'd                          0            0.0           0.0
PX local messages sent                            0            0.0           0.0
Requests to/from client                   1,418,864        1,573.8           7.7
RowCR - row contention                          231            0.3           0.0
RowCR attempts                              112,607          124.9           0.6
RowCR hits                                  111,471          123.6           0.6
SMON posted for undo segment shr                 24            0.0           0.0
SQL*Net roundtrips to/from clien          1,418,872        1,573.8           7.7
active txn count during cleanout             55,655           61.7           0.3
application wait time                            80            0.1           0.0
background checkpoints completed                 11            0.0           0.0
background checkpoints started                   11            0.0           0.0
background timeouts                           4,682            5.2           0.0
branch node splits                                3            0.0           0.0
buffer is not pinned count              177,662,097      197,062.9         968.0
buffer is pinned count                  179,300,974      198,880.8         976.9
bytes received via SQL*Net from         346,648,249      384,502.5       1,888.7
bytes sent via SQL*Net to client        767,717,895      851,553.3       4,182.9
calls to get snapshot scn: kcmgs          1,133,782        1,257.6           6.2
calls to kcmgas                             235,694          261.4           1.3
calls to kcmgcs                             726,676          806.0           4.0
cell physical IO interconnect by      7,982,754,816    8,854,478.2      43,494.2
change write time                             1,300            1.4           0.0
cleanout - number of ktugct call             32,874           36.5           0.2
cleanouts and rollbacks - consis             23,363           25.9           0.1
Instance Activity Stats          DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> Ordered by statistic name

Statistic                                     Total     per Second     per Trans
-------------------------------- ------------------ -------------- -------------
cleanouts only - consistent read              1,731            1.9           0.0
cluster key scan block gets                      60            0.1           0.0
cluster key scans                                60            0.1           0.0
commit batch/immediate performed                 18            0.0           0.0
commit batch/immediate requested                 18            0.0           0.0
commit cleanout failures: buffer                  9            0.0           0.0
commit cleanout failures: callba                 94            0.1           0.0
commit cleanout failures: cannot              4,927            5.5           0.0
commit cleanouts                            757,256          840.0           4.1
commit cleanouts successfully co            752,226          834.4           4.1
commit immediate performed                       18            0.0           0.0
commit immediate requested                       18            0.0           0.0
commit txn count during cleanout             47,753           53.0           0.3
concurrency wait time                            86            0.1           0.0
consistent changes                          100,357          111.3           0.6
consistent gets                         362,913,878      402,544.4       1,977.3
consistent gets - examination           236,188,959      261,981.0       1,286.9
consistent gets direct                            0            0.0           0.0
consistent gets from cache              362,913,875      402,544.4       1,977.3
consistent gets from cache (fast        126,504,818      140,319.3         689.3
cursor authentications                            5            0.0           0.0
data blocks consistent reads - u             90,673          100.6           0.5
db block changes                          2,549,313        2,827.7          13.9
db block gets                             3,483,003        3,863.4          19.0
db block gets direct                             27            0.0           0.0
db block gets from cache                  3,482,976        3,863.3          19.0
db block gets from cache (fastpa          1,190,104        1,320.1           6.5
deferred (CURRENT) block cleanou            265,326          294.3           1.5
dirty buffers inspected                     209,279          232.1           1.1
enqueue conversions                             579            0.6           0.0
enqueue releases                            443,391          491.8           2.4
enqueue requests                            443,403          491.8           2.4
enqueue timeouts                                  0            0.0           0.0
enqueue waits                                   691            0.8           0.0
execute count                             1,230,380        1,364.7           6.7
file io service time                              0            0.0           0.0
file io wait time                     8,599,511,451    9,538,585.2      46,854.6
free buffer inspected                       568,832          631.0           3.1
free buffer requested                       584,574          648.4           3.2
heap block compress                             576            0.6           0.0
hot buffers moved to head of LRU            267,499          296.7           1.5
immediate (CR) block cleanout ap             25,094           27.8           0.1
immediate (CURRENT) block cleano             29,435           32.7           0.2
in call idle wait time                    2,633,490        2,921.1          14.4
index crx upgrade (positioned)                    0            0.0           0.0
index fast full scans (full)                      2            0.0           0.0
index fetch by key                       58,944,680       65,381.5         321.2
index scans kdiixs1                      58,760,496       65,177.2         320.2
leaf node 90-10 splits                           20            0.0           0.0
leaf node splits                              1,611            1.8           0.0
lob reads                                         0            0.0           0.0
lob writes                                       80            0.1           0.0
lob writes unaligned                             80            0.1           0.0
logical read bytes from cache     3,001,522,946,048 3.32929172E+09  16,353,864.9
logons cumulative                                13            0.0           0.0
max cf enq hold time                             10            0.0           0.0
messages received                           207,981          230.7           1.1
messages sent                               207,981          230.7           1.1
min active SCN optimization appl            159,883          177.3           0.9
no buffer to keep pinned count                    0            0.0           0.0
Instance Activity Stats          DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> Ordered by statistic name

Statistic                                     Total     per Second     per Trans
-------------------------------- ------------------ -------------- -------------
no work - consistent read gets          125,842,864      139,585.0         685.7
non-idle wait count                       2,527,015        2,803.0          13.8
non-idle wait time                          476,964          529.1           2.6
opened cursors cumulative                 1,230,072        1,364.4           6.7
parse count (describe)                            0            0.0           0.0
parse count (failures)                            0            0.0           0.0
parse count (hard)                                5            0.0           0.0
parse count (total)                             492            0.6           0.0
parse time cpu                                1,883            2.1           0.0
parse time elapsed                            1,806            2.0           0.0
physical read IO requests                   521,753          578.7           2.8
physical read bytes                   4,283,432,960    4,751,187.4      23,338.4
physical read total IO requests             524,482          581.8           2.9
physical read total bytes             4,327,405,568    4,799,961.8      23,578.0
physical read total multi block                   5            0.0           0.0
physical reads                              522,880          580.0           2.9
physical reads cache                        522,825          579.9           2.9
physical reads cache prefetch                 1,170            1.3           0.0
physical reads direct                            55            0.1           0.0
physical reads direct temporary                   0            0.0           0.0
physical reads prefetch warmup                    0            0.0           0.0
physical write IO requests                  236,463          262.3           1.3
physical write bytes                  2,788,556,800    3,093,069.5      15,193.5
physical write total IO requests            597,121          662.3           3.3
physical write total bytes            3,655,349,248    4,054,516.4      19,916.3
physical write total multi block              1,099            1.2           0.0
physical writes                             340,400          377.6           1.9
physical writes direct                           82            0.1           0.0
physical writes direct (lob)                      0            0.0           0.0
physical writes direct temporary                  0            0.0           0.0
physical writes from cache                  340,318          377.5           1.9
physical writes non checkpoint              268,955          298.3           1.5
pinned buffers inspected                         39            0.0           0.0
prefetch warmup blocks aged out                   0            0.0           0.0
prefetched blocks aged out befor                  1            0.0           0.0
process last non-idle time                        0            0.0           0.0
recovery blocks read                              0            0.0           0.0
recursive calls                             193,830          215.0           1.1
recursive cpu usage                           1,536            1.7           0.0
redo KB read                                      0            0.0           0.0
redo blocks checksummed by FG (e            292,518          324.5           1.6
redo blocks read for recovery                     0            0.0           0.0
redo blocks written                         826,743          917.0           4.5
redo buffer allocation retries                  174            0.2           0.0
redo entries                                649,827          720.8           3.5
redo k-bytes read for recovery                    0            0.0           0.0
redo log space requests                         176            0.2           0.0
redo log space wait time                        497            0.6           0.0
redo ordering marks                           6,115            6.8           0.0
redo size                               354,549,884      393,267.0       1,931.8
redo size for direct writes                     208            0.2           0.0
redo subscn max counts                       16,125           17.9           0.1
redo synch long waits                           187            0.2           0.0
redo synch time                               9,601           10.7           0.1
redo synch time (usec)                   96,015,263      106,500.2         523.1
redo synch writes                           183,545          203.6           1.0
redo wastage                             55,374,424       61,421.4         301.7
redo write time                               5,260            5.8           0.0
redo writes                                 178,894          198.4           1.0
rollback changes - undo records                  48            0.1           0.0
Instance Activity Stats          DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> Ordered by statistic name

Statistic                                     Total     per Second     per Trans
-------------------------------- ------------------ -------------- -------------
rollbacks only - consistent read             19,770           21.9           0.1
rows fetched via callback                58,794,764       65,215.2         320.3
session connect time                              0            0.0           0.0
session logical reads                   366,396,963      406,407.8       1,996.3
shared hash latch upgrades - no             309,676          343.5           1.7
shared hash latch upgrades - wai                 30            0.0           0.0
sorts (memory)                                  445            0.5           0.0
sorts (rows)                                 16,322           18.1           0.1
sql area evicted                                  0            0.0           0.0
sql area purged                                   0            0.0           0.0
summed dirty queue length                 1,935,798        2,147.2          10.6
switch current to new buffer                    342            0.4           0.0
table fetch by rowid                    119,629,777      132,693.5         651.8
table fetch continued row                         0            0.0           0.0
table scan blocks gotten                  6,180,629        6,855.6          33.7
table scan rows gotten                  220,747,132      244,852.9       1,202.8
table scans (long tables)                         0            0.0           0.0
table scans (short tables)                  220,455          244.5           1.2
temp space allocated (bytes)                      0            0.0           0.0
total cf enq hold time                        3,250            3.6           0.0
total number of cf enq holders                   79            0.1           0.0
total number of times SMON poste                 28            0.0           0.0
transaction rollbacks                            15            0.0           0.0
undo change vector size                 119,248,856      132,270.9         649.7
user I/O wait time                          460,683          511.0           2.5
user calls                                2,611,214        2,896.4          14.2
user commits                                183,536          203.6           1.0
workarea executions - optimal                   274            0.3           0.0
write clones created in foregrou                123            0.1           0.0
          -------------------------------------------------------------

Instance Activity Stats - Absolute ValuesDB/Inst: DBM11203/DBM11203  Snaps: 1
-> Statistics with absolute values (should not be diffed)

Statistic                            Begin Value       End Value
-------------------------------- --------------- ---------------
logons current                                58              59
session uga memory max               276,205,016     302,141,872
session pga memory                   173,079,824     178,701,104
session pga memory max               315,033,488     327,256,848
session cursor cache count                 2,445           2,661
session uga memory                30,094,017,224  34,389,911,968
opened cursors current                        89              90
          -------------------------------------------------------------

Instance Activity Stats - Thread ActivityDB/Inst: DBM11203/DBM11203  Snaps: 18
-> Statistics identified by '(derived)' come from sources other than SYSSTAT

Statistic                                     Total  per Hour
-------------------------------- ------------------ ---------
log switches (derived)                           11     43.92
          -------------------------------------------------------------

IOStat by Function summary        DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> 'Data' columns suffixed with M,G,T,P are in multiples of 1024
    other columns suffixed with K,M,G,T,P are in multiples of 1000
-> ordered by (Data Read + Write) desc

                Reads:   Reqs   Data    Writes:  Reqs   Data    Waits:    Avg
Function Name   Data    per sec per sec Data    per sec per sec Count    Tm(ms)
--------------- ------- ------- ------- ------- ------- ------- ------- -------
Buffer Cache Re      4G   578.8 4.53108      0M     0.0      0M  521.8K     8.3
DBWR                 0M     0.0      0M    2.6G   262.2 2.94936       0     N/A
LGWR                 5M     0.4 .005546    811M   399.0 .899561  179.4K     0.1
Others              38M     2.7 .042149     16M     1.1 .017747    2900     1.5
Direct Reads         1M     0.1 .001109      0M     0.0      0M       0     N/A
Streams AQ           1M     0.0 .001109      0M     0.0      0M       8     5.8
Direct Writes        0M     0.0      0M      0M     0.0      0M       0     N/A
TOTAL:               4G   581.9 4.58099    3.4G   662.4 3.86667  704.1K     6.2
          -------------------------------------------------------------

IOStat by Filetype summary        DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> 'Data' columns suffixed with M,G,T,P are in multiples of 1024
    other columns suffixed with K,M,G,T,P are in multiples of 1000
-> Small Read and Large Read are average service times, in milliseconds
-> Ordered by (Data Read + Write) desc

                Reads:   Reqs   Data    Writes:  Reqs   Data      Small   Large
Filetype Name   Data    per sec per sec Data    per sec per sec    Read    Read
--------------- ------- ------- ------- ------- ------- ------- ------- -------
Data File            4G   578.9 4.53219    2.6G   262.3 2.95047     8.3    20.2
Log File             0M     0.0      0M    808M   398.8 .896234     4.9     N/A
Control File        42M     3.0 .046586     19M     1.4 .021074     1.8     N/A
Temp File            0M     0.0      0M      0M     0.0      0M    11.0     N/A
TOTAL:               4G   581.9 4.57878    3.4G   662.4 3.86778     8.3    20.2
          -------------------------------------------------------------

IOStat by Function/Filetype summaryDB/Inst: DBM11203/DBM11203  Snaps: 1822-182
-> 'Data' columns suffixed with M,G,T,P are in multiples of 1024
    other columns suffixed with K,M,G,T,P are in multiples of 1000
-> Ordered by (Data Read + Write) desc for each function

 Reads:   Reqs   Data    Writes:  Reqs   Data    Waits:    Avg
 Data    per sec per sec Data    per sec per sec Count    Tm(ms)
 ------- ------- ------- ------- ------- ------- ------- -------
Buffer Cache Reads
      4G   578.7 4.52997      0M     0.0      0M  521.7K     8.3
 Buffer Cache Reads (Data File)
      4G   578.7 4.52997      0M     0.0      0M  521.7K     8.3
DBWR
      0M     0.0      0M    2.6G   262.2 2.94936       0     N/A
 DBWR (Data File)
      0M     0.0      0M    2.6G   262.2 2.94936       0     N/A
LGWR
      5M     0.4 .005546    811M   399.0 .899561     368     2.1
 LGWR (Log File)
      0M     0.0      0M    808M   398.7 .896234      88     2.5
 LGWR (Control File)
      5M     0.3 .005546      3M     0.3 .003327     280     2.0
Others
     37M     2.7 .041040     16M     1.1 .017747    2405     1.8
 Others (Control File)
     37M     2.7 .041040     16M     1.1 .017747    2400     1.8
 Others (Data File)
      0M     0.0      0M      0M     0.0      0M       5     4.4
Direct Reads
      1M     0.1 .001109      0M     0.0      0M       0     N/A
 Direct Reads (Data File)
      1M     0.1 .001109      0M     0.0      0M       0     N/A
Streams AQ
      1M     0.0 .001109      0M     0.0      0M       8     5.8
 Streams AQ (Data File)
      1M     0.0 .001109      0M     0.0      0M       8     5.8
Direct Writes
      0M     0.0      0M      0M     0.0      0M       0     N/A
 Direct Writes (Data File)
      0M     0.0      0M      0M     0.0      0M       0     N/A
TOTAL:
      4G   581.8 4.57878    3.4G   662.4 3.86667  524.4K     8.3
          -------------------------------------------------------------

Tablespace IO Stats              DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> ordered by IOs (Reads + Writes) desc

Tablespace
------------------------------
                 Av       Av     Av                       Av     Buffer  Av Buf
         Reads Reads/s  Rd(ms) Blks/Rd       Writes Writes/s      Waits  Wt(ms)
-------------- ------- ------- ------- ------------ -------- ---------- -------
SOE
       519,831     577     8.8     1.0      234,576      260      3,270     8.4
SYSAUX
         1,475       2     6.4     1.4          502        1          0     0.0
UNDOTBS1
            83       0     6.0     1.0        1,363        2         52     0.2
SYSTEM
           230       0    10.5     3.3           26        0          1     0.0
USERS
            11       0     0.0     1.0           11        0          0     0.0
TEMP
             2       0    10.0     1.0            0        0          0     0.0
          -------------------------------------------------------------

File IO Stats                    DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> ordered by Tablespace, File

Tablespace               Filename
------------------------ ----------------------------------------------------
                 Av       Av     Av                       Av     Buffer  Av Buf
         Reads Reads/s  Rd(ms) Blks/Rd       Writes Writes/s      Waits  Wt(ms)
-------------- ------- ------- ------- ------------ -------- ---------- -------
SOE                      +DATA/dbm11203/datafile/soe.486.836957131
       519,831     577     8.8     1.0      234,576      260      3,270     8.4
SYSAUX                   +DATA/dbm11203/datafile/sysaux.460.772715927
         1,475       2     6.4     1.4          502        1          0     0.0
SYSTEM                   +DATA/dbm11203/datafile/system.459.772715923
           230       0    10.5     3.3           26        0          1     0.0
TEMP                     +DATA/dbm11203/tempfile/temp.462.772715931
             2       0    10.0     1.0            0        0          0     N/A
UNDOTBS1                 +DATA/dbm11203/datafile/undotbs1.461.772715929
            83       0     6.0     1.0        1,363        2         52     0.2
USERS                    +DATA/dbm11203/datafile/users.463.772715939
            11       0     0.0     1.0           11        0          0     0.0
          -------------------------------------------------------------

Buffer Pool Statistics           DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> Standard block size Pools  D: default,  K: keep,  R: recycle
-> Default Pools for other block sizes: 2k, 4k, 8k, 16k, 32k

                                                            Free   Writ   Buffer
     Number of Pool       Buffer     Physical    Physical   Buff   Comp     Busy
P      Buffers Hit%         Gets        Reads      Writes   Wait   Wait    Waits
--- ---------- ---- ------------ ------------ ----------- ------ ------ --------
D       89,362  100  365,315,273      522,788     340,346      0      0    3,322
          -------------------------------------------------------------

Checkpoint Activity               DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> Total Physical Writes:                      340,400

                                          Other    Autotune      Thread
       MTTR    Log Size    Log Ckpt    Settings        Ckpt        Ckpt
     Writes      Writes      Writes      Writes      Writes      Writes
----------- ----------- ----------- ----------- ----------- -----------
          0      40,910           0           0           0       8,366
          -------------------------------------------------------------

Instance Recovery Stats           DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> B: Begin Snapshot,  E: End Snapshot

                                                                            Estd
  Targt  Estd                                     Log Ckpt Log Ckpt    Opt   RAC
  MTTR   MTTR Recovery  Actual   Target   Log Sz   Timeout Interval    Log Avail
   (s)    (s) Estd IOs RedoBlks RedoBlks RedoBlks RedoBlks RedoBlks  Sz(M)  Time
- ----- ----- -------- -------- -------- -------- -------- -------- ------ -----
B     0    19    20987   167937   165888   165888   445422      N/A    N/A   N/A
E     0    19    21454   167685   165888   165888   384637      N/A    N/A   N/A
          -------------------------------------------------------------

MTTR Advisory                           DB/Inst: DBM11203/DBM11203  Snap: 1823

                  No data exists for this section of the report.
          -------------------------------------------------------------

Buffer Pool Advisory                    DB/Inst: DBM11203/DBM11203  Snap: 1823
-> Only rows with estimated physical reads >0 are displayed
-> ordered by Block Size, Buffers For Estimate

                                    Est
                                   Phys      Estimated                  Est
    Size for   Size      Buffers   Read     Phys Reads     Est Phys %DBtime
P    Est (M) Factor  (thousands) Factor    (thousands)    Read Time for Rds
--- -------- ------ ------------ ------ -------------- ------------ -------
D         72     .1            9  347.4      1,573,046            1 1.5E+07
D        144     .2           18  261.4      1,183,804            1 1.1E+07
D        216     .3           27  121.5        550,327            1 5.1E+06
D        288     .4           35    1.7          7,684            1 7.0E+04
D        360     .5           44    1.4          6,293            1 5.8E+04
D        432     .6           53    1.2          5,643            1 5.2E+04
D        504     .7           62    1.2          5,231            1 4.8E+04
D        576     .8           71    1.1          4,945            1 4.5E+04
D        648     .9           80    1.0          4,716            1 4.3E+04
D        720    1.0           88    1.0          4,545            1 4.1E+04
D        728    1.0           89    1.0          4,528            1 4.1E+04
D        792    1.1           97    1.0          4,400            1 4.0E+04
D        864    1.2          106    0.9          4,276            1 3.9E+04
D        936    1.3          115    0.9          4,167            1 3.8E+04
D      1,008    1.4          124    0.9          4,064            1 3.7E+04
D      1,080    1.5          133    0.9          3,968            1 3.6E+04
D      1,152    1.6          141    0.9          3,886            1 3.5E+04
D      1,224    1.7          150    0.8          3,810            1 3.5E+04
D      1,296    1.8          159    0.8          3,682            1 3.4E+04
D      1,368    1.9          168    0.7          3,110            1 2.8E+04
D      1,440    2.0          177    0.6          2,840            1 2.6E+04
          -------------------------------------------------------------

PGA Aggr Summary                 DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> PGA cache hit % - percentage of W/A (WorkArea) data processed only in-memory

PGA Cache Hit %   W/A MB Processed  Extra W/A MB Read/Written
--------------- ------------------ --------------------------
          100.0                 71                          0
          -------------------------------------------------------------



Warning:  pga_aggregate_target was set too low for current workload, as this
          value was exceeded during this interval.  Use the PGA Advisory view
          to help identify a different value for pga_aggregate_target.
PGA Aggr Target Stats             DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
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
B        128          8      178.2        0.0     .0     .0     .0     26,214
E        128          8      181.2        0.0     .0     .0     .0     26,214
          -------------------------------------------------------------

PGA Aggr Target Histogram         DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> Optimal Executions are purely in-memory operations

  Low     High
Optimal Optimal    Total Execs  Optimal Execs 1-Pass Execs M-Pass Execs
------- ------- -------------- -------------- ------------ ------------
     2K      4K            199            199            0            0
    64K    128K              9              9            0            0
   128K    256K              1              1            0            0
   512K   1024K             55             55            0            0
     1M      2M              6              6            0            0
     4M      8M              4              4            0            0
          -------------------------------------------------------------

PGA Memory Advisory                     DB/Inst: DBM11203/DBM11203  Snap: 1823
-> When using Auto Memory Mgmt, minimally choose a pga_aggregate_target value
   where Estd PGA Overalloc Count is 0

                                       Estd Extra    Estd P Estd PGA
PGA Target    Size           W/A MB   W/A MB Read/    Cache Overallo    Estd
  Est (MB)   Factr        Processed Written to Disk   Hit %    Count    Time
---------- ------- ---------------- ---------------- ------ -------- -------
        16     0.1            692.4             13.6   98.0        6 1.2E+06
        32     0.3            692.4             13.6   98.0        6 1.2E+06
        64     0.5            692.4             13.6   98.0        6 1.2E+06
        96     0.8            692.4             13.6   98.0        6 1.2E+06
       128     1.0            692.4              0.0  100.0        6 1.1E+06
       154     1.2            692.4              0.0  100.0        0 1.1E+06
       179     1.4            692.4              0.0  100.0        0 1.1E+06
       205     1.6            692.4              0.0  100.0        0 1.1E+06
       230     1.8            692.4              0.0  100.0        0 1.1E+06
       256     2.0            692.4              0.0  100.0        0 1.1E+06
       384     3.0            692.4              0.0  100.0        0 1.1E+06
       512     4.0            692.4              0.0  100.0        0 1.1E+06
       768     6.0            692.4              0.0  100.0        0 1.1E+06
     1,024     8.0            692.4              0.0  100.0        0 1.1E+06
          -------------------------------------------------------------

Shared Pool Advisory                   DB/Inst: DBM11203/DBM11203  Snap: 1823
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
     232    .9       12          783   10,050    1.0     433    1.8        3,925
     236    .9       15          898   10,081    1.0     402    1.6        3,927
     240    .9       17          997   10,129    1.0     354    1.4        3,928
     244    .9       21        1,249   10,142    1.0     341    1.4        3,928
     248   1.0       25        1,465   10,160    1.0     323    1.3        3,929
     252   1.0       29        1,681   10,178    1.0     305    1.2        3,929
     256   1.0       33        1,897   10,209    1.0     274    1.1        3,930
     260   1.0       37        2,113   10,236    1.0     247    1.0        3,932
     264   1.0       40        2,407   10,239    1.0     244    1.0        3,932
     268   1.0       44        2,621   10,239    1.0     244    1.0        3,932
     272   1.0       48        2,831   10,239    1.0     244    1.0        3,932
     276   1.1       52        3,057   10,239    1.0     244    1.0        3,932
     280   1.1       56        3,319   10,240    1.0     243    1.0        3,933
     284   1.1       59        3,645   10,240    1.0     243    1.0        3,933
     288   1.1       63        3,941   10,240    1.0     243    1.0        3,933
     292   1.1       67        4,176   10,240    1.0     243    1.0        3,933
     296   1.1       71        4,335   10,240    1.0     243    1.0        3,933
     316   1.2       91        4,820   10,240    1.0     243    1.0        3,933
     344   1.3       95        5,044   10,240    1.0     243    1.0        3,933
     372   1.4       95        5,044   10,240    1.0     243    1.0        3,933
     400   1.5       95        5,044   10,240    1.0     243    1.0        3,933
     428   1.6       95        5,044   10,240    1.0     243    1.0        3,933
     456   1.8       95        5,044   10,240    1.0     243    1.0        3,933
     484   1.9       95        5,044   10,240    1.0     243    1.0        3,933
     512   2.0       95        5,044   10,240    1.0     243    1.0        3,933
     540   2.1       95        5,044   10,240    1.0     243    1.0        3,933
          -------------------------------------------------------------

SGA Target Advisory                     DB/Inst: DBM11203/DBM11203  Snap: 1823

SGA Target   SGA Size       Est DB     Est Physical
  Size (M)     Factor     Time (s)            Reads
---------- ---------- ------------ ----------------
       512        0.5    5,164,978      563,502,939
       768        0.8       63,953        5,367,615
     1,024        1.0       56,257        4,514,774
     1,280        1.3       53,012        4,169,845
     1,536        1.5       49,428        3,778,414
     1,792        1.8       41,530        2,913,835
     2,048        2.0       41,530        2,913,835
          -------------------------------------------------------------

Streams Pool Advisory                   DB/Inst: DBM11203/DBM11203  Snap: 1823

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

Java Pool Advisory                      DB/Inst: DBM11203/DBM11203  Snap: 1823

                  No data exists for this section of the report.
          -------------------------------------------------------------

Buffer Wait Statistics            DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> ordered by wait time desc, waits desc

Class                    Waits Total Wait Time (s)  Avg Time (ms)
------------------ ----------- ------------------- --------------
data block               3,275                  27              8
undo block                  24                   0              0
undo header                 28                   0              0
          -------------------------------------------------------------

Enqueue Activity                 DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> only enqueues with waits are shown
-> Enqueue stats gathered prior to 10g should not be compared with 10g data
-> ordered by Wait Time desc, Waits desc

Enqueue Type (Request Reason)
------------------------------------------------------------------------------
    Requests    Succ Gets Failed Gets       Waits  Wt Time (s) Av Wt Time(ms)
------------ ------------ ----------- ----------- ------------ --------------
TX-Transaction (row lock contention)
         686          686           0         684            1           1.17
TX-Transaction (index contention)
         520          520           0           7            0          14.29
JS-Job Scheduler (queue lock)
       2,752        2,752           0           1            0          50.00
          -------------------------------------------------------------

Undo Segment Summary             DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> Min/Max TR (mins) - Min and Max Tuned Retention (minutes)
-> STO - Snapshot Too Old count,  OOS - Out of Space count
-> Undo segment block stats:
-> uS - unexpired Stolen,   uR - unexpired Released,   uU - unexpired reUsed
-> eS - expired   Stolen,   eR - expired   Released,   eU - expired   reUsed

Undo   Num Undo       Number of  Max Qry   Max Tx Min/Max   STO/     uS/uR/uU/
 TS# Blocks (K)    Transactions  Len (s) Concurcy TR (mins) OOS      eS/eR/eU
---- ---------- --------------- -------- -------- --------- ----- --------------
   2       21.3         247,075      939       20 19.6/29.7 0/0   0/0/0/0/0/0
          -------------------------------------------------------------

Undo Segment Stats                DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> Most recent 35 Undostat rows, ordered by Time desc

                Num Undo    Number of Max Qry  Max Tx Tun Ret STO/    uS/uR/uU/
End Time          Blocks Transactions Len (s)   Concy  (mins) OOS     eS/eR/eU
------------ ----------- ------------ ------- ------- ------- ----- ------------
23-Apr 18:43      10,617      123,638     338      20      20 0/0   0/0/0/0/0/0
23-Apr 18:33      10,647      123,437     939      20      30 0/0   0/0/0/0/0/0
          -------------------------------------------------------------

Latch Activity                   DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> "Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
   willing-to-wait latch get requests
-> "NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
-> "Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                                    Get    Get   Slps   Time       NoWait NoWait
Latch Name                     Requests   Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
AQ deq hash table latch               2    0.0             0            0    N/A
ASM Keyed state latch                23    0.0             0            0    N/A
ASM allocation                      150    0.0             0            0    N/A
ASM db client latch                 693    0.0             0            0    N/A
ASM map operation freeli             36    0.0             0            0    N/A
ASM map operation hash t      2,245,333    0.0    0.0      0            0    N/A
ASM network background l            440    0.0             0            0    N/A
ASM network state latch             192    0.0             0            0    N/A
AWR Alerted Metric Eleme          6,805    0.0             0            0    N/A
Change Notification Hash            301    0.0             0            0    N/A
Consistent RBA                  178,907    0.0             0            0    N/A
DML lock allocation             498,223    0.0    0.1      0            0    N/A
Event Group Locks                    27    0.0             0            0    N/A
FOB s.o list latch                  148    0.0             0            0    N/A
File State Object Pool P              2    0.0             0            0    N/A
I/O Staticstics latch                 2    0.0             0            0    N/A
IPC stats buffer allocat              2    0.0             0            0    N/A
In memory undo latch          1,305,440    0.0    0.6      0      183,774    0.0
JS Sh mem access                      6    0.0             0            0    N/A
JS broadcast autostart l              1    0.0             0            0    N/A
JS mem alloc latch                    2    0.0             0            0    N/A
JS queue access latch                 4    0.0             0            0    N/A
JS queue state obj latch          5,504    0.0             0            0    N/A
JS slv state obj latch                6    0.0             0            0    N/A
KFC FX Hash Latch                     2    0.0             0            0    N/A
KFC Hash Latch                        2    0.0             0            0    N/A
KFCL LE Freelist                      2    0.0             0            0    N/A
KFK SGA Libload latch               210    0.0             0            0    N/A
KFMD SGA                              1    0.0             0            0    N/A
KGNFS-NFS:SHM structure               2    0.0             0            0    N/A
KGNFS-NFS:SVR LIST                    2    0.0             0            0    N/A
KJC message pool free li              2    0.0             0            0    N/A
KJCT flow control latch               2    0.0             0            0    N/A
KMG MMAN ready and start            301    0.0             0            0    N/A
KTF sga latch                         5    0.0             0          302    0.0
KWQMN job cache list lat              1    0.0             0            0    N/A
KWQP Prop Status                    117    0.0             0            0    N/A
KWQS pqueue ctx latch                 2    0.0             0            0    N/A
Locator state objects po              2    0.0             0            0    N/A
Lsod array latch                    187    0.0             0            0    N/A
MQL Tracking Latch                    0    N/A             0           18    0.0
Memory Management Latch               2    0.0             0          301    0.0
Memory Queue                        120    0.0             0            0    N/A
Memory Queue Message Sub              2    0.0             0            0    N/A
Memory Queue Message Sub              2    0.0             0            0    N/A
Memory Queue Message Sub              2    0.0             0            0    N/A
Memory Queue Message Sub              2    0.0             0            0    N/A
Memory Queue Subscriber               2    0.0             0            0    N/A
MinActiveScn Latch                   10    0.0             0            0    N/A
Mutex                                 2    0.0             0            0    N/A
Mutex Stats                           2    0.0             0            0    N/A
OS process                          107    0.0             0            0    N/A
OS process allocation             1,865    0.0             0            0    N/A
OS process: request allo             23    0.0             0            0    N/A
PL/SQL warning settings              44    0.0             0            0    N/A
PX hash array latch                   2    0.0             0            0    N/A
QMT                                   2    0.0             0            0    N/A
Real-time plan statistic            436    0.0             0            0    N/A
SGA IO buffer pool latch             11    0.0             0           11    0.0
SGA blob parent                       2    0.0             0            0    N/A
Latch Activity                   DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> "Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
   willing-to-wait latch get requests
-> "NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
-> "Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                                    Get    Get   Slps   Time       NoWait NoWait
Latch Name                     Requests   Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
SGA bucket locks                      2    0.0             0            0    N/A
SGA heap locks                        2    0.0             0            0    N/A
SGA pool locks                        2    0.0             0            0    N/A
SQL memory manager latch              2    0.0             0          300    0.0
SQL memory manager worka         20,466    0.0             0            0    N/A
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
active checkpoint queue          28,428    0.0             0            0    N/A
active service list               1,760    0.0             0        2,133    0.0
begin backup scn array                4    0.0             0            0    N/A
bq:time manger info latc             32    0.0             0            0    N/A
buffer pool                           2    0.0             0            0    N/A
bufq statistics                     118    0.0             0            0    N/A
business card                         2    0.0             0            0    N/A
cache buffer handles             10,226    0.1    0.0      0            0    N/A
cache buffers chains        505,924,400    0.0    0.0      0      586,323    0.0
cache buffers lru chain         451,916    0.0    0.1      0      954,973    0.1
cache table scan latch              121    0.0             0          121    0.0
call allocation                     114    0.0             0            0    N/A
cas latch                             2    0.0             0            0    N/A
change notification clie              2    0.0             0            0    N/A
channel handle pool latc             27    0.0             0            0    N/A
channel operations paren          6,962    0.0             0            0    N/A
checkpoint queue latch        1,348,925    0.0    0.0      0      333,552    0.0
client/application info              18    0.0             0            0    N/A
compile environment latc             13    0.0             0            0    N/A
corrupted undo seg latch            159    0.0             0            0    N/A
cp cmon/server latch                  2    0.0             0            0    N/A
cp pool latch                         2    0.0             0            0    N/A
cp server hash latch                  2    0.0             0            0    N/A
cp sga latch                         34    0.0             0            0    N/A
cvmap freelist lock                   2    0.0             0            0    N/A
deferred cleanup latch               34    0.0             0            0    N/A
dml lock allocation                  34    0.0             0            0    N/A
done queue latch                      2    0.0             0            0    N/A
dummy allocation                     27    0.0             0            0    N/A
enqueue freelist latch                2    0.0             0       17,622    0.0
enqueue hash chains             888,071    0.0    0.1      0            0    N/A
enqueues                             21    0.0             0            0    N/A
fifth spare latch                     2    0.0             0            0    N/A
file cache latch                    220    0.0             0            0    N/A
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
Latch Activity                   DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> "Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
   willing-to-wait latch get requests
-> "NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
-> "Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                                    Get    Get   Slps   Time       NoWait NoWait
Latch Name                     Requests   Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
ges enqueue table freeli              2    0.0             0            0    N/A
ges group table                       2    0.0             0            0    N/A
ges process hash list                 2    0.0             0            0    N/A
ges process parent latch              2    0.0             0            0    N/A
ges resource hash list                2    0.0             0            0    N/A
ges resource scan list                2    0.0             0            0    N/A
ges resource table freel              2    0.0             0            0    N/A
ges value block free lis              2    0.0             0            0    N/A
global tx hash mapping                2    0.0             0            0    N/A
granule operation                     2    0.0             0            0    N/A
hash table column usage               8    0.0             0           35    0.0
hash table modification               2    0.0             0            0    N/A
heartbeat check                       2    0.0             0            0    N/A
intra txn parallel recov              2    0.0             0            0    N/A
io pool granule metadata              2    0.0             0            0    N/A
job workq parent latch                3    0.0             0            1    0.0
job_queue_processes free              4    0.0             0            0    N/A
job_queue_processes para            198    0.0             0            0    N/A
k2q lock allocation                   2    0.0             0            0    N/A
kcbtsemkid latch                     11    0.0             0            0    N/A
kdlx hb parent latch                  2    0.0             0            0    N/A
kgb parent                            2    0.0             0            0    N/A
kgnfs mount latch                     2    0.0             0            0    N/A
kokc descriptor allocati              4    0.0             0            0    N/A
ksfv messages                         2    0.0             0            0    N/A
ksim group membership ca              2    0.0             0            0    N/A
kss move lock                        22    0.0             0            0    N/A
ksuosstats global area               96    0.0             0            0    N/A
ksv allocation latch                 73    0.0             0            0    N/A
ksv class latch                     719    0.1    0.0      0            0    N/A
ksv instance latch                    4    0.0             0            0    N/A
ksv msg queue latch                   2    0.0             0            0    N/A
ksz_so allocation latch              23    0.0             0            0    N/A
ktm global data                     123    0.0             0            0    N/A
kwqbsn:qsga                         561    0.0             0            0    N/A
lgwr LWN SCN                    179,870    0.0    0.0      0            0    N/A
list of block allocation             54    0.0             0            0    N/A
loader state object free            134    0.0             0            0    N/A
lob segment dispenser la              2    0.0             0            0    N/A
lob segment hash table l              4    0.0             0            0    N/A
lob segment query latch               2    0.0             0            0    N/A
lock DBA buffer during m              2    0.0             0            0    N/A
logical standby cache                 2    0.0             0            0    N/A
logminer context allocat              3    0.0             0            0    N/A
logminer work area                    2    0.0             0            0    N/A
longop free list parent               2    0.0             0            0    N/A
mapped buffers lru chain              2    0.0             0            0    N/A
message pool operations             265    0.0             0            0    N/A
messages                        616,540    0.0    0.0      0            0    N/A
mostly latch-free SCN           182,081    0.3    0.0      0            0    N/A
msg queue latch                       2    0.0             0            0    N/A
multiblock read objects             366    0.0             0            0    N/A
name-service namespace b              2    0.0             0            0    N/A
ncodef allocation latch              34    0.0             0            0    N/A
object queue header heap        228,355    0.0             0        1,325    0.0
object queue header oper      2,330,854    0.0    0.0      0            0    N/A
object stats modificatio            195    0.0             0            0    N/A
parallel query alloc buf            122    0.0             0            0    N/A
parallel query stats                  2    0.0             0            0    N/A
parameter list                        2    0.0             0            0    N/A
Latch Activity                   DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> "Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
   willing-to-wait latch get requests
-> "NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
-> "Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                                    Get    Get   Slps   Time       NoWait NoWait
Latch Name                     Requests   Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
parameter table manageme             42    0.0             0            0    N/A
peshm                                 2    0.0             0            0    N/A
pesom_free_list                       2    0.0             0            0    N/A
pesom_hash_node                       2    0.0             0            0    N/A
post/wait queue                 271,590    0.0    0.0      0      184,450    0.0
process allocation                   35    0.0             0           12    0.0
process group creation               23    0.0             0            0    N/A
process queue                         2    0.0             0            0    N/A
process queue reference               2    0.0             0            0    N/A
qmn task queue latch                845    0.0             0            0    N/A
query server freelists                2    0.0             0            0    N/A
queued dump request                   3    0.0             0            0    N/A
queuing load statistics               2    0.0             0            0    N/A
recovery domain hash lis              2    0.0             0            0    N/A
redo allocation                 900,547    0.0    0.0      0      649,397    0.2
redo copy                             2    0.0             0      649,885    0.2
redo writing                    566,775    0.0    0.0      0            0    N/A
resmgr group change latc              2    0.0             0            0    N/A
resmgr:active threads                27    0.0             0            0    N/A
resmgr:actses change gro             13    0.0             0            0    N/A
resmgr:actses change sta              2    0.0             0            0    N/A
resmgr:free threads list             25    0.0             0            0    N/A
resmgr:plan CPU method                2    0.0             0            0    N/A
resmgr:resource group CP              2    0.0             0            0    N/A
resmgr:schema config                  2    0.0             0            0    N/A
resmgr:session queuing                2    0.0             0            0    N/A
rm cas latch                          2    0.0             0            0    N/A
row cache objects                 8,350    0.0    0.0      0           39    0.0
rules engine rule set st            200    0.0             0            0    N/A
second Audit Vault latch              2    0.0             0            0    N/A
second spare latch                    2    0.0             0            0    N/A
sequence cache                  154,907    0.0    0.0      0            0    N/A
session allocation              183,644    0.0    0.0      0      183,637    0.0
session idle bit              5,405,487    0.0    0.1      0            0    N/A
session queue latch                   2    0.0             0            0    N/A
session state list latch             38    0.0             0            0    N/A
session switching                    47    0.0             0            0    N/A
session timer                       314    0.0             0            0    N/A
shared pool                       2,350    0.1    0.0      0            0    N/A
shared pool sim alloc                 2    0.0             0            0    N/A
shared pool simulator                38    0.0             0            0    N/A
sim partition latch                   2    0.0             0            0    N/A
simulator hash latch         21,646,930    0.0    0.0      0            0    N/A
simulator lru latch              20,843    0.7    0.0      0   21,589,467    0.7
sort extent pool                     76    0.0             0            0    N/A
space background state o              5    0.0             0            0    N/A
space background task la          1,843    0.2    0.0      0          607    0.0
state object free list                2    0.0             0            0    N/A
statistics aggregation              336    0.0             0            0    N/A
tablespace key chain                  2    0.0             0            0    N/A
temp lob duration state               2    0.0             0            0    N/A
test excl. parent l0                  2    0.0             0            0    N/A
test excl. parent2 l0                 2    0.0             0            0    N/A
third spare latch                     2    0.0             0            0    N/A
threshold alerts latch               38    0.0             0            0    N/A
transaction allocation               45    0.0             0            0    N/A
undo global data              1,065,491    0.0    0.0      0            0    N/A
virtual circuit buffers               2    0.0             0            0    N/A
virtual circuit holder                2    0.0             0            0    N/A
virtual circuit queues                2    0.0             0            0    N/A
          -------------------------------------------------------------

Latch Sleep Breakdown            DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> ordered by misses desc

                                       Get                                 Spin
Latch Name                        Requests       Misses      Sleeps        Gets
-------------------------- --------------- ------------ ----------- -----------
cache buffers chains           505,924,400      239,995         450     239,545
simulator hash latch            21,646,930        1,507          22       1,485
mostly latch-free SCN              182,081          635          13         622
object queue header operat       2,330,854          450          14         436
session idle bit                 5,405,487          438          32         406
redo allocation                    900,547          316          11         305
In memory undo latch             1,305,440          277         158         120
enqueue hash chains                888,071          227          14         213
cache buffers lru chain            451,916          181          10         171
simulator lru latch                 20,843          148           3         145
messages                           616,540          115           2         113
undo global data                 1,065,491           73           3          70
DML lock allocation                498,223           43           4          39
checkpoint queue latch           1,348,925           41           1          40
          -------------------------------------------------------------

Latch Miss Sources               DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> only latches with sleeps are shown
-> ordered by name, sleeps desc

                                                     NoWait              Waiter
Latch Name               Where                       Misses     Sleeps   Sleeps
------------------------ -------------------------- ------- ---------- --------
DML lock allocation      ktaiam                           0          3        1
DML lock allocation      ktaidm                           0          1        3
In memory undo latch     ktiFlush: child                  0        123       50
In memory undo latch     kticmt: child                    0         38        8
In memory undo latch     ktichg: child                    0         11      104
In memory undo latch     kticflush_2                      0          1        0
cache buffers chains     kcbgtcr: fast path (cr pin       0        128      194
cache buffers chains     kcbgtcr: kslbegin shared         0        119       39
cache buffers chains     kcbget: fast exchange            0         87        2
cache buffers chains     kcbgtcr: fast path               0         68      195
cache buffers chains     kcbchg1: mod cr pin              0         65       22
cache buffers chains     kcbgtcr_2                        0         62       36
cache buffers chains     kcbgcur_2                        0         22        5
cache buffers chains     kcbgcur_4                        0         17        3
cache buffers chains     kcbgtcr_1                        0         15        0
cache buffers chains     kcbnew: new latch again          0         10        0
cache buffers chains     kcbzgb: scan from tail. no       0          6        0
cache buffers chains     kcbzwb                           0          5        5
cache buffers chains     kcbget: fast path                0          4        1
cache buffers chains     kcbgtcr: kslbegin excl           0          4        8
cache buffers chains     kcbnlc                           0          4        4
cache buffers chains     kcbrls: fast release             0          4       74
cache buffers chains     kcbgcur: fast path (shr)         0          3        3
cache buffers chains     kcbbic2                          0          2        0
cache buffers chains     kcbbxsv                          0          2        0
cache buffers chains     kcb_pre_apply: kcbhq61           0          1        5
cache buffers chains     kcbchg1: clear MS bit            0          1        3
cache buffers chains     kcbget: pin buffer               0          1        0
cache buffers chains     kcbrls_2                         0          1        9
cache buffers chains     kcbzib: exchange rls             0          1        3
cache buffers lru chain  kcbzgws                          0          9        0
cache buffers lru chain  kcbo_link_q                      0          1        0
checkpoint queue latch   kcbklbc_cql                      0          1        0
enqueue hash chains      ksqgtl3                          0         11        4
enqueue hash chains      ksqrcl                           0          2       10
enqueue hash chains      ksqcmi: get hash chain lat       0          1        0
lgwr LWN SCN             kcs023                           0          8        0
messages                 ksaamb: after wakeup             0          1        1
messages                 ksarcv                           0          1        1
mostly latch-free SCN    kcslcu3                          0          5       13
object queue header oper kcbo_switch_cq                   0          4        6
object queue header oper kcbo_link_q                      0          3        0
object queue header oper kcbo_unlink_q                    0          3        4
object queue header oper kcbo_check_flist                 0          1        3
object queue header oper kcbo_link_q:reget                0          1        0
object queue header oper kcbo_switch_mq_bg                0          1        1
object queue header oper kcbo_switch_q_bg                 0          1        0
redo allocation          kcrfw_redo_gen: redo alloc       0         11        0
session idle bit         ksupuc: set busy                 0         20       16
session idle bit         ksupuc: clear busy               0         11       14
session idle bit         ksuxds                           0          3        4
simulator hash latch     kcbsacc: lookup dba              0         22       21
simulator lru latch      kcbs_simulate: simulate se       0          3        0
undo global data         ktubnd_4                         0          2        0
undo global data         ktudnx:child                     0          1        1
          -------------------------------------------------------------

Mutex Sleep Summary               DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> ordered by number of sleeps desc

                                                                         Wait
Mutex Type            Location                               Sleeps    Time (ms)
--------------------- -------------------------------- ------------ ------------
Cursor Pin            kksfbc [KKSCHLPIN1]                        24            0
Library Cache         kglpin1   4                                15            0
Library Cache         kglpndl1  95                               11            0
Cursor Pin            kksLockDelete [KKSCHLPIN6]                 10            0
Library Cache         kglpnal1  90                                8            0
          -------------------------------------------------------------

Parent Latch Statistics          DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823

                  No data exists for this section of the report.
          -------------------------------------------------------------

Child Latch Statistics            DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823

                  No data exists for this section of the report.
          -------------------------------------------------------------

Segments by Logical Reads        DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> Total Logical Reads:     366,396,963
-> Captured Segments account for   99.8% of Total

           Tablespace                      Subobject  Obj.       Logical
Owner         Name    Object Name            Name     Type         Reads  %Total
---------- ---------- -------------------- ---------- ----- ------------ -------
SOE        SOE        ITEM_ORDER_IX                   INDEX  117,716,448   32.13
SOE        SOE        CUSTOMERS_PK                    INDEX  117,354,960   32.03
SOE        SOE        ORDERS                          TABLE   58,667,760   16.01
SOE        SOE        CUSTOMERS                       TABLE   58,425,952   15.95
SOE        SOE        PRODUCT_INFORMATION             TABLE    6,935,312    1.89
          -------------------------------------------------------------

Segments by Physical Reads        DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> Total Physical Reads:         522,880
-> Captured Segments account for   99.6% of Total

           Tablespace                      Subobject  Obj.      Physical
Owner         Name    Object Name            Name     Type         Reads  %Total
---------- ---------- -------------------- ---------- ----- ------------ -------
SOE        SOE        CUSTOMERS                       TABLE      107,285   20.52
SOE        SOE        CUSTOMERS_PK                    INDEX      103,490   19.79
SOE        SOE        ORD_CUSTOMER_IX                 INDEX       65,816   12.59
SOE        SOE        INVENTORIES                     TABLE       47,667    9.12
SOE        SOE        ITEM_ORDER_IX                   INDEX       46,285    8.85
          -------------------------------------------------------------

Segments by Physical Read RequestsDB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> Total Physical Read Requests:         521,753
-> Captured Segments account for   99.7% of Total

           Tablespace                      Subobject  Obj.     Phys Read
Owner         Name    Object Name            Name     Type      Requests  %Total
---------- ---------- -------------------- ---------- ----- ------------ -------
SOE        SOE        CUSTOMERS                       TABLE      107,283   20.56
SOE        SOE        CUSTOMERS_PK                    INDEX      103,490   19.84
SOE        SOE        ORD_CUSTOMER_IX                 INDEX       65,816   12.61
SOE        SOE        INVENTORIES                     TABLE       47,667    9.14
SOE        SOE        ITEM_ORDER_IX                   INDEX       46,285    8.87
          -------------------------------------------------------------

Segments by UnOptimized Reads     DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> Total UnOptimized Read Requests:         521,753
-> Captured Segments account for   99.7% of Total

           Tablespace                      Subobject  Obj.   UnOptimized
Owner         Name    Object Name            Name     Type         Reads  %Total
---------- ---------- -------------------- ---------- ----- ------------ -------
SOE        SOE        CUSTOMERS                       TABLE      107,283   20.56
SOE        SOE        CUSTOMERS_PK                    INDEX      103,490   19.84
SOE        SOE        ORD_CUSTOMER_IX                 INDEX       65,816   12.61
SOE        SOE        INVENTORIES                     TABLE       47,667    9.14
SOE        SOE        ITEM_ORDER_IX                   INDEX       46,285    8.87
          -------------------------------------------------------------

Segments by Optimized Reads       DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823

                  No data exists for this section of the report.
          -------------------------------------------------------------

Segments by Direct Physical Reads DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823

                  No data exists for this section of the report.
          -------------------------------------------------------------

Segments by Physical Writes       DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> Total Physical Writes:         340,400
-> Captured Segments account for   94.9% of Total

           Tablespace                      Subobject  Obj.      Physical
Owner         Name    Object Name            Name     Type        Writes  %Total
---------- ---------- -------------------- ---------- ----- ------------ -------
SOE        SOE        INVENTORIES                     TABLE       68,342   20.08
SOE        SOE        ORDER_PK                        INDEX       36,810   10.81
SOE        SOE        ORD_CUSTOMER_IX                 INDEX       35,321   10.38
SOE        SOE        ITEM_ORDER_IX                   INDEX       32,622    9.58
SOE        SOE        ORDER_ITEMS_PK                  INDEX       32,536    9.56
          -------------------------------------------------------------

Segments by Physical Write RequestsDB/Inst: DBM11203/DBM11203  Snaps: 1822-182
-> Total Physical Write Requestss:         236,463
-> Captured Segments account for   99.1% of Total

           Tablespace                      Subobject  Obj.    Phys Write
Owner         Name    Object Name            Name     Type      Requests  %Total
---------- ---------- -------------------- ---------- ----- ------------ -------
SOE        SOE        INVENTORIES                     TABLE       36,889   15.60
SOE        SOE        ORDER_PK                        INDEX       34,555   14.61
SOE        SOE        ORD_CUSTOMER_IX                 INDEX       32,424   13.71
SOE        SOE        ORDER_ITEMS_PK                  INDEX       30,019   12.70
SOE        SOE        ITEM_ORDER_IX                   INDEX       29,477   12.47
          -------------------------------------------------------------

Segments by Direct Physical WritesDB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> Total Direct Physical Writes:              82
-> Captured Segments account for   32.9% of Total

           Tablespace                      Subobject  Obj.        Direct
Owner         Name    Object Name            Name     Type        Writes  %Total
---------- ---------- -------------------- ---------- ----- ------------ -------
SYS        SYSAUX     WRH$_ACTIVE_SESSION_ 11053_1819 TABLE           27   32.93
          -------------------------------------------------------------

Segments by Table Scans           DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823

                  No data exists for this section of the report.
          -------------------------------------------------------------

Segments by DB Blocks Changes     DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> % of Capture shows % of DB Block Changes for each top segment compared
-> with total DB Block Changes for all segments captured by the Snapshot

           Tablespace                      Subobject  Obj.      DB Block    % of
Owner         Name    Object Name            Name     Type       Changes Capture
---------- ---------- -------------------- ---------- ----- ------------ -------
SOE        SOE        ORDER_ITEMS                     TABLE       91,216   17.68
SOE        SOE        ORD_WAREHOUSE_IX                INDEX       79,824   15.47
SOE        SOE        ORDERS                          TABLE       70,528   13.67
SOE        SOE        INVENTORIES                     TABLE       64,816   12.56
SOE        SOE        ITEM_ORDER_IX                   INDEX       63,184   12.24
          -------------------------------------------------------------

Segments by Row Lock Waits       DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> % of Capture shows % of row lock waits for each top segment compared
-> with total row lock waits for all segments captured by the Snapshot

                                                                     Row
           Tablespace                      Subobject  Obj.          Lock    % of
Owner         Name    Object Name            Name     Type         Waits Capture
---------- ---------- -------------------- ---------- ----- ------------ -------
SOE        SOE        ORDERS                          TABLE          685   56.94
SOE        SOE        ORD_ORDER_DATE_IX               INDEX          292   24.27
SOE        SOE        ITEM_PRODUCT_IX                 INDEX           96    7.98
SOE        SOE        ORD_WAREHOUSE_IX                INDEX           35    2.91
SOE        SOE        CUST_LNAME_IX                   INDEX           24    2.00
          -------------------------------------------------------------

Segments by ITL Waits             DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823

                  No data exists for this section of the report.
          -------------------------------------------------------------

Segments by Buffer Busy Waits     DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> % of Capture shows % of Buffer Busy Waits for each top segment compared
-> with total Buffer Busy Waits for all segments captured by the Snapshot

                                                                  Buffer
           Tablespace                      Subobject  Obj.          Busy    % of
Owner         Name    Object Name            Name     Type         Waits Capture
---------- ---------- -------------------- ---------- ----- ------------ -------
SOE        SOE        ORDERS                          TABLE          334   96.53
SOE        SOE        CUSTOMERS_PK                    INDEX            4    1.16
SOE        SOE        ORD_ORDER_DATE_IX               INDEX            3     .87
SOE        SOE        ITEM_ORDER_IX                   INDEX            2     .58
SOE        SOE        ORDER_PK                        INDEX            2     .58
          -------------------------------------------------------------

Dictionary Cache Stats           DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> "Pct Misses"  should be very low (< 2% in most cases)
-> "Final Usage" is the number of cache entries being used

                                   Get    Pct    Scan   Pct      Mod      Final
Cache                         Requests   Miss    Reqs  Miss     Reqs      Usage
------------------------- ------------ ------ ------- ----- -------- ----------
dc_awr_control                      19    0.0       0   N/A        2          1
dc_global_oids                       7    0.0       0   N/A        0         24
dc_histogram_data                   78   44.9       0   N/A        0      2,000
dc_histogram_defs                   41   12.2       0   N/A        0      2,024
dc_objects                         229    0.4       0   N/A        1      1,501
dc_profiles                          2    0.0       0   N/A        0          1
dc_rollback_segments               963    0.0       0   N/A        0         78
dc_segments                        121    0.0       0   N/A       10        614
dc_sequences                        10    0.0       0   N/A       10          5
dc_tablespaces                     506    0.0       0   N/A        0          7
dc_users                           234    0.0       0   N/A        0         46
global database name               612    0.0       0   N/A        0          1
outstanding_alerts                   8    0.0       0   N/A        0          4
sch_lj_oids                          2    0.0       0   N/A        0          1
          -------------------------------------------------------------

Library Cache Activity            DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> "Pct Misses"  should be very low

                         Get    Pct            Pin    Pct             Invali-
Namespace           Requests   Miss       Requests   Miss    Reloads  dations
--------------- ------------ ------ -------------- ------ ---------- --------
BODY                      15    0.0             44    0.0          0        0
CLUSTER                    2    0.0              2    0.0          0        0
DBLINK                     1    0.0              0    N/A          0        0
EDITION                    8    0.0              8    0.0          0        0
QUEUE                    262    0.0            262    0.0          0        0
SCHEMA                     1    0.0              0    N/A          0        0
SQL AREA                 372    1.1      1,230,463   -0.0          1        0
SQL AREA BUILD             5  100.0              0    N/A          0        0
SQL AREA STATS             5   80.0              5   80.0          0        0
TABLE/PROCEDURE           27    0.0        103,351    0.0          1        0
          -------------------------------------------------------------

Memory Dynamic Components        DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
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

Memory Resize Operations Summary  DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823

                  No data exists for this section of the report.
          -------------------------------------------------------------

Memory Resize Ops                 DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823

                  No data exists for this section of the report.
          -------------------------------------------------------------

Process Memory Summary           DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
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
B Other        151.5       N/A      2.6      2.4      14      25     58     58
  Freeable      23.6        .0       .8       .5       2     N/A     29     29
  PL/SQL         2.4       2.1       .0       .2       1       2     58     58
  SQL             .8        .1       .0       .0       0       9     40     36
E Other        153.9       N/A      2.6      2.4      14      25     59     59
  Freeable      24.1        .0       .8       .4       1     N/A     31     31
  PL/SQL         2.4       2.1       .0       .2       1       2     59     59
  SQL             .8        .1       .0       .0       0       9     41     36
          -------------------------------------------------------------

SGA Memory Summary                DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823

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

SGA breakdown difference          DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
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
shared KGLH0                                    18.4           18.4   -0.04
shared KGLHD                                     3.8            3.8    0.20
shared KGLS                                      4.4            4.4    0.09
shared KGLSG                                     5.0            5.0    0.00
shared KKSSP                                     2.7            2.8    1.41
shared KSFD SGA I/O b                            3.8            3.8    0.00
shared PLMCD                                     3.2            3.2    0.00
shared SQLA                                     22.3           22.3    0.30
shared db_block_hash_buckets                     5.6            5.6    0.00
shared dbwriter coalesce buffer                  3.8            3.8    0.00
shared dirty object counts array                 4.0            4.0    0.00
shared event statistics per sess                 3.1            3.1    0.00
shared free memory                              87.1           87.0   -0.17
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

Streams CPU/IO Usage             DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> Streams processes ordered by CPU Time, descending

                                                     User IO       SYS IO
Session Type         First Logon    CPU time(s) Wait time(s) Wait time(s)
-------------------- ------------- ------------ ------------ ------------
QMON Slaves          0423 16:34:10          0.0          0.1          0.0
QMON Coordinator     0423 16:34:00          0.0          0.0          0.0
          -------------------------------------------------------------

Streams Capture                   DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823

                  No data exists for this section of the report.
          -------------------------------------------------------------

Streams Capture Rate              DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823

                  No data exists for this section of the report.
          -------------------------------------------------------------

Streams Apply                     DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823

                  No data exists for this section of the report.
          -------------------------------------------------------------

Streams Apply Rate                DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823

                  No data exists for this section of the report.
          -------------------------------------------------------------

Buffered Queues                   DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> Ordered by Queue Name
-> * indicates queue (re)started between Begin/End snaps

        Enq        Enq        Deq        Deq   Spill     Spill     %Spill
       Msgs   Msgs/sec       Msgs   Msgs/sec    Msgs  Msgs/sec       Msgs
 ---------- ---------- ---------- ---------- ------- --------- ----------
SYS.SCHEDULER$_EVENT_QUEUE(12613)
          0       0.00          0       0.00       0      0.00        N/A
          -------------------------------------------------------------

Buffered Queue Subscribers        DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823

                  No data exists for this section of the report.
          -------------------------------------------------------------

Rule Set                          DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823

                  No data exists for this section of the report.
          -------------------------------------------------------------

Persistent Queues                 DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823

                  No data exists for this section of the report.
          -------------------------------------------------------------

Persistent Queues Rate            DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823

                  No data exists for this section of the report.
          -------------------------------------------------------------

Persistent Queue Subscribers      DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823

                  No data exists for this section of the report.
          -------------------------------------------------------------

Resource Limit Stats                   DB/Inst: DBM11203/DBM11203  Snap: 1823

                  No data exists for this section of the report.
          -------------------------------------------------------------

Shared Servers Activity           DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> Values represent averages for all samples

   Avg Total   Avg Active    Avg Total   Avg Active    Avg Total   Avg Active
 Connections  Connections Shared Srvrs Shared Srvrs  Dispatchers  Dispatchers
------------ ------------ ------------ ------------ ------------ ------------
           0            0            0            0            0            0
          -------------------------------------------------------------

Shared Servers Rates              DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823

  Common     Disp                        Common       Disp     Server
   Queue    Queue   Server    Server      Queue      Queue      Total     Server
 Per Sec  Per Sec Msgs/Sec    KB/Sec      Total      Total       Msgs  Total(KB)
-------- -------- -------- --------- ---------- ---------- ---------- ----------
       0        0        0       0.0          0          0          0          0
          -------------------------------------------------------------

Shared Servers Utilization        DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823

                  No data exists for this section of the report.
          -------------------------------------------------------------

Shared Servers Common Queue       DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823

                  No data exists for this section of the report.
          -------------------------------------------------------------

Shared Servers Dispatchers        DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823

                  No data exists for this section of the report.
          -------------------------------------------------------------

init.ora Parameters              DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823

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

init.ora Multi-Valued Parameters DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823
-> This section only displays parameters that have more one value
->'(NULL)' indicates a missing parameter value
-> A blank in the End Snapshot indicates the same value as the BeginSnapshot

                                                                End value
Parameter Name                Begin value                       (if different)
----------------------------- --------------------------------- --------------
control_files                 +DATA/dbm11203/controlfile/curren
                              +FRA/dbm11203/controlfile/current
          -------------------------------------------------------------

Dynamic Remastering Stats         DB/Inst: DBM11203/DBM11203  Snaps: 1822-1823

                  No data exists for this section of the report.
          -------------------------------------------------------------

End of Report
