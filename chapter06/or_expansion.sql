SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: or_expansion.sql
REM Author......: Christian Antognini
REM Date........: February 2013
REM Description.: This script provides examples of the "or expansion" 
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
  n1 NUMBER NULL,
  n2 NUMBER NULL,
  n3 NUMBER NULL,
  n4 NUMBER NULL,
  pad VARCHAR2(100)
);

CREATE INDEX i1 ON t (n1);
CREATE INDEX i2 ON t (n2);
CREATE INDEX i3 ON t (n3);
CREATE INDEX i4 ON t (n4);

INSERT INTO t SELECT rownum, rownum, mod(rownum,42), mod(rownum,42), rpad('*',100,'*') FROM dual CONNECT BY level <= 1E5;
COMMIT;

execute dbms_stats.gather_table_stats(user,'t')

ALTER SESSION SET tracefile_identifier = 'or_expansion';

ALTER SESSION SET "_b_tree_bitmap_plans" = FALSE;

REM id is the primary key --> transformation done

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT pad FROM t WHERE n1 = 1 OR n2 = 2;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT pad FROM t WHERE n3 = 3 OR n4 = 4;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT pad FROM t WHERE (n1 < 42 AND n3 = 3) OR (n2 < 42 AND n4 = 4);
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));

REM add an example with an FBI (other restrictions as well? see https://blogs.oracle.com/optimizer/entry/or_expansion_transformation)

REM special case of disjunctive predicates

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT * FROM t WHERE n1 = 1 OR n1 = 2 OR n1 = 3 OR n1 = 4;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));

REM hints (or_expand does not work)

EXPLAIN PLAN FOR SELECT pad FROM t WHERE n1 = 1 OR n2 = 2;
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));

EXPLAIN PLAN FOR SELECT /*+ no_expand */ pad FROM t WHERE n1 = 1 OR n2 = 2;
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));

TRUNCATE TABLE t;
INSERT INTO t SELECT rownum, rownum, mod(rownum,42), mod(rownum,42), rpad('*',100,'*') FROM dual CONNECT BY level <= 1E2;
COMMIT;
execute dbms_stats.gather_table_stats(user,'t')

EXPLAIN PLAN FOR SELECT pad FROM t WHERE n1 = 1 OR n2 = 2;
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));

EXPLAIN PLAN FOR SELECT /*+ use_concat */ pad FROM t WHERE n1 = 1 OR n2 = 2;
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));

EXPLAIN PLAN FOR SELECT /*+ or_expand */ pad FROM t WHERE n1 = 1 OR n2 = 2;
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));

