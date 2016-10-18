SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: baseline_from_sqlarea2.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows how to manually load a SQL plan baseline
REM               from the library cache. The cursor is identified by the SQL
REM               identifier of the SQL statement associated with it.
REM Notes.......: This script requires Oracle Database 11g.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 05.08.2013 Improvements to avoid user inputs + show outline with dbms_xplan
REM 01.05.2014 Removed restrictions based on systimestamp
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

COLUMN sql_text FORMAT A38
COLUMN sql_handle FORMAT A30 NEW_VALUE sql_handle
COLUMN prev_sql_id NEW_VALUE sql_id
COLUMN enabled FORMAT A7
COLUMN accepted FORMAT A8

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
REM Create a SQL plan baseline based on a SQL identifier
REM

SELECT count(pad) 
FROM t 
WHERE n = 42;

SELECT prev_sql_id, prev_child_number
FROM v$session
WHERE sid = sys_context('userenv','sid');

SELECT child_number, sql_text, plan_hash_value
FROM v$sql
WHERE sql_id = '&sql_id';

SET SERVEROUTPUT ON

DECLARE
  ret PLS_INTEGER;
BEGIN 
  ret := dbms_spm.load_plans_from_cursor_cache(sql_id          => '&sql_id',
                                               plan_hash_value => NULL);
  dbms_output.put_line(ret || ' SQL plan baseline(s) created');
END;
/

SET SERVEROUTPUT OFF

PAUSE

REM
REM Display SQL plan baseline
REM

SELECT sql_handle, sql_text, enabled, accepted 
FROM dba_sql_plan_baselines;

SELECT * 
FROM table(dbms_xplan.display_sql_plan_baseline(sql_handle => '&sql_handle'));

PAUSE

SELECT * 
FROM table(dbms_xplan.display_sql_plan_baseline(sql_handle => '&sql_handle', format => 'basic'));

PAUSE

SELECT * 
FROM table(dbms_xplan.display_sql_plan_baseline(sql_handle => '&sql_handle', format => 'outline'));

PAUSE

REM
REM Cleanup
REM

REM remove all baselines created in the last 15 minutes

DECLARE
  ret PLS_INTEGER;
BEGIN
  FOR c IN (SELECT DISTINCT sql_handle 
            FROM dba_sql_plan_baselines 
            WHERE creator = user)
  LOOP
    ret := dbms_spm.drop_sql_plan_baseline(c.sql_handle);
  END LOOP;
END;
/

DROP TABLE t PURGE;

UNDEFINE sql_handle
UNDEFINE sql_id
