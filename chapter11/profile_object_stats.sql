SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: profile_object_stats.sql
REM Author......: Christian Antognini
REM Date........: August 2013
REM Description.: This script shows how it is possible to provide object
REM               statistics to the query optimizer through a SQL profile.
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
SET LONG 10000000
SET PAGESIZE 1000
SET LINESIZE 150

COLUMN report FORMAT A150

@../connect.sql

ALTER SESSION SET optimizer_dynamic_sampling = 0;
ALTER SESSION SET "_optimizer_use_feedback" = FALSE;
ALTER SESSION SET optimizer_adaptive_features = FALSE;

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t1 CASCADE CONSTRAINTS PURGE;
DROP TABLE t2 CASCADE CONSTRAINTS PURGE;

CREATE TABLE t1 (id, col1, col2, pad, CONSTRAINT t1_pk PRIMARY KEY (id))
AS 
SELECT rownum, CASE WHEN rownum>500 THEN 666 ELSE rownum END, rownum, lpad('*',1000,'*')
FROM dual
CONNECT BY level <= 10000;

CREATE INDEX t1_col1_col2_i ON t1 (col1, col2);

CREATE TABLE t2 (id, col1, col2, pad, CONSTRAINT t2_pk PRIMARY KEY (id)) AS 
SELECT id, col1, col2, pad
FROM t1
WHERE mod(id,2) = 0;

BEGIN
  dbms_stats.gather_table_stats(
    ownname => user,
    tabname => 'T1',
    estimate_percent => 100,
    method_opt => 'for all columns size 1',
    cascade => TRUE
  );
  dbms_stats.delete_table_stats(
    ownname => user,
    tabname => 'T2'
  );
END;
/

BEGIN
  dbms_sqltune.drop_sql_profile(
    name   => 'opt_estimate',
    ignore => TRUE
  );
END;
/

PAUSE

REM
REM let tune it...
REM

VARIABLE g_task_name VARCHAR2(30)
BEGIN
  :g_task_name := dbms_sqltune.create_tuning_task(
                    sql_text => q'[SELECT * FROM t1, t2 WHERE t1.col1 = 666 AND t1.col2 > 42 AND t1.id = t2.id]',
                    scope => 'COMPREHENSIVE',
                    time_limit => 42
                  );
  dbms_sqltune.execute_tuning_task(:g_task_name);
END;
/

PAUSE

SELECT dbms_sqltune.report_tuning_task(:g_task_name) AS report FROM dual;

PAUSE

VARIABLE g_sql_profile VARCHAR2(30)

BEGIN
   dbms_sqltune.accept_sql_profile(
     task_name   => :g_task_name, 
     task_owner  => user,
     name        => 'opt_estimate',
     category    => 'TEST',
     force_match => TRUE,
     replace     => TRUE
   );
END;
/

PAUSE

REM
REM Display SQL profile hints
REM

REM 10g

SELECT attr_val
FROM sys.sqlprof$ p, sys.sqlprof$attr a
WHERE p.sp_name = 'opt_estimate'
AND p.signature = a.signature
AND p.category = a.category;

REM 11g/12c

SELECT extractValue(value(h),'.') AS hint
FROM sys.sqlobj$data od, sys.sqlobj$ so,
     table(xmlsequence(extract(xmltype(od.comp_data),'/outline_data/hint'))) h
WHERE so.name = 'opt_estimate'
AND so.signature = od.signature
AND so.category = od.category
AND so.obj_type = od.obj_type
AND so.plan_id = od.plan_id;

PAUSE

REM
REM Cleanup
REM

BEGIN
  dbms_sqltune.drop_tuning_task(:g_task_name);
  dbms_sqltune.drop_sql_profile(name=>'opt_estimate');
END;
/

DROP TABLE t1 CASCADE CONSTRAINTS PURGE;
DROP TABLE t2 CASCADE CONSTRAINTS PURGE;
