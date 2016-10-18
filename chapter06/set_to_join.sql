SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: set_to_join.sql
REM Author......: Christian Antognini
REM Date........: February 2013
REM Description.: This script provides examples of the "set to join conversion" 
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
  id NUMBER CONSTRAINT t1_pk PRIMARY KEY,
  n NUMBER NOT NULL,
  pad VARCHAR2(100) NOT NULL
);

CREATE TABLE t2 (
  id NUMBER CONSTRAINT t2_pk PRIMARY KEY,
  n NUMBER NOT NULL,
  pad VARCHAR2(100) NOT NULL
);



ALTER SESSION SET tracefile_identifier = 'set_to_join';


REM
REM Tests without data
REM


ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR
SELECT /*+ SET_TO_JOIN(@SET$1) */ *
FROM t1
WHERE n > 500
INTERSECT
SELECT *
FROM t2
WHERE t2.pad LIKE 'A%';
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));


ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR
SELECT /*+ SET_TO_JOIN(@SET$1) */ *
FROM t1
WHERE n > 500
MINUS
SELECT *
FROM t2
WHERE t2.pad LIKE 'A%';
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));


ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR
SELECT /*+ SET_TO_JOIN(@SET$1) */ *
FROM t1
WHERE n > 500
UNION
SELECT *
FROM t2
WHERE t2.pad LIKE 'A%';
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));


ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR
SELECT /*+ SET_TO_JOIN(@SET$1) */ *
FROM t1
WHERE n > 500
UNION ALL
SELECT *
FROM t2
WHERE t2.pad LIKE 'A%';
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));


