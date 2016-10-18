SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: mv_refresh_log.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows how fast refreshes based on materialized
REM               view logs work.
REM Notes.......: The sample schema SH is required and cannot own tables named
REM               REWRITE_TABLE and MV_CAPABILITIES_TABLE.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 18.12.2013 Changed code for changing current_schema + changed notes
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

COLUMN master FORMAT A30
COLUMN log_table FORMAT A30

COLUMN refresh_mode FORMAT A12
COLUMN refresh_method FORMAT A14
COLUMN last_refresh_type FORMAT A17
COLUMN last_refresh_date FORMAT A19
COLUMN staleness FORMAT A9

COLUMN what FORMAT A40
COLUMN interval FORMAT A35

COLUMN capability_name FORMAT A29
COLUMN possible FORMAT A8
COLUMN related_text FORMAT A12
COLUMN msgtxt FORMAT A31
COLUMN related_text FORMAT A13

@../connect.sql

COLUMN user NEW_VALUE initial_user
SELECT user FROM dual;

SET ECHO ON

REM
REM Setup test environment
REM

CREATE SYNONYM sh.mv_capabilities_table FOR mv_capabilities_table;

DROP TABLE mv_capabilities_table PURGE;

CREATE TABLE mv_capabilities_table (
  statement_id         VARCHAR(30),
  mvowner              VARCHAR(30),
  mvname               VARCHAR(30),
  capability_name      VARCHAR(30),
  possible             CHARACTER(1),
  related_text         VARCHAR(2000),
  related_num          NUMBER,
  msgno                INTEGER,
  msgtxt               VARCHAR(2000),
  seq                  NUMBER
);

GRANT ALL ON mv_capabilities_table TO public;

ALTER SESSION SET nls_date_format = 'DD.MM.YYYY HH24:MI:SS';

ALTER SESSION SET current_schema = SH;

DROP MATERIALIZED VIEW sales_mv;

DROP MATERIALIZED VIEW LOG ON sales;
DROP MATERIALIZED VIEW LOG ON customers;
DROP MATERIALIZED VIEW LOG ON products;

PAUSE

REM
REM Create a materialized view with refresh on demand (with and without job)
REM

CREATE MATERIALIZED VIEW sales_mv
AS
SELECT p.prod_category, c.country_id,
       sum(s.quantity_sold) AS quantity_sold,
       sum(s.amount_sold) AS amount_sold
FROM sales s, customers c, products p
WHERE s.cust_id = c.cust_id
AND s.prod_id = p.prod_id
GROUP BY p.prod_category, c.country_id;

ALTER MATERIALIZED VIEW sales_mv REFRESH FORCE ON DEMAND;

SELECT refresh_method, refresh_mode, staleness, 
       last_refresh_type, last_refresh_date
FROM dba_mviews
WHERE mview_name = 'SALES_MV'
AND owner = 'SH';

PAUSE

ALTER MATERIALIZED VIEW sales_mv REFRESH COMPLETE ON DEMAND
START WITH sysdate NEXT sysdate+to_dsinterval('0 00:10:00');

SELECT what, interval
FROM dba_jobs
WHERE schema_user = 'SH';

PAUSE

REM
REM Create some basic materialized view logs
REM

ALTER MATERIALIZED VIEW sales_mv REFRESH FORCE ON DEMAND;

CREATE MATERIALIZED VIEW LOG ON sales WITH ROWID;
CREATE MATERIALIZED VIEW LOG ON customers WITH ROWID;
CREATE MATERIALIZED VIEW LOG ON products WITH ROWID;

execute dbms_mview.refresh('sales_mv','c')

SELECT master, log_table
FROM dba_mview_logs
WHERE master IN ('SALES', 'CUSTOMERS', 'PRODUCTS')
AND log_owner = 'SH';

describe mlog$_sales

PAUSE

REM
REM Display refresh capabilities
REM

DELETE mv_capabilities_table 
WHERE statement_id = '42';

execute dbms_mview.explain_mview(mv => 'sales_mv', stmt_id => '42')

SELECT capability_name, possible, msgtxt, related_text
FROM mv_capabilities_table
WHERE statement_id = '42'
AND capability_name LIKE 'REFRESH_FAST_AFTER%'
ORDER BY seq;

PAUSE

REM
REM Recreate materialized view and materialized view logs
REM with all necessary parameters for a fast refresh
REM

DROP MATERIALIZED VIEW LOG ON sales;
DROP MATERIALIZED VIEW LOG ON customers;
DROP MATERIALIZED VIEW LOG ON products;

CREATE MATERIALIZED VIEW LOG ON sales WITH ROWID, SEQUENCE
(cust_id, prod_id, quantity_sold, amount_sold) INCLUDING NEW VALUES;

CREATE MATERIALIZED VIEW LOG ON customers WITH ROWID, SEQUENCE
(cust_id, country_id) INCLUDING NEW VALUES;

CREATE MATERIALIZED VIEW LOG ON products WITH ROWID, SEQUENCE
(prod_id, prod_category) INCLUDING NEW VALUES;

DROP MATERIALIZED VIEW sales_mv;

CREATE MATERIALIZED VIEW sales_mv
REFRESH FORCE ON DEMAND
AS
SELECT p.prod_category, c.country_id,
       sum(s.quantity_sold) AS quantity_sold,
       sum(s.amount_sold) AS amount_sold,
       count(*) AS count_star,
       count(s.quantity_sold) AS count_quantity_sold,
       count(s.amount_sold) AS count_amount_sold
FROM sales s, customers c, products p
WHERE s.cust_id = c.cust_id
AND s.prod_id = p.prod_id
GROUP BY p.prod_category, c.country_id;

PAUSE

REM
REM Display refresh capabilities
REM

DELETE mv_capabilities_table 
WHERE statement_id = '42';

execute dbms_mview.explain_mview(mv => 'sales_mv', stmt_id => '42')

SELECT capability_name, possible, msgtxt, related_text
FROM mv_capabilities_table
WHERE statement_id = '42'
AND capability_name LIKE 'REFRESH_FAST_AFTER%'
ORDER BY seq;

PAUSE

REM
REM Test fast refresh
REM

INSERT INTO products 
SELECT 619, prod_name, prod_desc, prod_subcategory,  prod_subcategory_id,
       prod_subcategory_desc, prod_category, prod_category_id,
       prod_category_desc, prod_weight_class, prod_unit_of_measure,
       prod_pack_size, supplier_id, prod_status, prod_list_price, 
       prod_min_price, prod_total, prod_total_id, prod_src_id, 
       prod_eff_from, prod_eff_to, prod_valid
FROM products
WHERE prod_id = 136;

INSERT INTO sales
SELECT 619, cust_id, time_id, channel_id, promo_id, quantity_sold, amount_sold
FROM sales
WHERE prod_id = 136;

COMMIT;

SET TIMING ON
execute dbms_mview.refresh(list => 'sh.sales_mv', method => 'f')
SET TIMING OFF

PAUSE

DELETE sales WHERE prod_id = 619;

DELETE products WHERE prod_id = 619;

COMMIT;

SET TIMING ON
execute dbms_mview.refresh(list => 'sh.sales_mv', method => 'f')
SET TIMING OFF

PAUSE

REM
REM Test out-of-place fast refresh (12.1 only)
REM

INSERT INTO products 
SELECT 619, prod_name, prod_desc, prod_subcategory,  prod_subcategory_id,
       prod_subcategory_desc, prod_category, prod_category_id,
       prod_category_desc, prod_weight_class, prod_unit_of_measure,
       prod_pack_size, supplier_id, prod_status, prod_list_price, 
       prod_min_price, prod_total, prod_total_id, prod_src_id, 
       prod_eff_from, prod_eff_to, prod_valid
FROM products
WHERE prod_id = 136;

INSERT INTO sales
SELECT 619, cust_id, time_id, channel_id, promo_id, quantity_sold, amount_sold
FROM sales
WHERE prod_id = 136;

COMMIT;

SET TIMING ON
ALTER SESSION SET sql_trace = TRUE;
BEGIN
  dbms_mview.refresh(
    list           => 'sh.sales_mv',
    method         => 'f', 
    atomic_refresh => FALSE, 
    out_of_place   => TRUE
  );
END;
/
ALTER SESSION SET sql_trace = FALSE;
SET TIMING OFF

PAUSE

DELETE sales WHERE prod_id = 619;

DELETE products WHERE prod_id = 619;

COMMIT;

SET TIMING ON
BEGIN
  dbms_mview.refresh(
    list           => 'sh.sales_mv',
    method         => 'f', 
    atomic_refresh => FALSE, 
    out_of_place   => TRUE
  );
END;
/
SET TIMING OFF

PAUSE

REM
REM Pitfall with materialized view log syntax...
REM

DROP MATERIALIZED VIEW LOG ON products;

CREATE MATERIALIZED VIEW LOG ON products WITH ROWID, SEQUENCE,
(prod_id, prod_category) INCLUDING NEW VALUES;

CREATE MATERIALIZED VIEW LOG ON products WITH ROWID, SEQUENCE
(prod_id, prod_category) INCLUDING NEW VALUES;

PAUSE

REM
REM Cleanup
REM

DROP SYNONYM mv_capabilities_table;

DROP MATERIALIZED VIEW sales_mv;

DROP MATERIALIZED VIEW LOG ON sales;
DROP MATERIALIZED VIEW LOG ON customers;
DROP MATERIALIZED VIEW LOG ON products;

ALTER SESSION SET current_schema = &initial_user;

DROP TABLE mv_capabilities_table;
