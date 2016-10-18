SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: profile_import.sql
REM Author......: Christian Antognini
REM Date........: August 2013
REM Description.: This script shows how to manually import a SQL profile.
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
SET LONG 1000000
SET PAGESIZE 100
SET LINESIZE 100

COLUMN report FORMAT A100
COLUMN executions FORMAT 999999999
COLUMN fetches FORMAT 999999999
COLUMN plan_table_output FORMAT A100

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t PURGE;

BEGIN
  dbms_sqltune.drop_sql_profile(name=>'import');
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE t (id, pad, CONSTRAINT t_pk PRIMARY KEY (id)) AS
SELECT rownum, lpad('*',1000,'*')
FROM dual
CONNECT BY level <= 1000
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

ALTER SESSION SET optimizer_mode = all_rows;
ALTER SESSION SET "_optimizer_use_feedback" = FALSE;
ALTER SESSION SET optimizer_adaptive_features = FALSE;

PAUSE

REM
REM Import SQL profile
REM

BEGIN
  dbms_sqltune.import_sql_profile(
    name        => 'import',
    description => 'SQL profile created manually',
    category    => 'TEST',
    sql_text    => 'SELECT * FROM t ORDER BY id',
    profile     => sqlprof_attr('first_rows(42)','optimizer_features_enable(default)'),
    replace     => FALSE,
    force_match => FALSE
  );
END;
/

PAUSE

REM
REM Test the SQL profile
REM

ALTER SESSION SET sqltune_category = DEFAULT;

EXPLAIN PLAN FOR
SELECT * FROM t ORDER BY id;

SELECT * FROM table(dbms_xplan.display);

PAUSE

ALTER SESSION SET sqltune_category = TEST;

EXPLAIN PLAN FOR
SELECT * FROM t ORDER BY id;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM Cleanup
REM

BEGIN
  dbms_sqltune.drop_sql_profile(name=>'import');
END;
/

DROP TABLE t PURGE;
