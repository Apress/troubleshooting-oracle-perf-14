SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: invisible_index_stats.sql
REM Author......: Christian Antognini
REM Date........: Februar 2014
REM Description.: This script shows that in 11.1 the query optimizer can take
REM               advantage of the statistics associated to an invisible index
REM               to improve its estimations.
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

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t PURGE;

CREATE TABLE t
AS
SELECT rownum AS id, mod(rownum,31) AS n1, mod(rownum,31) AS n2, rpad('*',100,'*') AS pad
FROM dual
CONNECT BY level <= 1000;

execute dbms_stats.gather_table_stats(user, 't')

REM
REM The test query returns 33 rows
REM

SELECT count(*)
FROM t
WHERE n1 = 5 AND n2 = 5;

PAUSE

REM
REM The cardinality is 1 instead of 33  
REM (the query optimizer has no information about the correlation between n1 and n2)
REM

EXPLAIN PLAN FOR
SELECT *
FROM t
WHERE n1 = 5 AND n2 = 5;

SELECT * FROM table(dbms_xplan.display(null,null,'basic rows'));

PAUSE

REM
REM Even though no index is used in the execution plan, the statistics associated  
REM to an index can provide important information to the query optimizer
REM

CREATE INDEX i ON t (n1, n2);

EXPLAIN PLAN FOR
SELECT *
FROM t
WHERE n1 = 5 AND n2 = 5;

SELECT * FROM table(dbms_xplan.display(null,null,'basic rows'));

PAUSE

REM
REM The query optimizer should not be able to take adavantage of the index when it
REM is invisible. Unfortunately, in 11.1 the statistics are used
REM

ALTER INDEX i INVISIBLE;

EXPLAIN PLAN FOR
SELECT *
FROM t
WHERE n1 = 5 AND n2 = 5;

SELECT * FROM table(dbms_xplan.display(null,null,'basic rows'));

PAUSE

REM
REM Cleanup
REM

DROP TABLE t PURGE;
