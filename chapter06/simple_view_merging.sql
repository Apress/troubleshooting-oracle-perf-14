SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: simple_view_merging.sql
REM Author......: Christian Antognini
REM Date........: February 2013
REM Description.: This script provides examples of the "simple view merging" 
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
DROP TABLE t3 CASCADE CONSTRAINTS PURGE;

CREATE TABLE t1 (
  id NUMBER PRIMARY KEY,
  pad VARCHAR2(100) NULL
);

CREATE TABLE t2 (
  id NUMBER PRIMARY KEY,
  t1_id NUMBER REFERENCES t1 (id),
  pad VARCHAR2(100) NULL
);

CREATE TABLE t3 (
  id NUMBER PRIMARY KEY,
  t1_id NUMBER REFERENCES t1 (id),
  pad VARCHAR2(100) NULL
);


ALTER SESSION SET tracefile_identifier = 'simple_view_merging';

REM plain select-join-projection inline views --> transformation done

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR
SELECT *
FROM (SELECT t1.* FROM t1, t2 WHERE t1.id = t2.t1_id) t12,
     (SELECT * FROM t3 WHERE id > 6) t3
WHERE t12.id = t3.t1_id;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate alias'));

REM outer join on single-table query block --> transformation done

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR
SELECT *
FROM (SELECT t1.* FROM t1, t2 WHERE t1.id = t2.t1_id) t12,
     (SELECT * FROM t3 WHERE id > 6) t3
WHERE t12.id = t3.t1_id(+);
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate alias'));

REM outer join on two-table query block --> transformation not done

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR
SELECT *
FROM (SELECT t1.* FROM t1, t2 WHERE t1.id = t2.t1_id) t12,
     (SELECT * FROM t3 WHERE id > 6) t3
WHERE t12.id(+) = t3.t1_id;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate alias'));

REM hints

EXPLAIN PLAN FOR
SELECT *
FROM (SELECT /*+ no_merge */ t1.* FROM t1, t2 WHERE t1.id = t2.t1_id) t12,
     (SELECT /*+ no_merge */ * FROM t3 WHERE id > 6) t3
WHERE t12.id = t3.t1_id;
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate alias'));

EXPLAIN PLAN FOR
SELECT /*+ no_merge(@sel$2) no_merge(@sel$3) */  *
FROM (SELECT t1.* FROM t1, t2 WHERE t1.id = t2.t1_id) t12,
     (SELECT * FROM t3 WHERE id > 6) t3
WHERE t12.id = t3.t1_id;
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate alias'));
