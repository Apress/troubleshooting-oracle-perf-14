SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: hash_cluster.sql
REM Author......: Christian Antognini
REM Date........: March 2009
REM Description.: This script shows examples of hash cluster scans.
REM Notes.......: This script requires Oracle Database 10g or never. 
REM               To reproduce the execution plan with a concatenation of 
REM               several TABLE ACCESS HASH or an inlist iterator, 10.2.0.4 or
REM               newer is required.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 24.06.2010 Changed comment related to IN operator because of 11.2 improvement
REM 25.02.2014 Added part about ANALYZE CLUSTER
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

DROP TABLE t PURGE;
DROP CLUSTER c;

CREATE CLUSTER c (id NUMBER(10,0)) 
SINGLE TABLE SIZE 100 HASHKEYS 10000 HASH IS id; 

CREATE TABLE t (
  id NUMBER(10,0),
  n NUMBER(10,0),
  pad VARCHAR2(4000)
)
CLUSTER c(id);

execute dbms_random.seed(0)

INSERT INTO t
SELECT rownum AS id,
       1+mod(rownum,100) AS n1,
       dbms_random.string('p',50) AS pad
FROM dual
CONNECT BY level <= 10000
ORDER BY dbms_random.value;

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

ALTER SESSION SET statistics_level = all;

REM
REM equality search --> TABLE ACCESS HASH
REM

SELECT * FROM t WHERE id = 6;
SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'runstats_last'));

PAUSE

REM
REM IN --> CONCATENATION (up to 11gR1) or INLIST ITERATOR (as of 11gR2)
REM This case can only be reproduced in 10.2.0.4 or newer!
REM

SELECT * FROM t WHERE id IN (6, 8, 19, 28);
SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'runstats_last'));

PAUSE

REM
REM if no index is available, other conditions lead to full scan
REM

SELECT /*+ index(t) */ * FROM t WHERE id < 6;
SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'runstats_last'));

PAUSE

ALTER TABLE t ADD CONSTRAINT t_pk PRIMARY KEY (id);

SELECT /*+ index(t) */ * FROM t WHERE id < 6;
SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'runstats_last'));

PAUSE

REM
REM Compare the estimations with and without cluster statistics
REM

EXPLAIN PLAN FOR SELECT * FROM t WHERE id IN (6, 8, 19, 28);

SELECT * FROM table(dbms_xplan.display);

PAUSE

ANALYZE CLUSTER c COMPUTE STATISTICS;

PAUSE

EXPLAIN PLAN FOR SELECT * FROM t WHERE id IN (6, 8, 19, 28);

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM Cleanup
REM

DROP TABLE t;
PURGE TABLE t;
DROP CLUSTER c;
