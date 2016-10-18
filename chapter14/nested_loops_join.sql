SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: nested_loops_join.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script provides several examples of nested loop joins.
REM Notes.......: -
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 12.11.2013 Added some hints to make sure that the query optimizer generates
REM            the expected execution plans
REM 11.03.2014 Completed/Amended hints for several queries
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
REM 2-table joins
REM

DROP INDEX t1_n;

EXPLAIN PLAN FOR
SELECT /*+ leading(t1 t2) use_nl(t2) full(t1) full(t2) */ *
FROM t1, t2
WHERE t1.id = t2.t1_id
AND t1.n = 19;

SELECT * FROM table(dbms_xplan.display);

PAUSE

CREATE UNIQUE INDEX t1_n ON t1 (n);

EXPLAIN PLAN FOR
SELECT /*+ full(t2) */ *
FROM t1, t2
WHERE t1.id = t2.t1_id
AND t1.n = 19;

SELECT * FROM table(dbms_xplan.display);

PAUSE

EXPLAIN PLAN FOR
SELECT /*+ ordered use_nl(t2) index(t1) index(t2) */ *
FROM t1, t2
WHERE t1.id = t2.t1_id
AND t1.n = 19;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM 4-table joins
REM

DROP INDEX t1_n;
CREATE INDEX t1_n ON t1 (n);

EXPLAIN PLAN FOR
SELECT /*+ ordered use_nl(t2 t3 t4) index(t1) index(t2) index(t3) index(t4) */ t1.*, t2.*, t3.*, t4.*
FROM t1, t2, t3, t4
WHERE t1.id = t2.t1_id 
AND t2.id = t3.t2_id 
AND t3.id = t4.t3_id 
AND t1.n = 19;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM alternate execution plans (only in Oracle Database 11g
REM the following queries use different execution plans)
REM

DROP INDEX t1_n;
CREATE INDEX t1_n ON t1 (n);

EXPLAIN PLAN FOR
SELECT /*+ leading(t1 t2) use_nl(t2) index(t1) index(t2) nlj_prefetch(t2) */ *
FROM t1, t2
WHERE t1.id = t2.t1_id
AND t1.n = 19;

SELECT * FROM table(dbms_xplan.display);

PAUSE

EXPLAIN PLAN FOR
SELECT /*+ leading(t1 t2) use_nl(t2) index(t1) index(t2) nlj_batching(t2) */ *
FROM t1, t2
WHERE t1.id = t2.t1_id
AND t1.n = 19;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM Cleanup
REM

DROP TABLE t4 PURGE;
DROP TABLE t3 PURGE;
DROP TABLE t2 PURGE;
DROP TABLE t1 PURGE;
