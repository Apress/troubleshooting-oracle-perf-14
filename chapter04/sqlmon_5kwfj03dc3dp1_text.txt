SQL Monitoring Report

SQL Text
------------------------------
SELECT /*+ monitor */ p.category_id, sum(i.quantity) AS quantity_sold, sum(i.unit_price * i.quantity) AS amount_sold FROM orders o, order_items i, products p WHERE o.order_id = i.order_id AND i.product_id = p.product_id AND o.order_status BETWEEN 5 and 9 GROUP BY p.category_id ORDER BY p.category_id

Global Information
------------------------------
 Status              :  DONE (ALL ROWS)
 Instance ID         :  1
 Session             :  SOE (167:13851)
 SQL ID              :  5kwfj03dc3dp1
 SQL Execution ID    :  16777216
 Execution Started   :  02/14/2014 10:59:17
 First Refresh Time  :  02/14/2014 10:59:17
 Last Refresh Time   :  02/14/2014 10:59:53
 Duration            :  36s
 Module/Action       :  SQL*Plus/-
 Service             :  DBM11203.antognini.ch
 Program             :  sqlplus.exe
 Fetch Calls         :  101

Global Stats
===========================================================================================
| Elapsed |   Cpu   |    IO    |  Other   | Fetch | Buffer | Read | Read  | Write | Write |
| Time(s) | Time(s) | Waits(s) | Waits(s) | Calls |  Gets  | Reqs | Bytes | Reqs  | Bytes |
===========================================================================================
|      35 |      23 |       12 |     0.02 |   101 |   206K | 7000 |   2GB |  3767 | 912MB |
===========================================================================================

SQL Plan Monitoring Details (Plan Hash Value=463527652)
========================================================================================================================================================================================================
| Id |         Operation         |        Name         |  Rows   | Cost  |   Time    | Start  | Execs |   Rows   | Read | Read  | Write | Write |  Mem  | Temp  | Activity |      Activity Detail      |
|    |                           |                     | (Estim) |       | Active(s) | Active |       | (Actual) | Reqs | Bytes | Reqs  | Bytes | (Max) | (Max) |   (%)    |        (# samples)        |
========================================================================================================================================================================================================
|  0 | SELECT STATEMENT          |                     |         |       |         2 |    +35 |     1 |      199 |      |       |       |       |       |       |          |                           |
|  1 |   SORT GROUP BY           |                     |     199 |  109K |         2 |    +35 |     1 |      199 |      |       |       |       | 20480 |       |          |                           |
|  2 |    NESTED LOOPS OUTER     |                     |    1000 |  109K |         1 |    +35 |     1 |     1000 |      |       |       |       |       |       |          |                           |
|  3 |     HASH JOIN             |                     |    1000 |  109K |        34 |     +2 |     1 |     1000 |      |       |       |       |    1M |       |          |                           |
|  4 |      TABLE ACCESS FULL    | PRODUCT_INFORMATION |    1000 |     9 |         1 |     +2 |     1 |     1000 |      |       |       |       |       |       |          |                           |
|  5 |      VIEW                 | VW_GBC_9            |    1000 |  109K |         1 |    +35 |     1 |     1000 |      |       |       |       |       |       |          |                           |
|  6 |       HASH GROUP BY       |                     |    1000 |  109K |        16 |    +20 |     1 |     1000 |      |       |       |       |    3M |       |    20.00 | Cpu (7)                   |
|  7 |        HASH JOIN          |                     |     18M |  108K |        34 |     +2 |     1 |      18M | 3767 | 912MB |  3767 | 912MB |   15M |  988M |    45.71 | Cpu (15)                  |
|    |                           |                     |         |       |           |        |       |          |      |       |       |       |       |       |          | direct path read temp (1) |
|  8 |         TABLE ACCESS FULL | ORDERS              |      6M | 23642 |         8 |     +1 |     1 |       6M | 1357 | 672MB |       |       |       |       |    14.29 | Cpu (3)                   |
|    |                           |                     |         |       |           |        |       |          |      |       |       |       |       |       |          | direct path read (2)      |
|  9 |         TABLE ACCESS FULL | ORDER_ITEMS         |     32M | 34238 |        14 |     +7 |     1 |      32M | 1876 | 929MB |       |       |       |       |    20.00 | Cpu (1)                   |
|    |                           |                     |         |       |           |        |       |          |      |       |       |       |       |       |          | direct path read (6)      |
| 10 |     INDEX UNIQUE SCAN     | PRD_DESC_PK         |       1 |       |           |        |  1000 |          |      |       |       |       |       |       |          |                           |
========================================================================================================================================================================================================

