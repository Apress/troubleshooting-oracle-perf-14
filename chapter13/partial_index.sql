SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: partial_index.sql
REM Author......: Christian Antognini
REM Date........: November 2013
REM Description.: This script shows how to create partial indexes and how the
REM               query optimizer uses them.
REM Notes.......: Requires Oracle Database 12c Release 1
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 
REM ***************************************************************************

SET TERMOUT ON SERVEROUTPUT ON PAGESIZE 100 LINESIZE 100

COLUMN def_indexing FORMAT A12
COLUMN indexing FORMAT A8
COLUMN partition_name FORMAT A14

@../connect.sql

DROP TABLE t PURGE;

SET ECHO ON

REM
REM Setup testing environment
REM

CREATE TABLE t (
  id NUMBER NOT NULL,
  d DATE NOT NULL,
  n NUMBER NOT NULL,
  pad VARCHAR2(4000) NOT NULL
)
INDEXING OFF
PARTITION BY RANGE (d) (
  PARTITION t_jan_2014 VALUES LESS THAN (to_date('2014-02-01','yyyy-mm-dd')),
  PARTITION t_feb_2014 VALUES LESS THAN (to_date('2014-03-01','yyyy-mm-dd')),
  PARTITION t_mar_2014 VALUES LESS THAN (to_date('2014-04-01','yyyy-mm-dd')),
  PARTITION t_apr_2014 VALUES LESS THAN (to_date('2014-05-01','yyyy-mm-dd')),
  PARTITION t_may_2014 VALUES LESS THAN (to_date('2014-06-01','yyyy-mm-dd')),
  PARTITION t_jun_2014 VALUES LESS THAN (to_date('2014-07-01','yyyy-mm-dd')),
  PARTITION t_jul_2014 VALUES LESS THAN (to_date('2014-08-01','yyyy-mm-dd')),
  PARTITION t_aug_2014 VALUES LESS THAN (to_date('2014-09-01','yyyy-mm-dd')),
  PARTITION t_sep_2014 VALUES LESS THAN (to_date('2014-10-01','yyyy-mm-dd')),
  PARTITION t_oct_2014 VALUES LESS THAN (to_date('2014-11-01','yyyy-mm-dd')),
  PARTITION t_nov_2014 VALUES LESS THAN (to_date('2014-12-01','yyyy-mm-dd')),
  PARTITION t_dec_2014 VALUES LESS THAN (to_date('2015-01-01','yyyy-mm-dd')) INDEXING ON
);

INSERT INTO t
SELECT rownum, to_date('2014-01-01','yyyy-mm-dd')+rownum/274, mod(rownum,11), rpad('*',100,'*')
FROM dual
CONNECT BY level <= 100000;

COMMIT;

EXECUTE dbms_stats.gather_table_stats(user,'T')

PAUSE

REM
REM Show indexing property at the table and at the partition level
REM

SELECT def_indexing
FROM user_part_tables
WHERE table_name = 'T';

PAUSE

SELECT partition_name, indexing
FROM user_tab_partitions
WHERE table_name = 'T'
ORDER BY partition_position;

PAUSE

REM
REM Nonpartitioned index
REM

CREATE INDEX i ON t (d) INDEXING PARTIAL;

PAUSE

EXPLAIN PLAN FOR SELECT * FROM t WHERE d BETWEEN to_date('2014-11-30 23:00:00','yyyy-mm-dd hh24:mi:ss')
                                             AND to_date('2014-12-01 01:00:00','yyyy-mm-dd hh24:mi:ss'); 

SELECT * FROM table(dbms_xplan.display(format=>'basic +partition +predicate'));

PAUSE

DROP INDEX i;

REM
REM Local partitioned index
REM

CREATE INDEX i ON t (d) LOCAL INDEXING PARTIAL;

PAUSE

EXPLAIN PLAN FOR SELECT * FROM t WHERE d BETWEEN to_date('2014-11-30 23:00:00','yyyy-mm-dd hh24:mi:ss')
                                             AND to_date('2014-12-01 01:00:00','yyyy-mm-dd hh24:mi:ss'); 

SELECT * FROM table(dbms_xplan.display(format=>'basic +partition +predicate'));

PAUSE

DROP INDEX i;

REM
REM Global partitioned index
REM

CREATE INDEX i ON t (d) GLOBAL PARTITION BY HASH (d) PARTITIONS 4 INDEXING PARTIAL;

PAUSE

EXPLAIN PLAN FOR SELECT * FROM t WHERE d BETWEEN to_date('2014-11-30 23:00:00','yyyy-mm-dd hh24:mi:ss')
                                             AND to_date('2014-12-01 01:00:00','yyyy-mm-dd hh24:mi:ss'); 

SELECT * FROM table(dbms_xplan.display(format=>'basic +partition +predicate'));

PAUSE

REM
REM Cleanup
REM

DROP TABLE t PURGE;
