
ASH Report For DBM11203/DBM11203

DB Name         DB Id    Instance     Inst Num Release     RAC Host
------------ ----------- ------------ -------- ----------- --- ------------
DBM11203      2532911053 DBM11203            1 11.2.0.3.0  NO  helicon

CPUs           SGA Size       Buffer Cache        Shared Pool    ASH Buffer Size
---- ------------------ ------------------ ------------------ ------------------
   8      1,019M (100%)       728M (71.4%)       260M (25.5%)       16.0M (1.6%)


          Analysis Begin Time:   23-Apr-14 18:45:00
            Analysis End Time:   23-Apr-14 19:00:00
                 Elapsed Time:        15.0 (mins)
            Begin Data Source:   V$ACTIVE_SESSION_HISTORY
              End Data Source:   V$ACTIVE_SESSION_HISTORY
                 Sample Count:       6,453
      Average Active Sessions:        7.17
  Avg. Active Session per CPU:        0.90
                Report Target:   None specified

Top User Events            DB/Inst: DBM11203/DBM11203  (Apr 23 18:45 to 19:00)

                                                               Avg Active
Event                               Event Class        % Event   Sessions
----------------------------------- --------------- ---------- ----------
db file sequential read             User I/O             69.19       4.96
CPU + Wait for CPU                  CPU                  26.78       1.92
log file sync                       Commit                1.77       0.13
          -------------------------------------------------------------

Top Background Events      DB/Inst: DBM11203/DBM11203  (Apr 23 18:45 to 19:00)

                  No data exists for this section of the report.
          -------------------------------------------------------------

Top Event P1/P2/P3 Values  DB/Inst: DBM11203/DBM11203  (Apr 23 18:45 to 19:00)

Event                          % Event  P1 Value, P2 Value, P3 Value % Activity
------------------------------ ------- ----------------------------- ----------
Parameter 1                Parameter 2                Parameter 3
-------------------------- -------------------------- --------------------------
db file sequential read          69.30             "5","1046094","1"       0.03
file#                      block#                     blocks

log file sync                     1.77          "564","99993269","0"       0.02
buffer#                    sync scn                   NOT DEFINED

          -------------------------------------------------------------

Top Service/Module         DB/Inst: DBM11203/DBM11203  (Apr 23 18:45 to 19:00)

Service        Module                   % Activity Action               % Action
-------------- ------------------------ ---------- ------------------ ----------
DBM11203.antog Swingbench User Thread        97.95 UNNAMED                 97.95
SYS$BACKGROUND UNNAMED                        1.86 UNNAMED                  1.86
          -------------------------------------------------------------

Top Client IDs             DB/Inst: DBM11203/DBM11203  (Apr 23 18:45 to 19:00)

                                                              Avg Active
Client ID                                          % Activity   Sessions
-------------------------------------------------- ---------- ----------
User            Program                           Service
--------------- --------------------------------- --------------------
Swingbench                                              97.95       7.02
SOE             JDBC Thin Client                  DBM11203.antognini.c

          -------------------------------------------------------------

Top SQL Command Types      DB/Inst: DBM11203/DBM11203  (Apr 23 18:45 to 19:00)
-> 'Distinct SQLIDs' is the count of the distinct number of SQLIDs
      with the given SQL Command Type found over all the ASH samples
      in the analysis period

                                           Distinct            Avg Active
SQL Command Type                             SQLIDs % Activity   Sessions
---------------------------------------- ---------- ---------- ----------
SELECT                                           12      61.57       4.41
INSERT                                           13      25.07       1.80
UPDATE                                            3       8.49       0.61
          -------------------------------------------------------------

Top Phases of Execution    DB/Inst: DBM11203/DBM11203  (Apr 23 18:45 to 19:00)

                                          Avg Active
Phase of Execution             % Activity   Sessions
------------------------------ ---------- ----------
SQL Execution                       94.31       6.76
          -------------------------------------------------------------

Top SQL with Top Events   DB/Inst: DBM11203/DBM11203  (Apr 23 18:45 to 19:00)

                                                        Sampled #
                 SQL ID             Planhash        of Executions     % Activity
----------------------- -------------------- -------------------- --------------
Event                          % Event Top Row Source                    % RwSrc
------------------------------ ------- --------------------------------- -------
          82ud5h0qcg0bf           4238351645                 1842          28.59
db file sequential read          28.14 TABLE ACCESS - BY INDEX ROWID       15.12
select customer_id, cust_first_name ,cust_last_name ,nls_language ,nls_territory
 ,credit_limit ,cust_email ,account_mgr_id from customers where customer_id = :
1

          g8rhybcumtwd6            799079936                 1435          22.24
CPU + Wait for CPU               21.08 INDEX - RANGE SCAN                   7.31
SELECT /*+ first_rows index(customers, customers_pk) index(orders, order_status
_ix) */ o.order_id, line_item_id, product_id, unit_price, quantity, order_mode,
 order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_firs
t_name, cust_last_name, credit_limit, cust_email, order_date FROM orders o , ord

          9zd49du11u7cf                  N/A                  620           9.65
db file sequential read           9.39 ** Row Source Not Available **       9.39
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) values (:1 ,
 :2 , :3 , :4 )

          8vvvyuun2urt6                  N/A                  606           9.42
db file sequential read           8.97 ** Row Source Not Available **       8.97
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY
) values (:1 , :2 , :3 , :4 , :5 )

          d5j6fbqmu3gjp            724732537                  507           7.89
db file sequential read           7.72 INDEX - RANGE SCAN                   4.15
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_price, quantity,
 order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_i
d, cust_first_name, cust_last_name, credit_limit, cust_email FROM orders o , o
rder_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id =

          -------------------------------------------------------------

Top SQL with Top Row SourcesDB/Inst: DBM11203/DBM11203  (Apr 23 18:45 to 19:00

                                                        Sampled #
                 SQL ID             PlanHash        of Executions     % Activity
----------------------- -------------------- -------------------- --------------
Row Source                               % RwSrc Top Event               % Event
---------------------------------------- ------- ----------------------- -------
          82ud5h0qcg0bf           4238351645                 1842          28.59
TABLE ACCESS - BY INDEX ROWID              15.23 db file sequential read   15.12
select customer_id, cust_first_name ,cust_last_name ,nls_language ,nls_territory
 ,credit_limit ,cust_email ,account_mgr_id from customers where customer_id = :
1


INDEX - UNIQUE SCAN                        13.13 db file sequential read   13.02

          g8rhybcumtwd6            799079936                 1435          22.24
INDEX - RANGE SCAN                          7.56 CPU + Wait for CPU         7.31
SELECT /*+ first_rows index(customers, customers_pk) index(orders, order_status
_ix) */ o.order_id, line_item_id, product_id, unit_price, quantity, order_mode,
 order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_firs
t_name, cust_last_name, credit_limit, cust_email, order_date FROM orders o , ord


INDEX - UNIQUE SCAN                         6.21 CPU + Wait for CPU         5.95


TABLE ACCESS - BY INDEX ROWID               3.75 CPU + Wait for CPU         3.60

          9zd49du11u7cf                  N/A                  620           9.65
** Row Source Not Available **              9.65 db file sequential read    9.39
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) values (:1 ,
 :2 , :3 , :4 )

          8vvvyuun2urt6                  N/A                  606           9.42
** Row Source Not Available **              9.42 db file sequential read    8.97
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY
) values (:1 , :2 , :3 , :4 , :5 )

          d5j6fbqmu3gjp            724732537                  507           7.89
INDEX - RANGE SCAN                          4.22 db file sequential read    4.15
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_price, quantity,
 order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_i
d, cust_first_name, cust_last_name, credit_limit, cust_email FROM orders o , o
rder_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id =


TABLE ACCESS - BY INDEX ROWID               1.24 db file sequential read    1.24


TABLE ACCESS - BY INDEX ROWID               1.18 db file sequential read    1.18

          -------------------------------------------------------------

Top SQL using literals     DB/Inst: DBM11203/DBM11203  (Apr 23 18:45 to 19:00)

                  No data exists for this section of the report.
          -------------------------------------------------------------

Top Parsing Module/Action  DB/Inst: DBM11203/DBM11203  (Apr 23 18:45 to 19:00)

                  No data exists for this section of the report.
          -------------------------------------------------------------

Top PL/SQL Procedures      DB/Inst: DBM11203/DBM11203  (Apr 23 18:45 to 19:00)

                  No data exists for this section of the report.
          -------------------------------------------------------------

Top Java Workload          DB/Inst: DBM11203/DBM11203  (Apr 23 18:45 to 19:00)

                  No data exists for this section of the report.
          -------------------------------------------------------------

Top Call Types             DB/Inst: DBM11203/DBM11203  (Apr 23 18:45 to 19:00)

Call Type                                     Count % Activity Avg Active
---------------------------------------- ---------- ---------- ----------
V8 Bundled Exec                               6,164      95.52       6.85
COMMIT                                          141       2.19       0.16
          -------------------------------------------------------------

Top Sessions              DB/Inst: DBM11203/DBM11203  (Apr 23 18:45 to 19:00)
-> '# Samples Active' shows the number of ASH samples in which the session
      was found waiting for that particular event. The percentage shown
      in this column is calculated with respect to wall clock time
      and not total database activity.
-> 'XIDs' shows the number of distinct transaction IDs sampled in ASH
      when the session was waiting for that particular event
-> For sessions running Parallel Queries, this section will NOT aggregate
      the PQ slave activity into the session issuing the PQ. Refer to
      the 'Top Sessions running PQs' section for such statistics.

   Sid, Serial# % Activity Event                             % Event
--------------- ---------- ------------------------------ ----------
User                 Program                          # Samples Active     XIDs
-------------------- ------------------------------ ------------------ --------
      160,   47       4.35 db file sequential read              2.99
SOE                  JDBC Thin Client                   193/900 [ 21%]       79

                           CPU + Wait for CPU                   1.22
                                                         79/900 [  9%]        8

       39,   73       4.22 db file sequential read              3.13
SOE                  JDBC Thin Client                   202/900 [ 22%]       86

                           CPU + Wait for CPU                   1.01
                                                         65/900 [  7%]        4

      130,   13       4.17 db file sequential read              3.10
SOE                  JDBC Thin Client                   200/900 [ 22%]       95

      226,   39       4.14 db file sequential read              3.01
SOE                  JDBC Thin Client                   194/900 [ 22%]       90

                           CPU + Wait for CPU                   1.02
                                                         66/900 [  7%]        3

      162,    3       4.04 db file sequential read              2.85
SOE                  JDBC Thin Client                   184/900 [ 20%]       88

                           CPU + Wait for CPU                   1.10
                                                         71/900 [  8%]        6

          -------------------------------------------------------------

Top Blocking Sessions      DB/Inst: DBM11203/DBM11203  (Apr 23 18:45 to 19:00)
-> Blocking session activity percentages are calculated with respect to
      waits on enqueues, latches and "buffer busy" only
-> '% Activity' represents the load on the database caused by
      a particular blocking session
-> '# Samples Active' shows the number of ASH samples in which the
      blocking session was found active.
-> 'XIDs' shows the number of distinct transaction IDs sampled in ASH
      when the blocking session was found active.

 Blocking Sid (Inst) % Activity Event Caused                      % Event
-------------------- ---------- ------------------------------ ----------
User                 Program                          # Samples Active     XIDs
-------------------- ------------------------------ ------------------ --------
    95,    1(     1)       1.77 log file sync                        1.77
SYS                  oracle@helicon (LGWR)              147/900 [ 16%]        0

          -------------------------------------------------------------

Top Sessions running PQs  DB/Inst: DBM11203/DBM11203  (Apr 23 18:45 to 19:00)

                  No data exists for this section of the report.
          -------------------------------------------------------------

Top DB Objects             DB/Inst: DBM11203/DBM11203  (Apr 23 18:45 to 19:00)
-> With respect to Application, Cluster, User I/O and buffer busy waits only.

      Object ID % Activity Event                             % Event
--------------- ---------- ------------------------------ ----------
Object Name (Type)                                    Tablespace
----------------------------------------------------- -------------------------
          43487      15.54 db file sequential read             15.48
SOE.CUSTOMERS (TABLE)                                 SOE

          43498      14.86 db file sequential read             14.81
SOE.CUSTOMERS_PK (INDEX)                              SOE

          44495       8.34 db file sequential read              8.34
SOE.ORD_CUSTOMER_IX (INDEX)                           SOE

          43491       6.31 db file sequential read              6.31
SOE.INVENTORIES (TABLE)                               SOE

          44499       5.83 db file sequential read              5.73
SOE.ITEM_ORDER_IX (INDEX)                             SOE

          -------------------------------------------------------------

Top DB Files               DB/Inst: DBM11203/DBM11203  (Apr 23 18:45 to 19:00)
-> With respect to Cluster and User I/O events only.

        File ID % Activity Event                             % Event
--------------- ---------- ------------------------------ ----------
File Name                                             Tablespace
----------------------------------------------------- -------------------------
              5      69.43 db file sequential read             69.16
+DATA/dbm11203/datafile/soe.486.836957131             SOE

          -------------------------------------------------------------

Top Latches                DB/Inst: DBM11203/DBM11203  (Apr 23 18:45 to 19:00)

                  No data exists for this section of the report.
          -------------------------------------------------------------

Activity Over Time        DB/Inst: DBM11203/DBM11203  (Apr 23 18:45 to 19:00)
-> Analysis period is divided into smaller time slots
-> Top 3 events are reported in each of those slots
-> 'Slot Count' shows the number of ASH samples in that slot
-> 'Event Count' shows the number of ASH samples waiting for
   that event in that slot
-> '% Event' is 'Event Count' over all ASH samples in the analysis period

                         Slot                                   Event
Slot Time (Duration)    Count Event                             Count % Event
-------------------- -------- ------------------------------ -------- -------
18:45:00   (1.0 min)      526 db file sequential read             392    6.07
                              CPU + Wait for CPU                  108    1.67
                              log file sync                        15    0.23
18:46:00   (2.0 min)    1,111 db file sequential read             815   12.63
                              CPU + Wait for CPU                  251    3.89
                              log file sync                        27    0.42
18:48:00   (2.0 min)      874 db file sequential read             632    9.79
                              CPU + Wait for CPU                  205    3.18
                              log file sync                        20    0.31
18:50:00   (2.0 min)      933 db file sequential read             668   10.35
                              CPU + Wait for CPU                  229    3.55
                              log file sync                        16    0.25
18:52:00   (2.0 min)      796 db file sequential read             542    8.40
                              CPU + Wait for CPU                  241    3.73
                              log file sync                         6    0.09
18:54:00   (2.0 min)      742 db file sequential read             483    7.48
                              CPU + Wait for CPU                  244    3.78
                              log file sync                         7    0.11
18:56:00   (2.0 min)      735 db file sequential read             465    7.21
                              CPU + Wait for CPU                  257    3.98
                              log file sync                         9    0.14
18:58:00   (2.0 min)      736 db file sequential read             475    7.36
                              CPU + Wait for CPU                  238    3.69
                              log file sync                        14    0.22
          -------------------------------------------------------------

End of Report
