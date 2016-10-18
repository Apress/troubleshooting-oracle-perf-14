SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: baseline_automatic.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows how the query optimizer automatically
REM               captures a SQL plan baseline.
REM Notes.......: This script requires Oracle Database 11g.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 18.03.2009 Fixed problem that occured the first time the SQL plan baseline
REM            was displayed + Fixed typos in comments
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON
SET LONG 100000 
SET PAGESIZE 100
SET LINESIZE 100

COLUMN plan_table_output FORMAT A80
COLUMN sql_text FORMAT A45
COLUMN sql_handle FORMAT A25 NEW_VALUE sql_handle

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
REM Create a baseline (the query is executed twice because 
REM the first time it is not added to the baseline) and
REM check if it is used
REM

ALTER SESSION SET optimizer_capture_sql_plan_baselines = TRUE;

SELECT count(pad) FROM t WHERE n = 42;

SELECT count(pad) FROM t WHERE n = 42;

ALTER SESSION SET optimizer_capture_sql_plan_baselines = FALSE;

PAUSE

EXPLAIN PLAN FOR SELECT count(pad) FROM t WHERE n = 42;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +note'));

PAUSE

REM
REM Display the baseline
REM

SELECT sql_handle, sql_text, enabled, accepted FROM dba_sql_plan_baselines;

PAUSE

SELECT * FROM table(dbms_xplan.display_sql_plan_baseline('&sql_handle', NULL, 'basic'));

PAUSE

REM
REM Create an index to avoid the full table scan
REM

CREATE INDEX i ON t (n);

PAUSE

REM
REM The index is not used because the baseline is used
REM

EXPLAIN PLAN FOR SELECT count(pad) FROM t WHERE n = 42;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic note'));

PAUSE

REM
REM Execute twice the query... then the query optimizer notices that
REM another execution plan could be used to process the query
REM

SELECT count(pad) FROM t WHERE n = 42;

SELECT count(pad) FROM t WHERE n = 42;

PAUSE

REM
REM The new execution plan is added to the baseline but not accepted
REM

SELECT sql_handle, sql_text, enabled, accepted FROM dba_sql_plan_baselines;

PAUSE

REM
REM Display the execution plans of the baseline
REM

SELECT * FROM table(dbms_xplan.display_sql_plan_baseline('&sql_handle', NULL, 'basic'));

PAUSE

REM
REM Evolve the baseline 
REM

SELECT dbms_spm.evolve_sql_plan_baseline(
         sql_handle => '&sql_handle',
         plan_name  => '',
         time_limit => 10,
         verify     => 'yes',
         commit     => 'yes'
       ) 
FROM dual;

PAUSE

SELECT sql_handle, sql_text, enabled, accepted FROM dba_sql_plan_baselines;

PAUSE

REM
REM Check if the new execution plan is used
REM

EXPLAIN PLAN FOR SELECT count(pad) FROM t WHERE n = 42;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic note'));

PAUSE

REM
REM What happens if the index is dropped?
REM

DROP INDEX i;

PAUSE

EXPLAIN PLAN FOR SELECT count(pad) FROM t WHERE n = 42;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic note'));

PAUSE

REM
REM What happens if the index is recreated?
REM

CREATE INDEX i ON t (n);

PAUSE

EXPLAIN PLAN FOR SELECT count(pad) FROM t WHERE n = 42;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic note'));

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

DROP TABLE t PURGE;

UNDEFINE sql_handle
