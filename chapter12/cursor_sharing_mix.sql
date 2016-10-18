SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: cursor_sharing_mix.sql
REM Author......: Christian Antognini
REM Date........: March 2014
REM Description.: This script shows that literal replacement does not always 
REM               occur for SQL statements containing both bind variables and
REM               literals. This is not a bug, it is a design decision.
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

@../connect.sql

SET ECHO ON

COLUMN sql_text FORMAT A65 WRAP

REM
REM Setup environment
REM

ALTER SYSTEM FLUSH SHARED_POOL;

ALTER SESSION SET cursor_sharing = force;

PAUSE

REM
REM SQL
REM

VARIABLE dummy VARCHAR2(1)
EXECUTE :dummy := 'X';

SELECT /*+ cs0 */ dummy FROM dual WHERE 1=1;
SELECT /*+ cs0 */ dummy FROM dual WHERE 2=2;
SELECT /*+ cs0 */ dummy FROM dual WHERE 3=3 AND dummy = :dummy;
SELECT /*+ cs0 */ dummy FROM dual WHERE 4=4 AND dummy = :dummy;

PAUSE

REM the replacement takes place for both queries

SELECT executions, sql_text 
FROM v$sql 
WHERE sql_text LIKE 'SELECT /*+ cs0 */%'
ORDER BY executions, sql_text;

PAUSE

REM
REM static SQL
REM

DECLARE
  l_dummy dual.dummy%TYPE := 'X';
BEGIN
  SELECT /*+ cs1 */ dummy INTO l_dummy FROM dual WHERE 11=11;
  SELECT /*+ cs1 */ dummy INTO l_dummy FROM dual WHERE 12=12;
  SELECT /*+ cs1 */ dummy INTO l_dummy FROM dual WHERE 13=13 AND dummy = l_dummy;
  SELECT /*+ cs1 */ dummy INTO l_dummy FROM dual WHERE 14=14 AND dummy = l_dummy;
END;
/

PAUSE

REM the replacement does not take place

SELECT executions, sql_text 
FROM v$sql 
WHERE sql_text LIKE 'SELECT /*+ cs1 */%'
ORDER BY executions, sql_text;

PAUSE

REM
REM native dynamic SQL - EXECUTE IMMEDIATE
REM

DECLARE
  l_dummy dual.dummy%TYPE := 'X';
BEGIN
  EXECUTE IMMEDIATE 'SELECT /*+ cs2 */ dummy FROM dual WHERE 21=21' INTO l_dummy;
  EXECUTE IMMEDIATE 'SELECT /*+ cs2 */ dummy FROM dual WHERE 22=22' INTO l_dummy;
  EXECUTE IMMEDIATE 'SELECT /*+ cs2 */ dummy FROM dual WHERE 23=23 AND dummy = :1' INTO l_dummy USING l_dummy;
  EXECUTE IMMEDIATE 'SELECT /*+ cs2 */ dummy FROM dual WHERE 24=24 AND dummy = :1' INTO l_dummy USING l_dummy;
END;
/

PAUSE

REM the replacement takes place only for the queries that do not contain bind variables

SELECT executions, sql_text 
FROM v$sql 
WHERE sql_text LIKE 'SELECT /*+ cs2 */%'
ORDER BY executions, sql_text;

PAUSE

REM
REM native dynamic SQL - OPEN/FETCH/CLOSE
REM

DECLARE
  TYPE t_cursor IS REF CURSOR;
  l_cursor t_cursor;
  l_dummy dual.dummy%TYPE := 'X';
BEGIN
  -- OPEN/FETCH/CLOSE
  OPEN l_cursor FOR 'SELECT /*+ cs3 */ dummy FROM dual WHERE 31=31';
  FETCH l_cursor INTO l_dummy;
  CLOSE l_cursor;
  OPEN l_cursor FOR 'SELECT /*+ cs3 */ dummy FROM dual WHERE 32=32';
  FETCH l_cursor INTO l_dummy;
  CLOSE l_cursor;
  OPEN l_cursor FOR 'SELECT /*+ cs3 */ dummy FROM dual WHERE 33=33 AND dummy = :1' USING l_dummy;
  FETCH l_cursor INTO l_dummy;
  CLOSE l_cursor;
  OPEN l_cursor FOR 'SELECT /*+ cs3 */ dummy FROM dual WHERE 34=34 AND dummy = :1' USING l_dummy;
  FETCH l_cursor INTO l_dummy;
  CLOSE l_cursor;
END;
/

PAUSE

REM the replacement takes place only for the queries that do not contain bind variables

SELECT executions, sql_text 
FROM v$sql 
WHERE sql_text LIKE 'SELECT /*+ cs3 */%'
ORDER BY executions, sql_text;

PAUSE

REM
REM dynamic SQL (dbms_sql)
REM

DECLARE
  l_cursor INTEGER;
  l_retval INTEGER;
  l_dummy dual.dummy%TYPE := 'X';
BEGIN
	--
  l_cursor := dbms_sql.open_cursor;
  dbms_sql.parse(l_cursor, 'SELECT /*+ cs4 */ dummy FROM dual WHERE 41=41', 1);
  dbms_sql.define_column(l_cursor, 1, l_dummy, 1);
  l_retval := dbms_sql.execute(l_cursor);
  dbms_sql.close_cursor(l_cursor);
	--
  l_cursor := dbms_sql.open_cursor;
  dbms_sql.parse(l_cursor, 'SELECT /*+ cs4 */ dummy FROM dual WHERE 42=42', 1);
  dbms_sql.define_column(l_cursor, 1, l_dummy, 1);
  l_retval := dbms_sql.execute(l_cursor);
  dbms_sql.close_cursor(l_cursor);
	--
  l_cursor := dbms_sql.open_cursor;
  dbms_sql.parse(l_cursor, 'SELECT /*+ cs4 */ dummy FROM dual WHERE 43=43 AND dummy = :1', 1);
  dbms_sql.define_column(l_cursor, 1, l_dummy, 1);
  dbms_sql.bind_variable(l_cursor, ':1', l_dummy);
  l_retval := dbms_sql.execute(l_cursor);
  dbms_sql.close_cursor(l_cursor);
	--
  l_cursor := dbms_sql.open_cursor;
  dbms_sql.parse(l_cursor, 'SELECT /*+ cs4 */ dummy FROM dual WHERE 44=44 AND dummy = :1', 1);
  dbms_sql.define_column(l_cursor, 1, l_dummy, 1);
  dbms_sql.bind_variable(l_cursor, ':1', l_dummy);
  l_retval := dbms_sql.execute(l_cursor);
  dbms_sql.close_cursor(l_cursor);
END;
/

PAUSE

REM the replacement takes place only for the queries that do not contain bind variables

SELECT executions, sql_text 
FROM v$sql 
WHERE sql_text LIKE 'SELECT /*+ cs4 */%'
ORDER BY executions, sql_text;

PAUSE

REM
REM Cleanup
REM
