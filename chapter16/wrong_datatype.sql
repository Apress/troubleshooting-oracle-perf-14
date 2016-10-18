SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: wrong_datatype.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows that the decisions of the query optimizer
REM               are badly affected by the utilization of wrong datatypes.
REM Notes.......: A plan table named PLAN_TABLE must exist.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 10.06.2009 To generate data use "to_date(...)" instead of "sysdate"
REM 24.11.2013 Replaced 2008 with 2014
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t PURGE;

CREATE TABLE t (d DATE, n NUMBER(8), c VARCHAR2(8));

INSERT INTO t (d)
SELECT to_date('20140101','YYYYMMDD')+level-1
FROM dual
CONNECT BY level <= 365;

UPDATE t SET n = to_number(to_char(d,'YYYYMMDD')), c = to_char(d,'YYYYMMDD');

execute dbms_stats.gather_table_stats(ownname=>user, tabname=>'t')

PAUSE

REM
REM Display data
REM

SELECT * FROM t ORDER BY d;	

PAUSE

REM
REM Wrong estimation
REM

DELETE plan_table;

EXPLAIN PLAN SET STATEMENT_ID = 'd' FOR
SELECT * 
FROM t 
WHERE d BETWEEN to_date('20140201','YYYYMMDD') AND to_date('20140228','YYYYMMDD');

PAUSE

EXPLAIN PLAN SET STATEMENT_ID = 'n' FOR
SELECT * 
FROM t 
WHERE n BETWEEN 20140201 AND 20140228;

PAUSE

EXPLAIN PLAN SET STATEMENT_ID = 'c' FOR
SELECT * 
FROM t 
WHERE c BETWEEN '20140201' AND '20140228';

SELECT statement_id, cardinality FROM plan_table WHERE id = 0;

PAUSE

REM
REM Implicit conversion
REM

CREATE INDEX i ON t (c);

DELETE plan_table;

EXPLAIN PLAN FOR
SELECT /*+ index(t) */ * 
FROM t 
WHERE c = '20140228';

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +predicate'));

DELETE plan_table;

EXPLAIN PLAN FOR
SELECT /*+ index(t) */ * 
FROM t 
WHERE c = 20140228;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +predicate'));

PAUSE

REM
REM Cleanup
REM

DROP TABLE t PURGE;
