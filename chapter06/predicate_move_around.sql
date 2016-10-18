SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: predicate_move_around.sql
REM Author......: Christian Antognini
REM Date........: February 2013
REM Description.: This script provides examples of the "predicate move around" 
REM               query transformation.
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

SET TERMOUT ON FEEDBACK OFF

@../connect.sql

SET ECHO ON

DROP TABLE t1 CASCADE CONSTRAINTS PURGE;
DROP TABLE t2 CASCADE CONSTRAINTS PURGE;

CREATE TABLE t1 (
  id NUMBER PRIMARY KEY,
  n NUMBER NULL,
  pad VARCHAR2(100) NULL
);

CREATE TABLE t2 (
  id NUMBER PRIMARY KEY,
  n NUMBER NULL,
  pad VARCHAR2(100) NULL
);


ALTER SESSION SET tracefile_identifier = 'predicate_move_around';


ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR
SELECT t1.pad, t2.pad
FROM (SELECT DISTINCT n, pad FROM t1 WHERE n = 1) t1,
     (SELECT DISTINCT n, pad FROM t2) t2
WHERE t1.n = t2.n;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));


ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR
SELECT /*+ opt_param('_pred_move_around' 'false') */ t1.pad, t2.pad
FROM (SELECT DISTINCT n, pad FROM t1 WHERE n = 1) t1,
     (SELECT DISTINCT n, pad FROM t2) t2
WHERE t1.n = t2.n;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));
