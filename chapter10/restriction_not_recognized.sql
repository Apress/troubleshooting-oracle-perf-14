SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: restriction_not_recognized.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script generates the output used for showing how to
REM               recognize inefficient execution plans, by checking actual
REM               cardinalities.
REM Notes.......: This script requires Oracle Database 10g Release 1 or later.
REM               The execution plan generated with the SQL profile depends on 
REM               the database engine version.
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
SET PAGESIZE 120
SET LINESIZE 120

COLUMN report FORMAT A100

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

execute dbms_sqltune.drop_sql_profile(name=>'restriction_not_recognized.sql');

DROP TABLE t1;

CREATE TABLE t1 (id, pad)
AS 
SELECT *
FROM (
  SELECT rownum AS id, lpad('*',100,'*')
  FROM dual
  CONNECT BY level <= 10000
)
WHERE mod(id,2) = 0;

INSERT INTO t1 SELECT id+10000, pad FROM t1;
INSERT INTO t1 SELECT id+20000, pad FROM t1;
COMMIT;

DROP TABLE t2;
CREATE TABLE t2 
AS
SELECT id, id AS t1_id, pad
FROM t1;

INSERT INTO t2 SELECT id+40000, id, pad FROM t2;
COMMIT;

DROP TABLE t3;
CREATE TABLE t3
AS
SELECT id+1 AS id, id+1 AS t2_id, pad
FROM t2;

INSERT INTO t3 SELECT id+80000, id, pad FROM t3;
DELETE t3 WHERE rownum <= 100;
INSERT INTO t3 SELECT id, id, pad FROM t2 WHERE id BETWEEN 1200 AND 1399;
COMMIT;

ALTER TABLE t1 ADD CONSTRAINT t1_pk PRIMARY KEY (id);
ALTER TABLE t2 ADD CONSTRAINT t2_pk PRIMARY KEY (id);
ALTER TABLE t3 ADD CONSTRAINT t3_pk PRIMARY KEY (id);
CREATE INDEX t2_t1_id ON t2 (t1_id);
CREATE INDEX t3_t2_id ON t3 (t2_id);

DECLARE
  TYPE t IS VARRAY(100) OF VARCHAR2(30);
  l t := t('T1','T2','T3');
BEGIN
  FOR i IN l.FIRST..l.LAST
  LOOP
    dbms_stats.gather_table_stats(
      ownname=>user, 
      tabname=>l(i), 
      cascade=>FALSE,
      estimate_percent=>100,
      method_opt=>'for all columns size 1',
      no_invalidate=>FALSE);
  END LOOP;
END;
/

ALTER SESSION SET statistics_level = ALL;

PAUSE

REM
REM SQL Trace
REM

execute dbms_monitor.session_trace_enable

SELECT count(t1.pad), count(t2.pad), count(t3.pad)
FROM t1, t2, t3
WHERE t1.id = t2.t1_id AND t2.id = t3.t2_id;

execute dbms_monitor.session_trace_disable

PAUSE

REM
REM EXPLAIN PLAN
REM

EXPLAIN PLAN FOR
SELECT count(t1.pad), count(t2.pad), count(t3.pad)
FROM t1, t2, t3
WHERE t1.id = t2.t1_id AND t2.id = t3.t2_id;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM DBMS_XPLAN Output
REM

SELECT count(t1.pad), count(t2.pad), count(t3.pad)
FROM t1, t2, t3
WHERE t1.id = t2.t1_id AND t2.id = t3.t2_id;

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'runstats_last'));

PAUSE

REM
REM Create a SQL profile to have a better execution plan
REM

VARIABLE g_task_name VARCHAR2(30)
BEGIN
  :g_task_name := dbms_sqltune.create_tuning_task(
                    sql_text => 'SELECT count(t1.pad), count(t2.pad), count(t3.pad) FROM t1, t2, t3 WHERE t1.id = t2.t1_id AND t2.id = t3.t2_id',
                    scope => 'COMPREHENSIVE',
                    time_limit => 42
                  );
  dbms_sqltune.execute_tuning_task(:g_task_name);
END;
/

PAUSE

SELECT dbms_sqltune.report_tuning_task(:g_task_name) report FROM dual;

PAUSE

DECLARE
  l_dummy VARCHAR2(100);
BEGIN
  l_dummy := dbms_sqltune.accept_sql_profile(
               task_name => :g_task_name, 
               name => 'restriction_not_recognized.sql',
               category => 'TEST'
             );
END;
/

PAUSE

REM
REM Test with SQL profile in place
REM

ALTER SESSION SET sqltune_category = TEST;

SELECT count(t1.pad), count(t2.pad), count(t3.pad)
FROM t1, t2, t3
WHERE t1.id = t2.t1_id AND t2.id = t3.t2_id;

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'runstats_last'));

PAUSE

execute dbms_monitor.session_trace_enable
SELECT count(t1.pad), count(t2.pad), count(t3.pad)
FROM t1, t2, t3
WHERE t1.id = t2.t1_id AND t2.id = t3.t2_id;
execute dbms_monitor.session_trace_disable

PAUSE

REM
REM Cleanup
REM

execute dbms_sqltune.drop_tuning_task(:g_task_name);
execute dbms_sqltune.drop_sql_profile(name=>'restriction_not_recognized.sql');

DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
PURGE TABLE t1;
PURGE TABLE t2;
PURGE TABLE t3;
