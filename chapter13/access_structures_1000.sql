SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: access_structures_1000.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script compares the performance of different access
REM               structures in order to read thousands of rows.
REM Notes.......: The script requires the sample schema SH of version 11g. 
REM               This is because the data has changed between 9i, 10g and 11g.
REM               Even if the schema SH is needed, be careful, do not run it
REM               with the user SH!
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

COLUMN prod_category FORMAT A14
COLUMN selectivity FORMAT 9.999

@../connect.sql

SET ECHO ON

REM
REM Index and non-partitioned table
REM

DROP INDEX sales_prod_category_i;
DROP TABLE sales;

execute dbms_random.seed(0)

CREATE TABLE sales 
AS
SELECT prod_id, cust_id, time_id, channel_id, promo_id, quantity_sold, amount_sold,
       decode(prod_category, 'Peripherals and Accessories', 'Peripherals', prod_category) AS prod_category
FROM sh.sales JOIN sh.products USING (prod_id)
--ORDER BY prod_category
ORDER BY round(dbms_random.normal,1);

execute dbms_stats.gather_table_stats(user,'sales')

CREATE INDEX sales_prod_category_i ON sales (prod_category);

SELECT prod_category, count(*), ratio_to_report(count(*)) over() AS selectivity
FROM sales
GROUP BY prod_category 
ORDER BY count(*);

PAUSE

SET AUTOTRACE TRACE STAT

SELECT /*+ full(sales) */ sum(amount_sold) FROM sales WHERE prod_category = 'Hardware';
SELECT /*+ full(sales) */ sum(amount_sold) FROM sales WHERE prod_category = 'Photo';
SELECT /*+ full(sales) */ sum(amount_sold) FROM sales WHERE prod_category = 'Electronics';
SELECT /*+ full(sales) */ sum(amount_sold) FROM sales WHERE prod_category = 'Peripherals';
SELECT /*+ full(sales) */ sum(amount_sold) FROM sales WHERE prod_category = 'Software/Other';
SELECT /*+ full(sales) */ sum(amount_sold) FROM sales;

SELECT /*+ index(sales) */ sum(amount_sold) FROM sales WHERE prod_category = 'Hardware';
SELECT /*+ index(sales) */ sum(amount_sold) FROM sales WHERE prod_category = 'Photo';
SELECT /*+ index(sales) */ sum(amount_sold) FROM sales WHERE prod_category = 'Electronics';
SELECT /*+ index(sales) */ sum(amount_sold) FROM sales WHERE prod_category = 'Peripherals';
SELECT /*+ index(sales) */ sum(amount_sold) FROM sales WHERE prod_category = 'Software/Other';
SELECT /*+ index(sales) */ sum(amount_sold) FROM sales;

SET AUTOTRACE OFF

PAUSE

REM
REM List partitioned table
REM

DROP TABLE sales;

execute dbms_random.seed(0)

CREATE TABLE sales
PARTITION BY LIST (prod_category)
(
  PARTITION sales_hardware    VALUES ('Hardware'),
  PARTITION sales_photo       VALUES ('Photo'),
  PARTITION sales_electronics VALUES ('Electronics'),
  PARTITION sales_peripherals VALUES ('Peripherals'),
  PARTITION sales_software    VALUES ('Software/Other')
)
AS
SELECT prod_id, cust_id, time_id, channel_id, promo_id, quantity_sold, amount_sold,
       decode(prod_category, 'Peripherals and Accessories', 'Peripherals', prod_category) AS prod_category
FROM sh.sales JOIN sh.products USING (prod_id)
ORDER BY round(dbms_random.normal,1);

execute dbms_stats.gather_table_stats(user,'sales')

PAUSE

SET AUTOTRACE TRACE STAT

SELECT sum(amount_sold) FROM sales WHERE prod_category = 'Hardware';
SELECT sum(amount_sold) FROM sales WHERE prod_category = 'Photo';
SELECT sum(amount_sold) FROM sales WHERE prod_category = 'Electronics';
SELECT sum(amount_sold) FROM sales WHERE prod_category = 'Peripherals';
SELECT sum(amount_sold) FROM sales WHERE prod_category = 'Software/Other';
SELECT sum(amount_sold) FROM sales;

SET AUTOTRACE OFF

PAUSE

REM
REM Single-table hash cluster
REM

DROP TABLE sales;
DROP CLUSTER sales_cluster;

execute dbms_random.seed(0)

CREATE CLUSTER sales_cluster (prod_category VARCHAR2(50)) 
SINGLE TABLE HASHKEYS 5;

CREATE TABLE sales 
CLUSTER sales_cluster (prod_category)
AS
SELECT prod_id, cust_id, time_id, channel_id, promo_id, quantity_sold, amount_sold,
       decode(prod_category, 'Peripherals and Accessories', 'Peripherals', prod_category) AS prod_category
FROM sh.sales JOIN sh.products USING (prod_id)
ORDER BY round(dbms_random.normal,1);

execute dbms_stats.gather_table_stats(user,'sales')

PAUSE

SET AUTOTRACE TRACE STAT TIMING ON

SELECT sum(amount_sold) FROM sales WHERE prod_category = 'Hardware';
SELECT sum(amount_sold) FROM sales WHERE prod_category = 'Photo';
SELECT sum(amount_sold) FROM sales WHERE prod_category = 'Electronics';
SELECT sum(amount_sold) FROM sales WHERE prod_category = 'Peripherals';
SELECT sum(amount_sold) FROM sales WHERE prod_category = 'Software/Other';
SELECT sum(amount_sold) FROM sales;

SET AUTOTRACE OFF TIMING OFF

PAUSE

SELECT count(distinct dbms_rowid.rowid_block_number(rowid)) FROM sales WHERE prod_category = 'Hardware';
SELECT count(distinct dbms_rowid.rowid_block_number(rowid)) FROM sales WHERE prod_category = 'Photo';
SELECT count(distinct dbms_rowid.rowid_block_number(rowid)) FROM sales WHERE prod_category = 'Electronics';
SELECT count(distinct dbms_rowid.rowid_block_number(rowid)) FROM sales WHERE prod_category = 'Peripherals';
SELECT count(distinct dbms_rowid.rowid_block_number(rowid)) FROM sales WHERE prod_category = 'Software/Other';

PAUSE

REM
REM Cleanup
REM

DROP TABLE sales;
PURGE TABLE sales;
DROP CLUSTER sales_cluster;
