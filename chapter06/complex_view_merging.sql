SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: complex_view_merging.sql
REM Author......: Christian Antognini
REM Date........: February 2013
REM Description.: This script provides examples of the "complex view merging" 
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
  n NUMBER NULL,
  pad VARCHAR2(100) NULL
);

CREATE TABLE t2 (
  id NUMBER CONSTRAINT t2_pk PRIMARY KEY,
  n NUMBER NULL,
  pad VARCHAR2(100) NULL
);

ALTER SESSION SET tracefile_identifier = 'complex_view_merging';

REM
REM Tests without data
REM

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR
SELECT t1.*, t2.sum_n
FROM t1, (SELECT n, sum(n) AS sum_n
          FROM t2
          GROUP BY n) t2
WHERE t1.n = t2.n;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate alias'));

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR
SELECT t1.*, t2.sum_n
FROM t1, (SELECT /*+ merge */ n, sum(n) AS sum_n
          FROM t2
          GROUP BY n) t2
WHERE t1.n = t2.n;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate alias'));

