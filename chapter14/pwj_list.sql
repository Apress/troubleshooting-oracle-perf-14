SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: pwj_list.sql
REM Author......: Christian Antognini
REM Date........: March 2014
REM Description.: This script shows that to perform full partition-wise joins 
REM               on list partitioned tables the order of the partitions is
REM               relevant. In fact, it must be the same.
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

COLUMN high_value FORMAT A10
COLUM equal FORMAT A5

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

EXECUTE dbms_random.seed(0)

DROP TABLE t2p PURGE;
DROP TABLE t1p PURGE;

CREATE TABLE t1p
PARTITION BY LIST (pkey) (
  PARTITION p_0 VALUES (0),
  PARTITION p_1 VALUES (1),
  PARTITION p_2 VALUES (2),
  PARTITION p_3 VALUES (3),
  PARTITION p_4 VALUES (4),
  PARTITION p_5 VALUES (5),
  PARTITION p_6 VALUES (6),
  PARTITION p_7 VALUES (7),
  PARTITION p_8 VALUES (8),
  PARTITION p_9 VALUES (9)
)
AS
SELECT rownum AS num, mod(rownum,10) AS pkey, dbms_random.string('p',50) AS pad
FROM dual
CONNECT BY level <= 10000;

CREATE TABLE t2p
PARTITION BY LIST (pkey) (
  PARTITION p_0 VALUES (0),
  PARTITION p_1 VALUES (1),
  PARTITION p_2 VALUES (2),
  PARTITION p_3 VALUES (3),
  PARTITION p_5 VALUES (5),
  PARTITION p_4 VALUES (4),
  PARTITION p_6 VALUES (6),
  PARTITION p_7 VALUES (7),
  PARTITION p_8 VALUES (8),
  PARTITION p_9 VALUES (9)
)
AS
SELECT rownum AS num, mod(rownum,10) AS pkey, dbms_random.string('p',50) AS pad
FROM dual
CONNECT BY level <= 10000;

BEGIN
  dbms_stats.gather_table_stats(user,'t1p');
  dbms_stats.gather_table_stats(user,'t2p');
END;
/

ALTER SESSION DISABLE PARALLEL QUERY;

PAUSE

REM
REM Even though they are logically equivalent, no partition-wise join is used
REM

EXPLAIN PLAN FOR
SELECT * FROM t1p JOIN t2p USING (num, pkey);

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic'));

PAUSE

REM
REM The difference in the order of the partitions 
REM

SELECT t1p.high_value,
       t1p.partition_position AS pos_t1p,
       t2p.partition_position AS pos_t2p,
       decode(t1p.partition_position, t2p.partition_position, 'Y', 'N') AS equal
FROM user_tab_partitions t1p JOIN user_tab_partitions t2p ON t1p.partition_name = t2p.partition_name
WHERE t1p.table_name = 'T1P'
AND t2p.table_name = 'T2P';

PAUSE

REM
REM Fix the order
REM

REM Move the P5 partition of the T1P table

CREATE TABLE t1p_5 AS
SELECT *
FROM t1p PARTITION (p_5)
WHERE 1 = 0;

ALTER TABLE t1p EXCHANGE PARTITION p_5 WITH TABLE t1p_5;

ALTER TABLE t1p DROP PARTITION p_5;

ALTER TABLE t1p ADD PARTITION p_5 VALUES (5);

ALTER TABLE t1p EXCHANGE PARTITION p_5 WITH TABLE t1p_5;

DROP TABLE t1p_5 PURGE;

PAUSE

REM Move the P5 partition of the T2P table

CREATE TABLE t2p_5 AS
SELECT *
FROM t2p PARTITION (p_5)
WHERE 1 = 0;

ALTER TABLE t2p EXCHANGE PARTITION p_5 WITH TABLE t2p_5;

ALTER TABLE t2p DROP PARTITION p_5;

ALTER TABLE t2p ADD PARTITION p_5 VALUES (5);

ALTER TABLE t2p EXCHANGE PARTITION p_5 WITH TABLE t2p_5;

DROP TABLE t2p_5 PURGE;

PAUSE

SELECT t1p.high_value,
       t1p.partition_position AS pos_t1p,
       t2p.partition_position AS pos_t2p,
       decode(t1p.partition_position, t2p.partition_position, 'Y', 'N') AS equal
FROM user_tab_partitions t1p JOIN user_tab_partitions t2p ON t1p.partition_name = t2p.partition_name
WHERE t1p.table_name = 'T1P'
AND t2p.table_name = 'T2P';

PAUSE

REM
REM Now the partition-wise join takes place
REM

EXPLAIN PLAN FOR
SELECT * FROM t1p JOIN t2p USING (num, pkey);

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic'));

PAUSE

REM
REM Cleanup
REM

DROP TABLE t2p PURGE;
DROP TABLE t1p PURGE;
