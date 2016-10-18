SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: baseline_clone.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows how to move SQL plan baselines between two
REM               databases.
REM Notes.......: This script requires Oracle Database 11g.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 06.08.2013 Improvements to avoid user inputs + 
REM            script renamed (the old name was clone_baseline.sql)
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

@../connect.sql

COLUMN sql_handle FORMAT A30 NEW_VALUE sql_handle
COLUMN plan_name FORMAT A30 NEW_VALUE plan_name

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE mystgtab PURGE;

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

BEGIN
  dbms_spm.create_stgtab_baseline(
    table_name      => 'MYSTGTAB',
    table_owner     => user,
    tablespace_name => 'USERS'
  );
END;
/

PAUSE

REM
REM Create a baseline 
REM

ALTER SESSION SET optimizer_capture_sql_plan_baselines = TRUE;

SELECT count(pad) FROM t WHERE n = 42;

SELECT count(pad) FROM t WHERE n = 42;

ALTER SESSION SET optimizer_capture_sql_plan_baselines = FALSE;

SELECT sql_handle, plan_name, sql_text, enabled, accepted
FROM dba_sql_plan_baselines;

PAUSE

REM
REM "Export" SQL plan baseline
REM

SET SERVEROUTPU ON

DECLARE
  ret PLS_INTEGER;
BEGIN
  ret := dbms_spm.pack_stgtab_baseline(
           table_name  => 'MYSTGTAB',
           table_owner => user,
           sql_handle  => '&sql_handle',
           plan_name   => '&plan_name'
         );
  dbms_output.put_line(ret || ' SQL plan baseline(s) exported from data dictionary');
END;
/

PAUSE

REM
REM Here the staging table should be moved to another database,
REM in this case the SQL plan baseline is simply dropped to 
REM reuse it in the current database
REM

PAUSE

DECLARE
  ret PLS_INTEGER;
BEGIN
  ret := dbms_spm.drop_sql_plan_baseline(
           sql_handle  => '&sql_handle',
           plan_name   => '&plan_name'
       );
  dbms_output.put_line(ret || ' SQL plan baseline(s) dropped');
END;
/

PAUSE

REM
REM "Inport" SQL plan baseline
REM

DECLARE
  ret PLS_INTEGER;
BEGIN
  ret := dbms_spm.unpack_stgtab_baseline(
           table_name  => 'MYSTGTAB',
           table_owner => user,
           sql_text  => '%FROM t%'
         );
  dbms_output.put_line(ret || ' SQL plan baseline(s) imported into data dictionary');
END;
/

SET SERVEROUTPU OFF

SELECT sql_handle, plan_name, sql_text, enabled, accepted
FROM dba_sql_plan_baselines;

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

DROP TABLE mystgtab PURGE;

DROP TABLE t PURGE;

UNDEFINE sql_handle
UNDEFINE plan_name
