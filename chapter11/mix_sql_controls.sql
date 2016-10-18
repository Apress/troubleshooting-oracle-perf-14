SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: mix_sql_controls.sql
REM Author......: Christian Antognini
REM Date........: August 2013
REM Description.: This script shows what happens when, for a given SQL 
REM               statement, several SQL controls (stored outline, SQL profile,
REM               SQL plan baseline and SQL patch) are enabled at the same time.
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
REM Create and test stored outline
REM

CREATE OR REPLACE OUTLINE "mix_stored_outline"
FOR CATEGORY test
ON SELECT * FROM t ORDER BY id;

PAUSE

ALTER SESSION SET use_stored_outlines = DEFAULT;

EXPLAIN PLAN FOR
SELECT * FROM t ORDER BY id;

SELECT * FROM table(dbms_xplan.display);

PAUSE

ALTER SESSION SET use_stored_outlines = TEST;

EXPLAIN PLAN FOR
SELECT * FROM t ORDER BY id;

SELECT * FROM table(dbms_xplan.display);

PAUSE

ALTER SESSION SET use_stored_outlines = DEFAULT;

REM
REM Import and test SQL profile
REM

BEGIN
  dbms_sqltune.import_sql_profile(
    name        => 'mix_sql_profile',
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

ALTER SESSION SET sqltune_category = DEFAULT;

BEGIN
  dbms_sqltune.alter_sql_profile(
    name           => 'mix_sql_profile', 
    attribute_name => 'category',
    value          => 'DUMMY'
  );
END;
/

PAUSE

REM
REM Create and test SQL plan baseline
REM

ALTER SESSION SET optimizer_capture_sql_plan_baselines = TRUE;

SET TERMOUT OFF
SELECT * FROM t ORDER BY id;
SELECT * FROM t ORDER BY id;
SET TERMOUT ON

ALTER SESSION SET optimizer_capture_sql_plan_baselines = FALSE;

PAUSE

ALTER SESSION SET optimizer_use_sql_plan_baselines = FALSE;

EXPLAIN PLAN FOR
SELECT * FROM t ORDER BY id;

SELECT * FROM table(dbms_xplan.display);

PAUSE

ALTER SESSION SET optimizer_use_sql_plan_baselines = TRUE;

EXPLAIN PLAN FOR
SELECT * FROM t ORDER BY id;

SELECT * FROM table(dbms_xplan.display);

PAUSE

ALTER SESSION SET optimizer_use_sql_plan_baselines = FALSE;

REM
REM Import SQL patch
REM

BEGIN
  sys.dbms_sqldiag_internal.i_create_patch(
    sql_text    => 'SELECT * FROM t ORDER BY id',
    hint_text   => 'opt_param(''optimizer_index_cost_adj'' 1)',
    name        => 'mix_sql_patch',
    description => 'SQL patch created manually',
    category    => 'TEST'
  );
END;
/

PAUSE

REM
REM Test SQL patch
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

ALTER SESSION SET sqltune_category = DEFAULT;

REM
REM Enable stored outline, SQL profile, SQL plan baseline and SQL patch - which one is used? 
REM

ALTER SESSION SET use_stored_outlines = TEST;
ALTER SESSION SET sqltune_category = TEST;
ALTER SESSION SET optimizer_use_sql_plan_baselines = TRUE;

BEGIN
  dbms_sqltune.alter_sql_profile(
    name           => 'mix_sql_profile', 
    attribute_name => 'category',
    value          => 'TEST'
  );
END;
/

EXPLAIN PLAN FOR
SELECT * FROM t ORDER BY id;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM Disable stored outline

ALTER SESSION SET use_stored_outlines = DEFAULT;

EXPLAIN PLAN FOR
SELECT * FROM t ORDER BY id;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM Cleanup
REM

DROP OUTLINE "mix_stored_outline";

BEGIN
  dbms_sqltune.drop_sql_profile(name=>'mix_sql_profile');
END;
/

DECLARE
  l_sql_handle dba_sql_plan_baselines.sql_handle%TYPE;
  l_ret PLS_INTEGER;
  CURSOR c IS
    SELECT sql_handle
    FROM dba_sql_plan_baselines
    WHERE creator = user
    ORDER BY created DESC;
BEGIN
  OPEN c;
  FETCH c INTO l_sql_handle;
  CLOSE c;
  IF l_sql_handle IS NOT NULL
  THEN
    l_ret := dbms_spm.drop_sql_plan_baseline(sql_handle => l_sql_handle);
  END IF;
END;
/

BEGIN
  dbms_sqldiag.drop_sql_patch(name=>'mix_sql_patch');
END;
/

DROP TABLE t PURGE;
