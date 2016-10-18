SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: rc_plsql.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows an example of a PL/SQL function that
REM               implements the PL/SQL function result cache.
REM Notes.......: Oracle Database 11g is required.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 24.06.2010 Added comment about invalidation in 11.2
REM 20.12.2013 Renamed (the old name was result_cache_plsql.sql) + added test
REM            for invoker's right function
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

@../connect.sql

SET ECHO ON

REM
REM Setup test environement
REM

DROP TABLE t PURGE;

CREATE TABLE t
AS
SELECT rownum AS id, rpad('*',100,'*') AS pad
FROM dual
CONNECT BY level <= 10000;

execute dbms_stats.gather_table_stats(ownname => user, tabname => 'T')

PAUSE

REM
REM Create the PL/SQL function that implements the PL/SQL function result cache
REM

CREATE OR REPLACE FUNCTION f(p IN NUMBER) 
  RETURN NUMBER 
  RESULT_CACHE RELIES_ON (t) 
IS
  l_ret NUMBER;
BEGIN
  SELECT count(*) INTO l_ret
  FROM t
  WHERE id = p;
  RETURN l_ret;
END;
/

PAUSE

REM
REM Test performance without the PL/SQL function result cache
REM

execute dbms_result_cache.bypass(bypass_mode => TRUE, session => TRUE)

SET TIMING ON
SELECT count(f(1)) FROM t;
SET TIMING OFF

PAUSE

REM
REM Test performance with the PL/SQL function result cache
REM

execute dbms_result_cache.bypass(bypass_mode => FALSE, session => TRUE)

SET TIMING ON
SELECT count(f(1)) FROM t;
SET TIMING OFF

PAUSE

REM
REM Test invalidation when RELIES_ON clause is used 
REM

CREATE OR REPLACE FUNCTION f(p IN NUMBER) 
  RETURN NUMBER 
  RESULT_CACHE RELIES_ON (t) 
IS
  l_ret NUMBER;
BEGIN
  SELECT count(*) INTO l_ret
  FROM t
  WHERE id = p;
  RETURN l_ret;
END;
/

PAUSE

SELECT f(-1) FROM dual;

INSERT INTO t VALUES (-1, 'invalidate...');
COMMIT;

SELECT f(-1) FROM dual;

PAUSE

REM
REM Test invalidation when RELIES_ON clause is not used 
REM (only in 11.2 the invalidation is automatically performed)
REM

CREATE OR REPLACE FUNCTION f(p IN NUMBER) 
  RETURN NUMBER 
  RESULT_CACHE 
IS
  l_ret NUMBER;
BEGIN
  SELECT count(*) INTO l_ret
  FROM t
  WHERE id = p;
  RETURN l_ret;
END;
/

PAUSE

SELECT f(-1) FROM dual;

INSERT INTO t VALUES (-1, 'invalidate...');
COMMIT;

SELECT f(-1) FROM dual;

PAUSE

execute dbms_result_cache.bypass(bypass_mode => TRUE, session => TRUE)

SELECT f(-1) FROM dual;

PAUSE

REM
REM Test invoker's right function (works from 12.1 onward)
REM

CREATE OR REPLACE FUNCTION f(p IN NUMBER) 
  RETURN NUMBER 
  AUTHID CURRENT_USER
  RESULT_CACHE 
IS
  l_ret NUMBER;
BEGIN
  SELECT count(*) INTO l_ret
  FROM t
  WHERE id = p;
  RETURN l_ret;
END;
/

PAUSE

SET TIMING ON
SELECT count(f(1)) FROM t;
SET TIMING OFF

PAUSE

REM
REM Cleanup
REM

DROP TABLE t PURGE;

DROP FUNCTION f;
