SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: pwj_reference.sql
REM Author......: Christian Antognini
REM Date........: November 2013
REM Description.: This script shows that it is possible to perform full
REM               partition-wise joins on reference partitioned tables.
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

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t2p PURGE;
DROP TABLE t1p PURGE;

CREATE TABLE t1p (
  id NUMBER NOT NULL,
  pad VARCHAR2(1000),
  CONSTRAINT t1p_pk PRIMARY KEY (id) USING INDEX LOCAL
)
NOLOGGING
PARTITION BY HASH (id) PARTITIONS 4;

CREATE TABLE t2p (
  id NUMBER NOT NULL,
  t1p_id NUMBER NOT NULL,
  pad VARCHAR2(1000),
  CONSTRAINT t2p_pk PRIMARY KEY (id) USING INDEX,
  CONSTRAINT t2p_t1p_fk FOREIGN KEY (t1p_id) REFERENCES t1p (id)
)
NOLOGGING
PARTITION BY REFERENCE (t2p_t1p_fk);

INSERT /*+ append */ INTO t1p
WITH 
  t1000 AS (
    SELECT  /*+ materialize */ rownum AS n
    FROM dual
    CONNECT BY rownum <= 1000
  )
SELECT rownum, rpad('*',50,'*') 
FROM t1000, t1000;

COMMIT;

INSERT /*+ append */ INTO t2p
SELECT rownum, id, pad
FROM t1p;

COMMIT;

BEGIN
  dbms_stats.gather_table_stats(user,'t1p');
  dbms_stats.gather_table_stats(user,'t2p');
END;
/

ALTER SESSION SET "_bloom_pruning_enabled" = FALSE;

PAUSE

SET AUTOTRACE TRACEONLY EXPLAIN

REM
REM No PWJ
REM

ALTER SESSION SET "_full_pwise_join_enabled" = FALSE;
ALTER SESSION DISABLE PARALLEL QUERY;

PAUSE

SELECT /*+ leading(t1p) use_hash(t2p) */ * FROM t1p, t2p WHERE t1p.id = t2p.t1p_id;
SELECT /*+ leading(t1p) use_merge(t2p) */ * FROM t1p, t2p WHERE t1p.id = t2p.t1p_id;
SELECT /*+ leading(t1p) use_nl(t2p) */ * FROM t1p, t2p WHERE t1p.id = t2p.t1p_id;

PAUSE

REM
REM Serial full PWJ
REM

ALTER SESSION SET "_full_pwise_join_enabled" = TRUE;
ALTER SESSION DISABLE PARALLEL QUERY;

PAUSE

SELECT /*+ leading(t1p) use_hash(t2p) */ * FROM t1p, t2p WHERE t1p.id = t2p.t1p_id;
SELECT /*+ leading(t1p) use_merge(t2p) */ * FROM t1p, t2p WHERE t1p.id = t2p.t1p_id;
SELECT /*+ leading(t1p) use_nl(t2p) */ * FROM t1p, t2p WHERE t1p.id = t2p.t1p_id;

PAUSE

REM
REM Parallel full PWJ
REM

ALTER SESSION SET "_full_pwise_join_enabled" = TRUE;
ALTER SESSION FORCE PARALLEL QUERY PARALLEL 4;

PAUSE

SELECT /*+ leading(t1p) use_hash(t2p) */ * FROM t1p, t2p WHERE t1p.id = t2p.t1p_id;
SELECT /*+ leading(t1p) use_merge(t2p) */ * FROM t1p, t2p WHERE t1p.id = t2p.t1p_id;
SELECT /*+ leading(t1p) use_nl(t2p) */ * FROM t1p, t2p WHERE t1p.id = t2p.t1p_id;

PAUSE

REM
REM Cleanup
REM

SET AUTOTRACE OFF

DROP TABLE t2p PURGE;
DROP TABLE t1p PURGE;
