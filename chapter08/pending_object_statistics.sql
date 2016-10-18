SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: pending_object_statistics.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows how to use pending statistics to test a new
REM               set of object statistics before publishing them.
REM Notes.......: This script works in Oracle Database 11g only.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 02.10.2012 Added examples using opt_param hint to enable pending statistics
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

DROP TABLE t PURGE;

execute dbms_random.seed(0)

CREATE TABLE t
AS
SELECT rownum AS id,
       dbms_random.string('p',250) AS pad
FROM dual
CONNECT BY level <= 1000
ORDER BY dbms_random.value;

PAUSE

REM
REM Gather "regular" stats
REM

BEGIN
  dbms_stats.gather_table_stats(
    ownname          => user,
    tabname          => 't',
    estimate_percent => 100,
    method_opt       => 'for all columns size 1',
    cascade          => TRUE
  );
END;
/

PAUSE

REM
REM Insert data to have another set of object statistics
REM

INSERT INTO t 
SELECT 1000+id, pad
FROM t;

COMMIT;

PAUSE

REM
REM Gather pending statistics
REM

BEGIN
  dbms_stats.set_table_prefs(
    ownname => user,
    tabname => 't',
    pname   => 'publish',
    pvalue  => 'false'
  );
  dbms_stats.gather_table_stats(
    ownname          => user,
    tabname          => 'T',
    estimate_percent => 100,
    method_opt       => 'for all columns size 1',
    cascade          => TRUE
  );
  dbms_stats.set_table_prefs(
    ownname => user,
    tabname => 't',
    pname   => 'publish',
    pvalue  => 'true'
  );
END;
/

PAUSE

REM
REM Use "regular" statistics
REM

ALTER SESSION SET optimizer_use_pending_statistics = FALSE;

SET AUTOTRACE TRACE EXPLAIN
SELECT * FROM t;
SELECT * FROM t WHERE id BETWEEN 900 AND 1100;
SET AUTOTRACE OFF

PAUSE

REM
REM Use pending statistics
REM

SET AUTOTRACE TRACE EXPLAIN
SELECT /*+ opt_param('optimizer_use_pending_statistics' 'true') */ * FROM t;
SELECT /*+ opt_param('optimizer_use_pending_statistics' 'true') */ * FROM t WHERE id BETWEEN 900 AND 1100;
SET AUTOTRACE OFF

PAUSE

ALTER SESSION SET optimizer_use_pending_statistics = TRUE;

SET AUTOTRACE TRACE EXPLAIN
SELECT * FROM t;
SELECT * FROM t WHERE id BETWEEN 900 AND 1100;
SET AUTOTRACE OFF

PAUSE

REM
REM Publish pending statistics
REM

SELECT num_rows FROM user_tables WHERE table_name = 'T';

PAUSE

execute dbms_stats.publish_pending_stats(ownname => user, tabname => 'T');

PAUSE

SELECT num_rows FROM user_tables WHERE table_name = 'T';

PAUSE

ALTER SESSION SET optimizer_use_pending_statistics = FALSE;

SET AUTOTRACE TRACE EXPLAIN
SELECT * FROM t;
SELECT * FROM t WHERE id BETWEEN 900 AND 1100;
SET AUTOTRACE OFF

PAUSE

REM
REM Cleanup
REM

DROP TABLE t PURGE;
