SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: mv.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows the basic concepts of materialized views.
REM Notes.......: The sample schema SH is required. Since the script uses
REM               the function display_cursor, it only works as of Oracle
REM               Database 10g.
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

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

DROP MATERIALIZED VIEW sales_mv;

ALTER SESSION SET current_schema = SH;

ALTER SESSION SET statistics_level = all;

PAUSE

REM
REM Run SQL statement without query rewrite
REM

SELECT p.prod_category, c.country_id,
       sum(quantity_sold) AS quantity_sold,
       sum(amount_sold) AS amount_sold
FROM sales s, customers c, products p
WHERE s.cust_id = c.cust_id
AND s.prod_id = p.prod_id
GROUP BY p.prod_category, c.country_id
ORDER BY p.prod_category, c.country_id;

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'runstats_last'));

PAUSE

REM
REM Create a materialized view, notice that query rewrite is disable
REM

CREATE MATERIALIZED VIEW sales_mv
AS
SELECT p.prod_category, c.country_id,
       sum(quantity_sold) AS quantity_sold,
       sum(amount_sold) AS amount_sold
FROM sales s, customers c, products p
WHERE s.cust_id = c.cust_id
AND s.prod_id = p.prod_id
GROUP BY p.prod_category, c.country_id;

SELECT * 
FROM sales_mv
ORDER BY prod_category, country_id;

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'runstats_last'));

PAUSE

REM
REM Enable query rewrite
REM

ALTER MATERIALIZED VIEW sales_mv ENABLE QUERY REWRITE;

SELECT p.prod_category, c.country_id,
       sum(quantity_sold) AS quantity_sold,
       sum(amount_sold) AS amount_sold
FROM sales s, customers c, products p
WHERE s.cust_id = c.cust_id
AND s.prod_id = p.prod_id
GROUP BY p.prod_category, c.country_id
ORDER BY p.prod_category, c.country_id;

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'runstats_last'));

PAUSE

REM
REM Creating a materizalized view by specifying more parameters
REM

DROP MATERIALIZED VIEW sales_mv;

CREATE MATERIALIZED VIEW sales_mv
PARTITION BY HASH (country_id) PARTITIONS 8
TABLESPACE users
BUILD IMMEDIATE
USING NO INDEX
ENABLE QUERY REWRITE
AS
SELECT p.prod_category, c.country_id,
       sum(quantity_sold) AS quantity_sold,
       sum(amount_sold) AS amount_sold
FROM sales s, customers c, products p
WHERE s.cust_id = c.cust_id
AND s.prod_id = p.prod_id
GROUP BY p.prod_category, c.country_id;

PAUSE

REM
REM Cleanup
REM

DROP MATERIALIZED VIEW sales_mv;
