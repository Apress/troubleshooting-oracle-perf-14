SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: baseline_upgrade_10g.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows how to create and export a SQL tuning set
REM               on Oracle Database 10g. It is used along with the script
REM               baseline_upgrade_11g.sql to show how to stabilize execution
REM               plans during an upgrade to Oracle Database 11g or 12c.
REM Notes.......: 1) 10gR2: run baseline_upgrade_10g.sql
REM               2) 11g/12c: run baseline_upgrade_11g.sql
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 29.06.2014 expdp->exp because of bug described in MOS note 1285889.1 +
REM            changed description
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
REM Run few times a test query
REM

SELECT count(pad) FROM t WHERE n = 42;

SELECT count(pad) FROM t WHERE n = 42;

SELECT count(pad) FROM t WHERE n = 42;

PAUSE

REM
REM Create a SQL tuning set containing the test query
REM

DECLARE
  baseline_cursor DBMS_SQLTUNE.SQLSET_CURSOR;
BEGIN
  dbms_sqltune.create_sqlset(
    sqlset_name => '10GR2_SET'
  );
  
  OPEN baseline_cursor FOR
    SELECT value(p)
    FROM table(dbms_sqltune.select_cursor_cache(
                 'sql_id=''2n8tjyr1nthf5''', -- basic_filter
                 NULL,                       -- object_filter
                 NULL, NULL, NULL,           -- ranking_measure1/2/3
                 NULL,                       -- result_percentage
                 NULL,                       -- result_limit
                 'all'                       -- attribute_list
               )) p;
    
  dbms_sqltune.load_sqlset(
    sqlset_name => '10GR2_SET', 
    populate_cursor => baseline_cursor
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
REM Export SQL tuning set
REM

BEGIN
  dbms_sqltune.create_stgtab_sqlset(
    table_name  => 'MY_STGTAB',
    schema_name => user
  );
  dbms_sqltune.pack_stgtab_sqlset(
    sqlset_name          => '10GR2_SET',
    sqlset_owner         => user,
    staging_table_name   => 'MY_STGTAB',
    staging_schema_owner => user
  );
END;
/

PAUSE

REM
REM Export staging table (because of a bug Data Pump does not always work - see MOS note 1285889.1)
REM

REM set environment
REM exp tables=MY_STGTAB

PAUSE

REM
REM Cleanup
REM

execute dbms_sqltune.drop_sqlset('10GR2_SET')

DROP TABLE my_stgtab PURGE;

DROP TABLE t PURGE;
