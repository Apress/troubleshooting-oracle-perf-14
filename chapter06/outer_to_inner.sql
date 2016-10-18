SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: outer_to_inner.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script provides an example of an outer join transformed
REM               into an inner join.
REM Notes.......: Oracle Database 11g is required to run this script.
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

@@create_tx.sql

PAUSE

REM
REM Run test
REM

EXPLAIN PLAN FOR
SELECT /*+ no_outer_join_to_inner */ *
FROM t1, t2
WHERE t1.id = t2.t1_id(+)
AND t2.id IS NOT NULL;

SELECT * FROM table(dbms_xplan.display);

PAUSE

EXPLAIN PLAN FOR
SELECT *
FROM t1, t2
WHERE t1.id = t2.t1_id(+)
AND t2.id IS NOT NULL;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM Cleanup
REM

DROP TABLE t4;
PURGE TABLE t4;
DROP TABLE t3;
PURGE TABLE t3;
DROP TABLE t2;
PURGE TABLE t2;
DROP TABLE t1;
PURGE TABLE t1;
