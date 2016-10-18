SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: array_interface.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: These scripts provide examples of implementing the array
REM               interface with PL/SQL.
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

REM
REM Setup test environment
REM

DROP TABLE t;

CREATE TABLE t (id NUMBER, pad VARCHAR2(1000));

PAUSE

REM
REM Run test
REM

ALTER SESSION SET sql_trace = TRUE;

DECLARE
  TYPE t_id IS TABLE OF t.id%TYPE;
  TYPE t_pad IS TABLE OF t.pad%TYPE;
  l_id t_id := t_id();
  l_pad t_pad := t_pad();
BEGIN
  -- prepare data
  l_id.extend(100000);
  l_pad.extend(100000);
  FOR i IN 1..100000
  LOOP
    l_id(i) := i;
    l_pad(i) := rpad('*',100,'*');
  END LOOP;
  -- insert data
  FORALL i IN l_id.FIRST..l_id.LAST 
    INSERT INTO t VALUES (l_id(i), l_pad(i));
END;
/

ALTER SESSION SET sql_trace = FALSE;

PAUSE

REM
REM Cleanup
REM

DROP TABLE t;
PURGE TABLE t;
