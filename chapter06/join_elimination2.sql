SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: join_elimination2.sql
REM Author......: Christian Antognini
REM Date........: June 2010
REM Description.: This script provides an example of join elimination.
REM Notes.......: At least Oracle Database 11g Release 2 is required to run 
REM               this script.
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

DROP TABLE t PURGE;

SET ECHO ON

REM
REM Setup test environment
REM

CREATE TABLE t (
  id NUMBER NOT NULL,
  n NUMBER,
  pad VARCHAR2(4000), 
  CONSTRAINT t_pk PRIMARY KEY(id)
);

INSERT INTO t SELECT rownum, rownum, rpad('*',42,'*') FROM dual CONNECT BY level <= 1000;

execute dbms_stats.gather_table_stats(user,'t')

PAUSE

REM
REM Run test with 11.1.0.7 optimizer
REM

ALTER SESSION SET optimizer_features_enable='11.1.0.7';

EXPLAIN PLAN FOR SELECT t1.*, t2.* FROM t t1, t t2 WHERE t1.id = t2.id;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM Run test with 11.2.0.1 optimizer
REM

ALTER SESSION SET optimizer_features_enable='11.2.0.1';

EXPLAIN PLAN FOR SELECT t1.*, t2.* FROM t t1, t t2 WHERE t1.id = t2.id;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM Run test without constraint
REM

ALTER TABLE t DISABLE CONSTRAINT t_pk;

EXPLAIN PLAN FOR SELECT t1.*, t2.* FROM t t1, t t2 WHERE t1.id = t2.id;

SELECT * FROM table(dbms_xplan.display);

PAUSE

ALTER TABLE t MODIFY CONSTRAINT t_pk RELY;

EXPLAIN PLAN FOR SELECT t1.*, t2.* FROM t t1, t t2 WHERE t1.id = t2.id;

SELECT * FROM table(dbms_xplan.display);

PAUSE

ALTER TABLE t ENABLE CONSTRAINT t_pk;
ALTER TABLE t MODIFY CONSTRAINT t_pk NOVALIDATE;

EXPLAIN PLAN FOR SELECT t1.*, t2.* FROM t t1, t t2 WHERE t1.id = t2.id;

SELECT * FROM table(dbms_xplan.display);

PAUSE

ALTER TABLE t MODIFY CONSTRAINT t_pk NORELY;

EXPLAIN PLAN FOR SELECT t1.*, t2.* FROM t t1, t t2 WHERE t1.id = t2.id;

SELECT * FROM table(dbms_xplan.display);

PAUSE

ALTER TABLE t DROP CONSTRAINT t_pk;
ALTER TABLE t ADD CONSTRAINT t_pk PRIMARY KEY (id) DEFERRABLE;

EXPLAIN PLAN FOR SELECT t1.*, t2.* FROM t t1, t t2 WHERE t1.id = t2.id;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM Cleanup
REM

DROP TABLE t PURGE;
