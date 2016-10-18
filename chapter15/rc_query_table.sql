SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: rc_query_table.sql
REM Author......: Christian Antognini
REM Date........: December 2013
REM Description.: This script shows an example of query that takes advantage of 
REM               the server result cache. The cache is actived through the
REM               RESULT_CACHE clause.
REM Notes.......: The sample schema SH and Oracle Database 11g are required.
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

COLUMN user NEW_VALUE initial_user
SELECT user FROM dual;

SET ECHO ON

REM
REM Setup test environment
REM

execute dbms_result_cache.flush

ALTER SESSION SET current_schema = SH;

ALTER SESSION SET statistics_level = ALL;

PAUSE

REM
REM Only one table has RESULT_CACHE set to FORCE --> no caching
REM

ALTER TABLE sales RESULT_CACHE (MODE FORCE);
ALTER TABLE customers RESULT_CACHE (MODE DEFAULT);
ALTER TABLE products RESULT_CACHE (MODE DEFAULT);

SELECT p.prod_category, c.country_id,
       sum(s.quantity_sold) AS quantity_sold,
       sum(s.amount_sold) AS amount_sold
FROM sales s, customers c, products p
WHERE s.cust_id = c.cust_id
AND s.prod_id = p.prod_id
GROUP BY p.prod_category, c.country_id
ORDER BY p.prod_category, c.country_id

SET TIMING ON TERMOUT OFF
/
/
SET TIMING OFF TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'iostats last'));

PAUSE

REM
REM Only two tables have RESULT_CACHE set to FORCE --> no caching
REM

ALTER TABLE sales RESULT_CACHE (MODE FORCE);
ALTER TABLE customers RESULT_CACHE (MODE FORCE);
ALTER TABLE products RESULT_CACHE (MODE DEFAULT);

SELECT p.prod_category, c.country_id,
       sum(s.quantity_sold) AS quantity_sold,
       sum(s.amount_sold) AS amount_sold
FROM sales s, customers c, products p
WHERE s.cust_id = c.cust_id
AND s.prod_id = p.prod_id
GROUP BY p.prod_category, c.country_id
ORDER BY p.prod_category, c.country_id

SET TIMING ON TERMOUT OFF
/
/
SET TIMING OFF TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'iostats last'));

PAUSE

REM
REM All tables have RESULT_CACHE set to FORCE --> caching
REM

ALTER TABLE sales RESULT_CACHE (MODE FORCE);
ALTER TABLE customers RESULT_CACHE (MODE FORCE);
ALTER TABLE products RESULT_CACHE (MODE FORCE);

SELECT p.prod_category, c.country_id,
       sum(s.quantity_sold) AS quantity_sold,
       sum(s.amount_sold) AS amount_sold
FROM sales s, customers c, products p
WHERE s.cust_id = c.cust_id
AND s.prod_id = p.prod_id
GROUP BY p.prod_category, c.country_id
ORDER BY p.prod_category, c.country_id

SET TIMING ON TERMOUT OFF
/
/
SET TIMING OFF TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'iostats last'));

PAUSE

REM
REM The NO_RESULT_CACHE hint overrides the RESULT_CACHE clause
REM

SELECT /*+ no_result_cache */ 
       p.prod_category, c.country_id,
       sum(s.quantity_sold) AS quantity_sold,
       sum(s.amount_sold) AS amount_sold
FROM sales s, customers c, products p
WHERE s.cust_id = c.cust_id
AND s.prod_id = p.prod_id
GROUP BY p.prod_category, c.country_id
ORDER BY p.prod_category, c.country_id

SET TIMING ON TERMOUT OFF
/
/
SET TIMING OFF TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'iostats last'));

PAUSE

REM
REM Show information about the content of the cache
REM (since a flush has been executed at the beginning of the script, only one object should be cached)
REM

SELECT status, creation_timestamp, build_time, row_count, scan_count
FROM v$result_cache_objects
WHERE type <> 'Dependency';

PAUSE

REM
REM Cleanup
REM

ALTER TABLE sales RESULT_CACHE (MODE DEFAULT);
ALTER TABLE customers RESULT_CACHE (MODE DEFAULT);
ALTER TABLE products RESULT_CACHE (MODE DEFAULT);

ALTER SESSION SET current_schema = &initial_user;
