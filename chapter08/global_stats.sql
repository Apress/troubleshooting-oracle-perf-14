SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: global_stats.sql
REM Author......: Christian Antognini
REM Date........: August 2013
REM Description.: This script shows that derived statistics can be inaccurate.
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

@../connect.sql

COLUMN partition_name FORMAT A14
COLUMN subpartition_name FORMAT A17
COLUMN num_rows FORMAT 999999
COLUMN blocks FORMAT 999999
COLUMN avg_row_len FORMAT 999999
COLUMN global_stats FORMAT A12

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t PURGE;

CREATE TABLE t (id NUMBER, p DATE, sp NUMBER, pad VARCHAR2(1000))
PARTITION BY RANGE (p)
SUBPARTITION BY HASH (sp) SUBPARTITION TEMPLATE
(
  SUBPARTITION sp1,
  SUBPARTITION sp2,
  SUBPARTITION sp3,
  SUBPARTITION sp4
)
(
  PARTITION q1 VALUES LESS THAN (to_date('2013-04-01','YYYY-MM-DD')),
  PARTITION q2 VALUES LESS THAN (to_date('2013-07-01','YYYY-MM-DD')),
  PARTITION q3 VALUES LESS THAN (to_date('2013-10-01','YYYY-MM-DD')),
  PARTITION q4 VALUES LESS THAN (to_date('2014-01-01','YYYY-MM-DD'))
);

INSERT INTO t
SELECT rownum, to_date('2013-01-01','YYYY-MM-DD')+mod(rownum,365), mod(rownum,100)+1, rpad('*',100,'*')
FROM dual
CONNECT BY level <= 16000;

COMMIT;

PAUSE

REM
REM Derivation of object and partition statistics from subpartition statistics
REM

BEGIN
	dbms_stats.delete_table_stats(ownname => user, 
	                              tabname => 't');
	dbms_stats.gather_table_stats(ownname => user, 
	                              tabname => 't', 
	                              estimate_percent => 100,
	                              granularity => 'subpartition');
END;
/

PAUSE

SELECT object_type, num_rows, blocks, avg_row_len, global_stats
FROM user_tab_statistics
WHERE table_name = 'T'
ORDER BY partition_name, subpartition_name;

PAUSE

REM
REM In general it is not possible to correctly derive the number of distinct values
REM

REM table-level statistics

SELECT count(DISTINCT sp) 
FROM t;

SELECT num_distinct, global_stats
FROM user_tab_col_statistics
WHERE table_name = 'T'
AND column_name = 'SP';

PAUSE

REM partition-level statistics

SELECT count(DISTINCT sp) 
FROM t PARTITION (q1);

SELECT num_distinct, global_stats
FROM user_part_col_statistics
WHERE table_name = 'T'
AND partition_name = 'Q1'
AND column_name = 'SP';

PAUSE

REM subpartition-level statistics

SELECT 'Q1_SP1' AS subpartition_name, count(DISTINCT sp) FROM t SUBPARTITION (q1_sp1)
UNION ALL
SELECT 'Q1_SP2', count(DISTINCT sp) FROM t SUBPARTITION (q1_sp2)
UNION ALL
SELECT 'Q1_SP3', count(DISTINCT sp) FROM t SUBPARTITION (q1_sp3)
UNION ALL
SELECT 'Q1_SP4', count(DISTINCT sp) FROM t SUBPARTITION (q1_sp4);

SELECT subpartition_name, num_distinct, global_stats
FROM user_subpart_col_statistics
WHERE table_name = 'T'
AND column_name = 'SP'
AND subpartition_name LIKE 'Q1%'
ORDER BY subpartition_name;

PAUSE

REM
REM The derivation only works when all underlying structures have object statistics in place
REM

BEGIN
	dbms_stats.delete_table_stats(ownname => user, 
	                              tabname => 't');
	dbms_stats.gather_table_stats(ownname => user, 
	                              tabname => 't', 
	                              partname => 'q1_sp1',
	                              granularity => 'subpartition');
END;
/

PAUSE

SELECT object_type, num_rows, blocks, avg_row_len, global_stats
FROM user_tab_statistics
WHERE table_name = 'T'
ORDER BY partition_name, subpartition_name;

PAUSE

BEGIN
	dbms_stats.gather_table_stats(ownname => user, 
	                              tabname => 't', 
	                              partname => 'q1_sp2',
	                              granularity => 'subpartition');
	dbms_stats.gather_table_stats(ownname => user, 
	                              tabname => 't', 
	                              partname => 'q1_sp3',
	                              granularity => 'subpartition');
END;
/

PAUSE

SELECT object_type, num_rows, blocks, avg_row_len, global_stats
FROM user_tab_statistics
WHERE table_name = 'T'
ORDER BY partition_name, subpartition_name;

PAUSE

BEGIN
	dbms_stats.gather_table_stats(ownname => user, 
	                              tabname => 't', 
	                              partname => 'q1_sp4',
	                              granularity => 'subpartition');
END;
/

PAUSE

SELECT object_type, num_rows, blocks, avg_row_len, global_stats
FROM user_tab_statistics
WHERE table_name = 'T'
ORDER BY partition_name, subpartition_name;

PAUSE

REM
REM The global statistics are not replaced by derived statistics
REM

TRUNCATE TABLE t;

PAUSE

BEGIN
	dbms_stats.delete_table_stats(ownname => user, 
	                              tabname => 't');
	dbms_stats.gather_table_stats(ownname => user, 
	                              tabname => 't',
	                              estimate_percent => 100,
	                              granularity => 'all');
END;
/

PAUSE

SELECT object_type, num_rows, blocks, avg_row_len, global_stats
FROM user_tab_statistics
WHERE table_name = 'T'
ORDER BY partition_name, subpartition_name;

PAUSE

INSERT INTO t
SELECT rownum, to_date('2013-01-01','YYYY-MM-DD')+mod(rownum,365), mod(rownum,100)+1, rpad('*',100,'*')
FROM dual
CONNECT BY level <= 16000;

COMMIT;

PAUSE

BEGIN
	dbms_stats.gather_table_stats(ownname => user, 
	                              tabname => 't', 
	                              partname => 'q2',
	                              granularity => 'partition');
END;
/

PAUSE

SELECT object_type, num_rows, blocks, avg_row_len, global_stats
FROM user_tab_statistics
WHERE table_name = 'T'
ORDER BY partition_name, subpartition_name;

PAUSE

BEGIN
	dbms_stats.gather_table_stats(ownname => user, 
	                              tabname => 't', 
	                              partname => 'q1',
	                              granularity => 'subpartition');
END;
/

PAUSE

SELECT object_type, num_rows, blocks, avg_row_len, global_stats
FROM user_tab_statistics
WHERE table_name = 'T'
ORDER BY partition_name, subpartition_name;

PAUSE

REM
REM Clean up
REM

DROP TABLE t PURGE;
