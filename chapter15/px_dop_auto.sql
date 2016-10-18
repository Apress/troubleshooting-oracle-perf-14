SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: px_dop_auto.sql
REM Author......: Christian Antognini
REM Date........: January 2014
REM Description.: This script shows that with automatic degree of parallelism 
REM               the query optimizer selects a degree depending on the amount 
REM               of processing.
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

CREATE TABLE t PARALLEL PCTFREE 0 AS
SELECT rownum AS id, rpad('*',84,'*') AS pad
FROM dual
CONNECT BY level <= 10000;

execute dbms_stats.gather_table_stats(user, 't')

REM The table should have a size of 1MB (db_block_size should be 8192)

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

*/

PAUSE

REM
REM Run test (table statistics are faked to perform the test with a single table)
REM

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
  DELETE plan_table;
  FOR i IN 1..400
  LOOP
    dbms_stats.set_table_stats(
      ownname => user,
      tabname => 'T',
      numrows => l_numrows*i*100,
      numblks => l_numblks*i*100,
      avgrlen => l_avgrlen
    );
    EXECUTE IMMEDIATE 'EXPLAIN PLAN SET STATEMENT_ID = '''||i||''' FOR SELECT * FROM t';
  END LOOP;
END;
/

PAUSE

REM
REM Display the result of the test
REM

SELECT to_number(statement_id)*100 as size_mb, 
       extractvalue(xmltype(other_xml),'/other_xml/info[@type="dop"]') AS dop
FROM plan_table
WHERE id = 1 
ORDER BY 1;

PAUSE

REM
REM Cleanup
REM

DROP TABLE t PURGE;
