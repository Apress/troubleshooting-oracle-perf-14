SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: subquery_coalescing.sql
REM Author......: Christian Antognini
REM Date........: February 2013
REM Description.: This script provides examples of the "subquery coalescing" 
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
  t1_id NUMBER REFERENCES t1 (id),
  n NUMBER NULL,
  pad VARCHAR2(100) NULL
);



ALTER SESSION SET tracefile_identifier = 'subquery_coalescing';


ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR
SELECT *
FROM t1
WHERE EXISTS (SELECT 1 FROM t2 WHERE t2.n > 10 AND t2.id = t1.id)
OR EXISTS (SELECT 1 FROM t2 WHERE t2.n < 100 AND t2.id = t1.id);
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));


ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR
SELECT /*+ no_coalesce_sq(@sq1) no_coalesce_sq(@sq2) */ *
FROM t1
WHERE EXISTS (SELECT /*+ qb_name(sq1) */ 1 FROM t2 WHERE t2.n > 10 AND t2.id = t1.id)
OR EXISTS (SELECT /*+ qb_name(sq2) */ 1 FROM t2 WHERE t2.n < 100 AND t2.id = t1.id);
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));
