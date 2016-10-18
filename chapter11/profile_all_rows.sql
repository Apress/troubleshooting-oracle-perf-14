SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: profile_all_rows.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows how it is possible to switch the optimizer
REM               mode from rule to all_rows with a SQL profile.
REM Notes.......: This scripts only works in Oracle Database 10g.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 08.03.2009 Added query to show SQL profile in 11g
REM 31.07.2013 Script renamed (the old name was all_rows.sql)
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON
SET LONG 1000000
SET LINESIZE 100
SET PAGESIZE 100

COLUMN report FORMAT A100

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t PURGE;

BEGIN
  dbms_sqltune.drop_sql_profile(name=>'all_rows');
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE t (id, pad, CONSTRAINT t_pk PRIMARY KEY (id)) AS
SELECT rownum, lpad('*',100,'*')
FROM dual
CONNECT BY level <= 10000
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

PAUSE

REM
REM Set optimizer mode
REM

ALTER SESSION SET optimizer_mode = all_rows;

PAUSE

REM
REM Let tune it...
REM

VARIABLE g_task_name VARCHAR2(30)
BEGIN
  :g_task_name := dbms_sqltune.create_tuning_task(
                    sql_text => 'SELECT /*+ rule */ * FROM T ORDER BY ID',
                    scope => 'COMPREHENSIVE',
                    time_limit => 42
                  );
  dbms_sqltune.execute_tuning_task(:g_task_name);
END;
/

PAUSE

SELECT dbms_sqltune.report_tuning_task(:g_task_name) report 
FROM dual;

PAUSE

BEGIN
  dbms_sqltune.accept_sql_profile(
    task_name => :g_task_name, 
    name => 'all_rows',
    category => 'TEST',
    force_match => TRUE,
    replace => TRUE
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
WHERE p.sp_name = 'all_rows'
AND p.signature = a.signature
AND p.category = a.category;

REM 11g

SELECT extractValue(value(h),'.') AS hint
FROM sys.sqlobj$data od, sys.sqlobj$ so,
     table(xmlsequence(extract(xmltype(od.comp_data),'/outline_data/hint'))) h
WHERE so.name = 'all_rows'
AND so.signature = od.signature
AND so.category = od.category
AND so.obj_type = od.obj_type
AND so.plan_id = od.plan_id;

PAUSE

REM
REM Test the SQL profile
REM

SET AUTOTRACE TRACE EXP

ALTER SESSION SET sqltune_category = DEFAULT;

SELECT /*+ rule */ * FROM t ORDER BY id;

PAUSE

ALTER SESSION SET sqltune_category = TEST;

SELECT /*+ rule */ * FROM t ORDER BY id;

SET AUTOTRACE OFF

PAUSE

REM
REM Cleanup
REM

BEGIN
  dbms_sqltune.drop_tuning_task(:g_task_name);
  dbms_sqltune.drop_sql_profile(name=>'all_rows');
END;
/

DROP TABLE t PURGE;
