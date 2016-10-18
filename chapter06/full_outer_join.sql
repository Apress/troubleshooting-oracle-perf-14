SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: full_outer_join.sql
REM Author......: Christian Antognini
REM Date........: February 2013
REM Description.: This script provides examples of the "full outer join" 
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
  t1_id NUMBER CONSTRAINT t2_t1_fk1 REFERENCES t1 (id),
  t1_id_nn NUMBER CONSTRAINT t2_t1_fk2 REFERENCES t1 (id) NOT NULL,
  n NUMBER NULL,
  pad VARCHAR2(100) NULL
);



ALTER SESSION SET tracefile_identifier = 'full_outer_join';

REM
REM Full outer join predicate not based on a FK
REM

REM native FOJ enabled --> tranformation not done

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR
SELECT *
FROM t1 FULL OUTER JOIN t2 ON t1.n = t2.n;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));

REM native FOJ disabled --> transformation done

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR
SELECT /*+ no_native_full_outer_join */ *
FROM t1 FULL OUTER JOIN t2 ON t1.n = t2.n;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));

REM
REM Full outer join predicate based on a nullable FK
REM

REM native FOJ enabled --> tranformation not done

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR
SELECT *
FROM t1 FULL OUTER JOIN t2 ON t1.id = t2.t1_id;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));

REM native FOJ disabled --> transformation done

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR
SELECT /*+ no_native_full_outer_join */ *
FROM t1 FULL OUTER JOIN t2 ON t1.id = t2.t1_id;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));

REM
REM Full outer join predicate based on a not-nullable FK
REM

REM native FOJ enabled --> tranformation not done

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR
SELECT *
FROM t1 FULL OUTER JOIN t2 ON t1.id = t2.t1_id_nn;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));

REM native FOJ disabled --> transformation done (full outer join to outer)

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR
SELECT /*+ no_native_full_outer_join */ *
FROM t1 FULL OUTER JOIN t2 ON t1.id = t2.t1_id_nn;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));

REM the constraint have to be enforeced, otherwise the full outer join to outer does not take place

ALTER TABLE t2 MODIFY CONSTRAINT t2_t1_fk2 NOVALIDATE;

EXPLAIN PLAN FOR
SELECT /*+ no_native_full_outer_join */ *
FROM t1 FULL OUTER JOIN t2 ON t1.id = t2.t1_id_nn;
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));

ALTER TABLE t2 MODIFY CONSTRAINT t2_t1_fk2 RELY;

EXPLAIN PLAN FOR
SELECT /*+ no_native_full_outer_join */ *
FROM t1 FULL OUTER JOIN t2 ON t1.id = t2.t1_id_nn;
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));

ALTER TABLE t2 DROP CONSTRAINT t2_t1_fk2;
ALTER TABLE t2 ADD CONSTRAINT t2_t1_fk2 t2_t1_fk2 REFERENCES t1 (id) DEFERRABLE;

EXPLAIN PLAN FOR
SELECT /*+ no_native_full_outer_join */ *
FROM t1 FULL OUTER JOIN t2 ON t1.id = t2.t1_id_nn;
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));
