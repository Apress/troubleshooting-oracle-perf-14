SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: seed_col_usage.sql
REM Author......: Christian Antognini
REM Date........: June 2014
REM Description.: This script shows that the database engine is able to detect
REM               missing column groups.
REM Notes.......: The script only works as of 11.2.0.2.
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

COLUMN column_name FORMAT A30
COLUMN data_type FORMAT A9
COLUMN hidden_column FORMAT A6
COLUMN data_default FORMAT A35

@../connect.sql

SET SERVEROUTPUT ON

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t PURGE;

CREATE TABLE t AS
SELECT mod(rownum,10) AS val1, mod(rownum,10) AS val2, mod(rownum+1,10) AS val3, mod(rownum+1,10) AS val4
FROM dual
CONNECT BY level <= 1E4;

INSERT INTO t 
SELECT 0, 0, 0, 0
FROM dual 
CONNECT BY level <= 10;

execute dbms_stats.gather_table_stats(ownname => user, tabname => 't', method_opt => 'for all columns size 254')

SELECT *
FROM t
WHERE val1 = 1 AND val2 = 2 AND val3 = 3;

execute dbms_stats.reset_col_usage(ownname => user, tabname => 't')

PAUSE

REM
REM Instruct the query optimizer to record information about predicates
REM specified in WHERE clauses
REM

BEGIN
  dbms_stats.seed_col_usage(sqlset_name => NULL,
                            owner_name => NULL,
                            time_limit => 30);
END;
/

PAUSE

REM
REM Let the query optimizer hard parse some queries
REM

SELECT *
FROM t
WHERE val1 = 1 AND val2 = 2 AND val3 = 3;

EXPLAIN PLAN FOR
SELECT *
FROM t
WHERE val1 = 8 AND val2 = 8;

SELECT * FROM table(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT *
FROM t
WHERE val1 = 8 AND val3 = 8;

SELECT * FROM table(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT val2, val3, count(*)
FROM t
GROUP BY val2, val3;

SELECT * FROM table(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT DISTINCT val3, val4
FROM t;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM Review utilization pattern
REM

SELECT dbms_stats.report_col_usage(ownname => user, tabname => 't')
FROM dual;

PAUSE

REM
REM Create extensions
REM

SELECT dbms_stats.create_extended_stats(ownname => user, tabname => 't')
FROM dual;

PAUSE

SELECT column_name, data_type, hidden_column, data_default
FROM user_tab_cols
WHERE table_name = 'T'
ORDER BY column_id;

PAUSE

REM
REM Gather object statistics (the previous call does not gather them)
REM

BEGIN
  dbms_stats.gather_table_stats(ownname => user, 
                                tabname => 't', 
                                method_opt => 'for all columns size 254');
END;
/

PAUSE

REM
REM Check whether the extensions are improving the estimations
REM

EXPLAIN PLAN FOR
SELECT *
FROM t
WHERE val1 = 8 AND val2 = 8;

SELECT * FROM table(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT *
FROM t
WHERE val1 = 8 AND val3 = 8;

SELECT * FROM table(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT val2, val3, count(*)
FROM t
GROUP BY val2, val3;

SELECT * FROM table(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT DISTINCT val3, val4
FROM t;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM Clean up
REM

DROP TABLE t PURGE;
