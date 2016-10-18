SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: read_consistency.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows how the number of logical reads might change
REM               because of read consistency.
REM Notes.......: There are three important requirements to run this script:
REM               - Oracle Database 10g Release 2 or never
REM               - The initialization parameter job_queue_processes must be 
REM                 set to a value greater than 0.
REM               - The user executing the script must have a directly granted
REM                 object privilege to execute the package DBMS_LOCK, i.e.:
REM                 GRANT EXECUTE ON dbms_lock TO &user;
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 06.09.2013 Removed 10gR1 code + added hints to force index range scan
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

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
REM No consistent read blocks must be reconstructed
REM

SELECT /*+ gather_plan_statistics index(t) */ * 
FROM t 
WHERE n1 BETWEEN 6000 AND 7000 
AND n2 = 19;

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

REM
REM Another session modifies the table
REM

DECLARE
  l_job NUMBER;
BEGIN
  dbms_job.submit(l_job, 'BEGIN 
                            DELETE t WHERE n1 BETWEEN 6000 AND 7000; 
                            dbms_lock.sleep(5); 
                            COMMIT; 
                          END;');
  COMMIT;
  dbms_lock.sleep(5);
END;
/

REM
REM Consistent read blocks must be reconstructed
REM

SELECT /*+ gather_plan_statistics index(t) */ * 
FROM t 
WHERE n1 BETWEEN 6000 AND 7000 
AND n2 = 19;

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

REM
REM Cleanup
REM

DROP TABLE t;
PURGE TABLE t;
