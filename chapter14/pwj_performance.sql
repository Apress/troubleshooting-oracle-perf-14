SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: pwj_performance.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script is used to compare the performance of different
REM               partition-wise joins. It was used to generate the figures
REM               found in Figure 14-15.
REM Notes.......: This script has been engineered to avoid too many disk I/O.
REM               For this reason, not only the average row length is only 26
REM               bytes, but also enough PGA is provided to the processes.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 17.11.2013 Removed dependency from create_tx.sql
REM 09.03.2014 Amended description
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

DROP TABLE t1p CASCADE CONSTRAINTS PURGE;
DROP TABLE t2p CASCADE CONSTRAINTS PURGE;

CREATE TABLE t1p 
PARTITION BY HASH (id) PARTITIONS 4 
AS 
WITH 
  t1000 AS (
    SELECT  /*+ materialize */ rownum AS n
    FROM dual
    CONNECT BY rownum <= 1000
  )
SELECT rownum AS id, rpad('*',20,'*') AS pad
FROM t1000, t1000, t1000
WHERE rownum <= 10E6;

CREATE TABLE t2p 
PARTITION BY HASH (id) PARTITIONS 4 
AS 
WITH 
  t1000 AS (
    SELECT  /*+ materialize */ rownum AS n
    FROM dual
    CONNECT BY rownum <= 1000
  )
SELECT mod(rownum,1E6) AS id, rpad('*',20,'*') AS pad
FROM t1000, t1000, t1000
WHERE rownum <= 100E6;

ALTER TABLE t1p PARALLEL 4;
ALTER TABLE t2p PARALLEL 4;

BEGIN
  dbms_stats.gather_table_stats(user,'t1p');
  dbms_stats.gather_table_stats(user,'t2p');
END;
/

ALTER SESSION SET workarea_size_policy = manual;
ALTER SESSION SET hash_area_size = 268435456; 

PAUSE

REM
REM Serial without PWJ
REM

ALTER SYSTEM FLUSH BUFFER_CACHE;

ALTER SESSION DISABLE PARALLEL QUERY;

ALTER SESSION SET "_full_pwise_join_enabled" = FALSE;

SET TIMING ON

SELECT /*+ ordered use_hash(t2p) pq_distribute(t2p none none) */ count(*) 
FROM t1p, t2p 
WHERE t1p.id = t2p.id;

SET TIMING OFF

PAUSE

REM
REM Serial with PWJ
REM

ALTER SYSTEM FLUSH BUFFER_CACHE;

ALTER SESSION DISABLE PARALLEL QUERY;

ALTER SESSION SET "_full_pwise_join_enabled" = TRUE;

SET TIMING ON

SELECT /*+ ordered use_hash(t2p) pq_distribute(t2p none none) */ count(*)
FROM t1p, t2p 
WHERE t1p.id = t2p.id;

SET TIMING OFF

PAUSE

REM
REM Parallel without PWJ
REM

ALTER SYSTEM FLUSH BUFFER_CACHE;

ALTER SESSION ENABLE PARALLEL QUERY;

ALTER SESSION SET "_full_pwise_join_enabled" = FALSE;

SET TIMING ON

SELECT /*+ ordered use_hash(t2p) pq_distribute(t2p none none) */ count(*) 
FROM t1p, t2p 
WHERE t1p.id = t2p.id;

SET TIMING OFF

PAUSE

REM
REM Parallel with PWJ
REM

ALTER SYSTEM FLUSH BUFFER_CACHE;

ALTER SESSION ENABLE PARALLEL QUERY;

ALTER SESSION SET "_full_pwise_join_enabled" = TRUE;

SET TIMING ON

SELECT /*+ ordered use_hash(t2p) pq_distribute(t2p none none) */ count(*) 
FROM t1p, t2p 
WHERE t1p.id = t2p.id;

SET TIMING OFF

PAUSE

REM
REM Cleanup
REM

DROP TABLE t1p PURGE;
DROP TABLE t2p PURGE;

