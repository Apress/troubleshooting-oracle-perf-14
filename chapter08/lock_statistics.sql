SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: lock_statistics.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows the working and behavior of locked object
REM               statistics.
REM Notes.......: This script works as of Oracle Database 10g. One call to the
REM               package dbms_stats even as of Release 2 only.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 10.04.2013 Cover direct-path insert for 12c
REM 07.05.2014 Fixed formatting
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

@../connect.sql

COLUMN index_name FORMAT A30
COLUMN column_name FORMAT A30

SET ECHO ON

REM
REM Setup test environment
REM

DROP INDEX t_i;

DROP TABLE t;

CREATE TABLE t 
AS
SELECT rownum AS id, rpad('*',25,'*') AS pad
FROM dual
CONNECT BY level <= 10;

ALTER TABLE t ADD CONSTRAINT t_pk PRIMARY KEY (id);

execute dbms_stats.gather_table_stats(ownname=>user, tabname=>'T')

ALTER SESSION SET nls_date_format = 'HH24:MI:SS';

PAUSE

REM
REM Display the object statistics
REM

SELECT num_rows, last_analyzed
FROM user_tables 
WHERE table_name = 'T';

SELECT column_name, num_distinct, last_analyzed
FROM user_tab_col_statistics
WHERE table_name = 'T';

SELECT index_name, distinct_keys, last_analyzed
FROM user_indexes
WHERE table_name = 'T';

PAUSE

REM
REM Insert some data to get a new set of object statistics
REM

INSERT INTO t
SELECT 10+rownum AS id, rpad('*',25,'*') AS pad
FROM dual
CONNECT BY level <= 10;

COMMIT;

PAUSE

REM
REM Lock object statistics
REM

BEGIN
  dbms_stats.lock_schema_stats(ownname => user);
END;
/

PAUSE

REM
REM Gather object statistics at schema level
REM

BEGIN
  dbms_stats.gather_schema_stats(ownname => user);
END;
/

PAUSE

REM
REM Display the object statistics
REM

SELECT num_rows, last_analyzed
FROM user_tables 
WHERE table_name = 'T';

SELECT column_name, num_distinct, last_analyzed
FROM user_tab_col_statistics
WHERE table_name = 'T';

SELECT index_name, distinct_keys, last_analyzed
FROM user_indexes
WHERE table_name = 'T';

PAUSE

REM
REM Gather object statistics at table level with and without the force option
REM

BEGIN
  dbms_stats.gather_table_stats(ownname => user, 
                                tabname => 'T');
END;
/

PAUSE

BEGIN
  dbms_stats.gather_table_stats(ownname => user, 
                                tabname => 'T',
                                force   => TRUE);
END;
/

PAUSE

REM
REM Display the object statistics
REM

SELECT num_rows, last_analyzed
FROM user_tables 
WHERE table_name = 'T';

SELECT column_name, num_distinct, last_analyzed
FROM user_tab_col_statistics
WHERE table_name = 'T';

SELECT index_name, distinct_keys, last_analyzed
FROM user_indexes
WHERE table_name = 'T';

PAUSE

REM
REM Insert some data to get a new set of object statistics
REM

REM execute dbms_stats.gather_table_stats(ownname=>user, tabname=>'T', force=>TRUE)

INSERT INTO t
SELECT 20+rownum AS id, rpad('*',25,'*') AS pad
FROM dual
CONNECT BY level <= 10;

COMMIT;

PAUSE

REM
REM Test statements that gather object statistics
REM

ANALYZE TABLE t COMPUTE STATISTICS;

ANALYZE TABLE t VALIDATE STRUCTURE;

PAUSE

ALTER INDEX t_pk REBUILD;

ALTER INDEX t_pk REBUILD COMPUTE STATISTICS;

PAUSE

CREATE INDEX t_i ON t (pad);

SELECT index_name, distinct_keys, last_analyzed
FROM user_indexes
WHERE table_name = 'T';

PAUSE

DROP INDEX t_i;

CREATE INDEX t_i ON t (pad) COMPUTE STATISTICS;

SELECT index_name, distinct_keys, last_analyzed
FROM user_indexes
WHERE table_name = 'T';

PAUSE

REM 12c only

TRUNCATE TABLE t;

execute dbms_stats.delete_table_stats(ownname=>user, tabname=>'T', force=>TRUE);

INSERT /*+ append */ INTO t
SELECT rownum AS id, rpad('*',25,'*') AS pad
FROM dual
CONNECT BY level <= 10;

PAUSE

SELECT num_rows, blocks
FROM user_tab_statistics
WHERE table_name = 'T';

PAUSE

execute dbms_stats.unlock_table_stats(ownname=>user, tabname=>'T');

PAUSE

TRUNCATE TABLE t;

INSERT /*+ append */ INTO t
SELECT rownum AS id, rpad('*',25,'*') AS pad
FROM dual
CONNECT BY level <= 10;

PAUSE

SELECT num_rows, blocks
FROM user_tab_statistics
WHERE table_name = 'T';

PAUSE
REM
REM Cleanup
REM

DROP TABLE t;
PURGE TABLE t;
