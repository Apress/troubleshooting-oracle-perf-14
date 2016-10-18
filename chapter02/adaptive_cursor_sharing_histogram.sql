SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************ http://top.antognini.ch **************************
REM ***************************************************************************
REM
REM File name...: adaptive_cursor_sharing_histogram.sql
REM Author......: Christian Antognini
REM Date........: December 2012
REM Description.: This script shows how the query optimizer uses the information
REM               provided by v$sql_cs_histogram to decide when a cursor is
REM               made bind aware.
REM Notes.......: This script works as of 11gR1 only.
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

VARIABLE id NUMBER

COLUMN sql_id NEW_VALUE sql_id

SET ECHO ON

REM
REM Setup test environment
REM

ALTER SYSTEM FLUSH SHARED_POOL;

DROP TABLE t;

CREATE TABLE t 
AS 
SELECT rownum AS id, rpad('*',100,'*') AS pad 
FROM dual
CONNECT BY level <= 1000;

INSERT /*+ append */ INTO t SELECT 1000+rownum, rpad('*',100,'*') FROM t, t WHERE rownum <= 999990;

ALTER TABLE t ADD CONSTRAINT t_pk PRIMARY KEY (id);

BEGIN
  dbms_stats.gather_table_stats(
    ownname          => user, 
    tabname          => 't', 
    estimate_percent => 100, 
    method_opt       => 'for all columns size 1'
  );
END;
/

SELECT count(id), count(DISTINCT id), min(id), max(id) FROM t;

PAUSE

REM
REM At first the cursor is executed 5 times with a good execution plan.
REM

EXECUTE :id := 10;

SELECT count(pad) FROM t WHERE id < :id;
SELECT count(pad) FROM t WHERE id < :id;
SELECT count(pad) FROM t WHERE id < :id;
SELECT count(pad) FROM t WHERE id < :id;
SELECT count(pad) FROM t WHERE id < :id;

PAUSE

SELECT sql_id 
FROM v$sqlarea 
WHERE sql_text = 'SELECT count(pad) FROM t WHERE id < :id';

PAUSE

SELECT child_number, bucket_id, count
FROM v$sql_cs_histogram 
WHERE sql_id = '&sql_id'
ORDER BY child_number, bucket_id;

PAUSE

REM
REM Then, the cursor is executed serveral times with a poor execution plan.
REM The number of executions to invalidate it depends on the magnitude of 
REM the variation.
REM
REM Enter the number of rows:
REM - 990 for an inefficient execution
REM - 999990 for a very inefficient execution

EXECUTE :id := &nor;

SELECT count(pad) FROM t WHERE id < :id;

SELECT child_number, bucket_id, count
FROM v$sql_cs_histogram 
WHERE sql_id = '&sql_id'
ORDER BY child_number, bucket_id;

PAUSE

EXECUTE :id := &nor;

SELECT count(pad) FROM t WHERE id < :id;

SELECT child_number, bucket_id, count
FROM v$sql_cs_histogram 
WHERE sql_id = '&sql_id'
ORDER BY child_number, bucket_id;

PAUSE

EXECUTE :id := &nor;

SELECT count(pad) FROM t WHERE id < :id;

SELECT child_number, bucket_id, count
FROM v$sql_cs_histogram 
WHERE sql_id = '&sql_id'
ORDER BY child_number, bucket_id;

PAUSE

EXECUTE :id := &nor;

SELECT count(pad) FROM t WHERE id < :id;

SELECT child_number, bucket_id, count
FROM v$sql_cs_histogram 
WHERE sql_id = '&sql_id'
ORDER BY child_number, bucket_id;

PAUSE

EXECUTE :id := &nor;

SELECT count(pad) FROM t WHERE id < :id;

SELECT child_number, bucket_id, count
FROM v$sql_cs_histogram 
WHERE sql_id = '&sql_id'
ORDER BY child_number, bucket_id;

PAUSE

EXECUTE :id := &nor;

SELECT count(pad) FROM t WHERE id < :id;

SELECT child_number, bucket_id, count
FROM v$sql_cs_histogram 
WHERE sql_id = '&sql_id'
ORDER BY child_number, bucket_id;

PAUSE

REM
REM Cleanup
REM

UNDEFINE sql_id
UNDEFINE nor

DROP TABLE t;
PURGE TABLE t;
