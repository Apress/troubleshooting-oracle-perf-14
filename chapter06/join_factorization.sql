SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: join_factorization.sql
REM Author......: Christian Antognini
REM Date........: February 2013
REM Description.: This script provides examples of the "join factorization" 
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
DROP TABLE t4 CASCADE CONSTRAINTS PURGE;

CREATE TABLE t1
AS
SELECT rownum AS id, rpad('*',50,'*') AS pad
FROM all_objects
WHERE rownum <= 1000;

BEGIN
  dbms_stats.gather_table_stats(
    ownname          => user,
    tabname          => 'T1',
    estimate_percent => 100,
    method_opt       => 'for all columns size 254'
  );
END;
/

CREATE TABLE t2
AS
SELECT rownum AS id, rpad('*',50,'*') AS pad
FROM all_objects
WHERE rownum <= 1000;

BEGIN
  dbms_stats.gather_table_stats(
    ownname          => user,
    tabname          => 'T2',
    estimate_percent => 100,
    method_opt       => 'for all columns size 254'
  );
END;
/

CREATE TABLE t3
AS
SELECT rownum AS id, rpad('*',50,'*') AS pad
FROM all_objects
WHERE rownum <= 1000;

BEGIN
  dbms_stats.gather_table_stats(
    ownname          => user,
    tabname          => 'T3',
    estimate_percent => 100,
    method_opt       => 'for all columns size 254'
  );
END;
/

CREATE TABLE t4
AS
SELECT rownum AS id, rpad('*',50,'*') AS pad
FROM all_objects
WHERE rownum <= 1000;

BEGIN
  dbms_stats.gather_table_stats(
    ownname          => user,
    tabname          => 'T4',
    estimate_percent => 100,
    method_opt       => 'for all columns size 254'
  );
END;
/

PAUSE

SELECT /*+ NO_FACTORIZE_JOIN(@"SET$1") */ *
FROM t1, t2
WHERE t1.id = t2.id AND t2.id < 10
UNION ALL
SELECT *
FROM t1, t2
WHERE t1.id = t2.id AND t2.id > 990;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(format=>'basic'));

PAUSE

SELECT /*+ FACTORIZE_JOIN(@"SET$1") */ *
FROM t1, t2
WHERE t1.id = t2.id AND t2.id < 10
UNION ALL
SELECT *
FROM t1, t2
WHERE t1.id = t2.id AND t2.id > 990;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(format=>'basic'));

PAUSE

REM Factorize single table

SELECT /*+ NO_FACTORIZE_JOIN(@"SET$1") */ *
FROM t1, t2, t3
WHERE t1.id = t2.id AND t1.id < 10 AND t2.id = t3.id
UNION ALL
SELECT *
FROM t1, t2, t4
WHERE t1.id = t2.id AND t1.id < 10 AND t2.id = t4.id;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(format=>'basic +outline'));

PAUSE

SELECT /*+ FACTORIZE_JOIN(@"SET$1") */ *
FROM t1, t2, t3
WHERE t1.id = t2.id AND t1.id < 10 AND t2.id = t3.id
UNION ALL
SELECT *
FROM t1, t2, t4
WHERE t1.id = t2.id AND t1.id < 10 AND t2.id = t4.id;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(format=>'basic +outline'));

PAUSE

REM Factorize multible tables

SELECT /*+ NO_FACTORIZE_JOIN(@"SET$1") */ *
FROM t1, t2, t3
WHERE t1.id = t2.id AND t1.id < 10 AND t2.id = t3.id
UNION ALL
SELECT *
FROM t1, t2, t3
WHERE t1.id = t2.id AND t1.id < 10 AND t2.id = t3.id;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(format=>'basic +outline'));

PAUSE

SELECT /*+ FACTORIZE_JOIN(@"SET$1") */ *
FROM t1, t2, t3
WHERE t1.id = t2.id AND t1.id < 10 AND t2.id = t3.id
UNION ALL
SELECT *
FROM t1, t2, t3
WHERE t1.id = t2.id AND t1.id < 10 AND t2.id = t3.id;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(format=>'basic +outline'));

PAUSE

REM Factorization with view

CREATE OR REPLACE VIEW v AS
SELECT t1.id AS t1_id, t1.pad AS t1_pad, t2.id AS t2_id, t2.pad AS t2_pad
FROM t1, t2
WHERE t1.id = t2.id;

PAUSE

SELECT /*+ NO_FACTORIZE_JOIN(@"SET$1") */ *
FROM v, t3
WHERE t2_id = t3.id AND t2_id < 10
UNION ALL
SELECT *
FROM v, t4
WHERE t2_id = t4.id AND t2_id < 10;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(format=>'basic +outline'));

PAUSE

SELECT /*+ FACTORIZE_JOIN(@"SET$1") */ *
FROM v, t3
WHERE t2_id = t3.id AND t2_id < 10
UNION ALL
SELECT *
FROM v, t4
WHERE t2_id = t4.id AND t2_id < 10;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(format=>'basic +outline'));

