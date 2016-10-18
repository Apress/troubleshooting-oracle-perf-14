SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: px_min_percent.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows the impact of the initialization parameter
REM               parallel_min_percent.
REM Notes.......: -
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 12.03.2012 Replaced NATURAL JOIN for selecting v$mystat and v$statname
REM 24.12.2013 Added reset of parallel_max_servers to original value
REM 07.02.2014 Added parallel_degree_policy = manual
REM            Script renamed (was px_dop1.sql) 
REM 04.05.2014 Added display of execution plan to show that a single table
REM            queue is used
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON
SET SERVEROUTPUT OFF

COLUMN parallel_max_servers NEW_VALUE parallel_max_servers

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

ALTER SESSION SET parallel_degree_policy = manual;

DROP TABLE t;

CREATE TABLE t (id NUMBER NOT NULL, pad VARCHAR2(1000));

INSERT INTO t
SELECT rownum, rpad('*',100,'*')
FROM dual
CONNECT BY level <= 100000;

COMMIT;

execute dbms_stats.gather_table_stats(ownname => user, tabname => 't')

PAUSE

REM
REM The parameter parallel_max_servers should be set to 40
REM

SELECT value AS parallel_max_servers
FROM v$parameter
WHERE name = 'parallel_max_servers';

ALTER SYSTEM SET parallel_max_servers = 40;

PAUSE

REM
REM Shows the impact of the initialization parameter parallel_min_percent
REM

ALTER TABLE t PARALLEL 50;

PAUSE

ALTER SESSION SET parallel_min_percent = 80;

SELECT count(pad) FROM t;

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'basic +parallel'));

PAUSE

ALTER SESSION SET parallel_min_percent = 81;

SELECT count(pad) FROM t;

PAUSE

SELECT name, value
FROM v$mystat JOIN v$statname USING (statistic#)
WHERE name like 'Parallel operations%';

PAUSE

SELECT name, value
FROM v$sysstat
WHERE name like 'Parallel operations%';

PAUSE

REM
REM Cleanup
REM

DROP TABLE t;
PURGE TABLE t;

ALTER SYSTEM SET parallel_max_servers = &parallel_max_servers;

SELECT value AS parallel_max_servers
FROM v$parameter
WHERE name = 'parallel_max_servers';
