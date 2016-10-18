SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: join_predicate_push_down.sql
REM Author......: Christian Antognini
REM Date........: February 2013
REM Description.: This script provides examples of the "join predicate push 
REM               down" query transformation.
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
DROP TABLE t3 CASCADE CONSTRAINTS PURGE;

CREATE TABLE t1 (
  id NUMBER PRIMARY KEY,
  pad VARCHAR2(100) NULL
);

CREATE TABLE t2 (
  id NUMBER PRIMARY KEY,
  pad VARCHAR2(100) NULL
);

CREATE TABLE t3 (
  id NUMBER PRIMARY KEY,
  pad VARCHAR2(100) NULL
);

ALTER SESSION SET tracefile_identifier = 'join_predicate_push_down';

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT /*+ push_pred(@"SEL$1" "T23"@"SEL$1" 1) */ * FROM t1, (SELECT * FROM t2 UNION SELECT * FROM t3) t23 WHERE t1.id = t23.id;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT /*+ no_push_pred(@"SEL$1" "T23"@"SEL$1" 1) */ * FROM t1, (SELECT * FROM t2 UNION SELECT * FROM t3) t23 WHERE t1.id = t23.id;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT * FROM t1, lateral(SELECT * FROM t2 WHERE t2.id = t1.id UNION SELECT * FROM t3 WHERE t3.id = t1.id) t23;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));
