SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: px_tqstat.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows what kind of information the dynamic
REM               performance view v$pq_tqstat displays.
REM Notes.......: -
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

SET ARRAYSIZE 1000

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t;

CREATE TABLE t 
PARTITION BY HASH (id) PARTITIONS 2
PARALLEL 2
AS
SELECT rownum AS id, rpad('*',100,'*') AS pad
FROM dual
CONNECT BY level <= 160000;

DELETE t WHERE ora_hash(id,1) = 0 AND rownum <= 60000;
COMMIT;

execute dbms_stats.gather_table_stats(ownname => user, tabname => 't')

ALTER SESSION SET "_bloom_pruning_enabled" = FALSE;

PAUSE

REM
REM Run test queries
REM

EXPLAIN PLAN FOR 
SELECT /*+ leading(t1) pq_distribute(t2 partition,none) */ * 
FROM t t1, t t2 
WHERE t1.id = t2.id;

SELECT * FROM table(dbms_xplan.display);

PAUSE

SELECT /*+ leading(t1) pq_distribute(t2 partition,none) */ * 
FROM t t1, t t2 
WHERE t1.id = t2.id

REM Run query without showing the output...
SET TERMOUT OFF
/
SET TERMOUT ON

SELECT dfo_number, tq_id, server_type, process, num_rows, bytes
FROM v$pq_tqstat
ORDER BY dfo_number, tq_id, server_type DESC, process;

PAUSE

EXPLAIN PLAN FOR 
SELECT /*+ leading(t1) pq_distribute(t2 hash,none) */ * 
FROM t t1, t t2 
WHERE t1.id = t2.id;

SELECT * FROM table(dbms_xplan.display);

PAUSE

SELECT /*+ leading(t1) pq_distribute(t2 hash,none) */ * 
FROM t t1, t t2 
WHERE t1.id = t2.id

REM Run query without showing the output...
SET TERMOUT OFF
/
SET TERMOUT ON

SELECT dfo_number, tq_id, server_type, process, num_rows, bytes
FROM v$pq_tqstat
ORDER BY dfo_number, tq_id, server_type DESC, process;

PAUSE

REM
REM Cleanup
REM

DROP TABLE t;
PURGE TABLE t;
