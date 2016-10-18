
STATSPACK report for

Database    DB Id    Instance     Inst Num  Startup Time   Release     RAC
~~~~~~~~ ----------- ------------ -------- --------------- ----------- ---
          2532911053 DBM11203            1 23-Apr-14 16:33 11.2.0.3.0  NO

Host Name             Platform                CPUs Cores Sockets   Memory (G)
~~~~ ---------------- ---------------------- ----- ----- ------- ------------
     helicon          Linux x86 64-bit           8     8       2          7.8

Snapshot       Snap Id     Snap Time      Sessions Curs/Sess Comment
~~~~~~~~    ---------- ------------------ -------- --------- ------------------
Begin Snap:        548 23-Apr-14 18:30:40       57       1.6
  End Snap:        549 23-Apr-14 18:45:40       59       1.5
   Elapsed:      15.00 (mins) Av Act Sess:       7.1
   DB time:     106.55 (mins)      DB CPU:      28.35 (mins)

Cache Sizes            Begin        End
~~~~~~~~~~~       ---------- ----------
    Buffer Cache:       728M              Std Block Size:         8K
     Shared Pool:       260M                  Log Buffer:     7,992K

Load Profile              Per Second    Per Transaction    Per Exec    Per Call
~~~~~~~~~~~~      ------------------  ----------------- ----------- -----------
      DB time(s):                7.1                0.0        0.01        0.00
       DB CPU(s):                1.9                0.0        0.00        0.00
       Redo size:          392,163.4            1,928.3
   Logical reads:          406,805.1            2,000.3
   Block changes:            2,822.9               13.9
  Physical reads:              579.7                2.9
 Physical writes:              377.8                1.9
      User calls:            2,895.2               14.2
          Parses:                0.6                0.0
     Hard parses:                0.0                0.0
W/A MB processed:                0.1                0.0
          Logons:                0.0                0.0
        Executes:            1,364.1                6.7
       Rollbacks:                0.0                0.0
    Transactions:              203.4

Instance Efficiency Indicators
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            Buffer Nowait %:  100.00       Redo NoWait %:   99.98
            Buffer  Hit   %:   99.86  Optimal W/A Exec %:  100.00
            Library Hit   %:  100.01        Soft Parse %:   98.99
         Execute to Parse %:   99.96         Latch Hit %:   99.96
Parse CPU to Parse Elapsd %:  103.03     % Non-Parse CPU:   98.84

 Shared Pool Statistics        Begin   End
                               ------  ------
             Memory Usage %:   66.47   66.55
    % SQL with executions>1:   71.80   71.85
  % Memory for SQL w/exec>1:   72.70   72.88

Top 5 Timed Events                                                    Avg %Total
~~~~~~~~~~~~~~~~~~                                                   wait   Call
Event                                            Waits    Time (s)   (ms)   Time
----------------------------------------- ------------ ----------- ------ ------
db file sequential read                        520,240       4,567      9   71.6
CPU time                                                     1,620          25.4
log file sync                                  182,275          94      1    1.5
log file parallel write                        178,406          39      0     .6
read by other session                            2,693          27     10     .4
          -------------------------------------------------------------
Host CPU  (CPUs: 8  Cores: 8  Sockets: 2)
~~~~~~~~              Load Average
                      Begin     End      User  System    Idle     WIO     WCPU
                    ------- -------   ------- ------- ------- ------- --------
                       5.98    7.09     23.83    0.89   74.75   21.86

Instance CPU
~~~~~~~~~~~~                                       % Time (seconds)
                                            -------- --------------
                     Host: Total time (s):                  7,001.7
                  Host: Busy CPU time (s):                  1,768.2
                   % of time Host is Busy:      25.3
             Instance: Total CPU time (s):                  1,739.9
          % of Busy CPU used for Instance:      98.4
        Instance: Total Database time (s):                  6,500.3
  %DB time waiting for CPU (Resource Mgr):       0.0

Memory Statistics                       Begin          End
~~~~~~~~~~~~~~~~~                ------------ ------------
                  Host Mem (MB):      7,974.6      7,974.6
                   SGA use (MB):      1,019.4      1,019.4
                   PGA use (MB):        175.1        183.1
    % Host Mem used for SGA+PGA:         15.0         15.1
          -------------------------------------------------------------

Time Model System Stats  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> Ordered by % of DB time desc, Statistic name

Statistic                                       Time (s) % DB time
----------------------------------- -------------------- ---------
sql execute elapsed time                         6,103.6      95.5
DB CPU                                           1,701.1      26.6
parse time elapsed                                  26.8        .4
sequence load elapsed time                           0.1        .0
PL/SQL execution elapsed time                        0.0        .0
repeated bind elapsed time                           0.0        .0
DB time                                          6,392.9
background elapsed time                            107.5
background cpu time                                 38.8
          -------------------------------------------------------------
Foreground Wait Events  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> Only events with Total Wait Time (s) >= .001 are shown
-> ordered by Total Wait Time desc, Waits desc (idle events last)

                                                             Avg          %Total
                                          %Tim Total Wait   wait    Waits   Call
Event                               Waits  out   Time (s)   (ms)     /txn   Time
---------------------------- ------------ ---- ---------- ------ -------- ------
db file sequential read           519,094    0      4,560      9      2.8   71.5
log file sync                     182,274    0         94      1      1.0    1.5
read by other session               2,692    0         27     10      0.0     .4
log file switch (private str          100    0          2     24      0.0     .0
log file switch (checkpoint            57    0          2     37      0.0     .0
enq: TX - row lock contentio          679    0          1      1      0.0     .0
db file parallel read                  43    0          0      9      0.0     .0
buffer busy waits                     355    0          0      0      0.0     .0
enq: TX - index contention              7    0          0     16      0.0     .0
control file sequential read          356    0          0      0      0.0     .0
latch: cache buffers chains           451    0          0      0      0.0     .0
cursor: pin S                          24    0          0      2      0.0     .0
latch free                             72    0          0      0      0.0     .0
latch: In memory undo latch           152    0          0      0      0.0     .0
library cache: mutex X                 31    0          0      0      0.0     .0
db file scattered read                  2    0          0      3      0.0     .0
latch: enqueue hash chains             14    0          0      0      0.0     .0
latch: object queue header o           10    0          0      0      0.0     .0
SQL*Net message from client     1,415,620    0     16,118     11      7.7
jobq slave wait                       120  100         60    501      0.0
SQL*Net message to client       1,415,620    0          2      0      7.7
          -------------------------------------------------------------

Background Wait Events  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> Only events with Total Wait Time (s) >= .001 are shown
-> ordered by Total Wait Time desc, Waits desc (idle events last)

                                                             Avg          %Total
                                          %Tim Total Wait   wait    Waits   Call
Event                               Waits  out   Time (s)   (ms)     /txn   Time
---------------------------- ------------ ---- ---------- ------ -------- ------
log file parallel write           178,406    0         39      0      1.0     .6
db file parallel write             25,039    0         14      1      0.1     .2
db file sequential read             1,146    0          8      7      0.0     .1
control file sequential read        2,295    0          5      2      0.0     .1
db file scattered read                122    0          2     12      0.0     .0
os thread startup                      12    0          0     35      0.0     .0
direct path read                       17    0          0     20      0.0     .0
log file sequential read               40    0          0      6      0.0     .0
ASM file metadata operation           541    0          0      0      0.0     .0
control file parallel write           600    0          0      0      0.0     .0
ADR block file read                    16    0          0      5      0.0     .0
LGWR wait for redo copy               826    0          0      0      0.0     .0
enq: JS - queue lock                    1    0          0     51      0.0     .0
reliable message                       91    0          0      0      0.0     .0
Disk file operations I/O               66    0          0      0      0.0     .0
CSS initialization                      1    0          0      5      0.0     .0
db file async I/O submit            1,551    0          0      0      0.0     .0
latch free                              3    0          0      1      0.0     .0
log file single write                  40    0          0      0      0.0     .0
ADR block file write                    5    0          0      1      0.0     .0
read by other session                   1    0          0      3      0.0     .0
latch: redo allocation                 12    0          0      0      0.0     .0
direct path write                      11    0          0      0      0.0     .0
CSS operation: action                   1    0          0      1      0.0     .0
rdbms ipc message                 184,120    2     12,509     68      1.0
class slave wait                      226    0      3,600  15931      0.0
Space Manager: slave idle wa          617   94      2,984   4837      0.0
DIAG idle wait                      1,798  100      1,800   1001      0.0
smon timer                             31    3        922  29733      0.0
Streams AQ: qmn coordinator           301   43        903   3001      0.0
Streams AQ: qmn slave idle w          129    0        903   7001      0.0
ASM background timer                  180    0        900   5000      0.0
wait for unread message on b          899  100        900   1001      0.0
pmon timer                            313   91        899   2874      0.0
KSV master wait                        72    0          0      0      0.0
          -------------------------------------------------------------

Wait Events (fg and bg) DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> s - second, cs - centisecond,  ms - millisecond, us - microsecond
-> %Timeouts:  value of 0 indicates value was < .5%.  Value of null is truly 0
-> Only events with Total Wait Time (s) >= .001 are shown
-> ordered by Total Wait Time desc, Waits desc (idle events last)

                                                             Avg          %Total
                                          %Tim Total Wait   wait    Waits   Call
Event                               Waits  out   Time (s)   (ms)     /txn   Time
---------------------------- ------------ ---- ---------- ------ -------- ------
db file sequential read           520,240    0      4,567      9      2.8   71.6
log file sync                     182,275    0         94      1      1.0    1.5
log file parallel write           178,406    0         39      0      1.0     .6
read by other session               2,693    0         27     10      0.0     .4
db file parallel write             25,039    0         14      1      0.1     .2
control file sequential read        2,651    0          5      2      0.0     .1
log file switch (private str          100    0          2     24      0.0     .0
log file switch (checkpoint            57    0          2     37      0.0     .0
db file scattered read                124    0          2     12      0.0     .0
enq: TX - row lock contentio          679    0          1      1      0.0     .0
os thread startup                      12    0          0     35      0.0     .0
db file parallel read                  43    0          0      9      0.0     .0
direct path read                       17    0          0     20      0.0     .0
log file sequential read               40    0          0      6      0.0     .0
ASM file metadata operation           541    0          0      0      0.0     .0
buffer busy waits                     362    0          0      0      0.0     .0
enq: TX - index contention              7    0          0     16      0.0     .0
control file parallel write           600    0          0      0      0.0     .0
ADR block file read                    16    0          0      5      0.0     .0
latch: cache buffers chains           452    0          0      0      0.0     .0
LGWR wait for redo copy               826    0          0      0      0.0     .0
cursor: pin S                          24    0          0      2      0.0     .0
enq: JS - queue lock                    1    0          0     51      0.0     .0
latch free                             75    0          0      0      0.0     .0
latch: In memory undo latch           154    0          0      0      0.0     .0
reliable message                       91    0          0      0      0.0     .0
library cache: mutex X                 31    0          0      0      0.0     .0
Disk file operations I/O               78    0          0      0      0.0     .0
CSS initialization                      1    0          0      5      0.0     .0
db file async I/O submit            1,551    0          0      0      0.0     .0
latch: object queue header o           14    0          0      0      0.0     .0
log file single write                  40    0          0      0      0.0     .0
ADR block file write                    5    0          0      1      0.0     .0
latch: enqueue hash chains             14    0          0      0      0.0     .0
latch: redo allocation                 12    0          0      0      0.0     .0
direct path write                      11    0          0      0      0.0     .0
CSS operation: action                   1    0          0      1      0.0     .0
SQL*Net message from client     1,415,620    0     16,118     11      7.7
rdbms ipc message                 184,120    2     12,509     68      1.0
class slave wait                      226    0      3,600  15931      0.0
Space Manager: slave idle wa          617   94      2,984   4837      0.0
DIAG idle wait                      1,798  100      1,800   1001      0.0
smon timer                             31    3        922  29733      0.0
Streams AQ: qmn coordinator           301   43        903   3001      0.0
Streams AQ: qmn slave idle w          129    0        903   7001      0.0
ASM background timer                  180    0        900   5000      0.0
wait for unread message on b          899  100        900   1001      0.0
pmon timer                            313   91        899   2874      0.0
jobq slave wait                       120  100         60    501      0.0

Wait Events (fg and bg) DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> s - second, cs - centisecond,  ms - millisecond, us - microsecond
-> %Timeouts:  value of 0 indicates value was < .5%.  Value of null is truly 0
-> Only events with Total Wait Time (s) >= .001 are shown
-> ordered by Total Wait Time desc, Waits desc (idle events last)

                                                             Avg          %Total
                                          %Tim Total Wait   wait    Waits   Call
Event                               Waits  out   Time (s)   (ms)     /txn   Time
---------------------------- ------------ ---- ---------- ------ -------- ------
SQL*Net message to client       1,415,620    0          2      0      7.7
KSV master wait                        72    0          0      0      0.0
          -------------------------------------------------------------
Wait Event Histogram  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> Total Waits - units: K is 1000, M is 1000000, G is 1000000000
-> % of Waits - column heading: <=1s is truly <1024ms, >1s is truly >=1024ms
-> % of Waits - value: .0 indicates value was <.05%, null is truly 0
-> Ordered by Event (idle events last)

                           Total ----------------- % of Waits ------------------
Event                      Waits  <1ms  <2ms  <4ms  <8ms <16ms <32ms  <=1s   >1s
-------------------------- ----- ----- ----- ----- ----- ----- ----- ----- -----
ADR block file read          16   75.0              12.5   6.3         6.3
ADR block file write          5   80.0  20.0
ADR file lock                 6  100.0
ASM file metadata operatio  541   96.3   2.4    .6    .4    .2          .2
CSS initialization            1                    100.0
CSS operation: action         1  100.0
CSS operation: query          6  100.0
Disk file operations I/O     78  100.0
LGWR wait for redo copy     826   99.6    .2    .1
asynch descriptor resize     25  100.0
buffer busy waits           362   97.8    .8    .6                .3    .6
control file parallel writ  600   99.5          .5
control file sequential re 2651   91.4    .1   1.1   3.6   2.6    .3    .8
cursor: pin S                24   79.2         4.2        16.7
db file async I/O submit   1551  100.0
db file parallel read        43                9.3  51.2  34.9   2.3   2.3
db file parallel write       25K  95.4    .4    .3    .4   3.5    .0    .0
db file scattered read      124   17.7   3.2  10.5  33.1  21.0   6.5   8.1
db file sequential read     520K   2.1   2.9  19.8  49.1  18.2   4.4   3.4
direct path read             17   11.8               5.9  47.1  29.4   5.9
direct path write            11  100.0
enq: JS - queue lock          1                                      100.0
enq: TX - index contention    7         14.3        42.9  14.3  14.3  14.3
enq: TX - row lock content  679   93.8   1.8   1.3   1.0    .9    .4    .7
latch free                   75   93.3   5.3   1.3
latch: In memory undo latc  154   97.4   1.9    .6
latch: cache buffers chain  452   96.5   2.0   1.5
latch: cache buffers lru c    9  100.0
latch: checkpoint queue la    1  100.0
latch: enqueue hash chains   14  100.0
latch: messages               2  100.0
latch: object queue header   14   92.9   7.1
latch: redo allocation       11  100.0
latch: undo global data       2  100.0
library cache: mutex X       31   96.8                     3.2
log file parallel write     178K  98.7    .3    .3    .2    .3    .2    .0
log file sequential read     40   35.0  10.0   5.0  22.5  22.5   5.0
log file single write        40  100.0
log file switch (checkpoin   57    1.8               1.8   8.8  14.0  73.7
log file switch (private s  100          1.0   2.0   8.0  14.0  48.0  27.0
log file sync               182K  96.3   1.2    .8    .5    .8    .3    .0
os thread startup            12                                      100.0
read by other session      2693    5.0   6.1  19.3  39.9  16.7   7.6   5.4
reliable message             91  100.0
ASM background timer        180                                            100.0
DIAG idle wait             1798                                      100.0
KSV master wait              72  100.0
SQL*Net message from clien 1415K  26.8    .1    .1    .0  47.1  25.2    .6
SQL*Net message to client  1415K 100.0          .0
Space Manager: slave idle   617     .2                      .2    .5    .6  98.5
Streams AQ: qmn coordinato  301   57.1                                      42.9
Wait Event Histogram  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> Total Waits - units: K is 1000, M is 1000000, G is 1000000000
-> % of Waits - column heading: <=1s is truly <1024ms, >1s is truly >=1024ms
-> % of Waits - value: .0 indicates value was <.05%, null is truly 0
-> Ordered by Event (idle events last)

                           Total ----------------- % of Waits ------------------
Event                      Waits  <1ms  <2ms  <4ms  <8ms <16ms <32ms  <=1s   >1s
-------------------------- ----- ----- ----- ----- ----- ----- ----- ----- -----
Streams AQ: qmn slave idle  129                                            100.0
class slave wait            226   36.3          .4   4.4   4.9  11.5  10.6  31.9
jobq slave wait             120                                      100.0
pmon timer                  313     .3                                 2.9  96.8
rdbms ipc message           184K  21.6  14.3  20.9  22.8  14.7   2.6   1.8   1.3
smon timer                   31                                       12.9  87.1
wait for unread message on  899                                      100.0
          -------------------------------------------------------------

SQL ordered by CPU  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> Total DB CPU (s):           1,701
-> Captured SQL accounts for   87.2% of Total DB CPU
-> SQL reported below exceeded  1.0% of Total DB CPU

    CPU                  CPU per             Elapsd                     Old
  Time (s)   Executions  Exec (s)  %Total   Time (s)    Buffer Gets  Hash Value
---------- ------------ ---------- ------ ---------- --------------- ----------
   1241.76        7,087       0.18   73.0    1354.48     352,259,124 1481390170
Module: Swingbench User Thread
SELECT /*+  first_rows index(customers, customers_pk) index(orde
rs, order_status_ix) */  o.order_id, line_item_id, product_id, u
nit_price, quantity, order_mode, order_status, order_total, sale
s_rep_id, promotion_id, c.customer_id, cust_first_name, cust_las

     46.71      220,312       0.00    2.7      52.33       6,615,367 3277652708
Module: Swingbench User Thread
select product_id, product_name, product_description, category_i
d, weight_class, supplier_id,  product_status  list_price, min_p
rice, catalog_url from  product_information where category_id =
:1

     32.06      124,585       0.00    1.9    1861.91         499,075 3739063178
Module: Swingbench User Thread
select customer_id, cust_first_name ,cust_last_name ,nls_languag
e ,nls_territory ,credit_limit ,cust_email ,account_mgr_id  from
 customers where customer_id = :1

     30.21      104,865       0.00    1.8     585.44       1,392,796  688899339
Module: Swingbench User Thread
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT
_PRICE, QUANTITY) values (:1 , :2 , :3 , :4 , :5 )

     20.58       36,705       0.00    1.2     648.93         697,472 3476971243
Module: Swingbench User Thread
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_
ID) values (:1 , :2 , :3 , :4 )

     17.01      124,588       0.00    1.0      23.17         745,611 3603038931
Module: Swingbench User Thread
insert into logon values(:1 ,:2 )

          -------------------------------------------------------------
SQL ordered by Elapsed time for DB: DBM11203  Instance: DBM11203  Snaps: 548 -54
-> Total DB Time (s):           6,393
-> Captured SQL accounts for   95.4% of Total DB Time
-> SQL reported below exceeded  1.0% of Total DB Time

  Elapsed                Elap per            CPU                        Old
  Time (s)   Executions  Exec (s)  %Total   Time (s)  Physical Reads Hash Value
---------- ------------ ---------- ------ ---------- --------------- ----------
   1861.91      124,585       0.01   29.1      32.06         194,485 3739063178
Module: Swingbench User Thread
select customer_id, cust_first_name ,cust_last_name ,nls_languag
e ,nls_territory ,credit_limit ,cust_email ,account_mgr_id  from
 customers where customer_id = :1

   1354.48        7,087       0.19   21.2    1241.76           7,834 1481390170
Module: Swingbench User Thread
SELECT /*+  first_rows index(customers, customers_pk) index(orde
rs, order_status_ix) */  o.order_id, line_item_id, product_id, u
nit_price, quantity, order_mode, order_status, order_total, sale
s_rep_id, promotion_id, c.customer_id, cust_first_name, cust_las

    648.93       36,705       0.02   10.2      20.58          70,411 3476971243
Module: Swingbench User Thread
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_
ID) values (:1 , :2 , :3 , :4 )

    585.44      104,865       0.01    9.2      30.21          67,813  688899339
Module: Swingbench User Thread
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT
_PRICE, QUANTITY) values (:1 , :2 , :3 , :4 , :5 )

    525.90       36,612       0.01    8.2      12.72          65,485 3620601857
Module: Swingbench User Thread
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_
price, quantity, order_mode, order_status, order_total, sales_re
p_id, promotion_id, c.customer_id, cust_first_name, cust_last_na
me, credit_limit, cust_email   FROM orders o , order_items oi, c

    431.65      104,856       0.00    6.8      15.00          47,892  686658588
Module: Swingbench User Thread
update inventories set quantity_on_hand = quantity_on_hand - :1
 where product_id = :2  and warehouse_id = :3

    397.88       14,611       0.03    6.2      10.51          46,784 2136488753
Module: Swingbench User Thread
insert into customers (customer_id ,cust_first_name ,cust_last_n
ame ,nls_language ,nls_territory ,credit_limit ,cust_email ,acco
unt_mgr_id ) values (:1  , :2  , :3  , :4  , :5  , :6  ,:7  , :8
 )

    104.82       36,702       0.00    1.6      10.78          11,205 1179264167
Module: Swingbench User Thread
update orders set order_mode = :1 , order_status = :2 , order_to
tal = :3  where order_id = :4

          -------------------------------------------------------------
SQL ordered by Gets  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> End Buffer Gets Threshold:     10000 Total Buffer Gets:     366,124,548
-> Captured SQL accounts for  100.0% of Total Buffer Gets
-> SQL reported below exceeded  1.0% of Total Buffer Gets

                                                     CPU      Elapsd     Old
  Buffer Gets    Executions  Gets per Exec  %Total Time (s)  Time (s) Hash Value
--------------- ------------ -------------- ------ -------- --------- ----------
    352,259,124        7,087       49,705.0   96.2  1241.76   1354.48 1481390170
Module: Swingbench User Thread
SELECT /*+  first_rows index(customers, customers_pk) index(orde
rs, order_status_ix) */  o.order_id, line_item_id, product_id, u
nit_price, quantity, order_mode, order_status, order_total, sale
s_rep_id, promotion_id, c.customer_id, cust_first_name, cust_las

      6,615,367      220,312           30.0    1.8    46.71     52.33 3277652708
Module: Swingbench User Thread
select product_id, product_name, product_description, category_i
d, weight_class, supplier_id,  product_status  list_price, min_p
rice, catalog_url from  product_information where category_id =
:1

          -------------------------------------------------------------
SQL ordered by Reads  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> End Disk Reads Threshold:      1000  Total Disk Reads:         521,691
-> Captured SQL accounts for   99.5% of Total Disk Reads
-> SQL reported below exceeded  1.0% of Total Disk Reads

                                                     CPU      Elapsd
  Physical Rds   Executions  Rds per Exec   %Total Time (s)  Time (s) Hash Value
--------------- ------------ -------------- ------ -------- --------- ----------
        194,485      124,585            1.6   37.3    32.06   1861.91 3739063178
Module: Swingbench User Thread
select customer_id, cust_first_name ,cust_last_name ,nls_languag
e ,nls_territory ,credit_limit ,cust_email ,account_mgr_id  from
 customers where customer_id = :1

         70,411       36,705            1.9   13.5    20.58    648.93 3476971243
Module: Swingbench User Thread
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_
ID) values (:1 , :2 , :3 , :4 )

         67,813      104,865            0.6   13.0    30.21    585.44  688899339
Module: Swingbench User Thread
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT
_PRICE, QUANTITY) values (:1 , :2 , :3 , :4 , :5 )

         65,485       36,612            1.8   12.6    12.72    525.90 3620601857
Module: Swingbench User Thread
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_
price, quantity, order_mode, order_status, order_total, sales_re
p_id, promotion_id, c.customer_id, cust_first_name, cust_last_na
me, credit_limit, cust_email   FROM orders o , order_items oi, c

         47,892      104,856            0.5    9.2    15.00    431.65  686658588
Module: Swingbench User Thread
update inventories set quantity_on_hand = quantity_on_hand - :1
 where product_id = :2  and warehouse_id = :3

         46,784       14,611            3.2    9.0    10.51    397.88 2136488753
Module: Swingbench User Thread
insert into customers (customer_id ,cust_first_name ,cust_last_n
ame ,nls_language ,nls_territory ,credit_limit ,cust_email ,acco
unt_mgr_id ) values (:1  , :2  , :3  , :4  , :5  , :6  ,:7  , :8
 )

         11,205       36,702            0.3    2.1    10.78    104.82 1179264167
Module: Swingbench User Thread
update orders set order_mode = :1 , order_status = :2 , order_to
tal = :3  where order_id = :4

          7,834        7,087            1.1    1.5  1241.76   1354.48 1481390170
Module: Swingbench User Thread
SELECT /*+  first_rows index(customers, customers_pk) index(orde
rs, order_status_ix) */  o.order_id, line_item_id, product_id, u
nit_price, quantity, order_mode, order_status, order_total, sale
s_rep_id, promotion_id, c.customer_id, cust_first_name, cust_las

          -------------------------------------------------------------
SQL ordered by Executions  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> End Executions Threshold:       100  Total Executions:       1,227,684
-> Captured SQL accounts for   99.9% of Total Executions
-> SQL reported below exceeded  1.0% of Total Executions

                                                CPU per    Elap per     Old
 Executions   Rows Processed   Rows per Exec    Exec (s)   Exec (s)  Hash Value
------------ --------------- ---------------- ----------- ---------- ----------
     220,312       1,108,983              5.0       0.00        0.00  3277652708
Module: Swingbench User Thread
select product_id, product_name, product_description, category_i
d, weight_class, supplier_id,  product_status  list_price, min_p
rice, catalog_url from  product_information where category_id =
:1

     124,588         124,586              1.0       0.00        0.00  3603038931
Module: Swingbench User Thread
insert into logon values(:1 ,:2 )

     124,585         124,585              1.0       0.00        0.01  3739063178
Module: Swingbench User Thread
select customer_id, cust_first_name ,cust_last_name ,nls_languag
e ,nls_territory ,credit_limit ,cust_email ,account_mgr_id  from
 customers where customer_id = :1

     110,015       1,100,130             10.0       0.00        0.00  1686147568
Module: Swingbench User Thread
select  p.product_id, product_name, product_description, categor
y_id, weight_class, supplier_id, product_status, list_price, min
_price, catalog_url,  quantity_on_hand, warehouse_id from   prod
uct_information p,  inventories i where  category_id = :1  and i

     104,865         104,865              1.0       0.00        0.01   688899339
Module: Swingbench User Thread
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT
_PRICE, QUANTITY) values (:1 , :2 , :3 , :4 , :5 )

     104,864       1,048,630             10.0       0.00        0.00  1757860790
Module: Swingbench User Thread
select  p.product_id, product_name, product_description, categor
y_id, weight_class, supplier_id,  product_status,  list_price, m
in_price, catalog_url, quantity_on_hand, warehouse_id from  prod
uct_information p, inventories i where   i.product_id = :1   and

     104,864         104,864              1.0       0.00        0.00  2907983846
Module: Swingbench User Thread
select product_id, product_name, product_description, category_i
d, weight_class, supplier_id, product_status, list_price, min_pr
ice, catalog_url from  product_information where product_id = :1


     104,856          94,344              0.9       0.00        0.00   686658588
Module: Swingbench User Thread
update inventories set quantity_on_hand = quantity_on_hand - :1
 where product_id = :2  and warehouse_id = :3

      36,709          36,709              1.0       0.00        0.00  2008308816
Module: Swingbench User Thread
select orders_seq.nextval from dual

SQL ordered by Executions  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> End Executions Threshold:       100  Total Executions:       1,227,684
-> Captured SQL accounts for   99.9% of Total Executions
-> SQL reported below exceeded  1.0% of Total Executions

                                                CPU per    Elap per     Old
 Executions   Rows Processed   Rows per Exec    Exec (s)   Exec (s)  Hash Value
------------ --------------- ---------------- ----------- ---------- ----------
      36,705          36,705              1.0       0.00        0.02  3476971243
Module: Swingbench User Thread
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_
ID) values (:1 , :2 , :3 , :4 )

      36,703         104,841              2.9       0.00        0.00  3653456532
Module: Swingbench User Thread
SELECT  o.order_id,   line_item_id,   product_id,   unit_price,
  quantity,   order_mode,   order_status,   order_total,   sales
_rep_id,   promotion_id,   c.customer_id,   cust_first_name,   c
ust_last_name,   credit_limit,   cust_email  FROM    orders o ,

      36,702          36,702              1.0       0.00        0.00  1179264167
Module: Swingbench User Thread
update orders set order_mode = :1 , order_status = :2 , order_to
tal = :3  where order_id = :4

      36,612          34,101              0.9       0.00        0.01  3620601857
Module: Swingbench User Thread
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_
price, quantity, order_mode, order_status, order_total, sales_re
p_id, promotion_id, c.customer_id, cust_first_name, cust_last_na
me, credit_limit, cust_email   FROM orders o , order_items oi, c

      14,612          14,612              1.0       0.00        0.00  2838916525
Module: Swingbench User Thread
select customer_seq.nextval from dual

      14,611          14,611              1.0       0.00        0.03  2136488753
Module: Swingbench User Thread
insert into customers (customer_id ,cust_first_name ,cust_last_n
ame ,nls_language ,nls_territory ,credit_limit ,cust_email ,acco
unt_mgr_id ) values (:1  , :2  , :3  , :4  , :5  , :6  ,:7  , :8
 )

          -------------------------------------------------------------
SQL ordered by Parse Calls  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> End Parse Calls Threshold:      1000 Total Parse Calls:             494
-> Captured SQL accounts for   35.2% of Total Parse Calls
-> SQL reported below exceeded  1.0% of Total Parse Calls

                           % Total    Old
 Parse Calls   Executions   Parses Hash Value
------------ ------------ -------- ----------
         134          134    27.13 2396279102
lock table sys.mon_mods$ in exclusive mode nowait

           7           91     1.42 1254950678
select file# from file$ where ts#=:1

           6           11     1.21 3776202709
update seg$ set type#=:4,blocks=:5,extents=:6,minexts=:7,maxexts
=:8,extsize=:9,extpct=:10,user#=:11,iniexts=:12,lists=decode(:13
, 65535, NULL, :13),groups=decode(:14, 65535, NULL, :14), cacheh
int=:15, hwmincr=:16, spare1=DECODE(:17,0,NULL,:17),scanhint=:18

          -------------------------------------------------------------
Instance Activity Stats  DB/Inst: DBM11203/DBM11203  Snaps: 548-549

Statistic                                      Total     per Second    per Trans
--------------------------------- ------------------ -------------- ------------
Batched IO (bound) vector count                  451            0.5          0.0
Batched IO (full) vector count                     0            0.0          0.0
Batched IO block miss count                      660            0.7          0.0
Batched IO buffer defrag count                     8            0.0          0.0
Batched IO double miss count                      93            0.1          0.0
Batched IO same unit count                       228            0.3          0.0
Batched IO single block count                    485            0.5          0.0
Batched IO vector block count                    121            0.1          0.0
Batched IO vector read count                      59            0.1          0.0
Block Cleanout Optim referenced                3,566            4.0          0.0
CCursor + sql area evicted                         0            0.0          0.0
CPU used by this session                     161,965          180.0          0.9
CPU used when call started                   161,867          179.9          0.9
CR blocks created                             43,989           48.9          0.2
Cached Commit SCN referenced                  35,196           39.1          0.2
Commit SCN cached                              6,393            7.1          0.0
DB time                                      640,110          711.2          3.5
DBWR checkpoint buffers written               49,192           54.7          0.3
DBWR checkpoints                                  10            0.0          0.0
DBWR thread checkpoint buffers wr             49,192           54.7          0.3
DBWR transaction table writes                    205            0.2          0.0
DBWR undo block writes                        16,346           18.2          0.1
HSC Heap Segment Block Changes               419,751          466.4          2.3
Heap Segment Array Inserts                       168            0.2          0.0
Heap Segment Array Updates                        16            0.0          0.0
IMU CR rollbacks                              13,454           15.0          0.1
IMU Flushes                                   23,267           25.9          0.1
IMU Redo allocation size                 116,804,124      129,782.4        638.2
IMU commits                                  153,568          170.6          0.8
IMU contention                                19,891           22.1          0.1
IMU pool not allocated                         6,186            6.9          0.0
IMU recursive-transaction flush                    2            0.0          0.0
IMU undo allocation size                 371,526,864      412,807.6      2,029.8
IMU- failed to get a private stra              6,186            6.9          0.0
LOB table id lookup cache misses                   0            0.0          0.0
PX local messages recv'd                           0            0.0          0.0
PX local messages sent                             0            0.0          0.0
Requests to/from client                    1,415,769        1,573.1          7.7
RowCR - row contention                           230            0.3          0.0
RowCR attempts                               112,158          124.6          0.6
RowCR hits                                   111,029          123.4          0.6
SMON posted for undo segment shri                 25            0.0          0.0
SQL*Net roundtrips to/from client          1,415,679        1,573.0          7.7
active txn count during cleanout              56,264           62.5          0.3
application wait time                             80            0.1          0.0
background checkpoints completed                  10            0.0          0.0
background checkpoints started                    10            0.0          0.0
background timeouts                            4,676            5.2          0.0
branch node splits                                 4            0.0          0.0
buffer is not pinned count               177,521,683      197,246.3        969.9
buffer is pinned count                   179,162,554      199,069.5        978.9
bytes received via SQL*Net from c        345,931,578      384,368.4      1,890.0
bytes sent via SQL*Net to client         766,762,644      851,958.5      4,189.2
calls to get snapshot scn: kcmgss          1,131,364        1,257.1          6.2
calls to kcmgas                              235,304          261.5          1.3
calls to kcmgcs                              725,658          806.3          4.0
Instance Activity Stats  DB/Inst: DBM11203/DBM11203  Snaps: 548-549

Statistic                                      Total     per Second    per Trans
--------------------------------- ------------------ -------------- ------------
cell physical IO interconnect byt      7,965,291,520    8,850,323.9     43,518.1
change write time                              1,293            1.4          0.0
cleanout - number of ktugct calls             33,106           36.8          0.2
cleanouts and rollbacks - consist             23,616           26.2          0.1
cleanouts only - consistent read               1,726            1.9          0.0
cluster key scan block gets                       61            0.1          0.0
cluster key scans                                 61            0.1          0.0
commit batch/immediate performed                  18            0.0          0.0
commit batch/immediate requested                  18            0.0          0.0
commit cleanout failures: buffer                   9            0.0          0.0
commit cleanout failures: callbac                 90            0.1          0.0
commit cleanout failures: cannot               4,959            5.5          0.0
commit cleanouts                             754,600          838.4          4.1
commit cleanouts successfully com            749,542          832.8          4.1
commit immediate performed                        18            0.0          0.0
commit immediate requested                        18            0.0          0.0
commit txn count during cleanout              47,971           53.3          0.3
concurrency wait time                             84            0.1          0.0
consistent changes                           101,259          112.5          0.6
consistent gets                          362,653,675      402,948.5      1,981.4
consistent gets - examination            236,016,951      262,241.1      1,289.5
consistent gets direct                             0            0.0          0.0
consistent gets from cache               362,653,674      402,948.5      1,981.4
consistent gets from cache (fastp        126,416,864      140,463.2        690.7
cursor authentications                             5            0.0          0.0
data blocks consistent reads - un             91,504          101.7          0.5
db block changes                           2,540,644        2,822.9         13.9
db block gets                              3,470,870        3,856.5         19.0
db block gets direct                              27            0.0          0.0
db block gets from cache                   3,470,842        3,856.5         19.0
db block gets from cache (fastpat          1,186,462        1,318.3          6.5
deferred (CURRENT) block cleanout            264,358          293.7          1.4
dirty buffers inspected                      208,905          232.1          1.1
enqueue conversions                              594            0.7          0.0
enqueue releases                             442,156          491.3          2.4
enqueue requests                             442,161          491.3          2.4
enqueue timeouts                                   0            0.0          0.0
enqueue waits                                    687            0.8          0.0
execute count                              1,227,684        1,364.1          6.7
file io service time                               0            0.0          0.0
file io wait time                      8,573,853,443    9,526,503.8     46,843.0
free buffer inspected                        567,389          630.4          3.1
free buffer requested                        583,379          648.2          3.2
heap block compress                              581            0.7          0.0
hot buffers moved to head of LRU             266,992          296.7          1.5
immediate (CR) block cleanout app             25,342           28.2          0.1
immediate (CURRENT) block cleanou             29,315           32.6          0.2
in call idle wait time                     2,637,890        2,931.0         14.4
index crx upgrade (positioned)                     0            0.0          0.0
index fast full scans (full)                       2            0.0          0.0
index fetch by key                        58,896,919       65,441.0        321.8
index scans kdiixs1                       58,714,550       65,238.4        320.8
leaf node 90-10 splits                            20            0.0          0.0
leaf node splits                               1,580            1.8          0.0
lob reads                                          0            0.0          0.0
lob writes                                        79            0.1          0.0
Instance Activity Stats  DB/Inst: DBM11203/DBM11203  Snaps: 548-549

Statistic                                      Total     per Second    per Trans
--------------------------------- ------------------ -------------- ------------
lob writes unaligned                              79            0.1          0.0
logical read bytes from cache      2,999,291,961,344 ############## ############
logons cumulative                                 13            0.0          0.0
max cf enq hold time                              10            0.0          0.0
messages received                            207,393          230.4          1.1
messages sent                                207,393          230.4          1.1
min active SCN optimization appli            159,882          177.7          0.9
no buffer to keep pinned count                     0            0.0          0.0
no work - consistent read gets           125,745,796      139,717.6        687.0
non-idle wait count                        2,520,899        2,801.0         13.8
non-idle wait time                           475,974          528.9          2.6
opened cursors cumulative                  1,227,458        1,363.8          6.7
parse count (describe)                             0            0.0          0.0
parse count (failures)                             0            0.0          0.0
parse count (hard)                                 5            0.0          0.0
parse count (total)                              494            0.6          0.0
parse time cpu                                 1,872            2.1          0.0
parse time elapsed                             1,817            2.0          0.0
physical read IO requests                    520,540          578.4          2.8
physical read bytes                    4,273,692,672    4,748,547.4     23,349.2
physical read total IO requests              523,236          581.4          2.9
physical read total bytes              4,317,188,096    4,796,875.7     23,586.8
physical read total multi block r                  5            0.0          0.0
physical reads                               521,691          579.7          2.9
physical reads cache                         521,641          579.6          2.9
physical reads cache prefetch                  1,197            1.3          0.0
physical reads direct                             50            0.1          0.0
physical reads direct temporary t                  0            0.0          0.0
physical reads prefetch warmup                     0            0.0          0.0
physical write IO requests                   236,146          262.4          1.3
physical write bytes                   2,785,320,960    3,094,801.1     15,217.5
physical write total IO requests             595,840          662.0          3.3
physical write total bytes             3,648,103,424    4,053,448.3     19,931.3
physical write total multi block               1,092            1.2          0.0
physical writes                              340,005          377.8          1.9
physical writes direct                            77            0.1          0.0
physical writes direct (lob)                       0            0.0          0.0
physical writes direct temporary                   0            0.0          0.0
physical writes from cache                   339,928          377.7          1.9
physical writes non checkpoint               268,653          298.5          1.5
pinned buffers inspected                          39            0.0          0.0
pinned cursors current                             2            0.0          0.0
prefetch warmup blocks aged out b                  0            0.0          0.0
prefetched blocks aged out before                  1            0.0          0.0
process last non-idle time                       900            1.0          0.0
recovery blocks read                               0            0.0          0.0
recursive calls                              193,357          214.8          1.1
recursive cpu usage                            1,529            1.7          0.0
redo KB read                                       0            0.0          0.0
redo blocks checksummed by FG (ex            289,944          322.2          1.6
redo blocks read for recovery                      0            0.0          0.0
redo blocks written                          823,333          914.8          4.5
redo buffer allocation retries                   158            0.2          0.0
redo entries                                 649,160          721.3          3.6
redo k-bytes read for recovery                     0            0.0          0.0
redo log space requests                          160            0.2          0.0
Instance Activity Stats  DB/Inst: DBM11203/DBM11203  Snaps: 548-549

Statistic                                      Total     per Second    per Trans
--------------------------------- ------------------ -------------- ------------
redo log space wait time                         458            0.5          0.0
redo ordering marks                            6,035            6.7          0.0
redo size                                352,947,044      392,163.4      1,928.3
redo size for direct writes                      208            0.2          0.0
redo subscn max counts                        15,781           17.5          0.1
redo synch long waits                            181            0.2          0.0
redo synch time                                9,558           10.6          0.1
redo synch time (usec)                    95,566,555      106,185.1        522.1
redo synch writes                            183,020          203.4          1.0
redo wastage                              55,266,600       61,407.3        302.0
redo write time                                5,251            5.8          0.0
redo writes                                  178,395          198.2          1.0
rollback changes - undo records a                 48            0.1          0.0
rollbacks only - consistent read              19,779           22.0          0.1
rows fetched via callback                 58,747,498       65,275.0        321.0
session connect time                               0            0.0          0.0
session logical reads                    366,124,548      406,805.1      2,000.3
session pga memory                         5,957,264        6,619.2         32.6
session pga memory max                    14,149,264       15,721.4         77.3
session uga memory                     4,296,091,104    4,773,434.6     23,471.6
session uga memory max                    25,871,384       28,746.0        141.4
shared hash latch upgrades - no w            308,804          343.1          1.7
shared hash latch upgrades - wait                 30            0.0          0.0
sorts (memory)                                   445            0.5          0.0
sorts (rows)                                  16,407           18.2          0.1
sql area evicted                                   0            0.0          0.0
sql area purged                                    0            0.0          0.0
summed dirty queue length                  1,929,457        2,143.8         10.5
switch current to new buffer                     333            0.4          0.0
table fetch by rowid                     119,535,422      132,817.1        653.1
table fetch continued row                          0            0.0          0.0
table scan blocks gotten                   6,178,992        6,865.6         33.8
table scan rows gotten                   220,684,706      245,205.2      1,205.7
table scans (long tables)                          0            0.0          0.0
table scans (short tables)                   220,385          244.9          1.2
temp space allocated (bytes)                       0            0.0          0.0
total cf enq hold time                         3,080            3.4          0.0
total number of cf enq holders                    76            0.1          0.0
total number of times SMON posted                 30            0.0          0.0
transaction rollbacks                             15            0.0          0.0
undo change vector size                  118,624,520      131,805.0        648.1
user I/O wait time                           459,812          510.9          2.5
user calls                                 2,605,661        2,895.2         14.2
user commits                                 183,034          203.4          1.0
workarea executions - optimal                    274            0.3          0.0
write clones created in foregroun                120            0.1          0.0
          -------------------------------------------------------------

Instance Activity Stats  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> Statistics with absolute values (should not be diffed)

Statistic                             Begin Value       End Value
--------------------------------- --------------- ---------------
logons current                                 57              59
opened cursors current                         94              91
session cursor cache count                  2,497           2,715
          -------------------------------------------------------------

Instance Activity Stats  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> Statistics identified by '(derived)' come from sources other than SYSSTAT

Statistic                                      Total  per Hour
--------------------------------- ------------------ ---------
log switches (derived)                            10     40.00
          -------------------------------------------------------------

OS Statistics  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> ordered by statistic type (CPU use, Virtual Memory, Hardware Config), Name

Statistic                                  Total
------------------------- ----------------------
BUSY_TIME                                176,820
IDLE_TIME                                523,351
IOWAIT_TIME                              153,057
NICE_TIME                                     35
SYS_TIME                                   6,253
USER_TIME                                166,868
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

OS Statistics - detail  DB/Inst: DBM11203/DBM11203  Snaps: 548-549

  Snap Snapshot
    Id Day Time          Load  %Busy  %User %System   %WIO  %WCPU
------ --------------- ------ ------ ------ ------- ------ ------
   548 Wed 23 18:30:40    6.0
   549 Wed 23 18:45:40    7.1   25.3   23.8      .9   21.9
          -------------------------------------------------------------
IO Stat by Function - summary  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
->Data Volume values suffixed with   M,G,T,P are in multiples of 1024,
  other values suffixed with       K,M,G,T,P are in multiples of 1000
->ordered by Data Volume (Read+Write) desc

               ---------- Read --------- --------- Write -------- --- Wait ----
                 Data  Requests    Data   Data  Requests    Data          Avg
Function        Volume     /sec  Vol/sec Volume     /sec  Vol/sec  Count Tm(ms)
--------------- ------ -------- -------- ------ -------- -------- ------ ------
Buffer Cache Re  4074M   578.1      4.5M                            520K    0.0
LGWR                4M      .3       .0M   807M   398.5       .9M   179K    0.0
Others             37M     2.7       .0M    15M     1.1       .0M  2882     0.0
Streams AQ          1M      .0       .0M                              8     0.0
Direct Reads        1M      .1       .0M             .0                     0.0
          -------------------------------------------------------------

IO Stat by Function - detail  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
->ordered by Data Volume (Read+Write) desc

                   ----------- Read ---------- ----------- Write ---------
                    Small  Large  Small  Large  Small  Large  Small  Large
                     Read   Read   Data   Data  Write  Write   Data   Data
Function             Reqs   Reqs   Read   Read   Reqs   Reqs  Writn  Writn
------------------ ------ ------ ------ ------ ------ ------ ------ ------
Buffer Cache Reads   520K     5   4070M     4M
LGWR                 299             4M          359K          807M
Others              2393            37M          979            15M
Streams AQ             8             1M
Direct Reads          50             1M           18
          -------------------------------------------------------------
Tablespace IO Stats  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
->ordered by IOs (Reads + Writes) desc

Tablespace
------------------------------
                 Av      Av     Av                    Av        Buffer Av Buf
         Reads Reads/s Rd(ms) Blks/Rd       Writes Writes/s      Waits Wt(ms)
-------------- ------- ------ ------- ------------ -------- ---------- ------
SOE
       518,528     576    8.8     1.0      234,024      260      3,190    8.5
SYSAUX
         1,461       2    6.4     1.4          487        1          0    0.0
UNDOTBS1
            82       0    6.1     1.0        1,352        2         50    0.2
SYSTEM
           233       0   11.2     3.3           25        0          1    0.0
USERS
            10       0    0.0     1.0           10        0          0    0.0
TEMP
             2       0   10.0     1.0            0        0          0    0.0
          -------------------------------------------------------------
File IO Stats  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
->Mx Rd Bkt: Max bucket time for single block read
->ordered by Tablespace, File

Tablespace               Filename
------------------------ ----------------------------------------------------
                        Av   Mx                                             Av
                 Av     Rd   Rd    Av                    Av        Buffer BufWt
         Reads Reads/s (ms)  Bkt Blks/Rd       Writes Writes/s      Waits  (ms)
-------------- ------- ----- --- ------- ------------ -------- ---------- ------
SOE                      +DATA/dbm11203/datafile/soe.486.836957131
       518,528     576   8.8 ###     1.0      234,024      260      3,190    8.5

SYSAUX                   +DATA/dbm11203/datafile/sysaux.460.772715927
         1,461       2   6.4 ###     1.4          487        1          0

SYSTEM                   +DATA/dbm11203/datafile/system.459.772715923
           233       0  11.2 ###     3.3           25        0          1    0.0

TEMP                     +DATA/dbm11203/tempfile/temp.462.772715931
             2       0  10.0         1.0            0        0          0

UNDOTBS1                 +DATA/dbm11203/datafile/undotbs1.461.772715929
            82       0   6.1 ###     1.0        1,352        2         50    0.2

USERS                    +DATA/dbm11203/datafile/users.463.772715939
            10       0   0.0         1.0           10        0          0

          -------------------------------------------------------------
File Read Histogram Stats  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
->Number of single block reads in each time range
->Tempfiles are not included
->ordered by Tablespace, File

Tablespace               Filename
------------------------ ----------------------------------------------------
    0 - 2 ms     2 - 4 ms    4 - 8 ms     8 - 16 ms   16 - 32 ms       32+ ms
------------ ------------ ------------ ------------ ------------ ------------
SYSTEM                   +DATA/dbm11203/datafile/system.459.772715923
           8           36           60           37            8            8

SYSAUX                   +DATA/dbm11203/datafile/sysaux.460.772715927
         402          295          413          199           58           25

UNDOTBS1                 +DATA/dbm11203/datafile/undotbs1.461.772715929
          34            7           13           13            2            3

SOE                      +DATA/dbm11203/datafile/soe.486.836957131
      25,937      102,767      254,780       94,642       22,862       17,559

          -------------------------------------------------------------
Instance Recovery Stats  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> B: Begin snapshot,  E: End snapshot

  Targt Estd                                  Log File  Log Ckpt    Log Ckpt
  MTTR  MTTR   Recovery   Actual    Target      Size     Timeout    Interval
   (s)   (s)   Estd IOs  Redo Blks Redo Blks Redo Blks  Redo Blks  Redo Blks
- ----- ----- ---------- --------- --------- ---------- --------- ------------
B     0    19      21256    167642    165888     165888    367186
E     0    19      20317    170069    165888     165888    384682
          -------------------------------------------------------------

Memory Dynamic Components  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
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

Buffer Pool Advisory  DB/Inst: DBM11203/DBM11203  End Snap: 549
-> Only rows with estimated physical reads >0 are displayed
-> ordered by Pool, Block Size, Buffers For Estimate

                                   Est
                                  Phys      Estimated                   Est
    Size for  Size      Buffers   Read     Phys Reads     Est Phys % dbtime
P    Est (M) Factr  (thousands)  Factr    (thousands)    Read Time  for Rds
--- -------- ----- ------------ ------ -------------- ------------ --------
D         72    .1            9  347.5      1,580,472   14,577,600   ######
D        144    .2           18  261.5      1,189,506   10,971,380   ######
D        216    .3           27  121.9        554,416    5,113,394   ######
D        288    .4           35    1.7          7,721       70,764    125.3
D        360    .5           44    1.4          6,321       57,849    102.4
D        432    .6           53    1.2          5,668       51,823     91.7
D        504    .7           62    1.2          5,255       48,010     85.0
D        576    .8           71    1.1          4,967       45,357     80.3
D        648    .9           80    1.0          4,738       43,240     76.5
D        720   1.0           88    1.0          4,565       41,649     73.7
D        728   1.0           89    1.0          4,548       41,496     73.5
D        792   1.1           97    1.0          4,420       40,308     71.3
D        864   1.2          106    0.9          4,295       39,162     69.3
D        936   1.3          115    0.9          4,185       38,146     67.5
D      1,008   1.4          124    0.9          4,082       37,196     65.8
D      1,080   1.5          133    0.9          3,986       36,307     64.3
D      1,152   1.6          141    0.9          3,903       35,541     62.9
D      1,224   1.7          150    0.8          3,826       34,837     61.7
D      1,296   1.8          159    0.8          3,699       33,660     59.6
D      1,368   1.9          168    0.7          3,126       28,377     50.2
D      1,440   2.0          177    0.6          2,852       25,853     45.8
          -------------------------------------------------------------

Buffer Pool Statistics  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> Standard block size Pools  D: default,  K: keep,  R: recycle
-> Default Pools for other block sizes: 2k, 4k, 8k, 16k, 32k
-> Buffers: the number of buffers.  Units of K, M, G are divided by 1000

                                                            Free Writ     Buffer
            Pool         Buffer     Physical    Physical  Buffer Comp       Busy
P   Buffers Hit%           Gets        Reads      Writes   Waits Wait      Waits
--- ------- ---- -------------- ------------ ----------- ------- ---- ----------
D       89K  100    364,857,224      521,484     339,572       0    0      3,242
          -------------------------------------------------------------

Buffer wait Statistics  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> ordered by wait time desc, waits desc

Class                        Waits Total Wait Time (s) Avg Time (ms)
---------------------- ----------- ------------------- -------------
data block                   3,201                  27             8
undo block                      21                   0             0
undo header                     29                   0             0
          -------------------------------------------------------------
PGA Aggr Target Stats  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
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
          100.0               73                         0

Warning:  pga_aggregate_target was set too low for current workload, as this
          value was exceeded during this interval.  Use the PGA Advisory view
          to help identify a different value for pga_aggregate_target.

                                             %PGA  %Auto   %Man
  PGA Aggr  Auto PGA   PGA Mem    W/A PGA    W/A    W/A    W/A   Global Mem
  Target(M) Target(M)  Alloc(M)   Used(M)    Mem    Mem    Mem    Bound(K)
- --------- --------- ---------- ---------- ------ ------ ------ ----------
B       128         8      175.1        0.0     .0     .0     .0     26,214
E       128         8      183.1        0.0     .0     .0     .0     26,214
          -------------------------------------------------------------

PGA Aggr Target Histogram  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> Optimal Executions are purely in-memory operations

    Low    High
Optimal Optimal    Total Execs Optimal Execs 1-Pass Execs M-Pass Execs
------- ------- -------------- ------------- ------------ ------------
     2K      4K            199           199            0            0
    64K    128K              9             9            0            0
   128K    256K              1             1            0            0
   512K   1024K             57            57            0            0
     1M      2M              6             6            0            0
     4M      8M              4             4            0            0
          -------------------------------------------------------------

PGA Memory Advisory  DB/Inst: DBM11203/DBM11203  End Snap: 549
-> When using Auto Memory Mgmt, minimally choose a pga_aggregate_target value
   where Estd PGA Overalloc Count is 0

                                   Estd Extra                Estd
  PGA Aggr                           W/A MB      Estd Time    PGA   Estd PGA
    Target   Size         W/A MB  Read/Written  to Process  Cache  Overalloc
  Est (MB)  Factr      Processed    to Disk      Bytes (s)  Hit %      Count
---------- ------ -------------- -------------- ---------- ------ ----------
        16    0.1            740             14        1.2   98.0          6
        32    0.3            740             14        1.2   98.0          6
        64    0.5            740             14        1.2   98.0          6
        96    0.8            740             14        1.2   98.0          6
       128    1.0            740              0        1.2  100.0          6
       154    1.2            740              0        1.2  100.0          0
       179    1.4            740              0        1.2  100.0          0
       205    1.6            740              0        1.2  100.0          0
       230    1.8            740              0        1.2  100.0          0
       256    2.0            740              0        1.2  100.0          0
       384    3.0            740              0        1.2  100.0          0
       512    4.0            740              0        1.2  100.0          0
       768    6.0            740              0        1.2  100.0          0
     1,024    8.0            740              0        1.2  100.0          0
          -------------------------------------------------------------
Process Memory Summary Stats  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
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
B --------     175.1     125.5     21.7      3.1     2.7      14     34     57
  Other        150.0                         2.6     2.4      14     25     57
  Freeable      21.7        .0               1.1     1.3       6            20
  PL/SQL         2.5       2.2                .0      .2       1      2     57
  SQL             .9        .1                .0      .0       0      9     34
E --------     183.1     128.6     27.4      3.1     2.6      14     34     59
  Other        151.3                         2.6     2.4      14     25     59
  Freeable      28.4        .0               1.0     1.1       6            29
  PL/SQL         2.5       2.2                .0      .2       1      2     59
  SQL             .9        .1                .0      .0       0      9     35
          -------------------------------------------------------------

Top Process Memory (by component)  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> ordered by Begin/End snapshot, Alloc (MB) desc

                        Alloc   Used   Freeabl     Max      Hist Max
     PId Category       (MB)    (MB)     (MB)   Alloc (MB) Alloc (MB)
- ------ ------------- ------- ------- -------- ---------- ----------
B     10 DBW0 --------    14.0    10.9       .0       14.0       25.3
         Other            14.0                        14.0       25.3
         PL/SQL             .0      .0                  .0         .0
      11 LGWR --------    12.9    12.1       .0       12.9       12.9
         Other            12.9                        12.9       12.9
         PL/SQL             .0      .0                  .0         .0
      23 J000 --------     9.1     2.5      6.3        9.1        9.1
         Freeable          6.3      .0                 6.3
         Other             2.5                         2.5        2.5
         PL/SQL             .2      .2                  .2         .2
         SQL                .1      .1                  .1        6.3
      20 MARK --------     8.2     8.0       .0        8.2        8.2
         Other             8.2                         8.2        8.2
         PL/SQL             .0      .0                  .0         .0
      19 TNS V1-V3 ---     7.9     5.4      1.0        7.9       34.4
         Other             5.4                         5.4       22.2
         PL/SQL            1.3     1.3                 1.3        1.7
         Freeable          1.0      .0                 1.0
         SQL                .2      .0                  .2        9.4
      17 MMON --------     3.7     3.2       .1        3.7        4.7
         Other             3.4                         3.4        3.4
         Freeable           .1      .0                  .1
         PL/SQL             .1      .1                  .1         .1
         SQL                .0      .0                  .0        1.0
      38  ------------     3.6     2.1       .0        3.6        4.6
         Other             3.6                         3.6        3.6
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      44  ------------     3.6     2.1      1.1        3.6        4.6
         Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      45  ------------     3.6     2.1      1.1        3.6        4.6
         Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      46  ------------     3.6     2.1      1.1        3.6        4.6
         Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      48  ------------     3.6     2.1       .0        3.6        4.6
         Other             3.6                         3.6        3.6
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      50  ------------     3.6     2.1      1.1        3.6        4.6
         Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      53  ------------     3.6     2.1      1.1        3.6        3.6

Top Process Memory (by component)  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> ordered by Begin/End snapshot, Alloc (MB) desc

                        Alloc   Used   Freeabl     Max      Hist Max
     PId Category       (MB)    (MB)     (MB)   Alloc (MB) Alloc (MB)
- ------ ------------- ------- ------- -------- ---------- ----------
B     53 Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        1.0
      54  ------------     3.6     2.1       .0        3.6        3.8
         Other             3.6                         3.6        3.6
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        1.0
      59  ------------     3.6     2.1      1.1        3.6        4.6
         Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      60  ------------     3.6     2.1      1.1        3.6        4.6
         Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      61  ------------     3.6     2.1       .0        3.6        4.6
         Other             3.6                         3.6        3.6
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      62  ------------     3.6     2.1      1.1        3.6        4.6
         Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      47  ------------     3.6     2.3       .0        3.6        4.6
         Other             3.5                         3.5        3.5
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      40  ------------     3.5     2.1      1.1        3.5        4.6
         Other             2.4                         2.4        2.4
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
E     10 DBW0 --------    14.0    10.9       .0       14.0       25.3
         Other            14.0                        14.0       25.3
         PL/SQL             .0      .0                  .0         .0
      11 LGWR --------    12.9    12.1       .0       12.9       12.9
         Other            12.9                        12.9       12.9
         PL/SQL             .0      .0                  .0         .0
      23 J000 --------     9.1     2.5      6.3        9.1        9.1
         Freeable          6.3      .0                 6.3
         Other             2.5                         2.5        2.5
         PL/SQL             .2      .2                  .2         .2
         SQL                .1      .1                  .1        6.3
      20 MARK --------     8.2     8.0       .0        8.2        8.2
         Other             8.2                         8.2        8.2
         PL/SQL             .0      .0                  .0         .0
      19 TNS V1-V3 ---     7.9     5.4      1.0        7.9       34.4
         Other             5.4                         5.4       22.2
         PL/SQL            1.3     1.3                 1.3        1.7

Top Process Memory (by component)  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> ordered by Begin/End snapshot, Alloc (MB) desc

                        Alloc   Used   Freeabl     Max      Hist Max
     PId Category       (MB)    (MB)     (MB)   Alloc (MB) Alloc (MB)
- ------ ------------- ------- ------- -------- ---------- ----------
E     19 Freeable          1.0      .0                 1.0
         SQL                .2      .0                  .2        9.4
      17 MMON --------     4.4     3.2       .8        4.4        4.7
         Other             3.4                         3.4        3.4
         Freeable           .8      .0                  .8
         PL/SQL             .1      .1                  .1         .1
         SQL                .0      .0                  .0        1.0
      36  ------------     3.7     2.2       .0        3.7        4.7
         Other             3.6                         3.6        3.6
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      37  ------------     3.7     2.2      1.1        3.7        4.7
         Other             2.6                         2.6        2.6
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      49  ------------     3.7     2.2      1.1        3.7        4.7
         Other             2.6                         2.6        2.6
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      38  ------------     3.6     2.1      1.1        3.6        4.7
         Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      44  ------------     3.6     2.1      1.1        3.6        4.6
         Other             2.4                         2.4        2.4
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      45  ------------     3.6     2.1      1.1        3.6        4.7
         Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      48  ------------     3.6     2.1       .0        3.6        4.6
         Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      51  ------------     3.6     2.1      1.1        3.6        4.7
         Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      53  ------------     3.6     2.1      1.1        3.6        3.6
         Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        1.0
      54  ------------     3.6     2.1      1.1        3.6        3.8
         Other             2.5                         2.5        2.5

Top Process Memory (by component)  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> ordered by Begin/End snapshot, Alloc (MB) desc

                        Alloc   Used   Freeabl     Max      Hist Max
     PId Category       (MB)    (MB)     (MB)   Alloc (MB) Alloc (MB)
- ------ ------------- ------- ------- -------- ---------- ----------
E     54 Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        1.0
      57  ------------     3.6     2.1      1.1        3.6        4.6
         Other             2.4                         2.4        2.4
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      59  ------------     3.6     2.1      1.1        3.6        4.6
         Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      60  ------------     3.6     2.1      1.1        3.6        4.6
         Other             2.5                         2.5        2.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
      62  ------------     3.6     2.1       .0        3.6        4.7
         Other             3.6                         3.6        3.6
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        2.0
          -------------------------------------------------------------
Enqueue activity  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> only enqueues with waits are shown
-> Enqueue stats gathered prior to 10g should not be compared with 10g data
-> ordered by Wait Time desc, Waits desc

Enqueue Type (Request Reason)
------------------------------------------------------------------------------
    Requests    Succ Gets Failed Gets       Waits Wt Time (s)  Av Wt Time(ms)
------------ ------------ ----------- ----------- ------------ --------------
TX-Transaction (row lock contention)
         681          681           0         679            1           1.19
TX-Transaction (index contention)
         557          557           0           7            0          14.29
JS-Job Scheduler (queue lock)
       2,752        2,752           0           1            0          50.00
          -------------------------------------------------------------

Undo Segment Summary  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> Min/Max TR (mins) - Min and Max Tuned Retention (minutes)
-> STO - Snapshot Too Old count,  OOS - Out Of Space count
-> Undo segment block stats:
   uS - unexpired Stolen,   uR - unexpired Released,   uU - unexpired reUsed
   eS - expired   Stolen,   eR - expired   Released,   eU - expired   reUsed

Undo   Num Undo       Number of  Max Qry     Max Tx Min/Max   STO/  uS/uR/uU/
 TS# Blocks (K)    Transactions  Len (s)      Concy TR (mins) OOS   eS/eR/eU
---- ---------- --------------- -------- ---------- --------- ----- -----------
   2       31.8         369,847      939         20 19.6/29.7 0/0   0/0/0/0/0/0
          -------------------------------------------------------------


Undo Segment Stats  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> Most recent 35 Undostat rows, ordered by End Time desc

                Num Undo    Number of Max Qry  Max Tx Tun Ret STO/  uS/uR/uU/
End Time          Blocks Transactions Len (s)   Concy  (mins) OOS   eS/eR/eU
------------ ----------- ------------ ------- ------- ------- ----- -----------
23-Apr 18:53      10,525      122,772     939      19      30 0/0   0/0/0/0/0/0
23-Apr 18:43      10,617      123,638     338      20      20 0/0   0/0/0/0/0/0
23-Apr 18:33      10,647      123,437     939      20      30 0/0   0/0/0/0/0/0
          -------------------------------------------------------------
Latch Activity  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
->"Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
  willing-to-wait latch get requests
->"NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
->"Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                              Get          Get   Slps   Time       NoWait NoWait
Latch                       Requests      Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
AQ deq hash table latch               2    0.0             0            0
ASM Keyed state latch                22    0.0             0            0
ASM allocation                      144    0.0             0            0
ASM db client latch                 692    0.0             0            0
ASM map operation freeli             34    0.0             0            0
ASM map operation hash t      2,239,349    0.0    0.0      0            0
ASM network background l            437    0.0             0            0
ASM network state latch             185    0.0             0            0
AWR Alerted Metric Eleme          6,805    0.0             0            0
Change Notification Hash            300    0.0             0            0
Consistent RBA                  178,398    0.0             0            0
DML lock allocation             496,682    0.0    0.1      0            0
Event Group Locks                    27    0.0             0            0
FOB s.o list latch                  140    0.0             0            0
File State Object Pool P              2    0.0             0            0
I/O Staticstics latch                 2    0.0             0            0
IPC stats buffer allocat              2    0.0             0            0
In memory undo latch          1,300,337    0.0    0.6      0      183,237    0.0
JS Sh mem access                      6    0.0             0            0
JS broadcast autostart l              1    0.0             0            0
JS mem alloc latch                    2    0.0             0            0
JS queue access latch                 4    0.0             0            0
JS queue state obj latch          5,504    0.0             0            0
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
KTF sga latch                         5    0.0             0          301    0.0
KWQMN job cache list lat              1    0.0             0            0
KWQP Prop Status                    117    0.0             0            0
KWQS pqueue ctx latch                 2    0.0             0            0
Locator state objects po              2    0.0             0            0
Lsod array latch                    174    0.0             0            0
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
Latch Activity  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
->"Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
  willing-to-wait latch get requests
->"NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
->"Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                              Get          Get   Slps   Time       NoWait NoWait
Latch                       Requests      Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
Mutex Stats                           2    0.0             0            0
OS process                          104    0.0             0            0
OS process allocation             1,860    0.0             0            0
OS process: request allo             22    0.0             0            0
PL/SQL warning settings              44    0.0             0            0
PX hash array latch                   2    0.0             0            0
QMT                                   2    0.0             0            0
Real-time plan statistic            436    0.0             0            0
SGA IO buffer pool latch             11    0.0             0           11    0.0
SGA blob parent                       2    0.0             0            0
SGA bucket locks                      2    0.0             0            0
SGA heap locks                        2    0.0             0            0
SGA pool locks                        2    0.0             0            0
SQL memory manager latch              2    0.0             0          299    0.0
SQL memory manager worka         20,399    0.0             0            0
Shared B-Tree                       728    0.0             0            0
Streams Generic                       2    0.0             0            0
Testing                               2    0.0             0            0
Token Manager                         2    0.0             0            0
WCR: sync                             2    0.0             0            0
Write State Object Pool               2    0.0             0            0
X$KSFQP                               1    0.0             0            0
XDB NFS Security Latch                2    0.0             0            0
XDB unused session pool               2    0.0             0            0
XDB used session pool                 2    0.0             0            0
active checkpoint queue          28,260    0.0             0            0
active service list               1,761    0.0             0        2,133    0.0
begin backup scn array                4    0.0             0            0
bq:time manger info latc             33    0.0             0            0
buffer pool                           2    0.0             0            0
bufq statistics                     118    0.0             0            0
business card                         2    0.0             0            0
cache buffer handles              9,918    0.1    0.0      0            0
cache buffers chains        505,222,379    0.0    0.0      0      585,013    0.0
cache buffers lru chain         450,234    0.0    0.1      0      952,930    0.1
cache table scan latch              124    0.0             0          124    0.0
call allocation                     108    0.0             0            0
cas latch                             2    0.0             0            0
change notification clie              2    0.0             0            0
channel handle pool latc             26    0.0             0            0
channel operations paren          6,978    0.0             0            0
checkpoint queue latch        1,341,728    0.0    0.0      0      331,995    0.0
client/application info              18    0.0             0            0
compile environment latc             13    0.0             0            0
corrupted undo seg latch            159    0.0             0            0
cp cmon/server latch                  2    0.0             0            0
cp pool latch                         2    0.0             0            0
cp server hash latch                  2    0.0             0            0
cp sga latch                         33    0.0             0            0
cvmap freelist lock                   2    0.0             0            0
Latch Activity  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
->"Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
  willing-to-wait latch get requests
->"NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
->"Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                              Get          Get   Slps   Time       NoWait NoWait
Latch                       Requests      Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
deferred cleanup latch               33    0.0             0            0
dml lock allocation                  33    0.0             0            0
done queue latch                      2    0.0             0            0
dummy allocation                     26    0.0             0            0
enqueue freelist latch                2    0.0             0       17,660    0.0
enqueue hash chains             885,505    0.0    0.1      0            0
enqueues                             18    0.0             0            0
fifth spare latch                     2    0.0             0            0
file cache latch                    225    0.0             0            0
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
global tx hash mapping                2    0.0             0            0
granule operation                     2    0.0             0            0
hash table column usage               8    0.0             0           35    0.0
hash table modification               2    0.0             0            0
heartbeat check                       2    0.0             0            0
intra txn parallel recov              2    0.0             0            0
io pool granule metadata              2    0.0             0            0
job workq parent latch                3    0.0             0            1    0.0
job_queue_processes free              4    0.0             0            0
job_queue_processes para            198    0.0             0            0
k2q lock allocation                   2    0.0             0            0
kcbtsemkid latch                     10    0.0             0            0
kdlx hb parent latch                  2    0.0             0            0
kgb parent                            2    0.0             0            0
kgnfs mount latch                     2    0.0             0            0
kokc descriptor allocati              4    0.0             0            0
ksfv messages                         2    0.0             0            0
ksim group membership ca              2    0.0             0            0
kss move lock                        22    0.0             0            0
ksuosstats global area               96    0.0             0            0
ksv allocation latch                 71    0.0             0            0
ksv class latch                     690    0.1    0.0      0            0
Latch Activity  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
->"Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
  willing-to-wait latch get requests
->"NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
->"Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                              Get          Get   Slps   Time       NoWait NoWait
Latch                       Requests      Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
ksv instance latch                    4    0.0             0            0
ksv msg queue latch                   2    0.0             0            0
ksz_so allocation latch              22    0.0             0            0
ktm global data                     127    0.0             0            0
kwqbsn:qsga                         566    0.0             0            0
lgwr LWN SCN                    179,364    0.0    0.0      0            0
list of block allocation             53    0.0             0            0
loader state object free            122    0.0             0            0
lob segment dispenser la              2    0.0             0            0
lob segment hash table l              4    0.0             0            0
lob segment query latch               2    0.0             0            0
lock DBA buffer during m              2    0.0             0            0
logical standby cache                 2    0.0             0            0
logminer context allocat              3    0.0             0            0
logminer work area                    2    0.0             0            0
longop free list parent               2    0.0             0            0
mapped buffers lru chain              2    0.0             0            0
message pool operations             277    0.0             0            0
messages                        614,675    0.0    0.0      0            0
mostly latch-free SCN           181,564    0.3    0.0      0            0
msg queue latch                       2    0.0             0            0
multiblock read objects             370    0.0             0            0
name-service namespace b              2    0.0             0            0
ncodef allocation latch              33    0.0             0            0
object queue header heap        227,032    0.0             0        1,286    0.0
object queue header oper      2,322,813    0.0    0.0      0            0
object stats modificatio            198    0.0             0            0
parallel query alloc buf            122    0.0             0            0
parallel query stats                  2    0.0             0            0
parameter list                        4    0.0             0            0
parameter table manageme             41    0.0             0            0
peshm                                 2    0.0             0            0
pesom_free_list                       2    0.0             0            0
pesom_hash_node                       2    0.0             0            0
post/wait queue                 270,974    0.0    0.0      0      183,937    0.0
process allocation                   34    0.0             0           12    0.0
process group creation               22    0.0             0            0
process queue                         2    0.0             0            0
process queue reference               2    0.0             0            0
qmn task queue latch                851    0.0             0            0
query server freelists                2    0.0             0            0
queued dump request                   3    0.0             0            0
queuing load statistics               2    0.0             0            0
recovery domain hash lis              2    0.0             0            0
redo allocation                 897,978    0.0    0.0      0      648,758    0.2
redo copy                             2    0.0             0      649,251    0.2
redo writing                    565,073    0.0    0.0      0            0
resmgr group change latc              2    0.0             0            0
resmgr:active threads                26    0.0             0            0
resmgr:actses change gro             13    0.0             0            0
Latch Activity  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
->"Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
  willing-to-wait latch get requests
->"NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
->"Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                              Get          Get   Slps   Time       NoWait NoWait
Latch                       Requests      Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
resmgr:actses change sta              2    0.0             0            0
resmgr:free threads list             24    0.0             0            0
resmgr:plan CPU method                2    0.0             0            0
resmgr:resource group CP              2    0.0             0            0
resmgr:schema config                  2    0.0             0            0
resmgr:session queuing                2    0.0             0            0
rm cas latch                          2    0.0             0            0
row cache objects                 8,340    0.0    0.0      0           39    0.0
rules engine rule set st            200    0.0             0            0
second Audit Vault latch              2    0.0             0            0
second spare latch                    2    0.0             0            0
sequence cache                  154,236    0.0    0.0      0            0
session allocation              183,117    0.0    0.0      0      183,113    0.0
session idle bit              5,393,920    0.0    0.1      0            0
session queue latch                   2    0.0             0            0
session state list latch             38    0.0             0            0
session switching                    45    0.0             0            0
session timer                       314    0.0             0            0
shared pool                       2,323    0.1    0.0      0            0
shared pool sim alloc                 2    0.0             0            0
shared pool simulator                38    0.0             0            0
sim partition latch                   2    0.0             0            0
simulator hash latch         21,617,524    0.0    0.0      0            0
simulator lru latch              20,648    0.7    0.0      0   21,560,360    0.7
sort extent pool                     76    0.0             0            0
space background state o              4    0.0             0            0
space background task la          1,863    0.2    0.0      0          605    0.0
state object free list                2    0.0             0            0
statistics aggregation              336    0.0             0            0
tablespace key chain                  2    0.0             0            0
temp lob duration state               2    0.0             0            0
test excl. parent l0                  2    0.0             0            0
test excl. parent2 l0                 2    0.0             0            0
third spare latch                     2    0.0             0            0
threshold alerts latch               38    0.0             0            0
transaction allocation               46    0.0             0            0
undo global data              1,063,790    0.0    0.0      0            0
virtual circuit buffers               2    0.0             0            0
virtual circuit holder                2    0.0             0            0
virtual circuit queues                2    0.0             0            0
          -------------------------------------------------------------
Latch Sleep breakdown  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> ordered by misses desc

                                       Get                                 Spin
Latch Name                        Requests       Misses      Sleeps        Gets
-------------------------- --------------- ------------ ----------- -----------
cache buffers chains           505,222,379      239,262         453     238,809
simulator hash latch            21,617,524        1,485          22       1,463
mostly latch-free SCN              181,564          627          14         613
object queue header operat       2,322,813          449          14         435
session idle bit                 5,393,920          425          32         393
redo allocation                    897,978          316          11         305
In memory undo latch             1,300,337          271         155         117
enqueue hash chains                885,505          229          14         215
cache buffers lru chain            450,234          177           9         168
simulator lru latch                 20,648          148           3         145
messages                           614,675          115           2         113
undo global data                 1,063,790           71           2          69
DML lock allocation                496,682           43           4          39
checkpoint queue latch           1,341,728           40           1          39
          -------------------------------------------------------------
Latch Miss Sources  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> only latches with sleeps are shown
-> ordered by name, sleeps desc

                                                     NoWait              Waiter
Latch Name               Where                       Misses     Sleeps   Sleeps
------------------------ -------------------------- ------- ---------- --------
DML lock allocation      ktaiam                           0          3        1
DML lock allocation      ktaidm                           0          1        3
In memory undo latch     ktiFlush: child                  0        121       49
In memory undo latch     kticmt: child                    0         37        8
In memory undo latch     ktichg: child                    0         10      103
In memory undo latch     kticflush_2                      0          1        0
cache buffers chains     kcbgtcr: fast path (cr pin       0        131      194
cache buffers chains     kcbgtcr: kslbegin shared         0        121       39
cache buffers chains     kcbget: fast exchange            0         86        2
cache buffers chains     kcbgtcr: fast path               0         70      197
cache buffers chains     kcbchg1: mod cr pin              0         62       22
cache buffers chains     kcbgtcr_2                        0         61       37
cache buffers chains     kcbgcur_2                        0         22        4
cache buffers chains     kcbgcur_4                        0         17        3
cache buffers chains     kcbgtcr_1                        0         16        0
cache buffers chains     kcbnew: new latch again          0         11        0
cache buffers chains     kcbzgb: scan from tail. no       0          7        0
cache buffers chains     kcbget: fast path                0          6        1
cache buffers chains     kcbzwb                           0          5        4
cache buffers chains     kcbgtcr: kslbegin excl           0          4        8
cache buffers chains     kcbrls: fast release             0          4       76
cache buffers chains     kcbnlc                           0          4        4
cache buffers chains     kcbgcur: fast path (shr)         0          3        3
cache buffers chains     kcbbxsv                          0          2        0
cache buffers chains     kcbbic2                          0          2        0
cache buffers chains     kcbchg1: clear MS bit            0          1        3
cache buffers chains     kcb_pre_apply: kcbhq61           0          1        6
cache buffers chains     kcbzib: exchange rls             0          1        4
cache buffers lru chain  kcbzgws                          0          9        0
checkpoint queue latch   kcbklbc_cql                      0          1        0
enqueue hash chains      ksqgtl3                          0         11        4
enqueue hash chains      ksqrcl                           0          2       10
enqueue hash chains      ksqcmi: get hash chain lat       0          1        0
lgwr LWN SCN             kcs023                           0          9        0
messages                 ksaamb: after wakeup             0          1        1
messages                 ksarcv                           0          1        1
mostly latch-free SCN    kcslcu3                          0          5       14
object queue header oper kcbo_switch_cq                   0          4        6
object queue header oper kcbo_unlink_q                    0          3        4
object queue header oper kcbo_link_q                      0          3        0
object queue header oper kcbo_switch_mq_bg                0          1        1
object queue header oper kcbo_link_q:reget                0          1        0
object queue header oper kcbo_check_flist                 0          1        3
object queue header oper kcbo_switch_q_bg                 0          1        0
redo allocation          kcrfw_redo_gen: redo alloc       0         11        0
session idle bit         ksupuc: set busy                 0         19       15
session idle bit         ksupuc: clear busy               0         12       15
session idle bit         ksuxds                           0          3        4
simulator hash latch     kcbsacc: lookup dba              0         22       21
simulator lru latch      kcbs_simulate: simulate se       0          3        0
undo global data         ktubnd_4                         0          2        0
          -------------------------------------------------------------
Mutex Sleep  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> ordered by Wait Time desc

                                                                         Wait
Mutex Type         Location                                 Sleeps     Time (s)
------------------ -------------------------------- -------------- ------------
Cursor Pin         kksLockDelete [KKSCHLPIN6]                    9          0.0
Cursor Pin         kksfbc [KKSCHLPIN1]                          23          0.0
Library Cache      kglpndl1  95                                 11          0.0
Library Cache      kglpnal1  90                                  8          0.0
Library Cache      kglpin1   4                                  14          0.0
          -------------------------------------------------------------
Segments by Logical Reads  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> End Segment Logical Reads Threshold:     10000
-> Pct Total shows % of logical reads for each top segment compared with total
   logical reads for all segments captured by the Snapshot

                                           Subobject    Obj.       Logical   Pct
Owner      Tablespace Object Name          Name         Type         Reads Total
---------- ---------- -------------------- ------------ ----- ------------ -----
SOE        SOE        ITEM_ORDER_IX                     INDEX  117,621,472  32.2
SOE        SOE        CUSTOMERS_PK                      INDEX  117,271,664  32.1
SOE        SOE        ORDERS                            TABLE   58,624,432  16.0
SOE        SOE        CUSTOMERS                         TABLE   58,399,904  16.0
SOE        SOE        PRODUCT_INFORMATION               TABLE    6,935,520   1.9
          -------------------------------------------------------------


Segments by Physical Reads  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> End Segment Physical Reads Threshold:      1000

                                           Subobject    Obj.      Physical   Pct
Owner      Tablespace Object Name          Name         Type         Reads Total
---------- ---------- -------------------- ------------ ----- ------------ -----
SOE        SOE        CUSTOMERS                         TABLE      107,088  20.6
SOE        SOE        CUSTOMERS_PK                      INDEX      103,216  19.9
SOE        SOE        ORD_CUSTOMER_IX                   INDEX       65,599  12.6
SOE        SOE        INVENTORIES                       TABLE       47,574   9.2
SOE        SOE        ITEM_ORDER_IX                     INDEX       46,206   8.9
          -------------------------------------------------------------
Segments by Row Lock Waits  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> End Segment Row Lock Waits Threshold:       100

                                                                       Row
                                           Subobject    Obj.          Lock   Pct
Owner      Tablespace Object Name          Name         Type         Waits Total
---------- ---------- -------------------- ------------ ----- ------------ -----
SOE        SOE        ORDERS                            TABLE          682  56.9
SOE        SOE        ORD_ORDER_DATE_IX                 INDEX          300  25.0
SOE        SOE        ITEM_PRODUCT_IX                   INDEX          100   8.3
SOE        SOE        ORD_WAREHOUSE_IX                  INDEX           36   3.0
SOE        SOE        CUST_LNAME_IX                     INDEX           24   2.0
          -------------------------------------------------------------


Segments by Buffer Busy Waits  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> End Segment Buffer Busy Waits Threshold:       100

                                                                    Buffer
                                           Subobject    Obj.          Busy   Pct
Owner      Tablespace Object Name          Name         Type         Waits Total
---------- ---------- -------------------- ------------ ----- ------------ -----
SOE        SOE        ORDERS                            TABLE          324  96.7
SOE        SOE        ORD_ORDER_DATE_IX                 INDEX            3    .9
SOE        SOE        CUSTOMERS_PK                      INDEX            3    .9
SOE        SOE        ITEM_ORDER_IX                     INDEX            2    .6
SOE        SOE        ORDER_ITEMS                       TABLE            2    .6
          -------------------------------------------------------------
Dictionary Cache Stats  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
->"Pct Misses"  should be very low (< 2% in most cases)
->"Final Usage" is the number of cache entries being used in End Snapshot

                                   Get    Pct    Scan   Pct      Mod      Final
Cache                         Requests   Miss    Reqs  Miss     Reqs      Usage
------------------------- ------------ ------ ------- ----- -------- ----------
dc_awr_control                      19    0.0       0              2          1
dc_global_oids                       7    0.0       0              0         24
dc_histogram_data                   78   44.9       0              0      2,000
dc_histogram_defs                   41   12.2       0              0      2,024
dc_objects                         229    0.4       0              1      1,501
dc_profiles                          2    0.0       0              0          1
dc_rollback_segments               963    0.0       0              0         78
dc_segments                        125    0.0       0             11        614
dc_sequences                         9    0.0       0              9          5
dc_tablespaces                     512    0.0       0              0          7
dc_users                           234    0.0       0              0         46
global database name               612    0.0       0              0          1
outstanding_alerts                   8    0.0       0              0          4
sch_lj_oids                          2    0.0       0              0          1
          -------------------------------------------------------------


Library Cache Activity  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
->"Pct Misses"  should be very low

                         Get  Pct        Pin        Pct               Invali-
Namespace           Requests  Miss     Requests     Miss     Reloads  dations
--------------- ------------ ------ -------------- ------ ---------- --------
BODY                      15    0.0             44    0.0          0        0
CLUSTER                    2    0.0              2    0.0          0        0
DBLINK                     1    0.0              0                 0        0
EDITION                    8    0.0              8    0.0          0        0
QUEUE                    264    0.0            264    0.0          0        0
SCHEMA                     1    0.0              0                 0        0
SQL AREA                 374    1.1      1,227,733   -0.0          1        0
SQL AREA BUILD             5  100.0              0                 0        0
SQL AREA STATS             5   80.0              5   80.0          0        0
TABLE/PROCEDURE           27    0.0        102,894    0.0          1        0
          -------------------------------------------------------------
Buffered Queues  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
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
Rule Sets  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
-> * indicates Rule Set activity (re)started between Begin/End snaps
-> Top 25 ordered by Evaluations desc

                                                               No-SQL  SQL
Rule                                *     Eval/sec Reloads/sec Eval % Eval %
----------------------------------- - ------------ ----------- ------ ------
SYS.ALERT_QUE_R                                  0           0      0      0
          -------------------------------------------------------------
Streams Pool Advisory  DB/Inst: DBM11203/DBM11203  End Snap: 549

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
Shared Pool Advisory  DB/Inst: DBM11203/DBM11203  End Snap: 549
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
       232    .9       10          792  10,096    1.0     444    1.8   3,941,981
       236    .9       13          893  10,131    1.0     409    1.6   3,943,415
       240    .9       15        1,000  10,182    1.0     358    1.4   3,944,659
       244    .9       18        1,252  10,196    1.0     344    1.4   3,945,052
       248   1.0       22        1,468  10,214    1.0     326    1.3   3,945,496
       252   1.0       26        1,684  10,233    1.0     307    1.2   3,946,096
       256   1.0       30        1,900  10,265    1.0     275    1.1   3,946,993
       260   1.0       34        2,116  10,292    1.0     248    1.0   3,949,296
       264   1.0       38        2,411  10,295    1.0     245    1.0   3,949,439
       268   1.0       42        2,624  10,295    1.0     245    1.0   3,949,452
       272   1.0       46        2,834  10,295    1.0     245    1.0   3,949,458
       276   1.1       50        3,060  10,295    1.0     245    1.0   3,949,459
       280   1.1       54        3,321  10,296    1.0     244    1.0   3,949,483
       284   1.1       58        3,648  10,296    1.0     244    1.0   3,949,500
       288   1.1       62        3,944  10,296    1.0     244    1.0   3,949,504
       292   1.1       66        4,178  10,296    1.0     244    1.0   3,949,519
       296   1.1       70        4,336  10,296    1.0     244    1.0   3,949,536
       316   1.2       90        4,822  10,296    1.0     244    1.0   3,949,579
       344   1.3       94        5,045  10,296    1.0     244    1.0   3,949,581
       372   1.4       94        5,045  10,296    1.0     244    1.0   3,949,581
       400   1.5       94        5,045  10,296    1.0     244    1.0   3,949,581
       428   1.6       94        5,045  10,296    1.0     244    1.0   3,949,581
       456   1.8       94        5,045  10,296    1.0     244    1.0   3,949,581
       484   1.9       94        5,045  10,296    1.0     244    1.0   3,949,581
       512   2.0       94        5,045  10,296    1.0     244    1.0   3,949,581
       540   2.1       94        5,045  10,296    1.0     244    1.0   3,949,581
          -------------------------------------------------------------
SGA Target Advisory  DB/Inst: DBM11203/DBM11203  End Snap: 549

SGA Target SGA Size   Est DB      Est DB   Est Physical
  Size (M)   Factor Time (s) Time Factor          Reads
---------- -------- -------- ----------- --------------
       512       .5 ########        92.0    567,073,619
       768       .8   64,226         1.1      5,389,498
     1,024      1.0   56,497         1.0      4,533,180
     1,280      1.3   53,238          .9      4,187,298
     1,536      1.5   49,645          .9      3,794,272
     1,792      1.8   41,712          .7      2,926,621
     2,048      2.0   41,713          .7      2,926,621
          -------------------------------------------------------------
SGA Memory Summary  DB/Inst: DBM11203/DBM11203  Snaps: 548-549

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


SGA breakdown difference  DB/Inst: DBM11203/DBM11203  Snaps: 548-549
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
shared KGLH0                                    18.5           18.4    -0.04
shared KGLHD                                     3.8            3.8     0.20
shared KGLS                                      4.4            4.4     0.09
shared KGLSG                                     5.0            5.0     0.00
shared KKSSP                                     2.7            2.8     2.87
shared KSFD SGA I/O b                            3.8            3.8     0.00
shared PLMCD                                     3.2            3.2     0.00
shared SQLA                                     22.3           22.3     0.30
shared db_block_hash_buckets                     5.6            5.6     0.00
shared dbwriter coalesce buffer                  3.8            3.8     0.00
shared dirty object counts array                 4.0            4.0     0.00
shared event statistics per sess                 3.1            3.1     0.00
shared free memory                              87.2           87.0    -0.24
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
SQL Memory Statistics  DB/Inst: DBM11203/DBM11203  Snaps: 548-549

                                   Begin            End         % Diff
                          -------------- -------------- --------------
   Avg Cursor Size (KB):           30.24          30.17           -.21
 Cursor to Parent ratio:            1.10           1.10           -.05
          Total Cursors:             925            930            .54
          Total Parents:             844            849            .59
          -------------------------------------------------------------
init.ora Parameters  DB/Inst: DBM11203/DBM11203  Snaps: 548-549

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

End of Report ( sp_1830_1845.txt )

