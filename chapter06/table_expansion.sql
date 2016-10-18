SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: table_expansion.sql
REM Author......: Christian Antognini
REM Date........: February 2013
REM Description.: This script provides examples of the "table expansion" 
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

DROP TABLE t PURGE;

CREATE TABLE t (
  id NUMBER PRIMARY KEY,
  d DATE NOT NULL,
  n NUMBER NOT NULL,
  pad VARCHAR2(4000) NOT NULL
)
PARTITION BY RANGE (d) (
  PARTITION t_q1_2014 VALUES LESS THAN (to_date('2014-04-01','yyyy-mm-dd')),
  PARTITION t_q2_2014 VALUES LESS THAN (to_date('2014-07-01','yyyy-mm-dd')),
  PARTITION t_q3_2014 VALUES LESS THAN (to_date('2014-10-01','yyyy-mm-dd')),
  PARTITION t_q4_2014 VALUES LESS THAN (to_date('2015-01-01','yyyy-mm-dd'))
);

CREATE INDEX i ON t (n) LOCAL UNUSABLE;
ALTER INDEX i REBUILD PARTITION t_q4_2014;

execute dbms_stats.gather_table_stats(user,'t')


ALTER SESSION SET tracefile_identifier = 'table_expansion';

REM
REM Tests without data
REM

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT * FROM t WHERE n = 8;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate partition'));

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT /*+ expand_table(t) */ * FROM t WHERE n = 8;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate partition'));

REM
REM Tests with data
REM

INSERT INTO t
SELECT rownum, to_date('2014-01-01','yyyy-mm-dd')+rownum/274, mod(rownum,1234), rpad('*',100,'*')
FROM dual
CONNECT BY level <= 100000;

COMMIT;

execute dbms_stats.gather_table_stats(user,'t')

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT * FROM t WHERE n = 8;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate partition'));

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT /*+ no_expand_table(t) */ * FROM t WHERE n = 8;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate partition'));

REM
REM Tests with additional index partitions
REM

ALTER INDEX i REBUILD PARTITION t_q1_2014;

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT * FROM t WHERE n = 8;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate partition'));
