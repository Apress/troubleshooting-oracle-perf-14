SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: rc_query_nondet.sql
REM Author......: Christian Antognini
REM Date........: December 2013
REM Description.: This script shows the influence of session-specific settings
REM               on queries using the server result cache.
REM               To avoid the problems shown in this script it is possible, as
REM               of 11.2.0.4, to set _result_cache_deterministic_plsql to TRUE
REM               (refer to support note 14320218.8).
REM Notes.......: The sample schema SH and Oracle Database 11g are required.
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

REM
REM Setup test environment
REM

execute dbms_result_cache.flush

PAUSE

REM
REM Some examples of SQL functions that are not cached
REM

SELECT /*+ result_cache */ sysdate FROM dual;
SELECT /*+ result_cache */ current_date FROM dual;
SELECT /*+ result_cache */ localtimestamp FROM dual;
SELECT /*+ result_cache */ systimestamp FROM dual;
SELECT /*+ result_cache */ current_timestamp FROM dual;
SELECT /*+ result_cache */ sys_guid() FROM dual;

PAUSE

REM since a flush has been executed at the beginning of the script, 
REM no rows should be returned by the following query

SELECT status, name 
FROM v$result_cache_objects;

PAUSE

REM
REM NLS parameters
REM

ALTER SESSION SET nls_date_format = 'YYYY-MM-DD HH24:MI';

PAUSE

CREATE OR REPLACE FUNCTION f RETURN VARCHAR2 
IS
  l_ret VARCHAR2(64);
BEGIN
  SELECT /*+ no_result_cache */ to_char(sysdate)
  INTO l_ret
  FROM dual;
  RETURN l_ret;
END f;
/

PAUSE

ALTER SESSION SET nls_date_format = 'YYYY-MM-DD HH24:MI:SS';

SELECT /*+ result_cache */ f() FROM dual;

PAUSE

ALTER SESSION SET nls_date_format = 'YYYY-MM-DD';

SELECT /*+ result_cache */ f() FROM dual;

PAUSE

REM
REM Context information
REM 

CREATE OR REPLACE FUNCTION f RETURN VARCHAR2
IS
  l_ret VARCHAR2(64);
BEGIN
  SELECT /*+ no_result_cache */ sys_context('userenv','client_identifier')
  INTO l_ret
  FROM dual;
  RETURN l_ret;
END;
/

PAUSE

EXECUTE dbms_session.set_identifier('A');

SELECT /*+ result_cache */ f() FROM dual;

PAUSE

EXECUTE dbms_session.set_identifier('B');

SELECT /*+ result_cache */ f() FROM dual;

PAUSE

REM
REM Cleanup
REM

DROP FUNCTION f;

EXECUTE dbms_session.clear_identifier
