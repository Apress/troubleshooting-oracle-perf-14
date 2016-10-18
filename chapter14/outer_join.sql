SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: outer_join.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script provides several examples of outer joins.
REM Notes.......: -
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 13.11.2013 Removed unnecessary parentheses in several queries 
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

@@create_tx.sql

PAUSE

REM
REM nested loop join
REM

EXPLAIN PLAN FOR
SELECT /*+ leading(t1) use_nl(t2) */ *
FROM t1, t2
WHERE t1.id = t2.t1_id(+);

SELECT * FROM table(dbms_xplan.display);

PAUSE

EXPLAIN PLAN FOR
SELECT /*+ leading(t1) use_nl(t2) */ *
FROM t1 LEFT JOIN t2 ON t1.id = t2.t1_id;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM hash join
REM

EXPLAIN PLAN FOR
SELECT /*+ leading(t1) use_hash(t2) */ *
FROM t1, t2
WHERE t1.id = t2.t1_id(+);

SELECT * FROM table(dbms_xplan.display);

PAUSE

EXPLAIN PLAN FOR
SELECT /*+ leading(t1) use_hash(t2) */ *
FROM t1 LEFT JOIN t2 ON t1.id = t2.t1_id;

SELECT * FROM table(dbms_xplan.display);

PAUSE

EXPLAIN PLAN FOR
SELECT /*+ leading(t1) use_hash(t2) swap_join_inputs(t2) */ *
FROM t1, t2
WHERE t1.id = t2.t1_id(+);

SELECT * FROM table(dbms_xplan.display);

PAUSE

EXPLAIN PLAN FOR
SELECT /*+ leading(t1) use_hash(t2) swap_join_inputs(t2) */ *
FROM t1 LEFT JOIN t2 ON t1.id = t2.t1_id;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM merge join
REM

EXPLAIN PLAN FOR
SELECT /*+ leading(t1) use_merge(t2) */ *
FROM t1, t2
WHERE t1.id = t2.t1_id(+);

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM Cleanup
REM

DROP TABLE t4;
PURGE TABLE t4;
DROP TABLE t3;
PURGE TABLE t3;
DROP TABLE t2;
PURGE TABLE t2;
DROP TABLE t1;
PURGE TABLE t1;
