SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: star_transformation.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script provides several examples of star transformation.
REM Notes.......: The sample schema SH is required.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 18.11.2013 Removed dependency on create_tx.sql + Added examples of other
REM            indexes
REM 09.03.2014 Added query that emulates what the star transformation does
REM            (e.g. it can be used with Standard Edition)
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

CREATE TABLE sales AS SELECT * FROM sh.sales;
CREATE TABLE customers AS SELECT * FROM sh.customers;
CREATE TABLE times AS SELECT * FROM sh.times;
CREATE TABLE products AS SELECT * FROM sh.products;

ALTER TABLE customers ADD CONSTRAINT customers_pk PRIMARY KEY (cust_id);
ALTER TABLE times ADD CONSTRAINT times_pk PRIMARY KEY (time_id);
ALTER TABLE products ADD CONSTRAINT products_pk PRIMARY KEY (prod_id);

REM Foreign keys are only required for bitmap-join indexes
ALTER TABLE sales ADD CONSTRAINT sales_cust_fk FOREIGN KEY (cust_id) REFERENCES customers (cust_id);
ALTER TABLE sales ADD CONSTRAINT sales_time_fk FOREIGN KEY (time_id) REFERENCES times (time_id);
ALTER TABLE sales ADD CONSTRAINT sales_prod_fk FOREIGN KEY (prod_id) REFERENCES products (prod_id);

REM Bitmap indexes provide best performance
CREATE BITMAP INDEX sales_cust_bix ON sales (cust_id);
CREATE BITMAP INDEX sales_prod_bix ON sales (prod_id);
CREATE BITMAP INDEX sales_time_bix ON sales (time_id);

REM Bitmap indexes with additional columns are also supported
REM CREATE BITMAP INDEX sales_cust_bix ON sales (cust_id, promo_id);
REM CREATE BITMAP INDEX sales_prod_bix ON sales (prod_id, promo_id);
REM CREATE BITMAP INDEX sales_time_bix ON sales (time_id, promo_id);

REM B-tree indexes can be used instead of bitmap indexes
REM CREATE INDEX sales_cust_bix ON sales (cust_id);
REM CREATE INDEX sales_prod_bix ON sales (prod_id);
REM CREATE INDEX sales_time_bix ON sales (time_id);

REM B-tree indexes with additional columns are NOT supported
REM CREATE INDEX sales_cust_bix ON sales (cust_id, promo_id);
REM CREATE INDEX sales_prod_bix ON sales (prod_id, promo_id);
REM CREATE INDEX sales_time_bix ON sales (time_id, promo_id);

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
REM No star transformation
REM

ALTER SESSION SET star_transformation_enabled = false;

EXPLAIN PLAN FOR
SELECT /*+ leading(s c t) use_hash(c t) swap_join_inputs(c) swap_join_inputs(t) */
       c.cust_state_province, t.fiscal_month_name, sum(s.amount_sold) AS amount_sold
FROM (SELECT /*+ no_merge */ *
      FROM sales
      WHERE rowid IN (SELECT c.rid
                      FROM (SELECT /*+ no_merge leading(c s) use_nl(s) */ s.rowid AS rid
                            FROM customers c, sales s
                            WHERE c.cust_id = s.cust_id
                            AND c.cust_year_of_birth BETWEEN 1970 AND 1979) c,
                           (SELECT /*+ no_merge leading(p s) use_nl(s) */ s.rowid AS rid
                            FROM products p, sales s
                            WHERE p.prod_id = s.prod_id
                            AND p.prod_subcategory = 'Cameras') p
                      WHERE c.rid = p.rid)) s,
     customers c, times t
WHERE s.cust_id = c.cust_id
AND s.time_id = t.time_id
GROUP BY c.cust_state_province, t.fiscal_month_name
ORDER BY c.cust_state_province, sum(s.amount_sold) DESC;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +predicate +note'));

PAUSE

REM
REM No temporary tables
REM

ALTER SESSION SET star_transformation_enabled = temp_disable;

EXPLAIN PLAN FOR
SELECT /*+ star_transformation */ c.cust_state_province, t.fiscal_month_name, sum(s.amount_sold) AS amount_sold
FROM sales s, customers c, times t, products p
WHERE s.cust_id = c.cust_id
AND s.time_id = t.time_id
AND s.prod_id = p.prod_id
AND c.cust_year_of_birth BETWEEN 1970 AND 1979
AND p.prod_subcategory = 'Cameras'
GROUP BY c.cust_state_province, t.fiscal_month_name
ORDER BY c.cust_state_province, sum(s.amount_sold) DESC;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +predicate +note'));

PAUSE

REM
REM With temporary tables
REM

ALTER SESSION SET star_transformation_enabled = TRUE;

EXPLAIN PLAN FOR
SELECT /*+ star_transformation */ c.cust_state_province, t.fiscal_month_name, sum(s.amount_sold) AS amount_sold
FROM sales s, customers c, times t, products p
WHERE s.cust_id = c.cust_id
AND s.time_id = t.time_id
AND s.prod_id = p.prod_id
AND c.cust_year_of_birth BETWEEN 1970 AND 1979
AND p.prod_subcategory = 'Cameras'
GROUP BY c.cust_state_province, t.fiscal_month_name
ORDER BY c.cust_state_province, sum(s.amount_sold) DESC;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +predicate +note'));

PAUSE

REM
REM With bitmap-join indexes
REM

CREATE BITMAP INDEX sales_cust_year_of_birth_bix ON sales (c.cust_year_of_birth)
FROM sales s, customers c
WHERE s.cust_id = c.cust_id;

CREATE BITMAP INDEX sales_prod_subcategory_bix ON sales (p.prod_subcategory)
FROM sales s, products p
WHERE s.prod_id = p.prod_id;

PAUSE

EXPLAIN PLAN FOR
SELECT /*+ star_transformation index(s sales_cust_year_of_birth_bix) index(s sales_prod_subcategory_bix) */ 
       c.cust_state_province, t.fiscal_month_name, sum(s.amount_sold) AS amount_sold
FROM sales s, customers c, times t, products p
WHERE s.cust_id = c.cust_id
AND s.time_id = t.time_id
AND s.prod_id = p.prod_id
AND c.cust_year_of_birth BETWEEN 1970 AND 1979
AND p.prod_subcategory = 'Cameras'
GROUP BY c.cust_state_province, t.fiscal_month_name
ORDER BY c.cust_state_province, sum(s.amount_sold) DESC;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +predicate +note'));

PAUSE

REM
REM Cleanup
REM

DROP TABLE sales PURGE;
DROP TABLE customers PURGE;
DROP TABLE times PURGE;
DROP TABLE products PURGE;
