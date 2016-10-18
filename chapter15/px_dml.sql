SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: px_dml.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows several examples of parallel DML statements.
REM Notes.......: -
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 24.06.2010 Changed the part displaying the parallel DML status
REM 24.12.2013 Removed 9i code
REM 05.01.2014 Added parallel_degree_policy = manual
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

ALTER SESSION SET parallel_degree_policy = manual;

DROP TABLE t;

CREATE TABLE t AS
SELECT rownum AS id, rpad('*',100,'*') AS pad
FROM dual
CONNECT BY level <= 100000;

execute dbms_stats.gather_table_stats(ownname => user, tabname => 't')

PAUSE

REM
REM Display and change parallel DML status at session level
REM

REM ALTER SESSION DISABLE PARALLEL DML;

SELECT pdml_status
FROM v$session
WHERE sid = sys_context('userenv','sid');

PAUSE

ALTER SESSION ENABLE PARALLEL DML;

SELECT pdml_status
FROM v$session
WHERE sid = sys_context('userenv','sid');

PAUSE

ALTER SESSION FORCE PARALLEL DML PARALLEL 4;

SELECT pdml_status
FROM v$session
WHERE sid = sys_context('userenv','sid');

PAUSE

REM
REM Parallel INSERT
REM

ALTER SESSION DISABLE PARALLEL QUERY;
ALTER SESSION DISABLE PARALLEL DML;
EXPLAIN PLAN FOR INSERT INTO t SELECT * FROM t;
SELECT * FROM table(dbms_xplan.display);
ROLLBACK;

PAUSE

ALTER SESSION DISABLE PARALLEL QUERY;
ALTER SESSION FORCE PARALLEL DML PARALLEL 4;
EXPLAIN PLAN FOR INSERT INTO t SELECT * FROM t;
SELECT * FROM table(dbms_xplan.display);
ROLLBACK;

PAUSE

ALTER SESSION DISABLE PARALLEL QUERY;
ALTER SESSION DISABLE PARALLEL DML;
EXPLAIN PLAN FOR INSERT /*+ parallel(t 4) */ INTO t SELECT /*+ parallel(t 4) */ * FROM t;
SELECT * FROM table(dbms_xplan.display);
ROLLBACK;

PAUSE

ALTER SESSION DISABLE PARALLEL QUERY;
ALTER SESSION FORCE PARALLEL DML PARALLEL 4;
EXPLAIN PLAN FOR INSERT /*+ parallel(t 4) */ INTO t SELECT /*+ parallel(t 4) */ * FROM t;
SELECT * FROM table(dbms_xplan.display);
ROLLBACK;

PAUSE

REM
REM Parallel UPDATE
REM

ALTER SESSION DISABLE PARALLEL DML;
EXPLAIN PLAN FOR UPDATE t SET id = id + 1;
SELECT * FROM table(dbms_xplan.display);
ROLLBACK;

PAUSE

ALTER SESSION FORCE PARALLEL DML PARALLEL 4;
EXPLAIN PLAN FOR UPDATE t SET id = id + 1;
SELECT * FROM table(dbms_xplan.display);
ROLLBACK;

PAUSE

ALTER SESSION DISABLE PARALLEL QUERY;
ALTER SESSION DISABLE PARALLEL DML;
ALTER TABLE t PARALLEL 2;
EXPLAIN PLAN FOR UPDATE t SET id = id + 1;
SELECT * FROM table(dbms_xplan.display);
ROLLBACK;

PAUSE

ALTER SESSION DISABLE PARALLEL QUERY;
ALTER SESSION ENABLE PARALLEL DML;
ALTER TABLE t PARALLEL 2;
EXPLAIN PLAN FOR UPDATE t SET id = id + 1;
SELECT * FROM table(dbms_xplan.display);
ROLLBACK;

PAUSE

ALTER SESSION ENABLE PARALLEL QUERY;
ALTER SESSION DISABLE PARALLEL DML;
ALTER TABLE t PARALLEL 2;
EXPLAIN PLAN FOR UPDATE t SET id = id + 1;
SELECT * FROM table(dbms_xplan.display);
ROLLBACK;

PAUSE

ALTER SESSION ENABLE PARALLEL QUERY;
ALTER SESSION ENABLE PARALLEL DML;
ALTER TABLE t PARALLEL 2;
EXPLAIN PLAN FOR UPDATE t SET id = id + 1;
SELECT * FROM table(dbms_xplan.display);
ROLLBACK;

PAUSE

REM
REM Parallel DELETE
REM

ALTER SESSION DISABLE PARALLEL DML;
EXPLAIN PLAN FOR DELETE t;
SELECT * FROM table(dbms_xplan.display);
ROLLBACK;

PAUSE

ALTER SESSION FORCE PARALLEL DML PARALLEL 4;
EXPLAIN PLAN FOR DELETE t;
SELECT * FROM table(dbms_xplan.display);
ROLLBACK;

PAUSE

ALTER SESSION DISABLE PARALLEL DML;
EXPLAIN PLAN FOR DELETE /*+ parallel(t 4) */ t;
SELECT * FROM table(dbms_xplan.display);
ROLLBACK;

PAUSE

ALTER SESSION ENABLE PARALLEL DML;
EXPLAIN PLAN FOR DELETE /*+ parallel(t 4) */ t;
SELECT * FROM table(dbms_xplan.display);
ROLLBACK;

PAUSE

REM
REM Cleanup
REM

DROP TABLE t;
PURGE TABLE t;
