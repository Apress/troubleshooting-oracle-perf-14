SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: star_transformation_multi.sql
REM Author......: Christian Antognini
REM Date........: November 2013
REM Description.: This script shows that for multi-column join conditions the
REM               order of the columns in the bitmap index matter.
REM Notes.......: The sample schema SH is required.
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
REM Setup testing environment
REM

DROP TABLE sales PURGE;
DROP TABLE customers PURGE;
DROP TABLE times PURGE;
DROP TABLE products PURGE;

CREATE TABLE sales AS SELECT s.*, 1 AS version FROM sh.sales s;
CREATE TABLE customers AS SELECT c.*, 1 AS cust_version FROM sh.customers c;
CREATE TABLE times AS SELECT t.*, 1 AS time_version FROM sh.times t;
CREATE TABLE products AS SELECT p.*, 1 AS prod_version FROM sh.products p;

ALTER TABLE customers ADD CONSTRAINT customers_pk PRIMARY KEY (cust_version, cust_id);
ALTER TABLE times ADD CONSTRAINT times_pk PRIMARY KEY (time_version, time_id);
ALTER TABLE products ADD CONSTRAINT products_pk PRIMARY KEY (prod_version, prod_id);

ALTER TABLE sales ADD CONSTRAINT sales_cust_fk FOREIGN KEY (version, cust_id) REFERENCES customers (cust_version, cust_id);
ALTER TABLE sales ADD CONSTRAINT sales_time_fk FOREIGN KEY (version, time_id) REFERENCES times (time_version, time_id);
ALTER TABLE sales ADD CONSTRAINT sales_prod_fk FOREIGN KEY (version, prod_id) REFERENCES products (prod_version, prod_id);

CREATE INDEX products_prod_subcat_ix ON products (prod_subcategory);

BEGIN
  dbms_stats.gather_table_stats(user, 'sales');
  dbms_stats.gather_table_stats(user, 'customers');
  dbms_stats.gather_table_stats(user, 'times');
  dbms_stats.gather_table_stats(user, 'products');
END;
/

PAUSE

REM
REM With these bitmap indexes in place the star transformation is used
REM

CREATE BITMAP INDEX sales_cust_bix ON sales (cust_id, version);
CREATE BITMAP INDEX sales_prod_bix ON sales (prod_id, version);
CREATE BITMAP INDEX sales_time_bix ON sales (time_id, version);

PAUSE

REM No temporary tables

ALTER SESSION SET star_transformation_enabled = temp_disable;

EXPLAIN PLAN FOR
SELECT /*+ star_transformation */ c.cust_state_province, t.fiscal_month_name, sum(s.amount_sold) AS amount_sold
FROM sales s, customers c, times t, products p
WHERE s.cust_id = c.cust_id AND s.version = c.cust_version
AND s.time_id = t.time_id AND s.version = t.time_version
AND s.prod_id = p.prod_id AND s.version = p.prod_version
AND c.cust_year_of_birth BETWEEN 1970 AND 1979
AND p.prod_subcategory = 'Cameras'
GROUP BY c.cust_state_province, t.fiscal_month_name
ORDER BY c.cust_state_province, sum(s.amount_sold) DESC;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'typical +outline'));

PAUSE

REM With temporary tables

ALTER SESSION SET star_transformation_enabled = TRUE;

EXPLAIN PLAN FOR
SELECT /*+ star_transformation */ c.cust_state_province, t.fiscal_month_name, sum(s.amount_sold) AS amount_sold
FROM sales s, customers c, times t, products p
WHERE s.cust_id = c.cust_id AND s.version = c.cust_version
AND s.time_id = t.time_id AND s.version = t.time_version
AND s.prod_id = p.prod_id AND s.version = p.prod_version
AND c.cust_year_of_birth BETWEEN 1970 AND 1979
AND p.prod_subcategory = 'Cameras'
GROUP BY c.cust_state_province, t.fiscal_month_name
ORDER BY c.cust_state_province, sum(s.amount_sold) DESC;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'typical +outline'));

PAUSE

DROP INDEX sales_cust_bix;
DROP INDEX sales_prod_bix;
DROP INDEX sales_time_bix;

REM
REM With these bitmap indexes in place the star transformation is NOT used
REM (notice that only the order of the columns changes)
REM

CREATE BITMAP INDEX sales_cust_bix ON sales (version, cust_id);
CREATE BITMAP INDEX sales_prod_bix ON sales (version, prod_id);
CREATE BITMAP INDEX sales_time_bix ON sales (version, time_id);

PAUSE

REM No temporary tables

ALTER SESSION SET star_transformation_enabled = temp_disable;

EXPLAIN PLAN FOR
SELECT /*+ star_transformation */ c.cust_state_province, t.fiscal_month_name, sum(s.amount_sold) AS amount_sold
FROM sales s, customers c, times t, products p
WHERE s.cust_id = c.cust_id AND s.version = c.cust_version
AND s.time_id = t.time_id AND s.version = t.time_version
AND s.prod_id = p.prod_id AND s.version = p.prod_version
AND c.cust_year_of_birth BETWEEN 1970 AND 1979
AND p.prod_subcategory = 'Cameras'
GROUP BY c.cust_state_province, t.fiscal_month_name
ORDER BY c.cust_state_province, sum(s.amount_sold) DESC;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'typical +outline'));

PAUSE

REM With temporary tables

ALTER SESSION SET star_transformation_enabled = TRUE;

EXPLAIN PLAN FOR
SELECT /*+ star_transformation */ c.cust_state_province, t.fiscal_month_name, sum(s.amount_sold) AS amount_sold
FROM sales s, customers c, times t, products p
WHERE s.cust_id = c.cust_id AND s.version = c.cust_version
AND s.time_id = t.time_id AND s.version = t.time_version
AND s.prod_id = p.prod_id AND s.version = p.prod_version
AND c.cust_year_of_birth BETWEEN 1970 AND 1979
AND p.prod_subcategory = 'Cameras'
GROUP BY c.cust_state_province, t.fiscal_month_name
ORDER BY c.cust_state_province, sum(s.amount_sold) DESC;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'typical +outline'));

PAUSE

REM
REM Cleanup
REM

DROP TABLE sales PURGE;
DROP TABLE customers PURGE;
DROP TABLE times PURGE;
DROP TABLE products PURGE;
