
STATSPACK report for

Database    DB Id    Instance     Inst Num  Startup Time   Release     RAC
~~~~~~~~ ----------- ------------ -------- --------------- ----------- ---
          2532911053 DBM11203            1 23-Apr-14 16:33 11.2.0.3.0  NO

Host Name             Platform                CPUs Cores Sockets   Memory (G)
~~~~ ---------------- ---------------------- ----- ----- ------- ------------
     helicon          Linux x86 64-bit           8     8       2          7.8

Snapshot       Snap Id     Snap Time      Sessions Curs/Sess Comment
~~~~~~~~    ---------- ------------------ -------- --------- ------------------
Begin Snap:        552 23-Apr-14 19:30:41       59       1.7
  End Snap:        553 23-Apr-14 19:45:40       74       1.8
   Elapsed:      14.98 (mins) Av Act Sess:      14.2
   DB time:     212.12 (mins)      DB CPU:      48.16 (mins)

Cache Sizes            Begin        End
~~~~~~~~~~~       ---------- ----------
    Buffer Cache:       728M              Std Block Size:         8K
     Shared Pool:       260M                  Log Buffer:     7,992K

Load Profile              Per Second    Per Transaction    Per Exec    Per Call
~~~~~~~~~~~~      ------------------  ----------------- ----------- -----------
      DB time(s):               14.2                0.1        0.01        0.00
       DB CPU(s):                3.2                0.0        0.00        0.00
       Redo size:          557,044.0            1,934.1
   Logical reads:          653,201.9            2,268.0
   Block changes:            3,980.8               13.8
  Physical reads:              864.7                3.0
 Physical writes:              582.7                2.0
      User calls:            4,086.1               14.2
          Parses:                1.5                0.0
     Hard parses:                0.3                0.0
W/A MB processed:                0.1                0.0
          Logons:                0.0                0.0
        Executes:            1,930.5                6.7
       Rollbacks:                0.0                0.0
    Transactions:              288.0

Instance Efficiency Indicators
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            Buffer Nowait %:  100.00       Redo NoWait %:   99.96
            Buffer  Hit   %:   99.87  Optimal W/A Exec %:  100.00
            Library Hit   %:   99.94        Soft Parse %:   79.16
         Execute to Parse %:   99.92         Latch Hit %:   99.82
Parse CPU to Parse Elapsd %:   71.84     % Non-Parse CPU:   98.85

 Shared Pool Statistics        Begin   End
                               ------  ------
             Memory Usage %:   75.01   67.04
    % SQL with executions>1:   76.93   78.52
  % Memory for SQL w/exec>1:   81.45   82.23

Top 5 Timed Events                                                    Avg %Total
~~~~~~~~~~~~~~~~~~                                                   wait   Call
Event                                            Waits    Time (s)   (ms)   Time
----------------------------------------- ------------ ----------- ------ ------
db file sequential read                        776,224       9,455     12   74.4
CPU time                                                     2,756          21.7
log file sync                                  257,879         270      1    2.1
log file parallel write                        243,502         107      0     .8
read by other session                            4,236          52     12     .4
          -------------------------------------------------------------
Host CPU  (CPUs: 8  Cores: 8  Sockets: 2)
~~~~~~~~              Load Average
                      Begin     End      User  System    Idle     WIO     WCPU
                    ------- -------   ------- ------- ------- ------- --------
                       7.92   14.88     40.08    1.45   57.66   30.71

Instance CPU
~~~~~~~~~~~~                                       % Time (seconds)
                                            -------- --------------
                     Host: Total time (s):                  7,050.3
                  Host: Busy CPU time (s):                  2,985.1
                   % of time Host is Busy:      42.3
             Instance: Total CPU time (s):                  2,951.9
          % of Busy CPU used for Instance:      98.9
        Instance: Total Database time (s):                 12,953.2
  %DB time waiting for CPU (Resource Mgr):       0.0

Memory Statistics                       Begin          End
~~~~~~~~~~~~~~~~~                ------------ ------------
                  Host Mem (MB):      7,974.6      7,974.6
                   SGA use (MB):      1,019.4      1,019.4
                   PGA use (MB):        183.1        219.4
    % Host Mem used for SGA+PGA:         15.1         15.5
          -------------------------------------------------------------

Time Model System Stats  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> Ordered by % of DB time desc, Statistic name

Statistic                                       Time (s) % DB time
----------------------------------- -------------------- ---------
sql execute elapsed time                        12,132.0      95.3
DB CPU                                           2,889.6      22.7
parse time elapsed                                  56.0        .4
connection management call elapsed                   7.4        .1
hard parse elapsed time                              2.2        .0
hard parse (sharing criteria) elaps                  0.5        .0
hard parse (bind mismatch) elapsed                   0.5        .0
PL/SQL compilation elapsed time                      0.3        .0
PL/SQL execution elapsed time                        0.0        .0
repeated bind elapsed time                           0.0        .0
DB time                                         12,727.0
background elapsed time                            226.2
background cpu time                                 62.3
          -------------------------------------------------------------
Foreground Wait Events  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> Only events with Total Wait Time (s) >= .001 are shown
-> ordered by Total Wait Time desc, Waits desc (idle events last)

                                                             Avg          %Total
                                          %Tim Total Wait   wait    Waits   Call
Event                               Waits  out   Time (s)   (ms)     /txn   Time
---------------------------- ------------ ---- ---------- ------ -------- ------
db file sequential read           774,575    0      9,438     12      3.0   74.2
log file sync                     257,878    0        270      1      1.0    2.1
read by other session               4,236    0         52     12      0.0     .4
log file switch (private str          266    0         12     45      0.0     .1
cursor: pin S wait on X                74    0          8    104      0.0     .1
log file switch (checkpoint           148    0          7     47      0.0     .1
enq: TX - row lock contentio        1,239    0          2      2      0.0     .0
library cache lock                     50    0          1     21      0.0     .0
library cache load lock                27    0          1     19      0.0     .0
enq: TX - index contention             32    0          1     16      0.0     .0
library cache: mutex X                218    0          0      2      0.0     .0
latch: cache buffers chains         1,361    0          0      0      0.0     .0
db file parallel read                  28    0          0     11      0.0     .0
kksfbc child completion                 6  100          0     51      0.0     .0
cursor: pin S                          63    0          0      4      0.0     .0
buffer busy waits                     638    0          0      0      0.0     .0
control file sequential read          364    0          0      0      0.0     .0
latch free                            191    0          0      1      0.0     .0
enq: HW - contention                    4    0          0     28      0.0     .0
enq: TX - contention                    1    0          0     69      0.0     .0
latch: In memory undo latch           253    0          0      0      0.0     .0
row cache lock                         11    0          0      3      0.0     .0
latch: object queue header o           49    0          0      0      0.0     .0
latch: shared pool                      9    0          0      2      0.0     .0
db file scattered read                  2    0          0      7      0.0     .0
Disk file operations I/O              145    0          0      0      0.0     .0
latch: enqueue hash chains             28    0          0      0      0.0     .0
enq: CU - contention                    1    0          0      4      0.0     .0
latch: row cache objects                8    0          0      0      0.0     .0
latch: redo allocation                  5    0          0      0      0.0     .0
latch: undo global data                 6    0          0      0      0.0     .0
SQL*Net message from client     1,996,035    0     22,938     11      7.7
jobq slave wait                       120  100         60    501      0.0
SQL*Net message to client       1,996,045    0          4      0      7.7
          -------------------------------------------------------------

Background Wait Events  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> Only events with Total Wait Time (s) >= .001 are shown
-> ordered by Total Wait Time desc, Waits desc (idle events last)

                                                             Avg          %Total
                                          %Tim Total Wait   wait    Waits   Call
Event                               Waits  out   Time (s)   (ms)     /txn   Time
---------------------------- ------------ ---- ---------- ------ -------- ------
log file parallel write           243,502    0        107      0      0.9     .8
db file parallel write             39,338    0         23      1      0.2     .2
db file sequential read             1,649    0         18     11      0.0     .1
control file sequential read        2,454    0         14      6      0.0     .1
db file scattered read                 91    0          1     15      0.0     .0
log file sequential read               56    0          1     10      0.0     .0
direct path read                       32    0          0     15      0.0     .0
os thread startup                      11    0          0     38      0.0     .0
control file parallel write           657    0          0      1      0.0     .0
ASM file metadata operation           541    0          0      1      0.0     .0
LGWR wait for redo copy             2,664    0          0      0      0.0     .0
ADR block file read                    16    0          0      7      0.0     .0
latch: cache buffers chains            18    0          0      1      0.0     .0
reliable message                       60    0          0      0      0.0     .0
latch: redo allocation                 40    0          0      0      0.0     .0
latch free                             12    0          0      1      0.0     .0
db file async I/O submit            2,578    0          0      0      0.0     .0
CSS initialization                      1    0          0      7      0.0     .0
log file single write                  56    0          0      0      0.0     .0
latch: cache buffers lru cha           22    0          0      0      0.0     .0
direct path write                      15    0          0      0      0.0     .0
Disk file operations I/O               51    0          0      0      0.0     .0
ADR block file write                    5    0          0      0      0.0     .0
log file sync                           1    0          0      2      0.0     .0
CSS operation: action                   1    0          0      2      0.0     .0
latch: object queue header o            7    0          0      0      0.0     .0
rdbms ipc message                 247,058    2     12,393     50      1.0
class slave wait                      264    0      3,599  13632      0.0
Space Manager: slave idle wa          454   91      2,141   4717      0.0
DIAG idle wait                      1,796  100      1,799   1001      0.0
smon timer                             42    0        922  21941      0.0
ASM background timer                  180    0        901   5003      0.0
pmon timer                            364   68        900   2472      0.0
wait for unread message on b          898  100        899   1002      0.0
Streams AQ: qmn coordinator           286   45        895   3130      0.0
Streams AQ: qmn slave idle w          128    0        895   6993      0.0
SQL*Net message from client            45    0          0      5      0.0
KSV master wait                        85    0          0      0      0.0
          -------------------------------------------------------------

Wait Events (fg and bg) DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> s - second, cs - centisecond,  ms - millisecond, us - microsecond
-> %Timeouts:  value of 0 indicates value was < .5%.  Value of null is truly 0
-> Only events with Total Wait Time (s) >= .001 are shown
-> ordered by Total Wait Time desc, Waits desc (idle events last)

                                                             Avg          %Total
                                          %Tim Total Wait   wait    Waits   Call
Event                               Waits  out   Time (s)   (ms)     /txn   Time
---------------------------- ------------ ---- ---------- ------ -------- ------
db file sequential read           776,224    0      9,455     12      3.0   74.4
log file sync                     257,879    0        270      1      1.0    2.1
log file parallel write           243,502    0        107      0      0.9     .8
read by other session               4,236    0         52     12      0.0     .4
db file parallel write             39,338    0         23      1      0.2     .2
control file sequential read        2,818    0         14      5      0.0     .1
log file switch (private str          266    0         12     45      0.0     .1
cursor: pin S wait on X                74    0          8    104      0.0     .1
log file switch (checkpoint           148    0          7     47      0.0     .1
enq: TX - row lock contentio        1,239    0          2      2      0.0     .0
db file scattered read                 93    0          1     15      0.0     .0
library cache lock                     50    0          1     21      0.0     .0
log file sequential read               56    0          1     10      0.0     .0
library cache load lock                27    0          1     19      0.0     .0
enq: TX - index contention             32    0          1     16      0.0     .0
library cache: mutex X                218    0          0      2      0.0     .0
direct path read                       32    0          0     15      0.0     .0
os thread startup                      11    0          0     38      0.0     .0
control file parallel write           657    0          0      1      0.0     .0
latch: cache buffers chains         1,379    0          0      0      0.0     .0
db file parallel read                  28    0          0     11      0.0     .0
ASM file metadata operation           541    0          0      1      0.0     .0
kksfbc child completion                 6  100          0     51      0.0     .0
cursor: pin S                          63    0          0      4      0.0     .0
LGWR wait for redo copy             2,664    0          0      0      0.0     .0
buffer busy waits                     642    0          0      0      0.0     .0
latch free                            203    0          0      1      0.0     .0
enq: HW - contention                    4    0          0     28      0.0     .0
ADR block file read                    16    0          0      7      0.0     .0
enq: TX - contention                    1    0          0     69      0.0     .0
latch: In memory undo latch           255    0          0      0      0.0     .0
row cache lock                         11    0          0      3      0.0     .0
latch: object queue header o           56    0          0      0      0.0     .0
latch: shared pool                      9    0          0      2      0.0     .0
Disk file operations I/O              196    0          0      0      0.0     .0
latch: redo allocation                 45    0          0      0      0.0     .0
reliable message                       60    0          0      0      0.0     .0
latch: enqueue hash chains             28    0          0      0      0.0     .0
db file async I/O submit            2,578    0          0      0      0.0     .0
CSS initialization                      1    0          0      7      0.0     .0
log file single write                  56    0          0      0      0.0     .0
latch: cache buffers lru cha           22    0          0      0      0.0     .0
direct path write                      15    0          0      0      0.0     .0
enq: CU - contention                    1    0          0      4      0.0     .0
ADR block file write                    5    0          0      0      0.0     .0
latch: row cache objects                8    0          0      0      0.0     .0
CSS operation: action                   1    0          0      2      0.0     .0
latch: undo global data                 6    0          0      0      0.0     .0
SQL*Net message from client     1,996,080    0     22,938     11      7.7

Wait Events (fg and bg) DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> s - second, cs - centisecond,  ms - millisecond, us - microsecond
-> %Timeouts:  value of 0 indicates value was < .5%.  Value of null is truly 0
-> Only events with Total Wait Time (s) >= .001 are shown
-> ordered by Total Wait Time desc, Waits desc (idle events last)

                                                             Avg          %Total
                                          %Tim Total Wait   wait    Waits   Call
Event                               Waits  out   Time (s)   (ms)     /txn   Time
---------------------------- ------------ ---- ---------- ------ -------- ------
rdbms ipc message                 247,058    2     12,393     50      1.0
class slave wait                      264    0      3,599  13632      0.0
Space Manager: slave idle wa          454   91      2,141   4717      0.0
DIAG idle wait                      1,796  100      1,799   1001      0.0
smon timer                             42    0        922  21941      0.0
ASM background timer                  180    0        901   5003      0.0
pmon timer                            364   68        900   2472      0.0
wait for unread message on b          898  100        899   1002      0.0
Streams AQ: qmn coordinator           286   45        895   3130      0.0
Streams AQ: qmn slave idle w          128    0        895   6993      0.0
jobq slave wait                       120  100         60    501      0.0
SQL*Net message to client       1,996,075    0          4      0      7.7
KSV master wait                        85    0          0      0      0.0
          -------------------------------------------------------------
Wait Event Histogram  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> Total Waits - units: K is 1000, M is 1000000, G is 1000000000
-> % of Waits - column heading: <=1s is truly <1024ms, >1s is truly >=1024ms
-> % of Waits - value: .0 indicates value was <.05%, null is truly 0
-> Ordered by Event (idle events last)

                           Total ----------------- % of Waits ------------------
Event                      Waits  <1ms  <2ms  <4ms  <8ms <16ms <32ms  <=1s   >1s
-------------------------- ----- ----- ----- ----- ----- ----- ----- ----- -----
ADR block file read          16   75.0              12.5              12.5
ADR block file write          5  100.0
ADR file lock                 6  100.0
ASM file metadata operatio  540   92.0   3.7   3.3    .4    .2    .2    .2
CSS initialization            1                    100.0
CSS operation: action         1        100.0
CSS operation: query          6  100.0
Disk file operations I/O    196  100.0
LGWR wait for redo copy    2666   99.6    .2    .2          .1
asynch descriptor resize     41  100.0
buffer busy waits           643   98.0    .6    .8    .2    .2          .3
control file parallel writ  657   91.2   4.0   2.7   1.2    .6    .2    .2
control file sequential re 2818   71.9    .6   2.8   9.6   8.0   3.9   3.2
cursor: pin S                63   55.6   6.3   4.8        31.7   1.6
cursor: pin S wait on X      74    2.7   1.4         1.4  17.6  13.5  63.5
db file async I/O submit   2578  100.0
db file parallel read        28                7.1  35.7  42.9  10.7   3.6
db file parallel write       39K  95.0    .4    .3    .5   3.8    .0    .0
db file scattered read       93    7.5  10.8   6.5  21.5  30.1  16.1   7.5
db file sequential read     776K   2.1   2.0  14.0  39.2  25.8  10.3   6.7
direct path read             32    6.3   6.3  21.9  15.6  18.8  25.0   6.3
direct path write            15   93.3         6.7
enq: CU - contention          1              100.0
enq: HW - contention          4   25.0                          50.0  25.0
enq: TX - contention          1                                      100.0
enq: TX - index contention   32   25.0   3.1   9.4  15.6  18.8  12.5  15.6
enq: TX - row lock content 1249   84.9   4.0   3.0   3.8   1.8   1.8    .8
kksfbc child completion       6                                      100.0
latch free                  203   93.6   3.0          .5   2.0   1.0
latch: In memory undo latc  255   96.9   1.6   1.2          .4
latch: cache buffers chain 1379   94.6   2.8   2.0    .2    .2          .1
latch: cache buffers lru c   22  100.0
latch: checkpoint queue la    1  100.0
latch: enqueue hash chains   28   96.4   3.6
latch: messages               3  100.0
latch: object queue header   56   94.6   1.8   3.6
latch: redo allocation       45   97.8         2.2
latch: redo writing           2  100.0
latch: row cache objects      8  100.0
latch: session allocation     2  100.0
latch: shared pool            9   44.4  11.1  22.2  22.2
latch: undo global data       6  100.0
library cache load lock      27   11.1         3.7        22.2  55.6   7.4
library cache lock           50   58.0   2.0   2.0        16.0   2.0  20.0
library cache: mutex X      218   83.0   2.3    .5        11.5   1.8    .9
log file parallel write     243K  92.6   3.3   2.3   1.0    .6    .2    .0
log file sequential read     56   26.8   7.1  14.3  16.1  23.2   5.4   7.1
log file single write        56  100.0
log file switch (checkpoin  148                2.0   2.7  11.5  16.2  67.6
log file switch (private s  265    1.5   1.1   1.9   4.2   7.2  21.5  62.6
log file sync               257K  85.2   5.8   3.9   2.2   2.1    .7    .1
Wait Event Histogram  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> Total Waits - units: K is 1000, M is 1000000, G is 1000000000
-> % of Waits - column heading: <=1s is truly <1024ms, >1s is truly >=1024ms
-> % of Waits - value: .0 indicates value was <.05%, null is truly 0
-> Ordered by Event (idle events last)

                           Total ----------------- % of Waits ------------------
Event                      Waits  <1ms  <2ms  <4ms  <8ms <16ms <32ms  <=1s   >1s
-------------------------- ----- ----- ----- ----- ----- ----- ----- ----- -----
os thread startup            11                                      100.0
read by other session      4240    4.0   5.1  15.5  33.4  22.2  11.8   7.9
reliable message             60  100.0
row cache lock               11    9.1        90.9
ASM background timer        180                                            100.0
DIAG idle wait             1796                                       99.9    .1
KSV master wait              85   98.8         1.2
SQL*Net message from clien 1996K  26.6    .2    .2    .1  46.2  26.1    .7
SQL*Net message to client  1996K 100.0    .0    .0    .0
Space Manager: slave idle   454                                        3.1  96.9
Streams AQ: qmn coordinato  288   54.9          .3                          44.8
Streams AQ: qmn slave idle  129                                            100.0
class slave wait            264   35.6          .4    .8   3.4   5.3  22.3  32.2
jobq slave wait             121                                      100.0
pmon timer                  364     .3                .5   1.1        11.8  86.3
rdbms ipc message           247K  31.6  17.6  21.9  18.3   7.5    .7   1.5    .9
smon timer                   42   14.3                                 7.1  78.6
wait for unread message on  898                                      100.0
          -------------------------------------------------------------

SQL ordered by CPU  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> Total DB CPU (s):           2,890
-> Captured SQL accounts for   87.9% of Total DB CPU
-> SQL reported below exceeded  1.0% of Total DB CPU

    CPU                  CPU per             Elapsd                     Old
  Time (s)   Executions  Exec (s)  %Total   Time (s)    Buffer Gets  Hash Value
---------- ------------ ---------- ------ ---------- --------------- ----------
   2144.30       10,426       0.21   74.2    2315.38     292,550,832 1481390170
Module: Swingbench User Thread
SELECT /*+  first_rows index(customers, customers_pk) index(orde
rs, order_status_ix) */  o.order_id, line_item_id, product_id, u
nit_price, quantity, order_mode, order_status, order_total, sale
s_rep_id, promotion_id, c.customer_id, cust_first_name, cust_las

     73.76      310,978       0.00    2.6      84.74       9,336,635 3277652708
Module: Swingbench User Thread
select product_id, product_name, product_description, category_i
d, weight_class, supplier_id,  product_status  list_price, min_p
rice, catalog_url from  product_information where category_id =
:1

     52.24      176,000       0.00    1.8    3641.24         704,446 3739063178
Module: Swingbench User Thread
select customer_id, cust_first_name ,cust_last_name ,nls_languag
e ,nls_territory ,credit_limit ,cust_email ,account_mgr_id  from
 customers where customer_id = :1

     51.89      147,205       0.00    1.8    1334.71       1,954,551  688899339
Module: Swingbench User Thread
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT
_PRICE, QUANTITY) values (:1 , :2 , :3 , :4 , :5 )

     34.60       51,997       0.00    1.2    1297.94         975,201 3476971243
Module: Swingbench User Thread
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_
ID) values (:1 , :2 , :3 , :4 )

          -------------------------------------------------------------
SQL ordered by Elapsed time for DB: DBM11203  Instance: DBM11203  Snaps: 552 -55
-> Total DB Time (s):          12,727
-> Captured SQL accounts for   95.3% of Total DB Time
-> SQL reported below exceeded  1.0% of Total DB Time

  Elapsed                Elap per            CPU                        Old
  Time (s)   Executions  Exec (s)  %Total   Time (s)  Physical Reads Hash Value
---------- ------------ ---------- ------ ---------- --------------- ----------
   3641.24      176,000       0.02   28.6      52.24         271,664 3739063178
Module: Swingbench User Thread
select customer_id, cust_first_name ,cust_last_name ,nls_languag
e ,nls_territory ,credit_limit ,cust_email ,account_mgr_id  from
 customers where customer_id = :1

   2315.38       10,426       0.22   18.2    2144.30           6,397 1481390170
Module: Swingbench User Thread
SELECT /*+  first_rows index(customers, customers_pk) index(orde
rs, order_status_ix) */  o.order_id, line_item_id, product_id, u
nit_price, quantity, order_mode, order_status, order_total, sale
s_rep_id, promotion_id, c.customer_id, cust_first_name, cust_las

   1334.71      147,205       0.01   10.5      51.89         112,324  688899339
Module: Swingbench User Thread
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT
_PRICE, QUANTITY) values (:1 , :2 , :3 , :4 , :5 )

   1297.94       51,997       0.02   10.2      34.60         100,283 3476971243
Module: Swingbench User Thread
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_
ID) values (:1 , :2 , :3 , :4 )

   1042.67       51,784       0.02    8.2      21.25          94,055 3620601857
Module: Swingbench User Thread
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_
price, quantity, order_mode, order_status, order_total, sales_re
p_id, promotion_id, c.customer_id, cust_first_name, cust_last_na
me, credit_limit, cust_email   FROM orders o , order_items oi, c

   1016.01      147,183       0.01    8.0      26.51          82,779  686658588
Module: Swingbench User Thread
update inventories set quantity_on_hand = quantity_on_hand - :1
 where product_id = :2  and warehouse_id = :3

    827.19       20,479       0.04    6.5      18.07          71,190 2136488753
Module: Swingbench User Thread
insert into customers (customer_id ,cust_first_name ,cust_last_n
ame ,nls_language ,nls_territory ,credit_limit ,cust_email ,acco
unt_mgr_id ) values (:1  , :2  , :3  , :4  , :5  , :6  ,:7  , :8
 )

    324.88       51,995       0.01    2.6      19.32          25,848 1179264167
Module: Swingbench User Thread
update orders set order_mode = :1 , order_status = :2 , order_to
tal = :3  where order_id = :4

          -------------------------------------------------------------
SQL ordered by Gets  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> End Buffer Gets Threshold:     10000 Total Buffer Gets:     587,228,518
-> Captured SQL accounts for -631.4% of Total Buffer Gets
-> SQL reported below exceeded  1.0% of Total Buffer Gets

                                                     CPU      Elapsd     Old
  Buffer Gets    Executions  Gets per Exec  %Total Time (s)  Time (s) Hash Value
--------------- ------------ -------------- ------ -------- --------- ----------
    292,550,832       10,426       28,059.7   49.8  2144.30   2315.38 1481390170
Module: Swingbench User Thread
SELECT /*+  first_rows index(customers, customers_pk) index(orde
rs, order_status_ix) */  o.order_id, line_item_id, product_id, u
nit_price, quantity, order_mode, order_status, order_total, sale
s_rep_id, promotion_id, c.customer_id, cust_first_name, cust_las

      9,336,635      310,978           30.0    1.6    73.76     84.74 3277652708
Module: Swingbench User Thread
select product_id, product_name, product_description, category_i
d, weight_class, supplier_id,  product_status  list_price, min_p
rice, catalog_url from  product_information where category_id =
:1

          -------------------------------------------------------------
SQL ordered by Reads  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> End Disk Reads Threshold:      1000  Total Disk Reads:         777,369
-> Captured SQL accounts for   99.7% of Total Disk Reads
-> SQL reported below exceeded  1.0% of Total Disk Reads

                                                     CPU      Elapsd
  Physical Rds   Executions  Rds per Exec   %Total Time (s)  Time (s) Hash Value
--------------- ------------ -------------- ------ -------- --------- ----------
        271,664      176,000            1.5   34.9    52.24   3641.24 3739063178
Module: Swingbench User Thread
select customer_id, cust_first_name ,cust_last_name ,nls_languag
e ,nls_territory ,credit_limit ,cust_email ,account_mgr_id  from
 customers where customer_id = :1

        112,324      147,205            0.8   14.4    51.89   1334.71  688899339
Module: Swingbench User Thread
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT
_PRICE, QUANTITY) values (:1 , :2 , :3 , :4 , :5 )

        100,283       51,997            1.9   12.9    34.60   1297.94 3476971243
Module: Swingbench User Thread
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_
ID) values (:1 , :2 , :3 , :4 )

         94,055       51,784            1.8   12.1    21.25   1042.67 3620601857
Module: Swingbench User Thread
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_
price, quantity, order_mode, order_status, order_total, sales_re
p_id, promotion_id, c.customer_id, cust_first_name, cust_last_na
me, credit_limit, cust_email   FROM orders o , order_items oi, c

         82,779      147,183            0.6   10.6    26.51   1016.01  686658588
Module: Swingbench User Thread
update inventories set quantity_on_hand = quantity_on_hand - :1
 where product_id = :2  and warehouse_id = :3

         71,190       20,479            3.5    9.2    18.07    827.19 2136488753
Module: Swingbench User Thread
insert into customers (customer_id ,cust_first_name ,cust_last_n
ame ,nls_language ,nls_territory ,credit_limit ,cust_email ,acco
unt_mgr_id ) values (:1  , :2  , :3  , :4  , :5  , :6  ,:7  , :8
 )

         25,848       51,995            0.5    3.3    19.32    324.88 1179264167
Module: Swingbench User Thread
update orders set order_mode = :1 , order_status = :2 , order_to
tal = :3  where order_id = :4

          -------------------------------------------------------------
SQL ordered by Executions  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> End Executions Threshold:       100  Total Executions:       1,735,485
-> Captured SQL accounts for   99.9% of Total Executions
-> SQL reported below exceeded  1.0% of Total Executions

                                                CPU per    Elap per     Old
 Executions   Rows Processed   Rows per Exec    Exec (s)   Exec (s)  Hash Value
------------ --------------- ---------------- ----------- ---------- ----------
     310,978       1,565,372              5.0       0.00        0.00  3277652708
Module: Swingbench User Thread
select product_id, product_name, product_description, category_i
d, weight_class, supplier_id,  product_status  list_price, min_p
rice, catalog_url from  product_information where category_id =
:1

     176,005         175,999              1.0       0.00        0.00  3603038931
Module: Swingbench User Thread
insert into logon values(:1 ,:2 )

     176,000         175,988              1.0       0.00        0.02  3739063178
Module: Swingbench User Thread
select customer_id, cust_first_name ,cust_last_name ,nls_languag
e ,nls_territory ,credit_limit ,cust_email ,account_mgr_id  from
 customers where customer_id = :1

     154,960       1,549,580             10.0       0.00        0.00  1686147568
Module: Swingbench User Thread
select  p.product_id, product_name, product_description, categor
y_id, weight_class, supplier_id, product_status, list_price, min
_price, catalog_url,  quantity_on_hand, warehouse_id from   prod
uct_information p,  inventories i where  category_id = :1  and i

     147,205         147,202              1.0       0.00        0.01   688899339
Module: Swingbench User Thread
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT
_PRICE, QUANTITY) values (:1 , :2 , :3 , :4 , :5 )

     147,205       1,471,950             10.0       0.00        0.00  1757860790
Module: Swingbench User Thread
select  p.product_id, product_name, product_description, categor
y_id, weight_class, supplier_id,  product_status,  list_price, m
in_price, catalog_url, quantity_on_hand, warehouse_id from  prod
uct_information p, inventories i where   i.product_id = :1   and

     147,200         147,201              1.0       0.00        0.00  2907983846
Module: Swingbench User Thread
select product_id, product_name, product_description, category_i
d, weight_class, supplier_id, product_status, list_price, min_pr
ice, catalog_url from  product_information where product_id = :1


     147,183         132,610              0.9       0.00        0.01   686658588
Module: Swingbench User Thread
update inventories set quantity_on_hand = quantity_on_hand - :1
 where product_id = :2  and warehouse_id = :3

      52,000          52,000              1.0       0.00        0.00  2008308816
Module: Swingbench User Thread
select orders_seq.nextval from dual

SQL ordered by Executions  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> End Executions Threshold:       100  Total Executions:       1,735,485
-> Captured SQL accounts for   99.9% of Total Executions
-> SQL reported below exceeded  1.0% of Total Executions

                                                CPU per    Elap per     Old
 Executions   Rows Processed   Rows per Exec    Exec (s)   Exec (s)  Hash Value
------------ --------------- ---------------- ----------- ---------- ----------
      51,997          51,996              1.0       0.00        0.02  3476971243
Module: Swingbench User Thread
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_
ID) values (:1 , :2 , :3 , :4 )

      51,995          51,995              1.0       0.00        0.01  1179264167
Module: Swingbench User Thread
update orders set order_mode = :1 , order_status = :2 , order_to
tal = :3  where order_id = :4

      51,994         147,157              2.8       0.00        0.00  3653456532
Module: Swingbench User Thread
SELECT  o.order_id,   line_item_id,   product_id,   unit_price,
  quantity,   order_mode,   order_status,   order_total,   sales
_rep_id,   promotion_id,   c.customer_id,   cust_first_name,   c
ust_last_name,   credit_limit,   cust_email  FROM    orders o ,

      51,784          49,883              1.0       0.00        0.02  3620601857
Module: Swingbench User Thread
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_
price, quantity, order_mode, order_status, order_total, sales_re
p_id, promotion_id, c.customer_id, cust_first_name, cust_last_na
me, credit_limit, cust_email   FROM orders o , order_items oi, c

      20,479          20,479              1.0       0.00        0.04  2136488753
Module: Swingbench User Thread
insert into customers (customer_id ,cust_first_name ,cust_last_n
ame ,nls_language ,nls_territory ,credit_limit ,cust_email ,acco
unt_mgr_id ) values (:1  , :2  , :3  , :4  , :5  , :6  ,:7  , :8
 )

      20,477          20,477              1.0       0.00        0.00  2838916525
Module: Swingbench User Thread
select customer_seq.nextval from dual

          -------------------------------------------------------------
SQL ordered by Parse Calls  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> End Parse Calls Threshold:      1000 Total Parse Calls:           1,315
-> Captured SQL accounts for   56.9% of Total Parse Calls
-> SQL reported below exceeded  1.0% of Total Parse Calls

                           % Total    Old
 Parse Calls   Executions   Parses Hash Value
------------ ------------ -------- ----------
         151          151    11.48 2554034351
lock table sys.col_usage$ in exclusive mode nowait

         137          137    10.42 2396279102
lock table sys.mon_mods$ in exclusive mode nowait

          22           62     1.67 2926525797
select type#,blocks,extents,minexts,maxexts,extsize,extpct,user#
,iniexts,NVL(lists,65535),NVL(groups,65535),cachehint,hwmincr, N
VL(spare1,0),NVL(scanhint,0),NVL(bitmapranges,0) from seg$ where
 ts#=:1 and file#=:2 and block#=:3

          19          111     1.44 1254950678
select file# from file$ where ts#=:1

          15      147,183     1.14  686658588
Module: Swingbench User Thread
update inventories set quantity_on_hand = quantity_on_hand - :1
 where product_id = :2  and warehouse_id = :3

          15      147,205     1.14  688899339
Module: Swingbench User Thread
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT
_PRICE, QUANTITY) values (:1 , :2 , :3 , :4 , :5 )

          15       51,995     1.14 1179264167
Module: Swingbench User Thread
update orders set order_mode = :1 , order_status = :2 , order_to
tal = :3  where order_id = :4

          15       10,426     1.14 1481390170
Module: Swingbench User Thread
SELECT /*+  first_rows index(customers, customers_pk) index(orde
rs, order_status_ix) */  o.order_id, line_item_id, product_id, u
nit_price, quantity, order_mode, order_status, order_total, sale
s_rep_id, promotion_id, c.customer_id, cust_first_name, cust_las

          15       10,421     1.14 1657735458
Module: Swingbench User Thread
update /*+ index(orders, order_pk) */ orders set order_status =
:1  where order_id = :2

          15      154,960     1.14 1686147568
Module: Swingbench User Thread
select  p.product_id, product_name, product_description, categor
y_id, weight_class, supplier_id, product_status, list_price, min
_price, catalog_url,  quantity_on_hand, warehouse_id from   prod
uct_information p,  inventories i where  category_id = :1  and i

          15      147,205     1.14 1757860790
Module: Swingbench User Thread
select  p.product_id, product_name, product_description, categor
SQL ordered by Parse Calls  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> End Parse Calls Threshold:      1000 Total Parse Calls:           1,315
-> Captured SQL accounts for   56.9% of Total Parse Calls
-> SQL reported below exceeded  1.0% of Total Parse Calls

                           % Total    Old
 Parse Calls   Executions   Parses Hash Value
------------ ------------ -------- ----------
y_id, weight_class, supplier_id,  product_status,  list_price, m
in_price, catalog_url, quantity_on_hand, warehouse_id from  prod
uct_information p, inventories i where   i.product_id = :1   and

          15       52,000     1.14 2008308816
Module: Swingbench User Thread
select orders_seq.nextval from dual

          15       20,479     1.14 2136488753
Module: Swingbench User Thread
insert into customers (customer_id ,cust_first_name ,cust_last_n
ame ,nls_language ,nls_territory ,credit_limit ,cust_email ,acco
unt_mgr_id ) values (:1  , :2  , :3  , :4  , :5  , :6  ,:7  , :8
 )

          15       20,477     1.14 2838916525
Module: Swingbench User Thread
select customer_seq.nextval from dual

          15      147,200     1.14 2907983846
Module: Swingbench User Thread
select product_id, product_name, product_description, category_i
d, weight_class, supplier_id, product_status, list_price, min_pr
ice, catalog_url from  product_information where product_id = :1


          15      310,978     1.14 3277652708
Module: Swingbench User Thread
select product_id, product_name, product_description, category_i
d, weight_class, supplier_id,  product_status  list_price, min_p
rice, catalog_url from  product_information where category_id =
:1

          15       51,997     1.14 3476971243
Module: Swingbench User Thread
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_
ID) values (:1 , :2 , :3 , :4 )

          15      176,005     1.14 3603038931
Module: Swingbench User Thread
insert into logon values(:1 ,:2 )

          15       51,784     1.14 3620601857
Module: Swingbench User Thread
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_
price, quantity, order_mode, order_status, order_total, sales_re
p_id, promotion_id, c.customer_id, cust_first_name, cust_last_na
me, credit_limit, cust_email   FROM orders o , order_items oi, c

          15       51,994     1.14 3653456532
Module: Swingbench User Thread
SELECT  o.order_id,   line_item_id,   product_id,   unit_price,
SQL ordered by Parse Calls  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> End Parse Calls Threshold:      1000 Total Parse Calls:           1,315
-> Captured SQL accounts for   56.9% of Total Parse Calls
-> SQL reported below exceeded  1.0% of Total Parse Calls

                           % Total    Old
 Parse Calls   Executions   Parses Hash Value
------------ ------------ -------- ----------
  quantity,   order_mode,   order_status,   order_total,   sales
_rep_id,   promotion_id,   c.customer_id,   cust_first_name,   c
ust_last_name,   credit_limit,   cust_email  FROM    orders o ,

          15      176,000     1.14 3739063178
Module: Swingbench User Thread
select customer_id, cust_first_name ,cust_last_name ,nls_languag
e ,nls_territory ,credit_limit ,cust_email ,account_mgr_id  from
 customers where customer_id = :1

          14          106     1.06 2869918817
select a.default_cpu_cost, a.default_io_cost             from as
sociation$ a                                      where a.obj# =
 :1                                          and a.property = :2

          -------------------------------------------------------------
Instance Activity Stats  DB/Inst: DBM11203/DBM11203  Snaps: 552-553

Statistic                                      Total     per Second    per Trans
--------------------------------- ------------------ -------------- ------------
Batched IO (bound) vector count                  428            0.5          0.0
Batched IO (full) vector count                     0            0.0          0.0
Batched IO block miss count                      762            0.9          0.0
Batched IO buffer defrag count                     3            0.0          0.0
Batched IO double miss count                     125            0.1          0.0
Batched IO same unit count                       261            0.3          0.0
Batched IO single block count                    493            0.6          0.0
Batched IO vector block count                    122            0.1          0.0
Batched IO vector read count                      60            0.1          0.0
Block Cleanout Optim referenced                6,824            7.6          0.0
CCursor + sql area evicted                         0            0.0          0.0
CPU used by this session                     275,563          306.5          1.1
CPU used when call started                   275,342          306.3          1.1
CR blocks created                             77,161           85.8          0.3
Cached Commit SCN referenced                  42,481           47.3          0.2
Commit SCN cached                              8,652            9.6          0.0
DB time                                    1,269,127        1,411.7          4.9
DBWR checkpoint buffers written               32,147           35.8          0.1
DBWR checkpoints                                  14            0.0          0.0
DBWR thread checkpoint buffers wr             32,147           35.8          0.1
DBWR transaction table writes                    290            0.3          0.0
DBWR undo block writes                        24,103           26.8          0.1
HSC Heap Segment Block Changes               592,069          658.6          2.3
Heap Segment Array Inserts                       168            0.2          0.0
Heap Segment Array Updates                        21            0.0          0.0
IMU CR rollbacks                              18,207           20.3          0.1
IMU Flushes                                   30,005           33.4          0.1
IMU Redo allocation size                 144,018,092      160,198.1        556.2
IMU commits                                  167,570          186.4          0.7
IMU contention                                26,501           29.5          0.1
IMU ktichg flush                                   0            0.0          0.0
IMU pool not allocated                        61,465           68.4          0.2
IMU recursive-transaction flush                    0            0.0          0.0
IMU undo allocation size                 373,504,056      415,466.1      1,442.5
IMU- failed to get a private stra             61,465           68.4          0.2
LOB table id lookup cache misses                   0            0.0          0.0
PX local messages recv'd                           0            0.0          0.0
PX local messages sent                             0            0.0          0.0
Requests to/from client                    1,996,546        2,220.9          7.7
RowCR - row contention                           265            0.3          0.0
RowCR attempts                               160,556          178.6          0.6
RowCR hits                                   157,752          175.5          0.6
SMON posted for undo segment shri                 27            0.0          0.0
SQL*Net roundtrips to/from client          1,997,070        2,221.4          7.7
active txn count during cleanout              60,680           67.5          0.2
application wait time                            225            0.3          0.0
background checkpoints completed                  14            0.0          0.0
background checkpoints started                    14            0.0          0.0
background timeouts                            4,670            5.2          0.0
branch node splits                                 4            0.0          0.0
buffer is not pinned count               285,946,869      318,072.2      1,104.4
buffer is pinned count                   288,262,229      320,647.6      1,113.3
bytes received via SQL*Net from c        487,718,453      542,512.2      1,883.6
bytes sent via SQL*Net to client       1,081,387,180    1,202,877.8      4,176.5
calls to get snapshot scn: kcmgss          1,600,923        1,780.8          6.2
calls to kcmgas                              351,301          390.8          1.4
Instance Activity Stats  DB/Inst: DBM11203/DBM11203  Snaps: 552-553

Statistic                                      Total     per Second    per Trans
--------------------------------- ------------------ -------------- ------------
calls to kcmgcs                            1,023,522        1,138.5          4.0
cell physical IO interconnect byt     11,907,248,128   13,244,992.4     45,987.6
change write time                              2,219            2.5          0.0
cleanout - number of ktugct calls             46,993           52.3          0.2
cleanouts and rollbacks - consist             33,808           37.6          0.1
cleanouts only - consistent read                 946            1.1          0.0
cluster key scan block gets                    3,860            4.3          0.0
cluster key scans                              3,012            3.4          0.0
commit batch/immediate performed                  34            0.0          0.0
commit batch/immediate requested                  34            0.0          0.0
commit cleanout failures: block l                 10            0.0          0.0
commit cleanout failures: buffer                  40            0.0          0.0
commit cleanout failures: callbac                225            0.3          0.0
commit cleanout failures: cannot               7,589            8.4          0.0
commit cleanouts                           1,063,524        1,183.0          4.1
commit cleanouts successfully com          1,055,660        1,174.3          4.1
commit immediate performed                        34            0.0          0.0
commit immediate requested                        34            0.0          0.0
commit txn count during cleanout              72,408           80.5          0.3
concurrency wait time                          1,156            1.3          0.0
consistent changes                           175,577          195.3          0.7
consistent gets                          582,388,209      647,817.8      2,249.3
consistent gets - examination            380,120,573      422,826.0      1,468.1
consistent gets direct                             0            0.0          0.0
consistent gets from cache               582,388,204      647,817.8      2,249.3
consistent gets from cache (fastp        201,930,012      224,616.3        779.9
cursor authentications                            44            0.1          0.0
data blocks consistent reads - un            162,802          181.1          0.6
db block changes                           3,578,746        3,980.8         13.8
db block gets                              4,840,274        5,384.1         18.7
db block gets direct                              47            0.1          0.0
db block gets from cache                   4,840,228        5,384.0         18.7
db block gets from cache (fastpat          1,660,791        1,847.4          6.4
deferred (CURRENT) block cleanout            373,511          415.5          1.4
dirty buffers inspected                      365,135          406.2          1.4
enqueue conversions                              571            0.6          0.0
enqueue releases                             622,369          692.3          2.4
enqueue requests                             622,393          692.3          2.4
enqueue timeouts                                   0            0.0          0.0
enqueue waits                                  1,287            1.4          0.0
execute count                              1,735,485        1,930.5          6.7
file io service time                               0            0.0          0.0
file io wait time                     15,530,899,851   17,275,750.7     59,982.7
free buffer inspected                        869,175          966.8          3.4
free buffer requested                        883,025          982.2          3.4
heap block compress                              852            1.0          0.0
hot buffers moved to head of LRU             481,129          535.2          1.9
immediate (CR) block cleanout app             34,754           38.7          0.1
immediate (CURRENT) block cleanou             40,779           45.4          0.2
in call idle wait time                     2,542,605        2,828.3          9.8
index crx upgrade (positioned)                     0            0.0          0.0
index fast full scans (full)                       2            0.0          0.0
index fetch by key                        94,928,168      105,593.1        366.6
index scans kdiixs1                       94,670,611      105,306.6        365.6
leaf node 90-10 splits                            21            0.0          0.0
leaf node splits                               1,980            2.2          0.0
Instance Activity Stats  DB/Inst: DBM11203/DBM11203  Snaps: 552-553

Statistic                                      Total     per Second    per Trans
--------------------------------- ------------------ -------------- ------------
lob reads                                          0            0.0          0.0
lob writes                                        93            0.1          0.0
lob writes unaligned                              93            0.1          0.0
logical read bytes from cache      4,810,575,241,216 ############## ############
logons cumulative                                 27            0.0          0.0
max cf enq hold time                              30            0.0          0.0
messages received                            289,104          321.6          1.1
messages sent                                289,104          321.6          1.1
min active SCN optimization appli            226,536          252.0          0.9
no buffer to keep pinned count                     3            0.0          0.0
no work - consistent read gets           201,109,130      223,703.2        776.7
non-idle wait count                        3,601,951        4,006.6         13.9
non-idle wait time                           996,510        1,108.5          3.9
opened cursors cumulative                  1,734,376        1,929.2          6.7
parse count (describe)                            10            0.0          0.0
parse count (failures)                             0            0.0          0.0
parse count (hard)                               274            0.3          0.0
parse count (total)                            1,315            1.5          0.0
parse time cpu                                 3,168            3.5          0.0
parse time elapsed                             4,410            4.9          0.0
physical read IO requests                    776,655          863.9          3.0
physical read bytes                    6,368,206,848    7,083,656.1     24,595.0
physical read total IO requests              779,533          867.1          3.0
physical read total bytes              6,414,446,592    7,135,090.8     24,773.6
physical read total multi block r                  2            0.0          0.0
physical reads                               777,369          864.7          3.0
physical reads cache                         777,299          864.6          3.0
physical reads cache prefetch                    744            0.8          0.0
physical reads direct                             70            0.1          0.0
physical reads direct temporary t                  0            0.0          0.0
physical reads prefetch warmup                     0            0.0          0.0
physical write IO requests                   385,321          428.6          1.5
physical write bytes                   4,291,624,960    4,773,776.4     16,574.9
physical write total IO requests             879,559          978.4          3.4
physical write total bytes             5,492,707,328    6,109,796.8     21,213.7
physical write total multi block                 357            0.4          0.0
physical writes                              523,880          582.7          2.0
physical writes direct                           117            0.1          0.0
physical writes direct (lob)                       0            0.0          0.0
physical writes direct temporary                   0            0.0          0.0
physical writes from cache                   523,763          582.6          2.0
physical writes non checkpoint               428,608          476.8          1.7
pinned buffers inspected                          99            0.1          0.0
pinned cursors current                            11            0.0          0.0
prefetch warmup blocks aged out b                  0            0.0          0.0
prefetched blocks aged out before                  2            0.0          0.0
process last non-idle time                       898            1.0          0.0
recovery blocks read                               0            0.0          0.0
recursive calls                              289,078          321.6          1.1
recursive cpu usage                            2,370            2.6          0.0
redo KB read                                       0            0.0          0.0
redo blocks checksummed by FG (ex            294,626          327.7          1.1
redo blocks read for recovery                      0            0.0          0.0
redo blocks written                        1,151,985        1,281.4          4.5
redo buffer allocation retries                   443            0.5          0.0
redo entries                               1,205,326        1,340.7          4.7
Instance Activity Stats  DB/Inst: DBM11203/DBM11203  Snaps: 552-553

Statistic                                      Total     per Second    per Trans
--------------------------------- ------------------ -------------- ------------
redo k-bytes read for recovery                     0            0.0          0.0
redo log space requests                          471            0.5          0.0
redo log space wait time                       1,869            2.1          0.0
redo ordering marks                           11,277           12.5          0.0
redo size                                500,782,520      557,044.0      1,934.1
redo size for direct writes                      104            0.1          0.0
redo subscn max counts                        28,856           32.1          0.1
redo synch long waits                            855            1.0          0.0
redo synch time                               27,310           30.4          0.1
redo synch time (usec)                   273,100,809      303,782.9      1,054.8
redo synch writes                            259,022          288.1          1.0
redo wastage                              70,346,728       78,250.0        271.7
redo write time                               12,789           14.2          0.1
redo writes                                  243,627          271.0          0.9
rollback changes - undo records a                126            0.1          0.0
rollbacks only - consistent read              42,220           47.0          0.2
rows fetched via callback                 94,713,796      105,354.6        365.8
session connect time                               0            0.0          0.0
session cursor cache hits                     97,427          108.4          0.4
session logical reads                    587,228,518      653,201.9      2,268.0
session pga memory                        36,670,528       40,790.4        141.6
session pga memory max                    59,790,368       66,507.6        230.9
session uga memory                     4,304,363,288    4,787,945.8     16,624.1
session uga memory max                    48,755,400       54,232.9        188.3
shared hash latch upgrades - no w            429,893          478.2          1.7
shared hash latch upgrades - wait                 55            0.1          0.0
sorts (memory)                                 2,028            2.3          0.0
sorts (rows)                                  26,697           29.7          0.1
sql area evicted                                 238            0.3          0.0
sql area purged                                    0            0.0          0.0
summed dirty queue length                  3,193,461        3,552.2         12.3
switch current to new buffer                     711            0.8          0.0
table fetch by rowid                     192,304,327      213,909.2        742.7
table fetch continued row                        157            0.2          0.0
table scan blocks gotten                   8,724,146        9,704.3         33.7
table scan rows gotten                   311,541,126      346,541.9      1,203.2
table scans (long tables)                          0            0.0          0.0
table scans (short tables)                   311,173          346.1          1.2
temp space allocated (bytes)                       0            0.0          0.0
total cf enq hold time                         4,920            5.5          0.0
total number of cf enq holders                    89            0.1          0.0
total number of times SMON posted                 42            0.1          0.0
transaction rollbacks                             33            0.0          0.0
undo change vector size                  165,092,072      183,639.7        637.6
user I/O wait time                           951,187        1,058.1          3.7
user calls                                 3,673,434        4,086.1         14.2
user commits                                 258,923          288.0          1.0
workarea executions - optimal                  1,045            1.2          0.0
write clones created in foregroun                681            0.8          0.0
          -------------------------------------------------------------

Instance Activity Stats  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> Statistics with absolute values (should not be diffed)

Statistic                             Begin Value       End Value
--------------------------------- --------------- ---------------
logons current                                 59              74
opened cursors current                         99             131
session cursor cache count                  3,531           4,136
          -------------------------------------------------------------

Instance Activity Stats  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> Statistics identified by '(derived)' come from sources other than SYSSTAT

Statistic                                      Total  per Hour
--------------------------------- ------------------ ---------
log switches (derived)                            14     56.06
          -------------------------------------------------------------

OS Statistics  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> ordered by statistic type (CPU use, Virtual Memory, Hardware Config), Name

Statistic                                  Total
------------------------- ----------------------
BUSY_TIME                                298,510
IDLE_TIME                                406,519
IOWAIT_TIME                              216,526
NICE_TIME                                    102
SYS_TIME                                  10,230
USER_TIME                                282,560
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

OS Statistics - detail  DB/Inst: DBM11203/DBM11203  Snaps: 552-553

  Snap Snapshot
    Id Day Time          Load  %Busy  %User %System   %WIO  %WCPU
------ --------------- ------ ------ ------ ------- ------ ------
   552 Wed 23 19:30:41    7.9
   553 Wed 23 19:45:40   14.9   42.3   40.1     1.5   30.7
          -------------------------------------------------------------
IO Stat by Function - summary  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
->Data Volume values suffixed with   M,G,T,P are in multiples of 1024,
  other values suffixed with       K,M,G,T,P are in multiples of 1000
->ordered by Data Volume (Read+Write) desc

               ---------- Read --------- --------- Write -------- --- Wait ----
                 Data  Requests    Data   Data  Requests    Data          Avg
Function        Volume     /sec  Vol/sec Volume     /sec  Vol/sec  Count Tm(ms)
--------------- ------ -------- -------- ------ -------- -------- ------ ------
Buffer Cache Re  6067M   862.9      6.7M                            776K    0.0
LGWR                6M      .5       .0M  1128M   548.2      1.3M   244K    0.0
Others             39M     2.7       .0M    16M     1.1       .0M  2964     0.0
Streams AQ          1M      .0       .0M                              8     0.0
Direct Reads                .1                       .0                     0.0
          -------------------------------------------------------------

IO Stat by Function - detail  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
->ordered by Data Volume (Read+Write) desc

                   ----------- Read ---------- ----------- Write ---------
                    Small  Large  Small  Large  Small  Large  Small  Large
                     Read   Read   Data   Data  Write  Write   Data   Data
Function             Reqs   Reqs   Read   Read   Reqs   Reqs  Writn  Writn
------------------ ------ ------ ------ ------ ------ ------ ------ ------
Buffer Cache Reads   776K     2   6065M     2M
LGWR                 413             6M          493K         1128M
Others              2462            39M         1005            16M
Streams AQ             8             1M
Direct Reads          70                          27
          -------------------------------------------------------------
Tablespace IO Stats  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
->ordered by IOs (Reads + Writes) desc

Tablespace
------------------------------
                 Av      Av     Av                    Av        Buffer Av Buf
         Reads Reads/s Rd(ms) Blks/Rd       Writes Writes/s      Waits Wt(ms)
-------------- ------- ------ ------- ------------ -------- ---------- ------
SOE
       773,223     860   12.2     1.0      381,707      425      5,018   10.3
UNDOTBS1
            89       0   10.7     1.0        2,827        3        117    0.3
SYSAUX
         1,404       2    9.6     1.3          536        1          0    0.0
SYSTEM
         1,131       1   10.2     1.3           34        0         63    2.4
USERS
            14       0    0.0     1.0           14        0          0    0.0
TEMP
             2       0   10.0     1.0            0        0          0    0.0
          -------------------------------------------------------------
File IO Stats  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
->Mx Rd Bkt: Max bucket time for single block read
->ordered by Tablespace, File

Tablespace               Filename
------------------------ ----------------------------------------------------
                        Av   Mx                                             Av
                 Av     Rd   Rd    Av                    Av        Buffer BufWt
         Reads Reads/s (ms)  Bkt Blks/Rd       Writes Writes/s      Waits  (ms)
-------------- ------- ----- --- ------- ------------ -------- ---------- ------
SOE                      +DATA/dbm11203/datafile/soe.486.836957131
       773,223     860  12.2 ###     1.0      381,707      425      5,018   10.3

SYSAUX                   +DATA/dbm11203/datafile/sysaux.460.772715927
         1,404       2   9.6 ###     1.3          536        1          0

SYSTEM                   +DATA/dbm11203/datafile/system.459.772715923
         1,131       1  10.2 ###     1.3           34        0         63    2.4

TEMP                     +DATA/dbm11203/tempfile/temp.462.772715931
             2       0  10.0         1.0            0        0          0

UNDOTBS1                 +DATA/dbm11203/datafile/undotbs1.461.772715929
            89       0  10.7 ###     1.0        2,827        3        117    0.3

USERS                    +DATA/dbm11203/datafile/users.463.772715939
            14       0   0.0         1.0           14        0          0

          -------------------------------------------------------------
File Read Histogram Stats  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
->Number of single block reads in each time range
->Tempfiles are not included
->ordered by Tablespace, File

Tablespace               Filename
------------------------ ----------------------------------------------------
    0 - 2 ms     2 - 4 ms    4 - 8 ms     8 - 16 ms   16 - 32 ms       32+ ms
------------ ------------ ------------ ------------ ------------ ------------
SYSTEM                   +DATA/dbm11203/datafile/system.459.772715923
         303          110          293          216           91           54

SYSAUX                   +DATA/dbm11203/datafile/sysaux.460.772715927
         318          271          318          265          116           59

UNDOTBS1                 +DATA/dbm11203/datafile/undotbs1.461.772715929
          22            6           13           17            9            8

SOE                      +DATA/dbm11203/datafile/soe.486.836957131
      31,224      108,115      303,265      199,464       79,256       51,987

          -------------------------------------------------------------
Instance Recovery Stats  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> B: Begin snapshot,  E: End snapshot

  Targt Estd                                  Log File  Log Ckpt    Log Ckpt
  MTTR  MTTR   Recovery   Actual    Target      Size     Timeout    Interval
   (s)   (s)   Estd IOs  Redo Blks Redo Blks Redo Blks  Redo Blks  Redo Blks
- ----- ----- ---------- --------- --------- ---------- --------- ------------
B     0    18      15598    168395    165888     165888    418267
E     0    18      16222    167071    165888     165888    425974
          -------------------------------------------------------------

Memory Dynamic Components  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
->  Op - memory resize Operation
->  Cache:    D: Default,  K: Keep,  R:  Recycle
->   Mode:  DEF: DEFerred mode,  IMM: IMMediate mode

                       Begin Snap End Snap   Op    Last Op
Cache                    Size (M) Size (M)  Count  Type/Mode   Last Op Time
---------------------- ---------- -------- ------- ---------- ---------------
D:buffer cache                728                0 SHRINK/IMM 23-Apr 16:34:00
PGA Target                    128                0 STATIC
SGA Target                  1,024                0 STATIC
java pool                       4                0 STATIC
large pool                      8                0 GROW/IMM   23-Apr 16:33:51
shared pool                   260                0 STATIC
streams pool                    8                0 GROW/IMM   23-Apr 16:34:00
          -------------------------------------------------------------

Buffer Pool Advisory  DB/Inst: DBM11203/DBM11203  End Snap: 553
-> Only rows with estimated physical reads >0 are displayed
-> ordered by Pool, Block Size, Buffers For Estimate

                                   Est
                                  Phys      Estimated                   Est
    Size for  Size      Buffers   Read     Phys Reads     Est Phys % dbtime
P    Est (M) Factr  (thousands)  Factr    (thousands)    Read Time  for Rds
--- -------- ----- ------------ ------ -------------- ------------ --------
D         72    .1            9  364.2      2,513,914   23,872,748   ######
D        144    .2           18  276.1      1,905,306   18,093,135   ######
D        216    .3           27  153.1      1,056,775   10,035,109   ######
D        288    .4           35   10.0         69,308      657,672    739.6
D        360    .5           44    1.4          9,787       92,438    103.9
D        432    .6           53    1.3          8,708       82,188     92.4
D        504    .7           62    1.2          8,039       75,835     85.3
D        576    .8           71    1.1          7,576       71,440     80.3
D        648    .9           80    1.0          7,211       67,972     76.4
D        720   1.0           88    1.0          6,929       65,295     73.4
D        728   1.0           89    1.0          6,902       65,036     73.1
D        792   1.1           97    1.0          6,695       63,072     70.9
D        864   1.2          106    0.9          6,495       61,178     68.8
D        936   1.3          115    0.9          6,318       59,492     66.9
D      1,008   1.4          124    0.9          6,154       57,937     65.2
D      1,080   1.5          133    0.9          6,000       56,471     63.5
D      1,152   1.6          141    0.9          5,868       55,220     62.1
D      1,224   1.7          150    0.8          5,748       54,082     60.8
D      1,296   1.8          159    0.8          5,578       52,464     59.0
D      1,368   1.9          168    0.7          4,897       46,000     51.7
D      1,440   2.0          177    0.6          4,257       39,918     44.9
          -------------------------------------------------------------

Buffer Pool Statistics  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> Standard block size Pools  D: default,  K: keep,  R: recycle
-> Default Pools for other block sizes: 2k, 4k, 8k, 16k, 32k
-> Buffers: the number of buffers.  Units of K, M, G are divided by 1000

                                                            Free Writ     Buffer
            Pool         Buffer     Physical    Physical  Buffer Comp       Busy
P   Buffers Hit%           Gets        Reads      Writes   Waits Wait      Waits
--- ------- ---- -------------- ------------ ----------- ------- ---- ----------
D       89K  100    582,892,402      776,740     523,468       0    0      5,200
          -------------------------------------------------------------

Buffer wait Statistics  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> ordered by wait time desc, waits desc

Class                        Waits Total Wait Time (s) Avg Time (ms)
---------------------- ----------- ------------------- -------------
data block                   5,073                  52            10
segment header                  22                   0             4
3rd level bmb                   11                   0             4
2nd level bmb                    9                   0             3
undo header                     46                   0             0
undo block                      72                   0             0
1st level bmb                    2                   0             0
          -------------------------------------------------------------
PGA Aggr Target Stats  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> B: Begin snap   E: End snap (rows identified with B or E contain data
   which is absolute i.e. not diffed over the interval)
-> PGA cache hit % - percentage of W/A (WorkArea) data processed only in-memory
-> Auto PGA Target - actual workarea memory target
-> W/A PGA Used    - amount of memory used for all WorkAreas (manual + auto)
-> %PGA W/A Mem    - percentage of PGA memory allocated to WorkAreas
-> %Auto W/A Mem   - percentage of WorkArea memory controlled by Auto Mem Mgmt
-> %Man W/A Mem    - percentage of WorkArea memory under Manual control

PGA Cache Hit % W/A MB Processed Extra W/A MB Read/Written
--------------- ---------------- -------------------------
          100.0               74                         0

Warning:  pga_aggregate_target was set too low for current workload, as this
          value was exceeded during this interval.  Use the PGA Advisory view
          to help identify a different value for pga_aggregate_target.

                                             %PGA  %Auto   %Man
  PGA Aggr  Auto PGA   PGA Mem    W/A PGA    W/A    W/A    W/A   Global Mem
  Target(M) Target(M)  Alloc(M)   Used(M)    Mem    Mem    Mem    Bound(K)
- --------- --------- ---------- ---------- ------ ------ ------ ----------
B       128         8      183.1        0.0     .0     .0     .0     26,214
E       128         8      219.4        0.0     .0     .0     .0     26,214
          -------------------------------------------------------------

PGA Aggr Target Histogram  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> Optimal Executions are purely in-memory operations

    Low    High
Optimal Optimal    Total Execs Optimal Execs 1-Pass Execs M-Pass Execs
------- ------- -------------- ------------- ------------ ------------
     2K      4K            808           808            0            0
    64K    128K              9             9            0            0
   128K    256K              3             3            0            0
   512K   1024K             57            57            0            0
     1M      2M              6             6            0            0
     4M      8M              4             4            0            0
          -------------------------------------------------------------

PGA Memory Advisory  DB/Inst: DBM11203/DBM11203  End Snap: 553
-> When using Auto Memory Mgmt, minimally choose a pga_aggregate_target value
   where Estd PGA Overalloc Count is 0

                                   Estd Extra                Estd
  PGA Aggr                           W/A MB      Estd Time    PGA   Estd PGA
    Target   Size         W/A MB  Read/Written  to Process  Cache  Overalloc
  Est (MB)  Factr      Processed    to Disk      Bytes (s)  Hit %      Count
---------- ------ -------------- -------------- ---------- ------ ----------
        16    0.1          1,728             32        2.9   98.0         11
        32    0.3          1,728             32        2.9   98.0         11
        64    0.5          1,728             32        2.9   98.0         11
        96    0.8          1,728             32        2.9   98.0         11
       128    1.0          1,728              0        2.8  100.0         11
       154    1.2          1,728              0        2.8  100.0          1
       179    1.4          1,728              0        2.8  100.0          0
       205    1.6          1,728              0        2.8  100.0          0
       230    1.8          1,728              0        2.8  100.0          0
       256    2.0          1,728              0        2.8  100.0          0
       384    3.0          1,728              0        2.8  100.0          0
       512    4.0          1,728              0        2.8  100.0          0
       768    6.0          1,728              0        2.8  100.0          0
     1,024    8.0          1,728              0        2.8  100.0          0
          -------------------------------------------------------------
Process Memory Summary Stats  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> B: Begin snap   E: End snap
-> All rows below contain absolute values (i.e. not diffed over the interval)
-> Max Alloc is Maximum PGA Allocation size at snapshot time
   Hist Max Alloc is the Historical Max Allocation for still-connected processes
-> Num Procs or Allocs:  For Begin/End snapshot lines, it is the number of
   processes. For Category lines, it is the number of allocations
-> ordered by Begin/End snapshot, Alloc (MB) desc

                                                                  Hist   Num
                                          Avg    Std Dev   Max    Max   Procs
             Alloc     Used    Freeabl   Alloc    Alloc   Alloc  Alloc    or
  Category   (MB)      (MB)      (MB)     (MB)    (MB)    (MB)    (MB)  Allocs
- -------- --------- --------- -------- -------- ------- ------- ------ ------
B --------     183.1     129.8     27.3      3.2     2.7      14     25     58
  Other        150.5                         2.6     2.4      14     25     58
  Freeable      27.3        .0               1.1     1.1       6            26
  PL/SQL         4.2       2.5                .1      .4       3      4     58
  SQL            1.1        .2                .0      .0       0      6     35
E --------     219.4     160.8     26.5      3.0     2.4      14     25     74
  Other        186.8                         2.5     2.2      14     25     74
  Freeable      26.5        .0               1.1     1.2       6            25
  PL/SQL         4.5       2.8                .1      .3       3      4     74
  SQL            1.6        .2                .0      .0       0      6     51
          -------------------------------------------------------------

Top Process Memory (by component)  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> ordered by Begin/End snapshot, Alloc (MB) desc

                        Alloc   Used   Freeabl     Max      Hist Max
     PId Category       (MB)    (MB)     (MB)   Alloc (MB) Alloc (MB)
- ------ ------------- ------- ------- -------- ---------- ----------
B     10 DBW0 --------    14.3    11.3       .0       14.3       25.3
         Other            14.3                        14.3       25.3
         PL/SQL             .0      .0                  .0         .0
      11 LGWR --------    12.9    12.1       .0       12.9       12.9
         Other            12.9                        12.9       12.9
         PL/SQL             .0      .0                  .0         .0
      24 J000 --------    10.0     3.0      5.9       10.0       10.0
         Freeable          5.9      .0                 5.9
         Other             3.7                         3.7        3.7
         PL/SQL             .2      .2                  .2         .2
         SQL                .2      .0                  .2        5.9
      20 MARK --------     8.2     8.0       .0        8.2        8.2
         Other             8.2                         8.2        8.2
         PL/SQL             .0      .0                  .0         .0
      26 TNS V1-V3 ---     6.8     6.0       .0        6.8       18.2
         Other             3.8                         3.8        9.2
         PL/SQL            2.8     1.4                 2.8        3.7
         SQL                .2      .0                  .2        5.2
      19 TNS V1-V3 ---     5.0     2.9      1.1        5.0        8.6
         Other             3.7                         3.7        3.7
         Freeable          1.1      .0                 1.1
         PL/SQL             .2      .2                  .2         .2
         SQL                .1      .0                  .1        3.9
      17 MMON --------     3.7     3.2       .2        3.7        4.7
         Other             3.4                         3.4        3.4
         Freeable           .2      .0                  .2
         PL/SQL             .1      .1                  .1         .1
         SQL                .1      .0                  .1        1.0
      36  ------------     3.7     2.2      1.1        3.7        4.7
         Other             2.6                         2.6        2.6
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      37  ------------     3.6     2.2      1.0        3.6        4.7
         Other             2.6                         2.6        2.6
         Freeable          1.0      .0                 1.0
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      38  ------------     3.6     2.1      1.1        3.6        4.7
         Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      45  ------------     3.6     2.1      1.1        3.6        4.7
         Other             2.4                         2.4        2.4
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      46  ------------     3.6     2.1      1.1        3.6        4.7
         Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0

Top Process Memory (by component)  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> ordered by Begin/End snapshot, Alloc (MB) desc

                        Alloc   Used   Freeabl     Max      Hist Max
     PId Category       (MB)    (MB)     (MB)   Alloc (MB) Alloc (MB)
- ------ ------------- ------- ------- -------- ---------- ----------
B     47  ------------     3.6     2.1      1.1        3.6        4.7
         Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      48  ------------     3.6     2.1      1.1        3.6        4.6
         Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      50  ------------     3.6     2.1      1.1        3.6        4.7
         Other             2.4                         2.4        2.4
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      51  ------------     3.6     2.1      1.1        3.6        4.7
         Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      53  ------------     3.6     2.1       .0        3.6        3.7
         Other             3.6                         3.6        3.6
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        1.0
      54  ------------     3.6     2.1      1.1        3.6        4.7
         Other             2.4                         2.4        2.4
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      57  ------------     3.6     2.1      1.1        3.6        4.7
         Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      60  ------------     3.6     2.1       .0        3.6        4.7
         Other             3.6                         3.6        3.6
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
E     10 DBW0 --------    14.3    11.4       .0       14.3       25.3
         Other            14.3                        14.3       25.3
         PL/SQL             .0      .0                  .0         .0
      11 LGWR --------    12.9    12.1       .0       12.9       12.9
         Other            12.9                        12.9       12.9
         PL/SQL             .0      .0                  .0         .0
      24 J000 --------     9.1     2.5      6.3        9.1        9.1
         Freeable          6.3      .0                 6.3
         Other             2.5                         2.5        2.5
         PL/SQL             .2      .2                  .2         .2
         SQL                .1      .1                  .1        6.3
      20 MARK --------     8.2     8.0       .0        8.2        8.2
         Other             8.2                         8.2        8.2
         PL/SQL             .0      .0                  .0         .0
      26 TNS V1-V3 ---     6.8     6.0       .0        6.8       18.2

Top Process Memory (by component)  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> ordered by Begin/End snapshot, Alloc (MB) desc

                        Alloc   Used   Freeabl     Max      Hist Max
     PId Category       (MB)    (MB)     (MB)   Alloc (MB) Alloc (MB)
- ------ ------------- ------- ------- -------- ---------- ----------
E     26 Other             3.8                         3.8        9.2
         PL/SQL            2.8     1.4                 2.8        3.7
         SQL                .2      .0                  .2        5.2
      19 TNS V1-V3 ---     5.0     2.9      1.1        5.0        8.6
         Other             3.7                         3.7        3.7
         Freeable          1.1      .0                 1.1
         PL/SQL             .2      .2                  .2         .2
         SQL                .1      .0                  .1        3.9
      37  ------------     3.7     2.2       .0        3.7        4.7
         Other             3.6                         3.6        3.6
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      38  ------------     3.6     2.1      1.1        3.6        4.7
         Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      45  ------------     3.6     2.1      1.1        3.6        4.7
         Other             2.4                         2.4        2.4
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      46  ------------     3.6     2.1      1.1        3.6        4.7
         Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         SQL                .0      .0                  .0        2.0
         PL/SQL             .0      .0                  .0         .0
      47  ------------     3.6     2.1      1.1        3.6        4.7
         Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      51  ------------     3.6     2.1      1.1        3.6        4.7
         Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      53  ------------     3.6     2.1      1.1        3.6        3.7
         Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        1.0
      54  ------------     3.6     2.2      1.1        3.6        4.7
         Other             2.4                         2.4        2.4
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      61  ------------     3.6     2.1      1.1        3.6        4.7
         Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      62  ------------     3.6     2.1       .0        3.6        4.7

Top Process Memory (by component)  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> ordered by Begin/End snapshot, Alloc (MB) desc

                        Alloc   Used   Freeabl     Max      Hist Max
     PId Category       (MB)    (MB)     (MB)   Alloc (MB) Alloc (MB)
- ------ ------------- ------- ------- -------- ---------- ----------
E     62 Other             3.6                         3.6        3.6
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      63  ------------     3.6     2.1      1.1        3.6        4.7
         Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         SQL                .0      .0                  .0        2.0
         PL/SQL             .0      .0                  .0         .0
      69  ------------     3.6     2.2      1.1        3.6        3.6
         Other             2.4                         2.4        2.4
         Freeable          1.1      .0                 1.1
         SQL                .0      .0                  .0        1.1
         PL/SQL             .0      .0                  .0         .0
      17 MMON --------     3.5     3.2       .0        3.5        4.7
         Other             3.4                         3.4        3.6
         PL/SQL             .1      .1                  .1         .1
         SQL                .1      .0                  .1        1.0
      40  ------------     3.5     2.1      1.1        3.5        4.6
         Other             2.4                         2.4        2.4
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
          -------------------------------------------------------------
Enqueue activity  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> only enqueues with waits are shown
-> Enqueue stats gathered prior to 10g should not be compared with 10g data
-> ordered by Wait Time desc, Waits desc

Enqueue Type (Request Reason)
------------------------------------------------------------------------------
    Requests    Succ Gets Failed Gets       Waits Wt Time (s)  Av Wt Time(ms)
------------ ------------ ----------- ----------- ------------ --------------
TX-Transaction (row lock contention)
       1,258        1,258           0       1,252            2           1.77
TX-Transaction (index contention)
         400          400           0          32            0          15.00
HW-Segment High Water Mark
         336          336           0           4            0          27.50
TX-Transaction
     261,466      261,469           0           1            0          70.00
CU-Cursor
         284          284           0           1            0          10.00
          -------------------------------------------------------------

Undo Segment Summary  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> Min/Max TR (mins) - Min and Max Tuned Retention (minutes)
-> STO - Snapshot Too Old count,  OOS - Out Of Space count
-> Undo segment block stats:
   uS - unexpired Stolen,   uR - unexpired Released,   uU - unexpired reUsed
   eS - expired   Stolen,   eR - expired   Released,   eU - expired   reUsed

Undo   Num Undo       Number of  Max Qry     Max Tx Min/Max   STO/  uS/uR/uU/
 TS# Blocks (K)    Transactions  Len (s)      Concy TR (mins) OOS   eS/eR/eU
---- ---------- --------------- -------- ---------- --------- ----- -----------
   2       26.6         313,610      938         31 19.6/29.6 0/0   0/0/0/0/0/0
          -------------------------------------------------------------


Undo Segment Stats  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> Most recent 35 Undostat rows, ordered by End Time desc

                Num Undo    Number of Max Qry  Max Tx Tun Ret STO/  uS/uR/uU/
End Time          Blocks Transactions Len (s)   Concy  (mins) OOS   eS/eR/eU
------------ ----------- ------------ ------- ------- ------- ----- -----------
23-Apr 19:43      14,853      175,772     336      31      20 0/0   0/0/0/0/0/0
23-Apr 19:33      11,722      137,838     938      27      30 0/0   0/0/0/0/0/0
          -------------------------------------------------------------
Latch Activity  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
->"Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
  willing-to-wait latch get requests
->"NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
->"Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                              Get          Get   Slps   Time       NoWait NoWait
Latch                       Requests      Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
AQ deq hash table latch               2    0.0             0            0
ASM Keyed state latch                37    0.0             0            0
ASM allocation                      170    0.0             0            0
ASM db client latch                 697    0.0             0            0
ASM map operation freeli             65    1.5    0.0      0            0
ASM map operation hash t      3,321,945    0.0    0.1      0            0
ASM network background l            450    0.0             0            0
ASM network state latch             295    0.0             0            0
AWR Alerted Metric Eleme          6,989    0.0             0            0
Change Notification Hash            300    0.0             0            0
Consistent RBA                  243,674    0.0    0.7      0            0
DML lock allocation             702,421    0.0    0.1      0            0
Event Group Locks                    55    0.0             0            0
FOB s.o list latch                  264    0.0             0            0
File State Object Pool P              2    0.0             0            0
I/O Staticstics latch                 2    0.0             0            0
IPC stats buffer allocat              2    0.0             0            0
In memory undo latch          1,386,730    0.0    0.7      0      259,259    0.0
JS Sh mem access                      4    0.0             0            0
JS mem alloc latch                    2    0.0             0            0
JS queue access latch                 4    0.0             0            0
JS queue state obj latch          5,474    0.0             0            0
JS slv state obj latch                6    0.0             0            0
KFC FX Hash Latch                     2    0.0             0            0
KFC Hash Latch                        2    0.0             0            0
KFCL LE Freelist                      2    0.0             0            0
KFK SGA Libload latch               210    0.0             0            0
KFMD SGA                              1    0.0             0            0
KGNFS-NFS:SHM structure               2    0.0             0            0
KGNFS-NFS:SVR LIST                    2    0.0             0            0
KJC message pool free li              2    0.0             0            0
KJCT flow control latch               2    0.0             0            0
KMG MMAN ready and start            300    0.0             0            0
KTF sga latch                         5    0.0             0          302    0.0
KWQMN job cache list lat              1    0.0             0            0
KWQP Prop Status                    117    0.0             0            0
KWQS pqueue ctx latch                 2    0.0             0            0
Locator state objects po              2    0.0             0            0
Lsod array latch                    266    0.0             0            0
MQL Tracking Latch                    0                    0           18    0.0
Memory Management Latch               2    0.0             0          300    0.0
Memory Queue                        120    0.0             0            0
Memory Queue Message Sub              2    0.0             0            0
Memory Queue Message Sub              2    0.0             0            0
Memory Queue Message Sub              2    0.0             0            0
Memory Queue Message Sub              2    0.0             0            0
Memory Queue Subscriber               2    0.0             0            0
MinActiveScn Latch                   10    0.0             0            0
Mutex                                 2    0.0             0            0
Mutex Stats                           2    0.0             0            0
Latch Activity  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
->"Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
  willing-to-wait latch get requests
->"NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
->"Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                              Get          Get   Slps   Time       NoWait NoWait
Latch                       Requests      Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
OS process                          116    0.0             0            0
OS process allocation             1,871    0.0             0            0
OS process: request allo             37    0.0             0            0
PL/SQL warning settings              81    0.0             0            0
PX hash array latch                   2    0.0             0            0
QMT                                   2    0.0             0            0
Real-time plan statistic            496    0.0             0            0
SGA IO buffer pool latch             14    0.0             0           14    0.0
SGA blob parent                       2    0.0             0            0
SGA bucket locks                      2    0.0             0            0
SGA heap locks                        2    0.0             0            0
SGA pool locks                        2    0.0             0            0
SQL memory manager latch              2    0.0             0          297    0.0
SQL memory manager worka         20,305    0.0             0            0
Shared B-Tree                       724    0.0             0            0
Streams Generic                       2    0.0             0            0
Testing                               2    0.0             0            0
Token Manager                         2    0.0             0            0
WCR: sync                             2    0.0             0            0
Write State Object Pool               2    0.0             0            0
X$KSFQP                               1    0.0             0            0
XDB NFS Security Latch                2    0.0             0            0
XDB unused session pool               2    0.0             0            0
XDB used session pool                 2    0.0             0            0
active checkpoint queue          44,210    0.0             0            0
active service list               1,829    0.1    0.0      0        2,161    0.0
begin backup scn array                2    0.0             0            0
bq:time manger info latc             32    0.0             0            0
buffer pool                           2    0.0             0            0
bufq statistics                     118    0.0             0            0
business card                         2    0.0             0            0
cache buffer handles             19,150    0.1    0.0      0            0
cache buffers chains        806,943,204    0.2    0.0      0      885,272    0.0
cache buffers lru chain         706,259    0.1    0.1      0    1,460,988    0.1
cache table scan latch               93    0.0             0           93    0.0
call allocation                     786    0.0             0            0
cas latch                             2    0.0             0            0
change notification clie              2    0.0             0            0
channel handle pool latc             39    0.0             0            0
channel operations paren          6,968    0.0             0            0
checkpoint queue latch        2,067,713    0.0    0.0      0      517,926    0.0
client/application info             152    0.0             0            0
compile environment latc             27    0.0             0            0
corrupted undo seg latch            411    0.0             0            0
cp cmon/server latch                  2    0.0             0            0
cp pool latch                         2    0.0             0            0
cp server hash latch                  2    0.0             0            0
cp sga latch                        117    0.0             0            0
cvmap freelist lock                   2    0.0             0            0
deferred cleanup latch              117    0.0             0            0
Latch Activity  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
->"Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
  willing-to-wait latch get requests
->"NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
->"Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                              Get          Get   Slps   Time       NoWait NoWait
Latch                       Requests      Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
dml lock allocation                 117    0.0             0            0
done queue latch                      2    0.0             0            0
dummy allocation                     41    0.0             0            0
enqueue freelist latch                2    0.0             0       19,685    0.0
enqueue hash chains           1,247,074    0.0    0.1      0            2    0.0
enqueues                             47    0.0             0            0
fifth spare latch                     2    0.0             0            0
file cache latch                    236    0.0             0            0
flashback copy                        2    0.0             0            0
fourth Audit Vault latch              2    0.0             0            0
gc element                            2    0.0             0            0
gcs commit scn state                  2    0.0             0            0
gcs partitioned table ha              2    0.0             0            0
gcs pcm hashed value buc              2    0.0             0            0
gcs resource freelist                 2    0.0             0            0
gcs resource hash                     2    0.0             0            0
gcs resource scan list                2    0.0             0            0
gcs shadows freelist                  2    0.0             0            0
ges domain table                      2    0.0             0            0
ges enqueue table freeli              2    0.0             0            0
ges group table                       2    0.0             0            0
ges process hash list                 2    0.0             0            0
ges process parent latch              2    0.0             0            0
ges resource hash list                2    0.0             0            0
ges resource scan list                2    0.0             0            0
ges resource table freel              2    0.0             0            0
ges value block free lis              2    0.0             0            0
global KZLD latch for me             15    0.0             0            0
global tx hash mapping                2    0.0             0            0
granule operation                     2    0.0             0            0
hash table column usage             292    0.0             0       15,789    0.0
hash table modification               1    0.0             0            0
heartbeat check                       2    0.0             0            0
internal temp table obje              3    0.0             0            0
intra txn parallel recov              2    0.0             0            0
io pool granule metadata              2    0.0             0            0
job workq parent latch                3    0.0             0            1    0.0
job_queue_processes free              4    0.0             0            0
job_queue_processes para            197    0.0             0            0
k2q lock allocation                   2    0.0             0            0
kcbtsemkid latch                     14    0.0             0            0
kdlx hb parent latch                  2    0.0             0            0
kgb parent                            2    0.0             0            0
kgnfs mount latch                     2    0.0             0            0
kokc descriptor allocati              4    0.0             0            0
ksfv messages                         2    0.0             0            0
ksim group membership ca              2    0.0             0            0
kss move lock                        20    0.0             0            0
ksuosstats global area               96    0.0             0            0
ksv allocation latch                153    0.0             0            0
Latch Activity  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
->"Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
  willing-to-wait latch get requests
->"NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
->"Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                              Get          Get   Slps   Time       NoWait NoWait
Latch                       Requests      Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
ksv class latch                     807    0.4    0.0      0            0
ksv instance latch                    4    0.0             0            0
ksv msg queue latch                   2    0.0             0            0
ksz_so allocation latch              37    0.0             0            0
ktm global data                     161    0.0             0            0
kwqbsn:qsga                         563    0.0             0            0
lgwr LWN SCN                    245,348    0.0    0.0      0            0
list of block allocation             95    0.0             0            0
loader state object free            170    0.0             0            0
lob segment dispenser la              2    0.0             0            0
lob segment hash table l              4    0.0             0            0
lob segment query latch               2    0.0             0            0
lock DBA buffer during m              2    0.0             0            0
logical standby cache                 2    0.0             0            0
logminer context allocat              3    0.0             0            0
logminer work area                    2    0.0             0            0
longop free list parent               2    0.0             0            0
mapped buffers lru chain              2    0.0             0            0
message pool operations             251    0.0             0            0
messages                        856,700    0.0    0.0      0            0
mostly latch-free SCN           248,895    0.4    0.0      0            0
msg queue latch                       2    0.0             0            0
multiblock read objects             312    0.0             0            0
name-service namespace b              2    0.0             0            0
ncodef allocation latch             117    0.0             0            0
object queue header heap        354,877    0.0             0        1,837    0.0
object queue header oper      3,539,088    0.0    0.0      0            0
object stats modificatio            330    0.0             0            0
parallel query alloc buf            118    0.0             0            0
parallel query stats                  2    0.0             0            0
parameter list                      141    2.1    0.0      0            0
parameter table manageme             86    0.0             0            0
peshm                                 2    0.0             0            0
pesom_free_list                       2    0.0             0            0
pesom_hash_node                       2    0.0             0            0
post/wait queue                 375,043    0.0    0.0      0      260,072    0.1
process allocation                   48    0.0             0           26    0.0
process group creation               37    0.0             0            0
process queue                         2    0.0             0            0
process queue reference               2    0.0             0            0
qmn task queue latch                847    0.0             0            0
query server freelists                2    0.0             0            0
queued dump request                   3    0.0             0            0
queuing load statistics               2    0.0             0            0
recovery domain hash lis              2    0.0             0            0
redo allocation               1,144,436    0.1    0.0      0    1,204,321    0.4
redo copy                             2    0.0             0    1,206,152    0.3
redo writing                    779,423    0.0    0.0      0            0
resmgr group change latc             17    5.9    0.0      0            0
resmgr:active threads                41    0.0             0            0
Latch Activity  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
->"Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
  willing-to-wait latch get requests
->"NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
->"Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                              Get          Get   Slps   Time       NoWait NoWait
Latch                       Requests      Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
resmgr:actses change gro             27    0.0             0            0
resmgr:actses change sta              2    0.0             0            0
resmgr:free threads list             39    0.0             0            0
resmgr:plan CPU method                2    0.0             0            0
resmgr:resource group CP              2    0.0             0            0
resmgr:schema config                  2    0.0             0            0
resmgr:session queuing                2    0.0             0            0
rm cas latch                          2    0.0             0            0
row cache objects                56,084    0.1    0.1      0          395    0.0
rules engine rule set st            200    0.0             0            0
second Audit Vault latch              2    0.0             0            0
second spare latch                    2    0.0             0            0
sequence cache                  217,912    0.0    0.0      0            0
session allocation              259,202    0.0    0.0      0      259,195    0.0
session idle bit              7,608,596    0.0    0.0      0            0
session queue latch                   2    0.0             0            0
session state list latch             66    0.0             0            0
session switching                   130    0.0             0            0
session timer                       365    0.0             0            0
shared pool                      26,406    0.2    0.3      0            0
shared pool sim alloc                11    0.0             0            0
shared pool simulator             1,567    0.0             0            0
sim partition latch                   2    0.0             0            0
simulator hash latch         34,472,983    0.0    0.0      0            0
simulator lru latch              32,555    1.3    0.0      0   34,387,108    1.4
sort extent pool                    174    0.0             0            0
space background state o              4    0.0             0            0
space background task la          1,527    0.5    0.0      0          607    0.0
state object free list                2    0.0             0            0
statistics aggregation              336    0.0             0            0
tablespace key chain                  2    0.0             0            0
temp lob duration state               2    0.0             0            0
test excl. parent l0                  2    0.0             0            0
test excl. parent2 l0                 2    0.0             0            0
third spare latch                     2    0.0             0            0
threshold alerts latch               38    0.0             0            0
trace latch                          11    0.0             0            0
transaction allocation              102    0.0             0            0
undo global data              1,417,613    0.0    0.0      0            0
virtual circuit buffers               2    0.0             0            0
virtual circuit holder                2    0.0             0            0
virtual circuit queues                2    0.0             0            0
          -------------------------------------------------------------
Latch Sleep breakdown  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> ordered by misses desc

                                       Get                                 Spin
Latch Name                        Requests       Misses      Sleeps        Gets
-------------------------- --------------- ------------ ----------- -----------
cache buffers chains           806,943,204    1,542,844       1,399   1,541,445
simulator hash latch            34,472,983        4,366         100       4,267
session idle bit                 7,608,596        1,294          52       1,242
object queue header operat       3,539,088        1,164          57       1,108
redo allocation                  1,144,436        1,028          46         982
mostly latch-free SCN              248,895          964          29         935
enqueue hash chains              1,247,074          470          28         442
cache buffers lru chain            706,259          432          23         410
simulator lru latch                 32,555          417          10         407
In memory undo latch             1,386,730          395         257         140
undo global data                 1,417,613          276           6         270
messages                           856,700          258           3         255
checkpoint queue latch           2,067,713          129           1         128
sequence cache                     217,912           95           2          93
DML lock allocation                702,421           83           7          76
row cache objects                   56,084           60           8          52
session allocation                 259,202           57           2          55
shared pool                         26,406           56          14          50
post/wait queue                    375,043           50           1          49
redo writing                       779,423           47           2          45
ASM map operation hash tab       3,321,945           13           1          12
Consistent RBA                     243,674            3           2           1
          -------------------------------------------------------------
Latch Miss Sources  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> only latches with sleeps are shown
-> ordered by name, sleeps desc

                                                     NoWait              Waiter
Latch Name               Where                       Misses     Sleeps   Sleeps
------------------------ -------------------------- ------- ---------- --------
ASM map operation hash t kffmDoDone_1                     0          1        0
DML lock allocation      ktaiam                           0          7        6
In memory undo latch     ktiFlush: child                  0        185       78
In memory undo latch     kticmt: child                    0         83       35
In memory undo latch     ktichg: child                    0         11      132
cache buffers chains     kcbchg1: mod cr pin              0        344      153
cache buffers chains     kcbgtcr: fast path (cr pin       0        299      454
cache buffers chains     kcbget: fast exchange            0        276       17
cache buffers chains     kcbgtcr: kslbegin shared         0        244       66
cache buffers chains     kcbgtcr: fast path               0        180      571
cache buffers chains     kcbgtcr_2                        0        166       91
cache buffers chains     kcbgtcr_1                        0         66        0
cache buffers chains     kcbgcur_4                        0         62        4
cache buffers chains     kcbgcur_2                        0         45       14
cache buffers chains     kcbzgb: scan from tail. no       0         32        0
cache buffers chains     kcbgtcr: kslbegin excl           0         29       36
cache buffers chains     kcbrls: fast release             0         26      265
cache buffers chains     kcbzwb                           0         25       21
cache buffers chains     kcbnew: new latch again          0         20        2
cache buffers chains     kcbget: fast path                0          9        1
cache buffers chains     kcbnlc                           0          8        8
cache buffers chains     kcbzib: finish processing        0          7        4
cache buffers chains     kcbchg1: aux pin                 0          7        6
cache buffers chains     kcbbic2                          0          6        1
cache buffers chains     kcb_pre_apply: kcbhq61           0          5        9
cache buffers chains     kcb_post_apply: kcbhq62          0          4        1
cache buffers chains     kcbzibmlt: multi-block rea       0          4        0
cache buffers chains     kcbzpbuf                         0          3       10
cache buffers chains     kcbchg1: clear MS bit            0          3       13
cache buffers chains     kcbzib: exchange rls             0          3        8
cache buffers chains     kcbnew_1                         0          2        0
cache buffers chains     kcbget: pin buffer               0          2        0
cache buffers chains     kcbbic1                          0          2        5
cache buffers chains     kcbget: release shr              0          2        6
cache buffers chains     kcbgcur: fast path (shr)         0          1        3
cache buffers chains     kcbrls_2                         0          1       27
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
object queue header oper kcbo_switch_cq                   0         15       32
object queue header oper kcbo_link_q                      0         13        2
object queue header oper kcbo_unlink_q                    0         13       18
object queue header oper kcbo_switch_mq_bg                0         13        2
object queue header oper kcbo_check_flist                 0          3        3
object queue header oper kcbo_switch_q_bg                 0          2        2
post/wait queue          ksliwat:add:nowait               0          1        0
Latch Miss Sources  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> only latches with sleeps are shown
-> ordered by name, sleeps desc

                                                     NoWait              Waiter
Latch Name               Where                       Misses     Sleeps   Sleeps
------------------------ -------------------------- ------- ---------- --------
redo allocation          kcrfw_redo_gen: redo alloc       0         41        0
redo allocation          kcrf_pvt_strand_bind             0          3        4
redo allocation          kcrf_pvt_strand_unbind           0          1        0
redo allocation          kcrfw_redo_gen: redo alloc       0          1        0
redo writing             kcrfw_cal_target_rba             0          1        0
redo writing             kcrfwcr                          0          1        1
row cache objects        kqreqd                           0          3        1
row cache objects        kqreqd: reget                    0          3        0
row cache objects        kqrpre: find obj                 0          1        2
row cache objects        kqrso                            0          1        0
sequence cache           kdnssd                           0          2        0
session allocation       ksucri_int : SSO                 0          1        0
session allocation       ksuxds                           0          1        2
session idle bit         ksupuc: set busy                 0         33       21
session idle bit         ksupuc: clear busy               0         16       29
session idle bit         ksuxds                           0          3        2
shared pool              kghalo                           0         12        6
shared pool              kghupr1                          0          2       13
simulator hash latch     kcbsacc: lookup dba              0        100      100
simulator lru latch      kcbs_simulate: simulate se       0         10        0
undo global data         ktubnd_4                         0          2        0
undo global data         ktudba: KSLBEGIN                 0          2        1
undo global data         ktudnx:child                     0          2        2
          -------------------------------------------------------------
Mutex Sleep  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> ordered by Wait Time desc

                                                                         Wait
Mutex Type         Location                                 Sleeps     Time (s)
------------------ -------------------------------- -------------- ------------
Cursor Pin         kksLockDelete [KKSCHLPIN6]                   20          0.0
Library Cache      kglpndl1  95                                 64          0.0
Cursor Pin         kkslce [KKSCHLPIN2]                       5,901          0.0
Library Cache      kglUpgradeLock 119                            4          0.0
Library Cache      kglget2   2                                   6          0.0
Library Cache      kglhdgn1  62                                  7          0.0
Library Cache      kglhdgn2 106                                 51          0.0
Library Cache      kglini1   32                                  3          0.0
Library Cache      kgllkal3  82                                  7          0.0
Library Cache      kgllkc1   57                                 33          0.0
Library Cache      kgllkdl1  85                                  8          0.0
Library Cache      kglllal3 111                                 32          0.0
Library Cache      kgllldl2 112                                  3          0.0
Library Cache      kglobld1  75                                  1          0.0
Library Cache      kglpin1   4                                  77          0.0
Library Cache      kglpnal1  90                                 32          0.0
Cursor Pin         kksfbc [KKSCHLPIN1]                          81          0.0
          -------------------------------------------------------------
Segments by Logical Reads  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> End Segment Logical Reads Threshold:     10000
-> Pct Total shows % of logical reads for each top segment compared with total
   logical reads for all segments captured by the Snapshot

                                           Subobject    Obj.       Logical   Pct
Owner      Tablespace Object Name          Name         Type         Reads Total
---------- ---------- -------------------- ------------ ----- ------------ -----
SOE        SOE        ITEM_ORDER_IX                     INDEX  189,287,216  32.3
SOE        SOE        CUSTOMERS_PK                      INDEX  189,094,320  32.2
SOE        SOE        CUSTOMERS                         TABLE   94,749,344  16.2
SOE        SOE        ORDERS                            TABLE   94,375,232  16.1
SOE        SOE        PRODUCT_INFORMATION               TABLE    9,791,456   1.7
          -------------------------------------------------------------


Segments by Physical Reads  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> End Segment Physical Reads Threshold:      1000

                                           Subobject    Obj.      Physical   Pct
Owner      Tablespace Object Name          Name         Type         Reads Total
---------- ---------- -------------------- ------------ ----- ------------ -----
SOE        SOE        CUSTOMERS                         TABLE      149,591  19.2
SOE        SOE        CUSTOMERS_PK                      INDEX      141,120  18.1
SOE        SOE        ORD_CUSTOMER_IX                   INDEX       93,593  12.0
SOE        SOE        INVENTORIES                       TABLE       82,201  10.5
SOE        SOE        ITEM_ORDER_IX                     INDEX       65,273   8.4
          -------------------------------------------------------------
Segments by Row Lock Waits  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> End Segment Row Lock Waits Threshold:       100

                                                                       Row
                                           Subobject    Obj.          Lock   Pct
Owner      Tablespace Object Name          Name         Type         Waits Total
---------- ---------- -------------------- ------------ ----- ------------ -----
SOE        SOE        ORDERS                            TABLE        1,267  77.4
SOE        SOE        ORD_ORDER_DATE_IX                 INDEX          137   8.4
SOE        SOE        ORD_WAREHOUSE_IX                  INDEX           96   5.9
SOE        SOE        ITEM_PRODUCT_IX                   INDEX           87   5.3
SOE        SOE        CUST_ACCOUNT_MANAGER              INDEX           24   1.5
          -------------------------------------------------------------


Segments by Buffer Busy Waits  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> End Segment Buffer Busy Waits Threshold:       100

                                                                    Buffer
                                           Subobject    Obj.          Busy   Pct
Owner      Tablespace Object Name          Name         Type         Waits Total
---------- ---------- -------------------- ------------ ----- ------------ -----
SOE        SOE        ORDERS                            TABLE          529  93.8
SOE        SOE        ORD_ORDER_DATE_IX                 INDEX           13   2.3
SOE        SOE        ORD_WAREHOUSE_IX                  INDEX            5    .9
SOE        SOE        ORDER_PK                          INDEX            5    .9
SOE        SOE        ORDER_ITEMS                       TABLE            5    .9
          -------------------------------------------------------------
Dictionary Cache Stats  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
->"Pct Misses"  should be very low (< 2% in most cases)
->"Final Usage" is the number of cache entries being used in End Snapshot

                                   Get    Pct    Scan   Pct      Mod      Final
Cache                         Requests   Miss    Reqs  Miss     Reqs      Usage
------------------------- ------------ ------ ------- ----- -------- ----------
dc_awr_control                      19    0.0       0              2          1
dc_global_oids                      35    0.0       0              0         24
dc_histogram_data                2,729   10.9       0              0      2,171
dc_histogram_defs                5,566   20.9       0              0      3,320
dc_object_grants                     2   50.0       0              0         10
dc_objects                       2,639    5.0       0              1      1,249
dc_profiles                         17    0.0       0              0          1
dc_rollback_segments             1,069    0.0       0              0         78
dc_segments                      1,220    6.1       0             15        470
dc_sequences                        11    0.0       0             11          4
dc_tablespaces                   3,016    0.0       0              0          7
dc_users                         3,221    0.7       0              0         22
global database name               625    0.0       0              0          1
outstanding_alerts                   8    0.0       0              0          4
sch_lj_oids                          2    0.0       0              0          1
          -------------------------------------------------------------


Library Cache Activity  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
->"Pct Misses"  should be very low

                         Get  Pct        Pin        Pct               Invali-
Namespace           Requests  Miss     Requests     Miss     Reloads  dations
--------------- ------------ ------ -------------- ------ ---------- --------
ACCOUNT_STATUS            30    3.3              0                 0        0
BODY                      30    6.7             59    3.4          0        0
CLUSTER                   28    0.0             28    0.0          0        0
DBLINK                    31    3.2              0                 0        0
EDITION                   23    0.0             38    7.9          0        0
INDEX                     27   18.5             27   18.5          0        0
QUEUE                    261    0.0            261    0.0          0        0
SCHEMA                   143    0.0              0                 0        0
SQL AREA               1,332    5.0      1,735,071    0.0        206        0
SQL AREA BUILD           284   77.8              0                 0        0
SQL AREA STATS           227   39.2            227   39.2          0        0
TABLE/PROCEDURE        1,264    9.1        147,825    0.6        468        0
          -------------------------------------------------------------
Buffered Queues  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> * indicates Buffered Queue activity (re)started between Begin/End snaps
-> Top 25 ordered by Queued Messages desc

Queue
------------------------------------------------------
    Enq     Deq    Spill
*  Msg/s   Msg/s   Msg/s
- ------- ------- -------
SYS.SCHEDULER$_EVENT_QUEUE
        0       0       0
          -------------------------------------------------------------
Rule Sets  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> * indicates Rule Set activity (re)started between Begin/End snaps
-> Top 25 ordered by Evaluations desc

                                                               No-SQL  SQL
Rule                                *     Eval/sec Reloads/sec Eval % Eval %
----------------------------------- - ------------ ----------- ------ ------
SYS.ALERT_QUE_R                                  0           0      0      0
          -------------------------------------------------------------
Streams Pool Advisory  DB/Inst: DBM11203/DBM11203  End Snap: 553

Streams Pool Streams Pool Est Spill Est Spill Est Unspill Est Unspill
    Size (M)  Size Factor     Count  Time (s)       Count    Time (s)
------------ ------------ --------- --------- ----------- -----------
         4.0           .5         0         0           0           0
         8.0          1.0         0         0           0           0
        12.0          1.5         0         0           0           0
        16.0          2.0         0         0           0           0
        20.0          2.5         0         0           0           0
        24.0          3.0         0         0           0           0
        28.0          3.5         0         0           0           0
        32.0          4.0         0         0           0           0
        36.0          4.5         0         0           0           0
        40.0          5.0         0         0           0           0
        44.0          5.5         0         0           0           0
        48.0          6.0         0         0           0           0
        52.0          6.5         0         0           0           0
        56.0          7.0         0         0           0           0
        60.0          7.5         0         0           0           0
        64.0          8.0         0         0           0           0
        68.0          8.5         0         0           0           0
        72.0          9.0         0         0           0           0
        76.0          9.5         0         0           0           0
        80.0         10.0         0         0           0           0
          -------------------------------------------------------------
Shared Pool Advisory  DB/Inst: DBM11203/DBM11203  End Snap: 553
-> SP: Shared Pool     Est LC: Estimated Library Cache   Factr: Factor
-> Note there is often a 1:Many correlation between a single logical object
   in the Library Cache, and the physical number of memory objects associated
   with it.  Therefore comparing the number of Lib Cache objects (e.g. in
   v$librarycache), with the number of Lib Cache Memory Objects is invalid

                                        Est LC Est LC  Est LC Est LC
    Shared    SP   Est LC                 Time   Time    Load   Load      Est LC
      Pool  Size     Size       Est LC   Saved  Saved    Time   Time         Mem
  Size (M) Factr      (M)      Mem Obj     (s)  Factr     (s)  Factr    Obj Hits
---------- ----- -------- ------------ ------- ------ ------- ------ -----------
       232    .9       20        1,307  15,565    1.0     859    2.2   5,808,715
       236    .9       24        1,538  15,642    1.0     782    2.0   5,811,187
       240    .9       27        1,722  15,750    1.0     674    1.7   5,813,328
       244    .9       31        1,871  15,791    1.0     633    1.6   5,813,960
       248   1.0       35        2,050  15,842    1.0     582    1.5   5,814,635
       252   1.0       39        2,196  15,894    1.0     530    1.3   5,815,457
       256   1.0       43        2,314  15,958    1.0     466    1.2   5,816,585
       260   1.0       47        2,362  16,026    1.0     398    1.0   5,820,079
       264   1.0       51        2,542  16,031    1.0     393    1.0   5,820,365
       268   1.0       55        2,690  16,031    1.0     393    1.0   5,820,417
       272   1.0       59        2,897  16,033    1.0     391    1.0   5,820,479
       276   1.1       63        3,006  16,033    1.0     391    1.0   5,820,503
       280   1.1       67        3,237  16,034    1.0     390    1.0   5,820,545
       284   1.1       71        3,443  16,034    1.0     390    1.0   5,820,591
       288   1.1       75        3,649  16,034    1.0     390    1.0   5,820,635
       292   1.1       79        3,855  16,034    1.0     390    1.0   5,820,690
       296   1.1       83        4,061  16,034    1.0     390    1.0   5,820,753
       316   1.2      103        5,208  16,034    1.0     390    1.0   5,821,024
       344   1.3      131        6,156  16,035    1.0     389    1.0   5,821,247
       372   1.4      134        6,372  16,035    1.0     389    1.0   5,821,252
       400   1.5      134        6,372  16,035    1.0     389    1.0   5,821,252
       428   1.6      134        6,372  16,035    1.0     389    1.0   5,821,252
       456   1.8      134        6,372  16,035    1.0     389    1.0   5,821,252
       484   1.9      134        6,372  16,035    1.0     389    1.0   5,821,252
       512   2.0      134        6,372  16,035    1.0     389    1.0   5,821,252
       540   2.1      134        6,372  16,035    1.0     389    1.0   5,821,252
          -------------------------------------------------------------
SGA Target Advisory  DB/Inst: DBM11203/DBM11203  End Snap: 553

SGA Target SGA Size   Est DB      Est DB   Est Physical
  Size (M)   Factor Time (s) Time Factor          Reads
---------- -------- -------- ----------- --------------
       512       .5 ########       #####  1,085,492,140
       768       .8  101,657         1.1      8,264,028
     1,024      1.0   88,930         1.0      6,882,675
     1,280      1.3   83,471          .9      6,326,555
     1,536      1.5   77,913          .9      5,734,645
     1,792      1.8   65,163          .7      4,375,316
     2,048      2.0   65,165          .7      4,375,316
          -------------------------------------------------------------
SGA Memory Summary  DB/Inst: DBM11203/DBM11203  Snaps: 552-553

                                                        End Size (Bytes)
SGA regions                      Begin Size (Bytes)       (if different)
------------------------------ -------------------- --------------------
Database Buffers                        763,363,328
Fixed Size                                2,235,208
Redo Buffers                              9,736,192
Variable Size                           293,602,488
                               -------------------- --------------------
sum                                   1,068,937,216
          -------------------------------------------------------------


SGA breakdown difference  DB/Inst: DBM11203/DBM11203  Snaps: 552-553
-> Top 35 rows by size, ordered by Pool, Name (note rows with null values for
   Pool column, or Names showing free memory are always shown)
-> Null value for Begin MB or End MB indicates the size of that Pool/Name was
   insignificant, or zero in that snapshot

Pool   Name                                 Begin MB         End MB  % Diff
------ ------------------------------ -------------- -------------- --------
java p free memory                               4.0            4.0     0.00
large  ASM map operations hashta                  .4             .4     0.00
large  PX msg pool                               3.7            3.7     0.00
large  free memory                               3.9            3.9     0.00
shared ASH buffers                              16.0           16.0     0.00
shared KCB Table Scan Buffer                     3.8            3.8     0.00
shared KGLH0                                    18.4           16.9    -7.97
shared KGLHD                                     3.6            3.2   -10.94
shared KGLS                                      5.5            6.3    14.38
shared KGLSG                                     5.0            5.0     0.00
shared KKSSP                                     2.8            3.6    27.78
shared KSFD SGA I/O b                            3.8            3.8     0.00
shared PLMCD                                     3.4                 -100.00
shared SQLA                                     44.4           24.6   -44.65
shared db_block_hash_buckets                     5.6            5.6     0.00
shared dbwriter coalesce buffer                  3.8            3.8     0.00
shared dirty object counts array                 4.0            4.0     0.00
shared event statistics per sess                 3.1            3.1     0.00
shared free memory                              65.0           85.7    31.88
shared kglsim hash table bkts                    4.0            4.0     0.00
shared ksunfy : SSO free list                    2.9            2.9     0.00
shared private strands                           3.5            3.5     0.00
shared row cache                                 7.2            7.2     0.00
shared write state object                        3.7            3.7     0.00
stream free memory                               8.0            8.0     0.00
       buffer_cache                            728.0          728.0     0.00
       fixed_sga                                 2.1            2.1     0.00
       log_buffer                                9.3            9.3     0.00
          -------------------------------------------------------------
SQL Memory Statistics  DB/Inst: DBM11203/DBM11203  Snaps: 552-553

                                   Begin            End         % Diff
                          -------------- -------------- --------------
   Avg Cursor Size (KB):           29.39          30.03           2.11
 Cursor to Parent ratio:            1.22           1.24           1.88
          Total Cursors:             994            972          -2.26
          Total Parents:             815            782          -4.22
          -------------------------------------------------------------
init.ora Parameters  DB/Inst: DBM11203/DBM11203  Snaps: 552-553

                                                                  End value
Parameter Name                Begin value                       (if different)
----------------------------- --------------------------------- --------------
audit_file_dest               /u00/app/oracle/admin/DBM11203/ad
                              ump
audit_trail                   DB
control_files                 +DATA/dbm11203/controlfile/curren
                              t.455.772715921, +FRA/dbm11203/co
                              ntrolfile/current.332.772715921
core_dump_dest                /u00/app/oracle/diag/rdbms/dbm112
                              03/DBM11203/cdump
cursor_sharing                EXACT
db_block_size                 8192
db_create_file_dest           +DATA
db_domain                     antognini.ch
db_name                       DBM11203
db_recovery_file_dest         +FRA
db_recovery_file_dest_size    2147483648
diagnostic_dest               /u00/app/oracle
local_listener                (DESCRIPTION=(ADDRESS=(PROTOCOL=t
                              cp)(HOST=192.168.1.101)(PORT=1521
                              )))
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
                              03/DBM11203/trace
          -------------------------------------------------------------

End of Report ( sp_1930_1945.txt )

