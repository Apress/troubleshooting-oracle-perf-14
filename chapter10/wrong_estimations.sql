SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: wrong_estimations.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script generates the output used for showing how to
REM               recognize inefficient execution plans by looking at wrong
REM               estimations.
REM Notes.......: This script requires Oracle Database 10g Release 1 or later.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 19.02.2014 To be able to reproduce the expected result on 12c, disable
REM            adaptive query optimizer
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

DROP TABLE t1;

CREATE TABLE t1 (id, col1, col2, pad)
AS 
SELECT rownum, CASE WHEN rownum>5000 THEN 666 ELSE rownum END, rownum, lpad('*',100,'*')
FROM dual
CONNECT BY level <= 10000;

INSERT INTO t1 SELECT id+10000, col1, col2, pad FROM t1;
INSERT INTO t1 SELECT id+20000, col1, col2, pad FROM t1;
INSERT INTO t1 SELECT id+40000, col1, col2, pad FROM t1;
INSERT INTO t1 SELECT id+80000, col1, col2, pad FROM t1;
COMMIT;

CREATE INDEX t1_col1 ON t1 (col1);

DROP TABLE t2;

CREATE TABLE t2 AS SELECT * FROM t1 WHERE mod(col2,19) != 0;

ALTER TABLE t2 ADD CONSTRAINT t2_pk PRIMARY KEY (id);

REM for 12c

ALTER SESSION SET optimizer_adaptive_features = false;

PAUSE

REM Gather statistics without histograms

BEGIN
 dbms_stats.gather_table_stats(
   ownname=>user, 
   tabname=>'T1', 
   cascade=>TRUE,
   estimate_percent=>100,
   method_opt=>'for all columns size 1',
   no_invalidate=>FALSE);
END;
/

BEGIN
 dbms_stats.gather_table_stats(
   ownname=>user, 
   tabname=>'T2', 
   cascade=>TRUE,
   estimate_percent=>100,
   method_opt=>'for all columns size 1',
   no_invalidate=>FALSE);
END;
/

PAUSE

REM
REM Display execution plan with execution statistics
REM

SELECT /*+ gather_plan_statistics */ count(t2.col2)
FROM t1 JOIN t2 USING (id)
WHERE t1.col1 = 666;

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'runstats_last'));

PAUSE

REM
REM Display statistics about the data
REM

SELECT num_rows, distinct_keys, num_rows/distinct_keys AS avg_rows_per_key
FROM user_indexes
WHERE index_name = 'T1_COL1';

PAUSE

SELECT count(*) AS num_rows, count(DISTINCT col1) AS distinct_keys, 
       count(nullif(col1,666)) AS rows_per_key_666
FROM t1;

PAUSE

REM
REM Gather statistics with histograms 
REM

SELECT histogram, num_buckets
FROM user_tab_col_statistics
WHERE table_name = 'T1' AND column_name = 'COL1';

PAUSE

BEGIN
 dbms_stats.gather_table_stats(
   ownname=>user, 
   tabname=>'T1', 
   cascade=>TRUE,
   estimate_percent=>100,
   method_opt=>'for all columns size 254',
   no_invalidate=>FALSE);
END;
/

PAUSE

SELECT histogram, num_buckets
FROM user_tab_col_statistics
WHERE table_name = 'T1' AND column_name = 'COL1';

PAUSE

REM
REM Display execution plan with execution statistics
REM

SELECT /*+ gather_plan_statistics */ count(t2.col2)
FROM t1 JOIN t2 USING (id)
WHERE t1.col1 = 666;

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'runstats_last'));

PAUSE

REM
REM Cleanup
REM


DROP TABLE t1;
PURGE TABLE t1;

DROP TABLE t2;
PURGE TABLE t2;
