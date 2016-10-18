SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: px_query.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows several examples of parallel queries.
REM Notes.......: -
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 24.06.2010 Changed the part displaying the parallel query status
REM 24.12.2013 Removed 9i code and comments
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

execute dbms_stats.gather_table_stats(user, 't1')

DROP TABLE t2;

CREATE TABLE t2 AS SELECT * FROM t1;

execute dbms_stats.gather_table_stats(user, 't2')

PAUSE

REM
REM Display parallel DML status at session level
REM

SELECT pq_status
FROM v$session
WHERE sid = sys_context('userenv','sid');

PAUSE

REM
REM Full table scans
REM

REM Serial full table scan

EXPLAIN PLAN FOR SELECT * FROM t1;
SELECT * FROM table(dbms_xplan.display);

PAUSE

REM Parallel full table scan

EXPLAIN PLAN FOR SELECT /*+ parallel(t1 2) */ * FROM t1;
SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM Index scans
REM

CREATE INDEX i1 ON t1 (id);

REM Parallel index fast full scan

EXPLAIN PLAN FOR SELECT /*+ index_ffs(t1) parallel_index(t1 4) */ count(id) FROM t1;
SELECT * FROM table(dbms_xplan.display);

PAUSE

REM Serial index full scan

EXPLAIN PLAN FOR SELECT /*+ index(t1) parallel_index(t1 4) */ count(id) FROM t1;
SELECT * FROM table(dbms_xplan.display);

PAUSE

REM Serial index range scan

EXPLAIN PLAN FOR SELECT /*+ index(t1) parallel_index(t1 4) */ * FROM t1 WHERE id > 9000;
SELECT * FROM table(dbms_xplan.display);

PAUSE

DROP INDEX i1;
CREATE INDEX i1 ON t1 (id) GLOBAL PARTITION BY HASH (id) PARTITIONS 4;

REM Parallel index full scan

EXPLAIN PLAN FOR SELECT /*+ index(t1) parallel_index(t1 4) */ count(id) FROM t1;
SELECT * FROM table(dbms_xplan.display);

PAUSE

REM Parallel index range scan

EXPLAIN PLAN FOR SELECT /*+ index(t1) parallel_index(t1 4) */ * FROM t1 WHERE id > 9000;
SELECT * FROM table(dbms_xplan.display);

PAUSE

EXPLAIN PLAN FOR SELECT /*+ leading(t1) use_hash(t2) index(t1) parallel_index(t1 2) full(t2) parallel(t2 2) pq_distribute(t2 hash,hash) */ * 
FROM t1, t2 
WHERE t1.id > 9000 AND t1.id = t2.id+1;
SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM Change parallel DML status at session level
REM

ALTER SESSION DISABLE PARALLEL QUERY;

SELECT pq_status
FROM v$session
WHERE sid = sys_context('userenv','sid');

PAUSE

ALTER SESSION ENABLE PARALLEL QUERY;

SELECT pq_status
FROM v$session
WHERE sid = sys_context('userenv','sid');

PAUSE

ALTER SESSION FORCE PARALLEL QUERY PARALLEL 4;

SELECT pq_status
FROM v$session
WHERE sid = sys_context('userenv','sid');

PAUSE

REM
REM Hints have precedence over the setting at the session level
REM

ALTER SESSION FORCE PARALLEL QUERY PARALLEL 4;
SELECT /*+ noparallel(t1) */ count(*) FROM t1;
SELECT * FROM v$pq_tqstat;

PAUSE

ALTER SESSION FORCE PARALLEL QUERY PARALLEL 4;
SELECT /*+ parallel(t1 2) */ count(*) FROM t1;
SELECT * FROM v$pq_tqstat;

PAUSE

REM
REM Cleanup
REM

DROP TABLE t1;
PURGE TABLE t1;

DROP TABLE t2;
PURGE TABLE t2;
