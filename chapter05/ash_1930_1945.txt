
ASH Report For DBM11203/DBM11203

DB Name         DB Id    Instance     Inst Num Release     RAC Host
------------ ----------- ------------ -------- ----------- --- ------------
DBM11203      2532911053 DBM11203            1 11.2.0.3.0  NO  helicon

CPUs           SGA Size       Buffer Cache        Shared Pool    ASH Buffer Size
---- ------------------ ------------------ ------------------ ------------------
   8      1,019M (100%)       728M (71.4%)       260M (25.5%)       16.0M (1.6%)


          Analysis Begin Time:   23-Apr-14 19:30:00
            Analysis End Time:   23-Apr-14 19:45:00
                 Elapsed Time:        15.0 (mins)
            Begin Data Source:   V$ACTIVE_SESSION_HISTORY
              End Data Source:   V$ACTIVE_SESSION_HISTORY
                 Sample Count:      12,374
      Average Active Sessions:       13.75
  Avg. Active Session per CPU:        1.72
                Report Target:   None specified

Top User Events            DB/Inst: DBM11203/DBM11203  (Apr 23 19:30 to 19:45)

                                                               Avg Active
Event                               Event Class        % Event   Sessions
----------------------------------- --------------- ---------- ----------
db file sequential read             User I/O             73.34      10.08
CPU + Wait for CPU                  CPU                  20.97       2.88
log file sync                       Commit                2.17       0.30
          -------------------------------------------------------------

Top Background Events      DB/Inst: DBM11203/DBM11203  (Apr 23 19:30 to 19:45)

                  No data exists for this section of the report.
          -------------------------------------------------------------

Top Event P1/P2/P3 Values  DB/Inst: DBM11203/DBM11203  (Apr 23 19:30 to 19:45)

Event                          % Event  P1 Value, P2 Value, P3 Value % Activity
------------------------------ ------- ----------------------------- ----------
Parameter 1                Parameter 2                Parameter 3
-------------------------- -------------------------- --------------------------
db file sequential read          73.44              "5","245639","1"       0.02
file#                      block#                     blocks

log file sync                     2.17        "6680","101317920","0"       0.02
buffer#                    sync scn                   NOT DEFINED

          -------------------------------------------------------------

Top Service/Module         DB/Inst: DBM11203/DBM11203  (Apr 23 19:30 to 19:45)

Service        Module                   % Activity Action               % Action
-------------- ------------------------ ---------- ------------------ ----------
DBM11203.antog Swingbench User Thread        98.10 UNNAMED                 98.10
SYS$BACKGROUND UNNAMED                        1.66 UNNAMED                  1.66
          -------------------------------------------------------------

Top Client IDs             DB/Inst: DBM11203/DBM11203  (Apr 23 19:30 to 19:45)

                                                              Avg Active
Client ID                                          % Activity   Sessions
-------------------------------------------------- ---------- ----------
User            Program                           Service
--------------- --------------------------------- --------------------
Swingbench                                              98.10      13.49
SOE             JDBC Thin Client                  DBM11203.antognini.c

          -------------------------------------------------------------

Top SQL Command Types      DB/Inst: DBM11203/DBM11203  (Apr 23 19:30 to 19:45)
-> 'Distinct SQLIDs' is the count of the distinct number of SQLIDs
      with the given SQL Command Type found over all the ASH samples
      in the analysis period

                                           Distinct            Avg Active
SQL Command Type                             SQLIDs % Activity   Sessions
---------------------------------------- ---------- ---------- ----------
SELECT                                           21      56.46       7.76
INSERT                                           10      28.58       3.93
UPDATE                                            5      10.14       1.39
          -------------------------------------------------------------

Top Phases of Execution    DB/Inst: DBM11203/DBM11203  (Apr 23 19:30 to 19:45)

                                          Avg Active
Phase of Execution             % Activity   Sessions
------------------------------ ---------- ----------
SQL Execution                       94.53      13.00
          -------------------------------------------------------------

Top SQL with Top Events   DB/Inst: DBM11203/DBM11203  (Apr 23 19:30 to 19:45)

                                                        Sampled #
                 SQL ID             Planhash        of Executions     % Activity
----------------------- -------------------- -------------------- --------------
Event                          % Event Top Row Source                    % RwSrc
------------------------------ ------- --------------------------------- -------
          82ud5h0qcg0bf           4238351645                 3542          28.71
db file sequential read          28.22 TABLE ACCESS - BY INDEX ROWID       15.86
select customer_id, cust_first_name ,cust_last_name ,nls_language ,nls_territory
 ,credit_limit ,cust_email ,account_mgr_id from customers where customer_id = :
1

          g8rhybcumtwd6            799079936                 2172          17.56
CPU + Wait for CPU               16.63 INDEX - RANGE SCAN                   6.00
SELECT /*+ first_rows index(customers, customers_pk) index(orders, order_status
_ix) */ o.order_id, line_item_id, product_id, unit_price, quantity, order_mode,
 order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_firs
t_name, cust_last_name, credit_limit, cust_email, order_date FROM orders o , ord

          8vvvyuun2urt6                  N/A                 1365          11.11
db file sequential read          10.23 ** Row Source Not Available **      10.23
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY
) values (:1 , :2 , :3 , :4 , :5 )

          9zd49du11u7cf                  N/A                 1268          10.30
db file sequential read           9.86 ** Row Source Not Available **       9.86
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) values (:1 ,
 :2 , :3 , :4 )

          d5j6fbqmu3gjp            724732537                  995           8.07
db file sequential read           7.96 INDEX - RANGE SCAN                   3.68
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_price, quantity,
 order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_i
d, cust_first_name, cust_last_name, credit_limit, cust_email FROM orders o , o
rder_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id =

          -------------------------------------------------------------

Top SQL with Top Row SourcesDB/Inst: DBM11203/DBM11203  (Apr 23 19:30 to 19:45

                                                        Sampled #
                 SQL ID             PlanHash        of Executions     % Activity
----------------------- -------------------- -------------------- --------------
Row Source                               % RwSrc Top Event               % Event
---------------------------------------- ------- ----------------------- -------
          82ud5h0qcg0bf           4238351645                 3542          28.71
TABLE ACCESS - BY INDEX ROWID              15.98 db file sequential read   15.86
select customer_id, cust_first_name ,cust_last_name ,nls_language ,nls_territory
 ,credit_limit ,cust_email ,account_mgr_id from customers where customer_id = :
1


INDEX - UNIQUE SCAN                        12.53 db file sequential read   12.36

          g8rhybcumtwd6            799079936                 2172          17.56
INDEX - RANGE SCAN                          6.14 CPU + Wait for CPU         6.00
SELECT /*+ first_rows index(customers, customers_pk) index(orders, order_status
_ix) */ o.order_id, line_item_id, product_id, unit_price, quantity, order_mode,
 order_status, order_total, sales_rep_id, promotion_id, c.customer_id, cust_firs
t_name, cust_last_name, credit_limit, cust_email, order_date FROM orders o , ord


INDEX - UNIQUE SCAN                         4.90 CPU + Wait for CPU         4.72


TABLE ACCESS - BY INDEX ROWID               2.93 CPU + Wait for CPU         2.70

          8vvvyuun2urt6                  N/A                 1365          11.11
** Row Source Not Available **             11.11 db file sequential read   10.23
insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY
) values (:1 , :2 , :3 , :4 , :5 )

          9zd49du11u7cf                  N/A                 1268          10.30
** Row Source Not Available **             10.30 db file sequential read    9.86
insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) values (:1 ,
 :2 , :3 , :4 )

          d5j6fbqmu3gjp            724732537                  995           8.07
INDEX - RANGE SCAN                          3.70 db file sequential read    3.68
SELECT /*+ use_nl */ o.order_id, line_item_id, product_id, unit_price, quantity,
 order_mode, order_status, order_total, sales_rep_id, promotion_id, c.customer_i
d, cust_first_name, cust_last_name, credit_limit, cust_email FROM orders o , o
rder_items oi, customers c WHERE o.order_id = oi.order_id and o.customer_id =


TABLE ACCESS - BY INDEX ROWID               1.65 db file sequential read    1.64


TABLE ACCESS - BY INDEX ROWID               1.44 db file sequential read    1.41

          -------------------------------------------------------------

Top SQL using literals     DB/Inst: DBM11203/DBM11203  (Apr 23 19:30 to 19:45)

                  No data exists for this section of the report.
          -------------------------------------------------------------

Top Parsing Module/Action  DB/Inst: DBM11203/DBM11203  (Apr 23 19:30 to 19:45)

                  No data exists for this section of the report.
          -------------------------------------------------------------

Top PL/SQL Procedures      DB/Inst: DBM11203/DBM11203  (Apr 23 19:30 to 19:45)

                  No data exists for this section of the report.
          -------------------------------------------------------------

Top Java Workload          DB/Inst: DBM11203/DBM11203  (Apr 23 19:30 to 19:45)

                  No data exists for this section of the report.
          -------------------------------------------------------------

Top Call Types             DB/Inst: DBM11203/DBM11203  (Apr 23 19:30 to 19:45)

Call Type                                     Count % Activity Avg Active
---------------------------------------- ---------- ---------- ----------
V8 Bundled Exec                              11,809      95.43      13.12
COMMIT                                          304       2.46       0.34
          -------------------------------------------------------------

Top Sessions              DB/Inst: DBM11203/DBM11203  (Apr 23 19:30 to 19:45)
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
      131,   53       2.69 db file sequential read              1.98
SOE                  JDBC Thin Client                   245/900 [ 27%]      114

        7,   65       2.68 db file sequential read              2.11
SOE                  JDBC Thin Client                   261/900 [ 29%]      126

        3,    3       2.66 db file sequential read              1.99
SOE                  JDBC Thin Client                   246/900 [ 27%]      133

        6,   59       2.60 db file sequential read              1.92
SOE                  JDBC Thin Client                   238/900 [ 26%]      120

      162,    3       2.60 db file sequential read              1.93
SOE                  JDBC Thin Client                   239/900 [ 27%]      116

          -------------------------------------------------------------

Top Blocking Sessions      DB/Inst: DBM11203/DBM11203  (Apr 23 19:30 to 19:45)
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
    95,    1(     1)       3.48 log file sync                        2.17
SYS                  oracle@helicon (LGWR)              147/900 [ 16%]        0

          -------------------------------------------------------------

Top Sessions running PQs  DB/Inst: DBM11203/DBM11203  (Apr 23 19:30 to 19:45)

                  No data exists for this section of the report.
          -------------------------------------------------------------

Top DB Objects             DB/Inst: DBM11203/DBM11203  (Apr 23 19:30 to 19:45)
-> With respect to Application, Cluster, User I/O and buffer busy waits only.

      Object ID % Activity Event                             % Event
--------------- ---------- ------------------------------ ----------
Object Name (Type)                                    Tablespace
----------------------------------------------------- -------------------------
          43487      16.07 db file sequential read             15.99
SOE.CUSTOMERS (TABLE)                                 SOE

          43498      14.09 db file sequential read             14.02
SOE.CUSTOMERS_PK (INDEX)                              SOE

          44495       8.08 db file sequential read              8.08
SOE.ORD_CUSTOMER_IX (INDEX)                           SOE

          43491       7.35 db file sequential read              7.34
SOE.INVENTORIES (TABLE)                               SOE

          44499       5.88 db file sequential read              5.85
SOE.ITEM_ORDER_IX (INDEX)                             SOE

          -------------------------------------------------------------

Top DB Files               DB/Inst: DBM11203/DBM11203  (Apr 23 19:30 to 19:45)
-> With respect to Cluster and User I/O events only.

        File ID % Activity Event                             % Event
--------------- ---------- ------------------------------ ----------
File Name                                             Tablespace
----------------------------------------------------- -------------------------
              5      73.62 db file sequential read             73.27
+DATA/dbm11203/datafile/soe.486.836957131             SOE

          -------------------------------------------------------------

Top Latches                DB/Inst: DBM11203/DBM11203  (Apr 23 19:30 to 19:45)

                  No data exists for this section of the report.
          -------------------------------------------------------------

Activity Over Time        DB/Inst: DBM11203/DBM11203  (Apr 23 19:30 to 19:45)
-> Analysis period is divided into smaller time slots
-> Top 3 events are reported in each of those slots
-> 'Slot Count' shows the number of ASH samples in that slot
-> 'Event Count' shows the number of ASH samples waiting for
   that event in that slot
-> '% Event' is 'Event Count' over all ASH samples in the analysis period

                         Slot                                   Event
Slot Time (Duration)    Count Event                             Count % Event
-------------------- -------- ------------------------------ -------- -------
19:30:00   (2.0 min)    1,349 db file sequential read             990    8.00
                              CPU + Wait for CPU                  300    2.42
                              log file sync                        20    0.16
19:32:00   (2.0 min)    1,520 db file sequential read           1,133    9.16
                              CPU + Wait for CPU                  336    2.72
                              log file sync                        27    0.22
19:34:00   (2.0 min)    1,711 db file sequential read           1,243   10.05
                              CPU + Wait for CPU                  368    2.97
                              log file sync                        44    0.36
19:36:00   (2.0 min)    1,805 db file sequential read           1,392   11.25
                              CPU + Wait for CPU                  320    2.59
                              log file sync                        35    0.28
19:38:00   (2.0 min)    1,793 db file sequential read           1,291   10.43
                              CPU + Wait for CPU                  357    2.89
                              log file sync                        52    0.42
19:40:00   (2.0 min)    1,686 db file sequential read           1,204    9.73
                              CPU + Wait for CPU                  388    3.14
                              log file sync                        46    0.37
19:42:00   (2.0 min)    1,610 db file sequential read           1,160    9.37
                              CPU + Wait for CPU                  378    3.05
                              log file sync                        28    0.23
19:44:00   (60 secs)      900 db file sequential read             675    5.45
                              CPU + Wait for CPU                  191    1.54
                              log file sync                        16    0.13
          -------------------------------------------------------------

End of Report
