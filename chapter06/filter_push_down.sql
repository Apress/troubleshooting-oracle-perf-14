SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: filter_push_down.sql
REM Author......: Christian Antognini
REM Date........: February 2013
REM Description.: This script provides examples of the "filter push down" 
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
  pad VARCHAR2(100) NULL
);

CREATE TABLE t2 (
  id NUMBER PRIMARY KEY,
  pad VARCHAR2(100) NULL
);

ALTER SESSION SET tracefile_identifier = 'filter_push_down';

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT * FROM (SELECT * FROM t1 UNION SELECT * FROM t2) WHERE id = 1;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT /*+ opt_param('_optimizer_filter_pushdown' 'false') */ * FROM (SELECT * FROM t1 UNION SELECT * FROM t2) WHERE id = 1;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));

REM no_push_pred hint works for join-predicates only

EXPLAIN PLAN FOR SELECT /*+ no_push_pred(@"SEL$2" "T1"@"SEL$2") no_push_pred(@"SEL$3" "T2"@"SEL$3") */ * FROM (SELECT * FROM t1 UNION SELECT * FROM t2) WHERE id = 1;
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));
