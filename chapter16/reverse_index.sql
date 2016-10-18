SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: reverse_index.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows that range scans on reverse indexes cannot
REM               be used to apply restrictions based on range conditions.
REM Notes.......: A plan table named PLAN_TABLE must exist.
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

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t PURGE;

CREATE TABLE t (n NUMBER, pad VARCHAR2(1000));

INSERT INTO t 
SELECT rownum, rpad('*',1000,'*')
FROM dual
CONNECT BY level <= 1000;

execute dbms_stats.gather_table_stats(ownname=>user, tabname=>'t')

PAUSE

REM
REM With the non-reverse index range scans based on range conditions are possible
REM

CREATE INDEX t_i ON t (n);

EXPLAIN PLAN FOR SELECT * FROM t WHERE n < 10;

SELECT * FROM table(dbms_xplan.display(NULL,NULL,'basic +predicate'));

PAUSE

REM
REM With the reverse index range scans based on range conditions are NOT possible
REM

ALTER INDEX t_i REBUILD REVERSE;

PAUSE

EXPLAIN PLAN FOR SELECT * FROM t WHERE n < 10;

SELECT * FROM table(dbms_xplan.display(NULL,NULL,'basic +predicate'));

PAUSE

REM Notice that the following execution plan uses a FULL index scan

EXPLAIN PLAN FOR SELECT /*+ index(t) */ * FROM t WHERE n < 10;

SELECT * FROM table(dbms_xplan.display(NULL,NULL,'basic +predicate'));

PAUSE

REM
REM With the reverse index range scans based on equality conditions are possible however
REM

EXPLAIN PLAN FOR SELECT * FROM t WHERE n = 10;

SELECT * FROM table(dbms_xplan.display(NULL,NULL,'basic +predicate'));

PAUSE

REM
REM Cleanup
REM

DROP TABLE t PURGE;
