SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: mv_rewrite_ext.sql
REM Author......: Christian Antognini
REM Date........: August 2013
REM Description.: This script shows several examples of query rewrite based on
REM               an external table. 
REM Notes.......: The sample schema SH is required and cannot own tables named
REM               REWRITE_TABLE and MV_CAPABILITIES_TABLE.
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

COLUMN message FORMAT A71

COLUMN rewrite_enabled FORMAT A15
COLUMN rewrite_capability FORMAT A18

COLUMN capability_name FORMAT A26
COLUMN possible FORMAT A8
COLUMN msgtxt FORMAT A40

@../connect.sql

COLUMN user NEW_VALUE initial_user
SELECT user FROM dual;

SET ECHO ON

REM
REM Setup test environment
REM

CREATE SYNONYM sh.mv_capabilities_table FOR mv_capabilities_table;

CREATE SYNONYM sh.rewrite_table FOR rewrite_table;

DROP TABLE mv_capabilities_table;

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

PAUSE

DROP TABLE rewrite_table;

CREATE TABLE rewrite_table(
  statement_id         VARCHAR2(30),
  mv_owner             VARCHAR2(30),
  mv_name              VARCHAR2(30),
  sequence             INTEGER,
  query                VARCHAR2(4000),
  query_block_no       INTEGER,
  rewritten_txt        VARCHAR2(4000),
  message              VARCHAR2(512),
  pass                 VARCHAR2(3),
  mv_in_msg            VARCHAR2(30),
  measure_in_msg       VARCHAR2(30),
  join_back_tbl        VARCHAR2(4000),
  join_back_col        VARCHAR2(4000),
  original_cost        INTEGER,
  rewritten_cost       INTEGER,
  flags                INTEGER,
  reserved1            INTEGER,
  reserved2            VARCHAR2(10)
);

GRANT ALL ON rewrite_table TO public;

ALTER SESSION SET current_schema = SH;

PAUSE

DROP MATERIALIZED VIEW sales_mv;

CREATE MATERIALIZED VIEW sales_mv
ENABLE QUERY REWRITE
AS
SELECT p.prod_category, c.country_id,
       sum(s.quantity_sold) AS quantity_sold,
       sum(s.amount_sold) AS amount_sold
FROM sales_transactions_ext s, customers c, products p
WHERE s.cust_id = c.cust_id
AND s.prod_id = p.prod_id
GROUP BY p.prod_category, c.country_id;

execute dbms_stats.gather_table_stats(ownname => 'sh', tabname => 'sales_mv')

PAUSE

REM
REM  Display rewrite capabilities
REM

SELECT rewrite_enabled, rewrite_capability
FROM dba_mviews
WHERE mview_name = 'SALES_MV'
AND owner = 'SH';

PAUSE

execute dbms_mview.explain_mview(mv => 'sales_mv', stmt_id => '42')

SELECT capability_name, possible, msgtxt
FROM mv_capabilities_table
WHERE statement_id = '42'
AND capability_name IN ('REWRITE_FULL_TEXT_MATCH',
                        'REWRITE_PARTIAL_TEXT_MATCH',
                        'REWRITE_GENERAL')
ORDER BY seq;

PAUSE

REM
REM Run test queries with different values of query_rewrite_integrity
REM

ALTER SESSION SET query_rewrite_integrity = enforced;

PAUSE

DECLARE
  l_query CLOB := 'SELECT p.prod_category, c.country_id,
                          sum(s.quantity_sold) AS quantity_sold,
                          sum(s.amount_sold) AS amount_sold
                   FROM sh.sales_transactions_ext s, sh.customers c, sh.products p
                   WHERE s.cust_id = c.cust_id
                   AND s.prod_id = p.prod_id
                   GROUP BY p.prod_category, c.country_id';
BEGIN
  DELETE rewrite_table WHERE statement_id = '42';
  dbms_mview.explain_rewrite(
    query        => l_query, 
    mv           => 'sh.sales_mv', 
    statement_id => '42'
  );
END;
/

SELECT message
FROM rewrite_table
WHERE statement_id = '42';

PAUSE

ALTER SESSION SET query_rewrite_integrity = trusted;

PAUSE

DECLARE
  l_query CLOB := 'SELECT p.prod_category, c.country_id,
                          sum(s.quantity_sold) AS quantity_sold,
                          sum(s.amount_sold) AS amount_sold
                   FROM sh.sales_transactions_ext s, sh.customers c, sh.products p
                   WHERE s.cust_id = c.cust_id
                   AND s.prod_id = p.prod_id
                   GROUP BY p.prod_category, c.country_id';
BEGIN
  DELETE rewrite_table WHERE statement_id = '42';
  dbms_mview.explain_rewrite(
    query        => l_query, 
    mv           => 'sh.sales_mv', 
    statement_id => '42'
  );
END;
/

SELECT message
FROM rewrite_table
WHERE statement_id = '42';

PAUSE

ALTER SESSION SET query_rewrite_integrity = stale_tolerated;

PAUSE

DECLARE
  l_query CLOB := 'SELECT p.prod_category, c.country_id,
                          sum(s.quantity_sold) AS quantity_sold,
                          sum(s.amount_sold) AS amount_sold
                   FROM sh.sales_transactions_ext s, sh.customers c, sh.products p
                   WHERE s.cust_id = c.cust_id
                   AND s.prod_id = p.prod_id
                   GROUP BY p.prod_category, c.country_id';
BEGIN
  DELETE rewrite_table WHERE statement_id = '42';
  dbms_mview.explain_rewrite(
    query        => l_query, 
    mv           => 'sh.sales_mv', 
    statement_id => '42'
  );
END;
/

SELECT message
FROM rewrite_table
WHERE statement_id = '42';

PAUSE

REM
REM Cleanup
REM

DROP SYNONYM mv_capabilities_table;
DROP SYNONYM rewrite_table;

DROP MATERIALIZED VIEW sales_mv;

ALTER SESSION SET current_schema = &initial_user;

DROP TABLE mv_capabilities_table;
PURGE TABLE mv_capabilities_table;

DROP TABLE rewrite_table;
PURGE TABLE rewrite_table;
