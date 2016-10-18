SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: full_scan_hwm.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows that full table scans read all blocks up to
REM               the high watermark.
REM Notes.......: Oracle Database 10g is required to run this script.
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
SET FEEDBACK ON
SET VERIFY OFF
SET SCAN ON

COLUMN pad FORMAT A10 TRUNCATE

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t;

CREATE TABLE t (
  id NUMBER, 
  n1 NUMBER, 
  n2 NUMBER, 
  pad VARCHAR2(4000)
);

execute dbms_random.seed(0)

INSERT INTO t
SELECT rownum AS id,
       1+mod(rownum,251) AS n1,
       1+mod(rownum,251) AS n2,
       dbms_random.string('p',255) AS pad
FROM dual
CONNECT BY level <= 10000
ORDER BY dbms_random.value;

BEGIN
  dbms_stats.gather_table_stats(
    ownname          => user,
    tabname          => 'T',
    estimate_percent => 100,
    method_opt       => 'for all columns size skewonly',
    cascade          => TRUE
  );
END;
/

PAUSE

ALTER SESSION SET statistics_level = all;

REM
REM Display the initial status
REM

SELECT /*+ full(t) */ * FROM t WHERE n2 = 19;

SELECT last_output_rows, last_cr_buffer_gets, last_cu_buffer_gets
FROM v$session s, v$sql_plan_statistics p
WHERE s.prev_sql_id = p.sql_id
AND s.prev_child_number = p.child_number
AND s.sid = sys_context('userenv','sid')
AND p.operation_id = 1;

PAUSE

REM
REM Delete almost all rows and retest
REM

DELETE t WHERE n2 <> 19;

PAUSE

SELECT /*+ full(t) */ * FROM t WHERE n2 = 19;

SELECT last_output_rows, last_cr_buffer_gets, last_cu_buffer_gets
FROM v$session s, v$sql_plan_statistics p
WHERE s.prev_sql_id = p.sql_id
AND s.prev_child_number = p.child_number
AND s.sid = sys_context('userenv','sid')
AND p.operation_id = 1;

PAUSE

REM
REM Reorganize the table and retest
REM (this works in Oracle Database 10g only)
REM

ALTER TABLE t ENABLE ROW MOVEMENT;
ALTER TABLE t SHRINK SPACE;

PAUSE

SELECT /*+ full(t) */ * FROM t WHERE n2 = 19;

SELECT last_output_rows, last_cr_buffer_gets, last_cu_buffer_gets
FROM v$session s, v$sql_plan_statistics p
WHERE s.prev_sql_id = p.sql_id
AND s.prev_child_number = p.child_number
AND s.sid = sys_context('userenv','sid')
AND p.operation_id = 1;

PAUSE

REM
REM Cleanup
REM

DROP TABLE t;
PURGE TABLE t;
