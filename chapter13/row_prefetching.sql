SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: row_prefetching.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows how the number of logical reads might
REM               change because of row prefetching.
REM Notes.......: This script requires Oracle Database 10g Release 2 or never
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 06.09.2013 Removed 10gR1 code
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

COLUMN pad FORMAT A10 TRUNCATE

@../connect.sql

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
REM Low prefetching value --> High number of logical reads
REM

SET ARRAYSIZE 2

PAUSE

SELECT /*+ gather_plan_statistics */ * FROM t

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

REM
REM High prefetching value --> Low number of logical reads
REM

SET ARRAYSIZE 100

PAUSE

SELECT /*+ gather_plan_statistics */ * FROM t

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

REM
REM Test with aggregation
REM

SET ARRAYSIZE 2

PAUSE

SELECT /*+ gather_plan_statistics */ sum(n1) FROM t;

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

REM
REM Cleanup
REM

DROP TABLE t;
PURGE TABLE t;
