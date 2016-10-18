SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: join_trees.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script provides an example for each type of join tree.
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

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t4;
DROP TABLE t3;
DROP TABLE t2;
DROP TABLE t1;

CREATE TABLE t1 AS SELECT rownum AS id, rpad('*',50,'*') AS pad FROM dual CONNECT BY level <= 10;
CREATE TABLE t2 AS SELECT rownum AS id, rpad('*',50,'*') AS pad FROM dual CONNECT BY level <= 100;
CREATE TABLE t3 AS SELECT rownum AS id, rpad('*',50,'*') AS pad FROM dual CONNECT BY level <= 1000;
CREATE TABLE t4 AS SELECT rownum AS id, rpad('*',50,'*') AS pad FROM dual CONNECT BY level <= 10000;

BEGIN
  dbms_stats.gather_table_stats(user,'t1');
  dbms_stats.gather_table_stats(user,'t2');
  dbms_stats.gather_table_stats(user,'t3');
  dbms_stats.gather_table_stats(user,'t4');
END;
/

PAUSE

SET AUTOTRACE TRACEONLY EXPLAIN

REM
REM left-depth tree
REM

SELECT /*+ ordered use_hash(t2,t3,t4) */ t1.*, t2.*, t3.*, t4.*
FROM t1, t2, t3, t4
WHERE t1.id = t2.id AND t2.id = t3.id AND t3.id = t4.id;

PAUSE

REM
REM right-depth tree
REM

SELECT /*+ ordered use_hash(t4,t2,t1) */ t1.*, t2.*, t3.*, t4.*
FROM t3, t4, t2, t1
WHERE t1.id = t2.id AND t2.id = t3.id AND t3.id = t4.id;

PAUSE

REM
REM zig-zag tree
REM

SELECT /*+ ordered use_hash(t3,t1,t4) */ t1.*, t2.*, t3.*, t4.*
FROM t2, t3, t1, t4
WHERE t1.id = t2.id AND t2.id = t3.id AND t3.id = t4.id;

PAUSE

REM
REM bushy tree
REM

SELECT /*+ ordered use_hash(b) no_merge(a) no_merge(b) */ *
FROM (SELECT /*+ ordered use_hash(t2) */ t1.*
      FROM t1, t2
      WHERE t1.id = t2.id) a,
     (SELECT /*+ ordered use_hash(t4) */ t3.*
      FROM t3, t4
      WHERE t3.id = t4.id) b
WHERE a.id = b.id;

PAUSE

REM
REM Cleanup
REM

SET AUTOTRACE OFF

DROP TABLE t4;
PURGE TABLE t4;
DROP TABLE t3;
PURGE TABLE t3;
DROP TABLE t2;
PURGE TABLE t2;
DROP TABLE t1;
PURGE TABLE t1;
