SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: baseline_from_sqlarea1.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows how to manually load a SQL plan baseline
REM               from the library cache. The cursor is identified by the text
REM               of the SQL statement associated with it.
REM Notes.......: This script requires Oracle Database 11g.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 05.08.2013 Improvements to avoid user inputs + show outline with dbms_xplan
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

COLUMN sql_text FORMAT A33
COLUMN sql_handle FORMAT A30 NEW_VALUE sql_handle
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
REM Create several SQL plan baselines based on the text of the SQL statement 
REM

SELECT /* MySqlStm */ count(pad) 
FROM t 
WHERE n = 6;

SELECT /* MySqlStm */ count(pad) 
FROM t 
WHERE n = 19;

SELECT /* MySqlStm */ count(pad) 
FROM t 
WHERE n = 28;

SET SERVEROUTPUT ON

DECLARE
  ret PLS_INTEGER;
BEGIN 
  ret := dbms_spm.load_plans_from_cursor_cache(attribute_name  => 'sql_text',
                                               attribute_value => '%/* MySqlStm */%');
  dbms_output.put_line(ret || ' SQL plan baseline(s) created');
END;
/

SET SERVEROUTPUT OFF

PAUSE

REM
REM Display SQL plan baselines
REM

SELECT sql_handle, sql_text, enabled, accepted 
FROM dba_sql_plan_baselines
WHERE created > systimestamp - to_dsinterval('0 00:15:00');

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
            WHERE creator = user
            AND created > systimestamp - to_dsinterval('0 00:15:00'))
  LOOP
    ret := dbms_spm.drop_sql_plan_baseline(c.sql_handle);
  END LOOP;
END;
/

DROP TABLE t PURGE;

UNDEFINE sql_handle
