SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: baseline_evolution_delete.sql
REM Author......: Christian Antognini
REM Date........: June 2010
REM Description.: This script shows how a SQL plan baseline based on a DELETE
REM               statement is evolved. It is basically used to know whether
REM               the DELETE statement is actually run.
REM Notes.......: This script requires Oracle Database 11g.
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

COLUMN plan_table_output FORMAT A80
COLUMN sql_text FORMAT A55
COLUMN sql_handle FORMAT A25

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t PURGE;

CREATE TABLE t (id, n, pad, CONSTRAINT t_pk PRIMARY KEY (id))
AS 
SELECT rownum, mod(rownum,100), rpad('*',500,'*')
FROM dual
CONNECT BY level <= 10000;

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

DELETE /*+ gather_plan_statistics */ t WHERE n = 42;

ROLLBACK;

DELETE /*+ gather_plan_statistics */ t WHERE n = 42;

ROLLBACK;

ALTER SESSION SET optimizer_capture_sql_plan_baselines = FALSE;

CREATE INDEX i ON t (n);

DELETE /*+ gather_plan_statistics */ t WHERE n = 42;

ROLLBACK;

DELETE /*+ gather_plan_statistics */ t WHERE n = 42;

ROLLBACK;

PAUSE

REM
REM Display the baseline incl. the execution plans
REM

SELECT sql_handle, sql_text, enabled, accepted 
FROM dba_sql_plan_baselines
WHERE creator = user
AND sql_text LIKE 'DELETE%';

PAUSE

SELECT * FROM table(dbms_xplan.display_sql_plan_baseline('&sql_handle', NULL, 'basic'));

PAUSE

REM
REM Evolve the baseline 
REM

execute dbms_monitor.session_trace_enable(plan_stat=>'ALL_EXECUTIONS')

SELECT dbms_spm.evolve_sql_plan_baseline(
         sql_handle => '&sql_handle',
         plan_name  => '',
         time_limit => 10,
         verify     => 'yes',
         commit     => 'yes'
       ) 
FROM dual;

execute dbms_monitor.session_trace_disable

SELECT value
FROM v$diag_info
WHERE name = 'Default Trace File';

PAUSE

SELECT sql_handle, sql_text, enabled, accepted 
FROM dba_sql_plan_baselines
WHERE creator = user
AND sql_text LIKE 'DELETE%';

PAUSE

REM
REM Check whether the data is still available
REM

SELECT count(*)
FROM t
WHERE n = 42;

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
