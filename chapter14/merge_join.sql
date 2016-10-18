SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: merge_join.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script provides several examples of merge joins.
REM Notes.......: -
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 08.03.2009 Added hint gather_plan_statistics to the last three queries +
REM            added PGA setting to make sure that in-memory sorts works as
REM            expected + removed comment related to releases through 10.1
REM 16.11.2013 Added examples with left/right input returning no rows + 
REM            Cartesian product
REM 07.03.2014 Completed hints for several queries
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

COLUMN pad FORMAT A10 TRUNCATE

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

@@create_tx.sql

PAUSE

REM
REM 2-table joins
REM

EXPLAIN PLAN FOR
SELECT /*+ ordered use_merge(t2) */ *
FROM t1, t2
WHERE t1.id = t2.t1_id
AND t1.n = 19;

SELECT * FROM table(dbms_xplan.display);

PAUSE

CREATE INDEX t1_n ON t1 (n);

PAUSE

EXPLAIN PLAN FOR
SELECT /*+ ordered use_merge(t2) index(t1 t1_n) */ *
FROM t1, t2
WHERE t1.id = t2.t1_id
AND t1.n = 19;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM For the left input no sort is necessary in case data is already in the 
REM expected order

EXPLAIN PLAN FOR
SELECT /*+ ordered use_merge(t2) index(t1 t1_pk) */ *
FROM t1, t2
WHERE t1.id = t2.t1_id
AND t1.n = 19;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM Things are different for the right input...

EXPLAIN PLAN FOR
SELECT /*+ leading(t2 t1) use_merge(t1) index(t1 t1_pk) */ *
FROM t1, t2
WHERE t1.id = t2.t1_id
AND t1.n = 19;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM If the left input does not return data, the right input is not executed
REM

SELECT /*+ ordered use_merge(t2) gather_plan_statistics */ *
FROM t1, t2
WHERE t1.id = t2.t1_id
AND t1.n = -1;

SELECT * FROM table(dbms_xplan.display_cursor(format=>'iostats last -rows'));

PAUSE

SELECT /*+ ordered use_merge(t2) gather_plan_statistics */ *
FROM t1, t2
WHERE t1.id = t2.t1_id
AND t2.n = -1;

SELECT * FROM table(dbms_xplan.display_cursor(format=>'iostats last -rows'));

PAUSE

REM
REM Cartesian product
REM

SELECT /*+ ordered use_merge(t2) gather_plan_statistics */ *
FROM t1, t2

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(format=>'iostats last -rows'));

PAUSE

REM
REM 4-table joins
REM

DROP INDEX t1_n;

EXPLAIN PLAN FOR
SELECT /*+ leading(t1 t2 t3 t4) use_merge(t2 t3 t4) */ t1.*, t2.*, t3.*, t4.*
FROM t1, t2, t3, t4
WHERE t1.id = t2.t1_id 
AND t2.id = t3.t2_id 
AND t3.id = t4.t3_id 
AND t1.n = 19;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM in-memory sorts
REM

ALTER SESSION SET workarea_size_policy = manual;
ALTER SESSION SET sort_area_size = 1024000;

PAUSE

SELECT /*+ ordered use_merge(t2 t3 t4) full(t1) full(t2) full(t3) full(t4) gather_plan_statistics */ t1.*, t2.*, t3.*, t4.*
FROM t1, t2, t3, t4
WHERE t1.id = t2.t1_id 
AND t2.id = t3.t2_id 
AND t3.id = t4.t3_id 
AND t1.n = 19

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'memstats last'));

PAUSE

SELECT /*+ ordered use_merge(t2 t3 t4) full(t1) full(t2) full(t3) full(t4) gather_plan_statistics */ t1.id, t2.id, t3.id, t4.id
FROM t1, t2, t3, t4
WHERE t1.id = t2.t1_id 
AND t2.id = t3.t2_id 
AND t3.id = t4.t3_id 
AND t1.n = 19

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'memstats last'));

PAUSE

REM
REM on-disk sort
REM

ALTER SESSION SET workarea_size_policy = manual;
ALTER SESSION SET sort_area_size = 2048;

PAUSE

SELECT /*+ ordered use_merge(t2 t3 t4) full(t1) full(t2) full(t3) full(t4) gather_plan_statistics */ t1.*, t2.*, t3.*, t4.*
FROM t1, t2, t3, t4
WHERE t1.id = t2.t1_id 
AND t2.id = t3.t2_id 
AND t3.id = t4.t3_id 
AND t1.n = 19

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'memstats last'));

PAUSE

REM
REM Cleanup
REM

DROP TABLE t4 PURGE;
DROP TABLE t3 PURGE;
DROP TABLE t2 PURGE;
DROP TABLE t1 PURGE;
