SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: baseline_unreproducible.sql
REM Author......: Christian Antognini
REM Date........: August 2013
REM Description.: This script shows what happens when the plan stored in a SQL
REM               plan baseline is unreproducible.
REM Notes.......: This script requires Oracle Database 11g/12c.
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
SET LONG 100000 
SET PAGESIZE 100
SET LINESIZE 100

COLUMN plan_table_output FORMAT A100
COLUMN sql_handle FORMAT A25 NEW_VALUE sql_handle
COLUMN sql_text FORMAT A40

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t PURGE;

CREATE TABLE t (id, n, pad, CONSTRAINT t_pk PRIMARY KEY (id))
AS 
SELECT rownum, rownum, rpad('*',500,'*')
FROM dual
CONNECT BY level <= 1000;

CREATE INDEX i ON t (n);

BEGIN
  dbms_stats.gather_table_stats(
    ownname => user, 
    tabname => 't', 
    estimate_percent => 100, 
    method_opt => 'for all columns size 254',
    cascade => TRUE
  );
END;
/

PAUSE

REM
REM Create SQL plan baseline
REM

ALTER SESSION SET optimizer_capture_sql_plan_baselines = TRUE;

SELECT count(pad) FROM t WHERE n = 42;

SELECT count(pad) FROM t WHERE n = 42;

ALTER SESSION SET optimizer_capture_sql_plan_baselines = FALSE;

PAUSE

EXPLAIN PLAN FOR SELECT count(pad) FROM t WHERE n = 42;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic note'));

PAUSE

REM
REM Display SQL plan baseline
REM

SELECT *
FROM (
  SELECT sql_handle, sql_text, accepted
  FROM dba_sql_plan_baselines 
  ORDER BY created DESC
)
WHERE rownum = 1;

PAUSE

SELECT * FROM table(dbms_xplan.display_sql_plan_baseline('&sql_handle'));

PAUSE

REM
REM What happens if the execution plan is unreproducible?
REM

DROP INDEX i;

PAUSE

EXPLAIN PLAN FOR SELECT count(pad) FROM t WHERE n = 42;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic note'));

PAUSE

SELECT * FROM table(dbms_xplan.display_sql_plan_baseline('&sql_handle'));

PAUSE

DROP TABLE t PURGE;

PAUSE

SELECT * FROM table(dbms_xplan.display_sql_plan_baseline('&sql_handle'));

PAUSE

REM
REM Cleanup
REM

REM Remove all baselines created in the last 15 minutes

DECLARE
  ret PLS_INTEGER;
BEGIN
  FOR c IN (SELECT DISTINCT sql_handle 
            FROM dba_sql_plan_baselines 
            WHERE creator = user
            AND created > systimestamp - to_dsinterval('0 00:15:00'))
  LOOP
    ret := dbms_spm.drop_sql_plan_baseline(c.sql_handle);
  END LOOP;
END;
/

UNDEFINE sql_handle
