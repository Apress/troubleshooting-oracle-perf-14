SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: logical_reads.sql
REM Author......: Christian Antognini
REM Date........: August 2013
REM Description.: This script shows how to display the number of logical reads
REM               for a specific execution plan operation.
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
SET LONG 1000000
SET LONGCHUNK 1000000

COLUMN pad FORMAT A20 TRUNCATE

@../connect.sql

SET ARRAYSIZE 2

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t;

execute dbms_random.seed(0)

CREATE TABLE t
AS
SELECT rownum AS id,
       round(5678+dbms_random.normal*1234) AS n1,
       mod(255+trunc(dbms_random.normal*1000),255) AS n2,
       dbms_random.string('p',255) AS pad
FROM dual
CONNECT BY level <= 10000
ORDER BY dbms_random.value;

ALTER TABLE t ADD CONSTRAINT t_pk PRIMARY KEY (id);

CREATE INDEX t_n2_i ON t (n2);

BEGIN
  dbms_stats.gather_table_stats(
    ownname          => user,
    tabname          => 'T',
    estimate_percent => 100,
    method_opt       => 'for all columns size skewonly',
    cascade          => TRUE
  );
END;
/

PAUSE

SELECT num_rows, blocks, round(num_rows/blocks) AS rows_per_block
FROM user_tables
WHERE table_name = 'T';

PAUSE

REM
REM DBMS_XPLAN
REM

SELECT /*+ gather_plan_statistics index(t) */ * 
FROM t 
WHERE n1 BETWEEN 6000 AND 7000 
AND n2 = 19;

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ gather_plan_statistics full(t) */ * 
FROM t 
WHERE n1 BETWEEN 6000 AND 7000 
AND n2 = 19;

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ gather_plan_statistics */ sum(n1) FROM t WHERE n2 > 246;

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

REM
REM SQL Trace
REM

execute dbms_session.session_trace_enable

SELECT /*+ index(t) */ * 
FROM t 
WHERE n1 BETWEEN 6000 AND 7000 
AND n2 = 19;

SELECT /*+ full(t) */ * 
FROM t 
WHERE n1 BETWEEN 6000 AND 7000 
AND n2 = 19;

execute dbms_session.session_trace_disable

PAUSE

SELECT value FROM v$diag_info WHERE name = 'Default Trace File';

PAUSE

REM
REM SQL Monitoring 
REM (does not show the number of logical reads at the operation level)
REM

SELECT /*+ monitor index(t) */ * 
FROM t 
WHERE n1 BETWEEN 6000 AND 7000 
AND n2 = 19;

SELECT dbms_sqltune.report_sql_monitor(type=>'text') FROM dual;

PAUSE

SELECT /*+ monitor full(t) */ * 
FROM t 
WHERE n1 BETWEEN 6000 AND 7000 
AND n2 = 19;

SELECT dbms_sqltune.report_sql_monitor(type=>'text') FROM dual;

PAUSE

REM
REM Cleanup
REM

DROP TABLE t;
PURGE TABLE t;
