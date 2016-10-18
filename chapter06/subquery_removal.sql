SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: subquery_removal.sql
REM Author......: Christian Antognini
REM Date........: February 2013
REM Description.: This script provides examples of the "subquery removal" 
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


ALTER SESSION SET tracefile_identifier = 'subquery_removal';


ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR
SELECT t1.id, t1.n, t2.id, t2.n
FROM t1, t2
WHERE t1.id = t2.t1_id
AND t2.n = (SELECT max(n)
            FROM t2
            WHERE t2.t1_id = t1.id);
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));


ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR
SELECT /*+ opt_param('_remove_aggr_subquery' 'false') */ t1.id, t1.n, t2.id, t2.n
FROM t1, t2
WHERE t1.id = t2.t1_id
AND t2.n = (SELECT max(n)
            FROM t2
            WHERE t2.t1_id = t1.id);
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));




insert into t1 values (1,1,null);
insert into t1 values (2,1,null);
insert into t1 values (3,2,null);
insert into t1 values (4,2,null);
insert into t1 values (5,2,null);
insert into t2 values (1,1,1,null);
insert into t2 values (2,1,2,null);
insert into t2 values (3,1,3,null);
insert into t2 values (4,1,3,null);
insert into t2 values (4,2,25,null);
insert into t2 values (5,2,2,null);
commit;