SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: rc_query_hint.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows an example of query that takes advantage of 
REM               the server result cache. The cache is actived through a hint.
REM Notes.......: The sample schema SH and Oracle Database 11g are required.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 20.12.2013 Added execution timing + added example of invalidation + Renamed
REM            script (the old name was result_cache_query.sql)
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
REM Run test queries with hints
REM

REM First execution

SET TIMING ON

SELECT /*+ result_cache */
       p.prod_category, c.country_id,
       sum(s.quantity_sold) AS quantity_sold,
       sum(s.amount_sold) AS amount_sold
FROM sales s, customers c, products p
WHERE s.cust_id = c.cust_id
AND s.prod_id = p.prod_id
GROUP BY p.prod_category, c.country_id
ORDER BY p.prod_category, c.country_id;

SET TIMING OFF

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'iostats last'));

PAUSE

REM Second execution

SET TIMING ON

SELECT /*+ result_cache */
       p.prod_category, c.country_id,
       sum(s.quantity_sold) AS quantity_sold,
       sum(s.amount_sold) AS amount_sold
FROM sales s, customers c, products p
WHERE s.cust_id = c.cust_id
AND s.prod_id = p.prod_id
GROUP BY p.prod_category, c.country_id
ORDER BY p.prod_category, c.country_id;

SET TIMING OFF

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'iostats last'));

PAUSE

REM Third execution

SET TIMING ON

SELECT /*+ result_cache */
       p.prod_category, c.country_id,
       sum(s.quantity_sold) AS quantity_sold,
       sum(s.amount_sold) AS amount_sold
FROM sales s, customers c, products p
WHERE s.cust_id = c.cust_id
AND s.prod_id = p.prod_id
GROUP BY p.prod_category, c.country_id
ORDER BY p.prod_category, c.country_id;

SET TIMING OFF

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'iostats last'));

PAUSE

REM
REM Example of invalidation
REM

REM Show information about the content of the cache
REM (since a flush has been executed at the beginning of the script, only one object should be cached)

SELECT status, creation_timestamp, build_time, row_count, scan_count
FROM v$result_cache_objects
WHERE type <> 'Dependency';

PAUSE

SELECT cust_id
FROM customers
WHERE rownum = 1 FOR UPDATE;

PAUSE

COMMIT;

PAUSE

SELECT status, creation_timestamp, build_time, row_count, scan_count
FROM v$result_cache_objects
WHERE type <> 'Dependency';

PAUSE

SELECT /*+ result_cache */
       p.prod_category, c.country_id,
       sum(s.quantity_sold) AS quantity_sold,
       sum(s.amount_sold) AS amount_sold
FROM sales s, customers c, products p
WHERE s.cust_id = c.cust_id
AND s.prod_id = p.prod_id
GROUP BY p.prod_category, c.country_id
ORDER BY p.prod_category, c.country_id;

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'iostats last'));

PAUSE

SELECT status, creation_timestamp, build_time, row_count, scan_count
FROM v$result_cache_objects
WHERE type <> 'Dependency';

PAUSE

REM
REM Cleanup
REM

ALTER SESSION SET current_schema = &initial_user;
