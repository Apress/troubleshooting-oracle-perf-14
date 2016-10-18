SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: baseline_from_sqlset.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows how to manually load a SQL plan baseline
REM               from a SQL tuning set.
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

COLUMN sql_text FORMAT A30
COLUMN sql_handle FORMAT A30

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
REM Run few times a test query
REM

SELECT count(pad) 
FROM t 
WHERE n = 42;

SELECT count(pad) 
FROM t 
WHERE n = 42;

SELECT count(pad) 
FROM t 
WHERE n = 42;

PAUSE

REM
REM Create a SQL tuning set containing the test query
REM

DECLARE
  baseline_cursor DBMS_SQLTUNE.SQLSET_CURSOR;
BEGIN
  dbms_sqltune.create_sqlset(
    sqlset_name => 'test_sqlset'
  );
  
  OPEN baseline_cursor FOR
    SELECT value(p)
    FROM table(dbms_sqltune.select_cursor_cache(
                 basic_filter   => 'sql_id=''2y5r75r8y3sj0''',
                 attribute_list => 'all'
               )) p;
    
  dbms_sqltune.load_sqlset(
    sqlset_name     => 'test_sqlset', 
    populate_cursor => baseline_cursor
  );
END;
/

PAUSE

REM
REM Display content of the SQL tuning set
REM

SELECT * 
FROM table(dbms_xplan.display_sqlset('test_sqlset', '2y5r75r8y3sj0'));

PAUSE

REM
REM Load baseline from SQL tuning set
REM

DECLARE
  ret PLS_INTEGER;
BEGIN
  ret := dbms_spm.load_plans_from_sqlset(
           sqlset_name  => 'test_sqlset',
           sqlset_owner => user
         );
END;
/

SELECT sql_handle, sql_text, enabled, accepted 
FROM dba_sql_plan_baselines
WHERE created > systimestamp - to_dsinterval('0 00:15:00');

PAUSE

REM
REM Clenaup
REM

REM remove all baselines created in the last 15 minutes

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

BEGIN
  dbms_sqltune.drop_sqlset(
    sqlset_name  => 'test_sqlset',
    sqlset_owner => user
  );
END;
/

DROP TABLE t PURGE;
