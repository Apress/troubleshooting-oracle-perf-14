SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: access_structures_1.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script compares the performance of different access
REM               structures in order to read a single row.
REM Notes.......: The script requires the sample schema SH. But, be careful, do
REM               not run it with the user SH!
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

VARIABLE rid VARCHAR2(18)

@../connect.sql

SET ECHO ON

REM
REM Regular table with primary key
REM

DROP TABLE sales;

execute dbms_random.seed(0)

CREATE TABLE sales (
  id,
  prod_id,
  cust_id,
  time_id,
  channel_id,
  promo_id,
  quantity_sold,
  amount_sold,
  prod_category,
  CONSTRAINT sales_pk PRIMARY KEY (id)
)
AS
SELECT rownum, prod_id, cust_id, time_id, channel_id, promo_id, quantity_sold, amount_sold, prod_category
FROM sh.sales JOIN sh.products USING (prod_id)
--WHERE rownum <= 10
--WHERE rownum <= 10000
ORDER BY round(dbms_random.normal,1);

execute dbms_stats.gather_table_stats(user,'sales')

PAUSE

BEGIN
  SELECT rowid INTO :rid FROM sales WHERE id = 6;
END;
/

SET AUTOTRACE TRACE STAT

SELECT * FROM sales WHERE id = 6;
SELECT * FROM sales WHERE id = 6;
SELECT * FROM sales WHERE id = 6;
SELECT * FROM sales WHERE rowid = :rid;
SELECT * FROM sales WHERE rowid = :rid;
SELECT * FROM sales WHERE rowid = :rid;

SET AUTOTRACE OFF

PAUSE

REM
REM Index-organized table
REM

DROP TABLE sales;

execute dbms_random.seed(0)

CREATE TABLE sales (
  id,
  prod_id,
  cust_id,
  time_id,
  channel_id,
  promo_id,
  quantity_sold,
  amount_sold,
  prod_category,
  CONSTRAINT sales_pk PRIMARY KEY (id)
)
ORGANIZATION INDEX
AS
SELECT rownum, prod_id, cust_id, time_id, channel_id, promo_id, quantity_sold, amount_sold, prod_category
FROM sh.sales JOIN sh.products USING (prod_id)
--WHERE rownum <= 10
--WHERE rownum <= 10000
ORDER BY round(dbms_random.normal,1);

execute dbms_stats.gather_table_stats(user,'sales')

PAUSE

BEGIN
  SELECT rowid INTO :rid FROM sales WHERE id = 6;
END;
/

SET AUTOTRACE TRACE STAT

SELECT * FROM sales WHERE id = 6;
SELECT * FROM sales WHERE id = 6;
SELECT * FROM sales WHERE id = 6;
SELECT * FROM sales WHERE rowid = :rid;
SELECT * FROM sales WHERE rowid = :rid;
SELECT * FROM sales WHERE rowid = :rid;

SET AUTOTRACE OFF

PAUSE

REM
REM Single-table hash cluster
REM

DROP TABLE sales;
DROP CLUSTER sales_cluster;

execute dbms_random.seed(0)

CREATE CLUSTER sales_cluster (id NUMBER) 
SINGLE TABLE SIZE 60 HASHKEYS 1000000;

execute dbms_random.seed(0)

CREATE TABLE sales (
  id,
  prod_id,
  cust_id,
  time_id,
  channel_id,
  promo_id,
  quantity_sold,
  amount_sold,
  prod_category,
  CONSTRAINT sales_pk PRIMARY KEY (id)
)
CLUSTER sales_cluster (id)
AS
SELECT rownum, prod_id, cust_id, time_id, channel_id, promo_id, quantity_sold, amount_sold, prod_category
FROM sh.sales JOIN sh.products USING (prod_id)
--WHERE rownum <= 10
--WHERE rownum <= 10000
ORDER BY round(dbms_random.normal,1);

execute dbms_stats.gather_table_stats(user,'sales')

PAUSE

BEGIN
  SELECT rowid INTO :rid FROM sales WHERE id = 6;
END;
/

SET AUTOTRACE TRACE STAT

SELECT * FROM sales WHERE id = 6;
SELECT * FROM sales WHERE id = 6;
SELECT * FROM sales WHERE id = 6;
SELECT * FROM sales WHERE rowid = :rid;
SELECT * FROM sales WHERE rowid = :rid;
SELECT * FROM sales WHERE rowid = :rid;

SET AUTOTRACE OFF

PAUSE

REM
REM Cleanup
REM

DROP TABLE sales;
PURGE TABLE sales;
DROP CLUSTER sales_cluster;
