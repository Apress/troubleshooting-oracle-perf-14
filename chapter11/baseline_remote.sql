SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: baseline_remote.sql
REM Author......: Christian Antognini
REM Date........: April 2014
REM Description.: This script shows that a SQL plan baseline is not created for
REM               a SQL statement referencing a remote table.
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
SET LONG 1000000
SET PAGESIZE 100
SET LINESIZE 100

COLUMN report FORMAT A120
COLUMN executions FORMAT 999999999
COLUMN fetches FORMAT 999999999
COLUMN plan_table_output FORMAT A100

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t PURGE;

BEGIN
  dbms_sqltune.drop_sql_profile(name=>'import');
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE t (id, pad, CONSTRAINT t_pk PRIMARY KEY (id)) AS
SELECT rownum, lpad('*',1000,'*')
FROM dual
CONNECT BY level <= 1000
ORDER BY mod(rownum,23);

BEGIN
  dbms_stats.gather_table_stats(
    ownname => user,
    tabname => 'T',
    estimate_percent => 100,
    method_opt => 'FOR ALL COLUMNS SIZE 1',
    cascade => TRUE
  );
END;
/

DROP DATABASE LINK loopback;

CREATE DATABASE LINK loopback
CONNECT TO &user IDENTIFIED BY &password
USING '&connect_string';

ALTER SESSION SET "_optimizer_use_feedback" = FALSE;
ALTER SESSION SET optimizer_adaptive_features = FALSE;

PAUSE

REM
REM Create and test SQL plan baseline - LOCAL
REM

ALTER SESSION SET optimizer_capture_sql_plan_baselines = TRUE;

ALTER SESSION SET optimizer_mode = first_rows_1;

SET TERMOUT OFF
SELECT * FROM t t1, t t2 WHERE t1.id = t2.id+1 ORDER BY t1.id;
SELECT * FROM t t1, t t2 WHERE t1.id = t2.id+1 ORDER BY t1.id;
SET TERMOUT ON

ALTER SESSION SET optimizer_mode = all_rows;

ALTER SESSION SET optimizer_capture_sql_plan_baselines = FALSE;

PAUSE

ALTER SESSION SET optimizer_use_sql_plan_baselines = TRUE;

EXPLAIN PLAN FOR
SELECT * FROM t t1, t t2 WHERE t1.id = t2.id+1 ORDER BY t1.id;

SELECT * FROM table(dbms_xplan.display);

PAUSE

ALTER SESSION SET optimizer_use_sql_plan_baselines = FALSE;

PAUSE

EXPLAIN PLAN FOR
SELECT * FROM t t1, t t2 WHERE t1.id = t2.id+1 ORDER BY t1.id;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM Create and test SQL plan baseline - REMOTE
REM

ALTER SESSION SET optimizer_capture_sql_plan_baselines = TRUE;

ALTER SESSION SET optimizer_mode = first_rows_1;

SET TERMOUT OFF
SELECT * FROM t t1, t@loopback t2 WHERE t1.id = t2.id+1 ORDER BY t1.id;
SELECT * FROM t t1, t@loopback t2 WHERE t1.id = t2.id+1 ORDER BY t1.id;
SET TERMOUT ON

ALTER SESSION SET optimizer_mode = all_rows;

ALTER SESSION SET optimizer_capture_sql_plan_baselines = FALSE;

PAUSE

ALTER SESSION SET optimizer_use_sql_plan_baselines = TRUE;

EXPLAIN PLAN FOR
SELECT * FROM t t1, t@loopback t2 WHERE t1.id = t2.id+1 ORDER BY t1.id;

SELECT * FROM table(dbms_xplan.display);

PAUSE

ALTER SESSION SET optimizer_use_sql_plan_baselines = FALSE;

PAUSE

EXPLAIN PLAN FOR
SELECT * FROM t t1, t@loopback t2 WHERE t1.id = t2.id+1 ORDER BY t1.id;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM Cleanup
REM

DECLARE
  l_sql_handle dba_sql_plan_baselines.sql_handle%TYPE;
  l_ret PLS_INTEGER;
  CURSOR c IS
    SELECT sql_handle
    FROM dba_sql_plan_baselines
    WHERE creator = user
    ORDER BY created DESC;
BEGIN
  OPEN c;
  FETCH c INTO l_sql_handle;
  CLOSE c;
  IF l_sql_handle IS NOT NULL
  THEN
    l_ret := dbms_spm.drop_sql_plan_baseline(sql_handle => l_sql_handle);
  END IF;
END;
/

DROP TABLE t PURGE;
