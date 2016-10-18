
ASH Report For DBM12101/DBM12101

DB Name         DB Id    Instance     Inst Num Release     RAC Host
------------ ----------- ------------ -------- ----------- --- ------------
DBM12101       153818222 DBM12101            1 12.1.0.1.0  NO  helicon

CPUs           SGA Size       Buffer Cache        Shared Pool    ASH Buffer Size
---- ------------------ ------------------ ------------------ ------------------
   4        510M (100%)         48M (9.4%)       220M (43.2%)        7.3M (1.4%)


          Analysis Begin Time:   12-Feb-14 22:12:30
            Analysis End Time:   12-Feb-14 22:17:30
                 Elapsed Time:         5.0 (mins)
            Begin Data Source:   V$ACTIVE_SESSION_HISTORY
              End Data Source:   V$ACTIVE_SESSION_HISTORY
                 Sample Count:       4,583
      Average Active Sessions:       15.28
  Avg. Active Session per CPU:        3.82
                Report Target:   None specified

Top User Events            DB/Inst: DBM12101/DBM12101  (Feb 12 22:12 to 22:17)

                                                               Avg Active
Event                               Event Class        % Event   Sessions
----------------------------------- --------------- ---------- ----------
db file sequential read             User I/O             65.94      10.07
log file sync                       Commit               14.42       2.20
CPU + Wait for CPU                  CPU                   5.59       0.85
write complete waits                Configuration         1.07       0.16
          -------------------------------------------------------------

Top Background Events      DB/Inst: DBM12101/DBM12101  (Feb 12 22:12 to 22:17)

                                                               Avg Active
Event                               Event Class     % Activity   Sessions
----------------------------------- --------------- ---------- ----------
log file parallel write             System I/O            5.80       0.89
LGWR any worker group               Other                 1.75       0.27
target log write size               Other                 1.53       0.23
db file parallel write              System I/O            1.48       0.23
          -------------------------------------------------------------

Top Event P1/P2/P3 Values  DB/Inst: DBM12101/DBM12101  (Feb 12 22:12 to 22:17)

Event                          % Event  P1 Value, P2 Value, P3 Value % Activity
------------------------------ ------- ----------------------------- ----------
Parameter 1                Parameter 2                Parameter 3
-------------------------- -------------------------- --------------------------
db file sequential read          66.46               "4","58964","1"       0.07
file#                      block#                     blocks

log file sync                    14.42            "24","3559128","0"       0.02
buffer#                    sync scn                   NOT DEFINED

log file parallel write           5.80                   "1","2","1"       0.87
files                      blocks                     requests

db file parallel write            1.48          "1","0","2147483647"       0.89
requests                   interrupt                  timeout

write complete waits              1.07                "3","4820","0"       0.04
file#                      block#                     NOT DEFINED

          -------------------------------------------------------------

Top Service/Module         DB/Inst: DBM12101/DBM12101  (Feb 12 22:12 to 22:17)

Service        Module                   % Activity Action               % Action
-------------- ------------------------ ---------- ------------------ ----------
DBM12101.antog New Order                     46.41 getProductDetailsB      22.02
                                                   UNNAMED                 17.22
                                                   getProductQuantity       4.32
               UNNAMED                       14.71 UNNAMED                 14.71
               Browse Products               12.13 getProductDetails        8.29
                                                   getCustomerDetails       2.92
SYS$BACKGROUND UNNAMED                       11.87 UNNAMED                 11.87
DBM12101.antog Process Orders                 7.51 UNNAMED                  7.51
          -------------------------------------------------------------

Top Client IDs             DB/Inst: DBM12101/DBM12101  (Feb 12 22:12 to 22:17)

                                                              Avg Active
Client ID                                          % Activity   Sessions
-------------------------------------------------- ---------- ----------
User            Program                           Service
--------------- --------------------------------- --------------------
Swingbench                                              86.17      13.16
SOE             JDBC Thin Client                  DBM12101.antognini.c

          -------------------------------------------------------------

Top SQL Command Types      DB/Inst: DBM12101/DBM12101  (Feb 12 22:12 to 22:17)
-> 'Distinct SQLIDs' is the count of the distinct number of SQLIDs
      with the given SQL Command Type found over all the ASH samples
      in the analysis period

                                           Distinct            Avg Active
SQL Command Type                             SQLIDs % Activity   Sessions
---------------------------------------- ---------- ---------- ----------
SELECT                                           49      50.32       7.69
INSERT                                            5      18.44       2.82
UPDATE                                            4       2.75       0.42
PL/SQL EXECUTE                                   10       1.96       0.30
          -------------------------------------------------------------

Top Phases of Execution    DB/Inst: DBM12101/DBM12101  (Feb 12 22:12 to 22:17)

                                          Avg Active
Phase of Execution             % Activity   Sessions
------------------------------ ---------- ----------
SQL Execution                       72.31      11.05
PLSQL Execution                      1.46       0.22
          -------------------------------------------------------------

Top SQL with Top Events   DB/Inst: DBM12101/DBM12101  (Feb 12 22:12 to 22:17)

                                                        Sampled #
                 SQL ID             Planhash        of Executions     % Activity
----------------------- -------------------- -------------------- --------------
Event                          % Event Top Row Source                    % RwSrc
------------------------------ ------- --------------------------------- -------
          c13sma6rkr27c            569677903                 1005          21.99
db file sequential read          21.32 TABLE ACCESS - BY INDEX ROWID       15.64
SELECT PRODUCTS.PRODUCT_ID, PRODUCT_NAME, PRODUCT_DESCRIPTION, CATEGORY_ID, WEIG
HT_CLASS, WARRANTY_PERIOD, SUPPLIER_ID, PRODUCT_STATUS, LIST_PRICE, MIN_PRICE, C
ATALOG_URL, QUANTITY_ON_HAND FROM PRODUCTS, INVENTORIES WHERE PRODUCTS.CATEGORY_
ID = :B3 AND INVENTORIES.PRODUCT_ID = PRODUCTS.PRODUCT_ID AND INVENTORIES.WAREHO

          0yas01u2p9ch4                  N/A                  382           8.34
db file sequential read           7.92 ** Row Source Not Available **       7.92
INSERT INTO ORDER_ITEMS(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY
) VALUES (:B4 , :B3 , :B2 , :B1 , 1)

          0y1prvxqc2ra9           1702173200                  373           8.20
db file sequential read           7.70 INDEX - RANGE SCAN                   4.56
SELECT PRODUCTS.PRODUCT_ID, PRODUCT_NAME, PRODUCT_DESCRIPTION, CATEGORY_ID, WEIG
HT_CLASS, WARRANTY_PERIOD, SUPPLIER_ID, PRODUCT_STATUS, LIST_PRICE, MIN_PRICE, C
ATALOG_URL, QUANTITY_ON_HAND FROM PRODUCTS, INVENTORIES WHERE PRODUCTS.PRODUCT_I
D = :B2 AND INVENTORIES.PRODUCT_ID = PRODUCTS.PRODUCT_ID AND ROWNUM < :B1

          7hk2m2702ua0g           1796444556                  320           7.00
db file sequential read           6.83 TABLE ACCESS - BY INDEX ROWID BAT    3.75
WITH NEED_TO_PROCESS AS (SELECT ORDER_ID, CUSTOMER_ID FROM ORDERS WHERE ORDER_ST
ATUS <= 4 AND WAREHOUSE_ID = :B1 AND ROWNUM < 10 ) SELECT O.ORDER_ID, OI.LINE_IT
EM_ID, OI.PRODUCT_ID, OI.UNIT_PRICE, OI.QUANTITY, O.ORDER_MODE, O.ORDER_STATUS,
O.ORDER_TOTAL, O.SALES_REP_ID, O.PROMOTION_ID, C.CUSTOMER_ID, C.CUST_FIRST_NAME,

          bymb3ujkr3ubk            494735477                  277           6.04
db file sequential read           5.63 LOAD TABLE CONVENTIONAL              5.63
INSERT INTO ORDERS(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) VALUES (ORDE
RS_SEQ.NEXTVAL + :B3 , SYSTIMESTAMP , :B2 , :B1 ) RETURNING ORDER_ID INTO :O0

          -------------------------------------------------------------

Top SQL with Top Row SourcesDB/Inst: DBM12101/DBM12101  (Feb 12 22:12 to 22:17

                                                        Sampled #
                 SQL ID             PlanHash        of Executions     % Activity
----------------------- -------------------- -------------------- --------------
Row Source                               % RwSrc Top Event               % Event
---------------------------------------- ------- ----------------------- -------
          c13sma6rkr27c            569677903                 1005          21.99
TABLE ACCESS - BY INDEX ROWID              15.91 db file sequential read   15.64
SELECT PRODUCTS.PRODUCT_ID, PRODUCT_NAME, PRODUCT_DESCRIPTION, CATEGORY_ID, WEIG
HT_CLASS, WARRANTY_PERIOD, SUPPLIER_ID, PRODUCT_STATUS, LIST_PRICE, MIN_PRICE, C
ATALOG_URL, QUANTITY_ON_HAND FROM PRODUCTS, INVENTORIES WHERE PRODUCTS.CATEGORY_
ID = :B3 AND INVENTORIES.PRODUCT_ID = PRODUCTS.PRODUCT_ID AND INVENTORIES.WAREHO


INDEX - UNIQUE SCAN                         5.76 db file sequential read    5.67

          0yas01u2p9ch4                  N/A                  382           8.34
** Row Source Not Available **              8.34 db file sequential read    7.92
INSERT INTO ORDER_ITEMS(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY
) VALUES (:B4 , :B3 , :B2 , :B1 , 1)

          0y1prvxqc2ra9           1702173200                  373           8.20
INDEX - RANGE SCAN                          4.63 db file sequential read    4.56
SELECT PRODUCTS.PRODUCT_ID, PRODUCT_NAME, PRODUCT_DESCRIPTION, CATEGORY_ID, WEIG
HT_CLASS, WARRANTY_PERIOD, SUPPLIER_ID, PRODUCT_STATUS, LIST_PRICE, MIN_PRICE, C
ATALOG_URL, QUANTITY_ON_HAND FROM PRODUCTS, INVENTORIES WHERE PRODUCTS.PRODUCT_I
D = :B2 AND INVENTORIES.PRODUCT_ID = PRODUCTS.PRODUCT_ID AND ROWNUM < :B1


TABLE ACCESS - BY INDEX ROWID BATCHED       3.23 db file sequential read    3.14

          7hk2m2702ua0g           1796444556                  320           7.00
TABLE ACCESS - BY INDEX ROWID BATCHED       3.82 db file sequential read    3.75
WITH NEED_TO_PROCESS AS (SELECT ORDER_ID, CUSTOMER_ID FROM ORDERS WHERE ORDER_ST
ATUS <= 4 AND WAREHOUSE_ID = :B1 AND ROWNUM < 10 ) SELECT O.ORDER_ID, OI.LINE_IT
EM_ID, OI.PRODUCT_ID, OI.UNIT_PRICE, OI.QUANTITY, O.ORDER_MODE, O.ORDER_STATUS,
O.ORDER_TOTAL, O.SALES_REP_ID, O.PROMOTION_ID, C.CUSTOMER_ID, C.CUST_FIRST_NAME,


INDEX - RANGE SCAN                          1.22 db file sequential read    1.20

          bymb3ujkr3ubk            494735477                  277           6.04
LOAD TABLE CONVENTIONAL                     6.00 db file sequential read    5.63
INSERT INTO ORDERS(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID) VALUES (ORDE
RS_SEQ.NEXTVAL + :B3 , SYSTIMESTAMP , :B2 , :B1 ) RETURNING ORDER_ID INTO :O0

          -------------------------------------------------------------

Top SQL using literals     DB/Inst: DBM12101/DBM12101  (Feb 12 22:12 to 22:17)

                  No data exists for this section of the report.
          -------------------------------------------------------------

Top Parsing Module/Action  DB/Inst: DBM12101/DBM12101  (Feb 12 22:12 to 22:17)

                  No data exists for this section of the report.
          -------------------------------------------------------------

Top PL/SQL Procedures      DB/Inst: DBM12101/DBM12101  (Feb 12 22:12 to 22:17)
-> 'PL/SQL entry subprogram' represents the application's top-level
      entry-point(procedure, function, trigger, package initialization
      or RPC call) into PL/SQL.
-> 'PL/SQL current subprogram' is the pl/sql subprogram being executed
      at the point of sampling . If the value is 'SQL', it represents
      the percentage of time spent executing SQL for the particular
      plsql entry subprogram

PLSQL Entry Subprogram                                            % Activity
----------------------------------------------------------------- ----------
PLSQL Current Subprogram                                           % Current
----------------------------------------------------------------- ----------
SOE.ORDERENTRY.NEWORDER                                                46.41
   SQL                                                                 45.65
SOE.ORDERENTRY.BROWSEPRODUCTS                                          12.13
   SQL                                                                 11.59
SOE.ORDERENTRY.PROCESSORDERS#2                                          7.51
   SQL                                                                  7.46
SOE.ORDERENTRY.NEWCUSTOMER                                              3.25
   SQL                                                                  3.23
SOE.ORDERENTRY.BROWSEANDUPDATEORDERS                                    2.12
   SQL                                                                  2.09
          -------------------------------------------------------------

Top Java Workload          DB/Inst: DBM12101/DBM12101  (Feb 12 22:12 to 22:17)

                  No data exists for this section of the report.
          -------------------------------------------------------------

Top Call Types             DB/Inst: DBM12101/DBM12101  (Feb 12 22:12 to 22:17)

Call Type                                     Count % Activity Avg Active
---------------------------------------- ---------- ---------- ----------
V8 Bundled Exec                               4,000      87.28      13.33
          -------------------------------------------------------------

Top Sessions              DB/Inst: DBM12101/DBM12101  (Feb 12 22:12 to 22:17)
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
      240,    1       4.19 log file parallel write              4.17
SYS                  oracle@helicon (LG00)              191/300 [ 64%]        0

        3,    1       3.34 LGWR any worker group                1.75
SYS                  oracle@helicon (LGWR)               80/300 [ 27%]        0

                           target log write size                1.53
                                                         70/300 [ 23%]        0

        4,    1       2.18 log file parallel write              1.64
SYS                  oracle@helicon (LG01)               75/300 [ 25%]        0

      164, 4419       2.07 db file sequential read              1.59
SOE                  JDBC Thin Client                    73/300 [ 24%]       20

       23,18491       2.03 db file sequential read              1.70
SOE                  JDBC Thin Client                    78/300 [ 26%]       31

          -------------------------------------------------------------

Top Blocking Sessions      DB/Inst: DBM12101/DBM12101  (Feb 12 22:12 to 22:17)
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
     3,    1(     1)      14.42 log file sync                       14.42
SYS                  oracle@helicon (LGWR)              153/300 [ 51%]        0

   240,    1(     1)       2.29 LGWR any worker group                1.75
SYS                  oracle@helicon (LG00)              192/300 [ 64%]        0

   358,    1(     1)       1.07 write complete waits                 1.07
SYS                  oracle@helicon (DBW0)               78/300 [ 26%]        0

          -------------------------------------------------------------

Top Sessions running PQs  DB/Inst: DBM12101/DBM12101  (Feb 12 22:12 to 22:17)

                  No data exists for this section of the report.
          -------------------------------------------------------------

Top DB Objects             DB/Inst: DBM12101/DBM12101  (Feb 12 22:12 to 22:17)
-> With respect to Application, Cluster, User I/O and buffer busy waits only.

      Object ID % Activity Event                             % Event
--------------- ---------- ------------------------------ ----------
Object Name (Type)                                    Tablespace
----------------------------------------------------- -------------------------
          20124      22.39 db file sequential read             22.39
SOE.INVENTORIES (TABLE)                               USERS

          20146       6.22 db file sequential read              6.20
SOE.INVENTORY_PK (INDEX)                              USERS

          20162       5.50 db file sequential read              5.48
SOE.ITEM_PRODUCT_IX (INDEX)                           USERS

          20166       4.95 db file sequential read              4.95
SOE.ORD_WAREHOUSE_IX (INDEX)                          USERS

          20159       4.58 db file sequential read              4.56
SOE.INV_PRODUCT_IX (INDEX)                            USERS

          -------------------------------------------------------------

Top DB Files               DB/Inst: DBM12101/DBM12101  (Feb 12 22:12 to 22:17)
-> With respect to Cluster and User I/O events only.

        File ID % Activity Event                             % Event
--------------- ---------- ------------------------------ ----------
File Name                                             Tablespace
----------------------------------------------------- -------------------------
              4      65.66 db file sequential read             65.57
+DATA/DBM12101/DATAFILE/users.277.836928737           USERS

          -------------------------------------------------------------

Top Latches                DB/Inst: DBM12101/DBM12101  (Feb 12 22:12 to 22:17)

                  No data exists for this section of the report.
          -------------------------------------------------------------

Activity Over Time        DB/Inst: DBM12101/DBM12101  (Feb 12 22:12 to 22:17)
-> Analysis period is divided into smaller time slots
-> Top 3 events are reported in each of those slots
-> 'Slot Count' shows the number of ASH samples in that slot
-> 'Event Count' shows the number of ASH samples waiting for
   that event in that slot
-> '% Event' is 'Event Count' over all ASH samples in the analysis period

                         Slot                                   Event
Slot Time (Duration)    Count Event                             Count % Event
-------------------- -------- ------------------------------ -------- -------
22:12:30   (30 secs)      192 db file sequential read              85    1.85
                              log file sync                        77    1.68
                              CPU + Wait for CPU                   10    0.22
22:13:00   (1.0 min)    1,178 db file sequential read             833   18.18
                              log file sync                       134    2.92
                              CPU + Wait for CPU                   71    1.55
22:14:00   (1.0 min)      991 db file sequential read             763   16.65
                              CPU + Wait for CPU                   57    1.24
                              log file sync                        52    1.13
22:15:00   (1.0 min)      888 db file sequential read             624   13.62
                              CPU + Wait for CPU                   76    1.66
                              log file sync                        73    1.59
22:16:00   (1.0 min)      849 db file sequential read             498   10.87
                              log file sync                       185    4.04
                              log file parallel write              55    1.20
22:17:00   (30 secs)      485 db file sequential read             243    5.30
                              log file sync                       140    3.05
                              log file parallel write              36    0.79
          -------------------------------------------------------------

End of Report
