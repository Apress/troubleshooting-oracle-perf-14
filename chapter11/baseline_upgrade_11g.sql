SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: baseline_upgrade_11g.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows how to import and load a SQL tuning set
REM               into a SQL plan baseline. It is used along with the script
REM               baseline_upgrade_10g.sql to show how to stabilize execution
REM               plans during an upgrade from Oracle Database 10g to Oracle
REM               Database 11g or 12c.
REM Notes.......: 1) 10gR2: run baseline_upgrade_10g.sql
REM               2) 11g/12c: run baseline_upgrade_11g.sql
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 24.06.2010 After import added update to set the owner of the SQL tuning set
REM 29.06.2014 Filter output when selecting dba_sql_plan_baselines +
REM            impdp->imp because of bug described in MOS note 1285889.1 +
REM            because of 12c changed evolution code + changed description
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

COLUMN plan_table_output FORMAT A80
COLUMN sql_text FORMAT A45
COLUMN sql_handle FORMAT A25

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t PURGE;

execute dbms_sqltune.drop_sqlset('10GR2_SET')

DROP TABLE my_stgtab PURGE;

execute dbms_sqltune.drop_sqlset('10GR2_SET')

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
REM Import staging table (because of a bug Data Pump does not always work - see MOS note 1285889.1)
REM

REM set environment
REM imp full=y

PAUSE

REM
REM Import SQL tuning set
REM

BEGIN
  -- This is only necessary when the owner is not the same in both databases 
  UPDATE my_stgtab SET owner = user, parsing_schema_name = user;
  COMMIT;
  
  dbms_sqltune.unpack_stgtab_sqlset(
    sqlset_name          => '10GR2_SET',
    sqlset_owner         => user,
    replace              => FALSE,
    staging_table_name   => 'MY_STGTAB',
    staging_schema_owner => user
  );
END;
/

PAUSE

REM
REM Display content of the SQL tuning set
REM

SELECT * 
FROM table(dbms_xplan.display_sqlset('10GR2_SET', '2n8tjyr1nthf5'));

PAUSE

REM
REM Load baseline from SQL tuning set
REM

DECLARE
  dummy PLS_INTEGER;
BEGIN
  dummy := dbms_spm.load_plans_from_sqlset(sqlset_name => '10GR2_SET');
END;
/

PAUSE

REM
REM The new execution plan is added to the baseline and accepted
REM

SELECT sql_handle, sql_text, enabled, accepted 
FROM dba_sql_plan_baselines
WHERE created > systimestamp - to_dsinterval('0 00:15:00');

PAUSE

REM
REM Display the execution plans of the baseline
REM

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
REM Execute twice the query... then the query optimizer notice that
REM another execution plan could be used to process the query
REM

SELECT count(pad) FROM t WHERE n = 42;

SELECT count(pad) FROM t WHERE n = 42;

PAUSE

REM
REM The new execution plan is added to the baseline but not accepted
REM

SELECT sql_handle, sql_text, enabled, accepted 
FROM dba_sql_plan_baselines
WHERE created > systimestamp - to_dsinterval('0 00:15:00');

PAUSE

REM
REM Display the execution plans of the baseline
REM

SELECT * FROM table(dbms_xplan.display_sql_plan_baseline('&sql_handle', NULL, 'basic'));

PAUSE

REM
REM Evolve the baseline 
REM

VARIABLE ret CLOB

BEGIN
  :ret := dbms_spm.evolve_sql_plan_baseline('&sql_handle');
END;
/

PRINT :ret

PAUSE

SELECT sql_handle, sql_text, enabled, accepted 
FROM dba_sql_plan_baselines
WHERE created > systimestamp - to_dsinterval('0 00:15:00');

PAUSE

REM
REM Check if the new execution plan is used
REM

EXPLAIN PLAN FOR SELECT count(pad) FROM t WHERE n = 42;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic note'));

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

execute dbms_sqltune.drop_sqlset('10GR2_SET')

DROP TABLE my_stgtab PURGE;

DROP TABLE t PURGE;
