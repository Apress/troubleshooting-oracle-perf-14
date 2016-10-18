SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: px_query_udf.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows examples of queries that are supposed to
REM               run in parallel but, because they reference a user-defined
REM               function, some of them have to run serially.
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

@../connect.sql

COLUMN statement_id FORMAT A13
COLUMN cost FORMAT 9999

SET ECHO ON

REM
REM Setup test environment
REM

ALTER SESSION SET parallel_degree_policy = manual;

DROP TABLE t;

CREATE TABLE t
PARALLEL 2
AS
SELECT rownum AS id, rpad('*',100,'*') AS pad
FROM dual
CONNECT BY level <= 100000;

execute dbms_stats.gather_table_stats(ownname => user, tabname => 't')

PAUSE

REM
REM Create two function: only the second one specifies PARALLEL_ENABLE
REM

CREATE OR REPLACE PACKAGE p IS
  g_n NUMBER;
  FUNCTION fs (p_n IN NUMBER) RETURN NUMBER;
  FUNCTION fp (p_n IN NUMBER) RETURN NUMBER PARALLEL_ENABLE;
END p;
/

CREATE OR REPLACE PACKAGE BODY p IS
  FUNCTION fs (p_n IN NUMBER) RETURN NUMBER IS
  BEGIN
    p.g_n := p_n;
    RETURN p_n;
  END fs;
  FUNCTION fp (p_n IN NUMBER) RETURN NUMBER PARALLEL_ENABLE IS
  BEGIN
    p.g_n := p_n;
    RETURN p_n;
  END fp;
END p;
/

CREATE OR REPLACE FUNCTION fs (p_n IN NUMBER) RETURN NUMBER IS
BEGIN
  p.g_n := p_n;
  RETURN p_n;
END fs;
/

CREATE OR REPLACE FUNCTION fp (p_n IN NUMBER) RETURN NUMBER PARALLEL_ENABLE IS
BEGIN
  p.g_n := p_n;
  RETURN p_n;
END fp;
/

PAUSE

REM
REM For the following queries the PARALLEL_ENABLE clause is irrelevant
REM

EXPLAIN PLAN FOR SELECT fs(id) FROM t; 
SELECT * FROM table(dbms_xplan.display(format=>'basic'));

PAUSE

EXPLAIN PLAN FOR SELECT fp(id) FROM t; 
SELECT * FROM table(dbms_xplan.display(format=>'basic'));

PAUSE

EXPLAIN PLAN FOR SELECT p.fs(id) FROM t; 
SELECT * FROM table(dbms_xplan.display(format=>'basic'));

PAUSE

EXPLAIN PLAN FOR SELECT p.fp(id) FROM t; 
SELECT * FROM table(dbms_xplan.display(format=>'basic'));

PAUSE

REM
REM For the following queries the PARALLEL_ENABLE clause is relevant
REM

EXPLAIN PLAN FOR SELECT DISTINCT fs(id) FROM t; 
SELECT * FROM table(dbms_xplan.display(format=>'basic'));

PAUSE

EXPLAIN PLAN FOR SELECT DISTINCT fp(id) FROM t; 
SELECT * FROM table(dbms_xplan.display(format=>'basic'));

PAUSE

EXPLAIN PLAN FOR SELECT DISTINCT p.fs(id) FROM t; 
SELECT * FROM table(dbms_xplan.display(format=>'basic'));

PAUSE

EXPLAIN PLAN FOR SELECT DISTINCT p.fp(id) FROM t; 
SELECT * FROM table(dbms_xplan.display(format=>'basic'));

PAUSE

REM
REM Cleanup
REM

DROP TABLE t;
DROP FUNCTION fs;
DROP FUNCTION fp;
DROP PACKAGE p;
