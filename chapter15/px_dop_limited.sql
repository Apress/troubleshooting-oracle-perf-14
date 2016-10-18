SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: px_dop_limited.sql
REM Author......: Christian Antognini
REM Date........: January 2014
REM Description.: This script shows that when automatic degree of parallelism
REM               is enabled with the value "limited", only objects having a
REM               default DOP associated to them are considered. 
REM Notes.......: Oracle Database 11g Release 2 or newer is required.
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
SET SCAN ON
SET VERIFY OFF

COLUMN dop FORMAT A3

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

ALTER SESSION SET parallel_degree_policy = limited;
ALTER SESSION SET parallel_degree_limit = 16;
ALTER SESSION SET parallel_min_time_threshold = 10;

DROP TABLE t PURGE;

CREATE TABLE t NOPARALLEL PCTFREE 0 AS
SELECT rownum AS id, rpad('*',84,'*') AS pad
FROM dual
CONNECT BY level <= 10000;

execute dbms_stats.gather_table_stats(user, 't')

DECLARE
  l_numrows PLS_INTEGER;
  l_numblks PLS_INTEGER;
  l_avgrlen PLS_INTEGER;
BEGIN
  dbms_stats.get_table_stats(
    ownname => user,
    tabname => 'T',
    numrows => l_numrows,
    numblks => l_numblks,
    avgrlen => l_avgrlen
  );
  -- artificially increase the size of the table
  dbms_stats.set_table_stats(
    ownname => user,
    tabname => 'T',
    numrows => l_numrows*10000,
    numblks => l_numblks*10000,
    avgrlen => l_avgrlen
  );
END;
/

SELECT blocks*dbs.value/1024/1024 AS size_mb
FROM user_tables, (SELECT value FROM v$parameter WHERE name = 'db_block_size') dbs
WHERE table_name = 'T';

PAUSE

REM
REM Are statistics gathered through I/O calibration in place?
REM

SELECT max_iops, max_mbps, max_pmbps, latency, num_physical_disks
FROM dba_rsrc_io_calibrate;

PAUSE

/* If not, either run px_calibare_io.sql or execute as SYS the following SQL statements

DELETE FROM sys.resource_io_calibrate$;
INSERT INTO sys.resource_io_calibrate$ VALUES (current_timestamp, current_timestamp, 0, 3200, 200, 0, 0);
COMMIT;
SHUTDOWN
STARTUP

*/

PAUSE

REM
REM NOPARALLEL --> serial
REM

ALTER TABLE t NOPARALLEL;

EXPLAIN PLAN FOR SELECT * FROM t;

SELECT * FROM table(dbms_xplan.display(format=>'basic +note +parallel'));

PAUSE

REM
REM PARALLEL n --> manual DOP
REM

ALTER TABLE t PARALLEL 4;

EXPLAIN PLAN FOR SELECT * FROM t;

SELECT * FROM table(dbms_xplan.display(format=>'basic +note +parallel'));

PAUSE

REM
REM PARALLEL --> auto DOP
REM

ALTER TABLE t PARALLEL;

EXPLAIN PLAN FOR SELECT * FROM t;

SELECT * FROM table(dbms_xplan.display(format=>'basic +note +parallel'));

PAUSE

REM
REM Cleanup
REM

DROP TABLE t PURGE;
