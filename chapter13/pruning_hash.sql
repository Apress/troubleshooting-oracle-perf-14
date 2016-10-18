SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: pruning_hash.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows several examples of partition pruning
REM               applied to a hash-partitioned table.
REM Notes.......: -
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 11.09.2013 Replaced AUTOTRACE with dbms_xplan.display_cursor
REM 24.02.2014 Changed year used for partitions (2007->2014)
REM 15.03.2014 Added example with PARTITION HASH ITERATOR + changed partition
REM            key to reproduce AND pruning
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

COLUMN partition_name FORMAT A14

COLUMN id_plus_exp FORMAT 990 HEADING i NOPRINT
COLUMN parent_id_plus_exp FORMAT 990 HEADING p NOPRINT
COLUMN plan_plus_exp FORMAT A80 TRUNC
COLUMN object_node_plus_exp FORMAT A8
COLUMN other_tag_plus_exp FORMAT A29
COLUMN other_plus_exp FORMAT A44

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

ALTER SESSION SET statistics_level = all;

DROP TABLE t PURGE;

CREATE TABLE t (
  id NUMBER,
  d1 DATE,
  n1 NUMBER,
  n2 NUMBER,
  n3 NUMBER,
  pad VARCHAR2(4000),
  CONSTRAINT t_pk PRIMARY KEY (id)
)
PARTITION BY HASH (n1) PARTITIONS 16;

PAUSE

execute dbms_random.seed(0)

INSERT INTO t 
SELECT rownum AS id,
       trunc(to_date('2014-01-01','YYYY-MM-DD')+rownum/27.4) AS d1,
       1+mod(rownum,32) AS n1,
       255+mod(trunc(dbms_random.normal*1000),255) AS n2,
       round(4515+dbms_random.normal*1234) AS n3,
       dbms_random.string('p',255) AS pad
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

SELECT partition_name, partition_position, num_rows
FROM user_tab_partitions
WHERE table_name = 'T'
ORDER BY partition_position;

PAUSE

DROP TABLE tx PURGE;

CREATE TABLE tx AS SELECT * FROM t;

ALTER TABLE tx ADD CONSTRAINT tx_pk PRIMARY KEY (id);

BEGIN
  dbms_stats.gather_table_stats(
    ownname          => user,
    tabname          => 'TX'
  );
END;
/

PAUSE

REM
REM SINGLE
REM

SELECT * FROM t WHERE n1 = 3

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last partition'));

PAUSE

VARIABLE n1 NUMBER
EXECUTE :n1 := 3

SELECT * FROM t WHERE n1 = :n1

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last partition'));

PAUSE

SELECT * FROM t WHERE n1 IS NULL

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last partition'));

PAUSE

SELECT * FROM t WHERE n1 IN (3)

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last partition'));

PAUSE

REM
REM INLIST
REM

SELECT * FROM t WHERE n1 IN (1,3)

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last partition'));

PAUSE

REM
REM ITERATOR
REM

CREATE INDEX i ON t (n1) LOCAL;

PAUSE

SELECT * FROM t WHERE n1 IN (1,3)

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last partition'));

DROP INDEX i;

PAUSE

REM
REM ALL
REM

SELECT * FROM t WHERE n1 > 3

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last partition'));

PAUSE

SELECT * FROM t WHERE n1 BETWEEN 1 AND 3

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last partition'));

PAUSE

SELECT * FROM t WHERE n1 != 3

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last partition'));

PAUSE

SELECT * FROM t WHERE to_char(n1,'S9') = '+3'

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last partition'));

PAUSE

SELECT * FROM t WHERE n1 + 1 = 4

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last partition'));

PAUSE

REM
REM Subquery and join-filter pruning
REM (join-filter pruning is available as of Oracle Database 11g)
REM

REM Without subquery and join-filter pruning

ALTER SESSION SET "_subquery_pruning_enabled" = FALSE;
ALTER SESSION SET "_bloom_pruning_enabled" = FALSE;

PAUSE

SELECT /*+ leading(tx) use_nl(t) */ * FROM tx, t WHERE tx.d1 = t.d1 AND tx.n1 = t.n1 AND tx.id = 19

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last partition'));

PAUSE

SELECT /*+ leading(tx) use_hash(t) */ * FROM tx, t WHERE tx.d1 = t.d1 AND tx.n1 = t.n1 AND tx.id = 19

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last partition'));

PAUSE

SELECT /*+ leading(tx) use_merge(t) */ * FROM tx, t WHERE tx.d1 = t.d1 AND tx.n1 = t.n1 AND tx.id = 19

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last partition'));

PAUSE

REM With subquery pruning

ALTER SESSION SET "_bloom_pruning_enabled" = FALSE;
ALTER SESSION SET "_subquery_pruning_enabled" = TRUE;
ALTER SESSION SET "_subquery_pruning_cost_factor"=1;
ALTER SESSION SET "_subquery_pruning_reduction"=100;

PAUSE

SELECT /*+ leading(tx) use_hash(t) */ * FROM tx, t WHERE tx.d1 = t.d1 AND tx.n1 = t.n1 AND tx.id = 19

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last partition'));

PAUSE

SELECT /*+ leading(tx) use_merge(t) */ * FROM tx, t WHERE tx.d1 = t.d1 AND tx.n1 = t.n1 AND tx.id = 19

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last partition'));

PAUSE

REM Trace recursive query

ALTER SESSION SET sql_trace = TRUE;

SELECT /*+ leading(tx) use_hash(t) */ * FROM tx, t WHERE tx.d1 = t.d1 AND tx.n1 = t.n1 AND tx.id = 19

SET TERMOUT OFF
/
SET TERMOUT ON

ALTER SESSION SET sql_trace = FALSE;

PAUSE

REM With join-filter pruning

ALTER SESSION SET "_subquery_pruning_enabled" = FALSE;
ALTER SESSION SET "_bloom_pruning_enabled" = TRUE;

PAUSE

SELECT /*+ leading(tx) use_hash(t) */ * FROM tx, t WHERE tx.d1 = t.d1 AND tx.n1 = t.n1 AND tx.id = 19

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last partition'));

PAUSE

SELECT /*+ leading(tx) use_merge(t) */ * FROM tx, t WHERE tx.d1 = t.d1 AND tx.n1 = t.n1 AND tx.id = 19

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last partition'));

PAUSE

REM
REM AND
REM

ALTER SESSION SET "_and_pruning_enabled" = FALSE;

SELECT /*+ leading(tx) use_hash(t) */ * FROM tx, t WHERE tx.d1 = t.d1 AND tx.n1 = t.n1 AND tx.id = 19 AND t.n1 IN (1,2,3,4)

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last partition'));

PAUSE

ALTER SESSION SET "_and_pruning_enabled" = TRUE;

SELECT /*+ leading(tx) use_hash(t) */ * FROM tx, t WHERE tx.d1 = t.d1 AND tx.n1 = t.n1 AND tx.id = 19 AND t.n1 IN (1,2,3,4)

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last partition'));

PAUSE

REM
REM Cleanup 
REM

DROP TABLE t PURGE;

DROP TABLE tx PURGE;
