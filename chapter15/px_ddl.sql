SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: px_ddl.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows several examples of parallel DDL statements.
REM Notes.......: -
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 24.06.2010 Changed the part displaying the parallel DDL status
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

DROP TABLE t1;

CREATE TABLE t1 AS
SELECT rownum AS id, rpad('*',100,'*') AS pad
FROM dual
CONNECT BY level <= 10000;

execute dbms_stats.gather_table_stats(ownname => user, tabname => 't1')

PAUSE

REM
REM Display parallel DDL status at session level
REM

SELECT pddl_status
FROM v$session
WHERE sid = sys_context('userenv','sid');

PAUSE

ALTER SESSION DISABLE PARALLEL DDL;

SELECT pddl_status
FROM v$session
WHERE sid = sys_context('userenv','sid');

PAUSE

ALTER SESSION FORCE PARALLEL DDL PARALLEL 4;

SELECT pddl_status
FROM v$session
WHERE sid = sys_context('userenv','sid');

PAUSE

ALTER SESSION ENABLE PARALLEL DDL;

REM
REM Parallel CTAS
REM

EXPLAIN PLAN FOR CREATE TABLE t2 PARALLEL 2 AS SELECT /*+ no_parallel(t1) */ * FROM t1;
SELECT * FROM table(dbms_xplan.display);

PAUSE

EXPLAIN PLAN FOR CREATE TABLE t2 NOPARALLEL AS SELECT /*+ parallel(t1 2) */ * FROM t1;
SELECT * FROM table(dbms_xplan.display);

PAUSE

EXPLAIN PLAN FOR CREATE TABLE t2 PARALLEL 2 AS SELECT /*+ parallel(t1 2) */ * FROM t1;
SELECT * FROM table(dbms_xplan.display);

PAUSE

EXPLAIN PLAN FOR CREATE /*+ parallel(2) */ TABLE t2 AS SELECT * FROM t1;
SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM Parallel CREATE/ALTER INDEX
REM

EXPLAIN PLAN FOR CREATE INDEX i1 ON t1 (id) PARALLEL 4;
SELECT * FROM table(dbms_xplan.display);

PAUSE

CREATE INDEX i1 ON t1 (id) PARALLEL 4;

EXPLAIN PLAN FOR ALTER INDEX i1 REBUILD;
SELECT * FROM table(dbms_xplan.display);

PAUSE

EXPLAIN PLAN FOR ALTER INDEX i1 REBUILD PARALLEL 4;
SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM Parallel validation of constraints
REM

ALTER SESSION SET sql_trace = TRUE;

ALTER TABLE t1 PARALLEL 4;

ALTER TABLE t1 ADD CONSTRAINT t1_id_nn CHECK (id IS NOT NULL);

ALTER TABLE t1 DROP CONSTRAINT t1_id_nn;

ALTER TABLE t1 NOPARALLEL;

ALTER TABLE t1 ADD CONSTRAINT t1_id_nn CHECK (id IS NOT NULL);

ALTER TABLE t1 DROP CONSTRAINT t1_id_nn;

ALTER SESSION FORCE PARALLEL DDL PARALLEL 4;

ALTER TABLE t1 ADD CONSTRAINT t1_id_nn CHECK (id IS NOT NULL);

ALTER TABLE t1 DROP CONSTRAINT t1_id_nn;

ALTER SESSION FORCE PARALLEL QUERY PARALLEL 4;

ALTER TABLE t1 ADD CONSTRAINT t1_id_nn CHECK (id IS NOT NULL);

ALTER TABLE t1 DROP CONSTRAINT t1_id_nn;

ALTER SESSION DISABLE PARALLEL DDL;
ALTER SESSION DISABLE PARALLEL QUERY;

ALTER TABLE t1 PARALLEL 4;

ALTER TABLE t1 ADD CONSTRAINT t1_id_nn CHECK (id IS NOT NULL);

DROP INDEX i1;

CREATE UNIQUE index t1_pk ON t1 (id) PARALLEL 2;

ALTER TABLE t1 ADD CONSTRAINT t_pk PRIMARY KEY (id);

ALTER SESSION SET sql_trace = FALSE;

PAUSE

REM
REM Check the generated trace file for detailed information about the
REM executions. E.g. the following command may be used:
REM  tkprof <trace file> <output file> sys=no aggregate=no
REM

PAUSE

REM
REM Cleanup
REM

DROP TABLE t1;
PURGE TABLE t1;
