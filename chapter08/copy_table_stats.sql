SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: copy_table_stats.sql
REM Author......: Christian Antognini
REM Date........: April 2014
REM Description.: This script shows how to copy statistics between two
REM               partitions.
REM Notes.......: -
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 22.08.2014 Added convert_raw_value function to decode low/high values
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET LINESIZE 100
SET PAGESIZE 1000

COLUMN column_name FORMAT A11
COLUMN partition_name FORMAT A14
COLUMN global_stats FORMAT A12
COLUMN low_value FORMAT A10 TRUNCATE
COLUMN high_value FORMAT A10 TRUNCATE

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

CREATE OR REPLACE FUNCTION convert_raw_value(p_value IN RAW, p_datatype IN VARCHAR2) RETURN VARCHAR2 IS
  l_ret VARCHAR2(64);
  l_date DATE;
  l_number NUMBER;
  l_binary_float BINARY_FLOAT;
  l_binary_double BINARY_DOUBLE;
  l_nvarchar2 NVARCHAR2(64);
  l_rowid ROWID;
BEGIN
  IF p_datatype = 'VARCHAR2' OR p_datatype = 'CHAR'
  THEN
    dbms_stats.convert_raw_value(p_value, l_ret);
  ELSIF p_datatype = 'DATE'
  THEN
    dbms_stats.convert_raw_value(p_value, l_date);
    l_ret := to_char(l_date, 'YYYY-MM-DD HH24:MI:SS');
  ELSIF p_datatype LIKE 'TIMESTAMP%'
  THEN
    dbms_stats.convert_raw_value(p_value, l_date);
    l_ret := to_char(l_date, 'YYYY-MM-DD HH24:MI:SS');
  ELSIF p_datatype = 'NUMBER'
  THEN
    dbms_stats.convert_raw_value(p_value, l_number);
    l_ret := to_char(l_number);
  ELSIF p_datatype = 'BINARY_FLOAT'
  THEN
    dbms_stats.convert_raw_value(p_value, l_binary_float);
    l_ret := to_char(l_binary_float);
  ELSIF p_datatype = 'BINARY_DOUBLE'
  THEN
    dbms_stats.convert_raw_value(p_value, l_binary_double);
    l_ret := to_char(l_binary_double);
  ELSIF p_datatype = 'NVARCHAR2'
  THEN
    dbms_stats.convert_raw_value(p_value, l_nvarchar2);
    l_ret := to_char(l_nvarchar2);
  ELSIF p_datatype = 'ROWID'
  THEN
    dbms_stats.convert_raw_value(p_value, l_nvarchar2);
    l_ret := to_char(l_nvarchar2);
  ELSE
    l_ret := 'UNSUPPORTED DATATYPE';
  END IF;
  RETURN l_ret;
END convert_raw_value;
/

DROP TABLE t PURGE;

CREATE TABLE t (id NUMBER, p DATE, sp NUMBER, pad VARCHAR2(1000))
PARTITION BY RANGE (p)
(
  PARTITION p_2013_q1 VALUES LESS THAN (to_date('2013-04-01','YYYY-MM-DD')),
  PARTITION p_2013_q2 VALUES LESS THAN (to_date('2013-07-01','YYYY-MM-DD')),
  PARTITION p_2013_q3 VALUES LESS THAN (to_date('2013-10-01','YYYY-MM-DD')),
  PARTITION p_2013_q4 VALUES LESS THAN (to_date('2014-01-01','YYYY-MM-DD'))
);

INSERT INTO t
SELECT rownum, to_date('2013-01-01','YYYY-MM-DD')+mod(rownum,365), mod(rownum,100)+1, rpad('*',100,'*')
FROM dual
CONNECT BY level <= 16000;

COMMIT;

PAUSE

REM
REM Gather and display object statistics
REM

REM Use granularity => 'partition' to NOT collect global stats, and hence 
REM to have derived statistics at the object level

BEGIN
	dbms_stats.gather_table_stats(ownname => user, 
	                              tabname => 't',
	                              granularity => 'all'
	                              --granularity => 'partition'
	                              );
END;
/

PAUSE

SELECT partition_name, num_rows, blocks, global_stats
FROM user_tab_statistics
WHERE table_name = 'T'
ORDER BY partition_name NULLS FIRST;

PAUSE

SELECT column_name, 
       num_distinct, 
       convert_raw_value(low_value, data_type) AS low_value, 
       convert_raw_value(high_value, data_type) AS high_value, 
       global_stats
FROM user_tab_columns
WHERE table_name = 'T'
AND column_name IN ('P', 'SP')
ORDER BY column_name;

PAUSE

SELECT s.column_name, 
       s.partition_name, 
       s.num_distinct, 
       convert_raw_value(s.low_value, c.data_type) AS low_value, 
       convert_raw_value(s.high_value, c.data_type) AS high_value, 
       s.global_stats
FROM user_part_col_statistics s, user_tab_columns c
WHERE s.table_name = 'T'
AND s.column_name IN ('P', 'SP')
AND s.table_name = c.table_name
AND s.column_name = c.column_name
ORDER BY s.column_name, s.partition_name;

PAUSE

REM
REM Add a new partition and insert data into it
REM

ALTER TABLE t ADD PARTITION p_2014_q1 VALUES LESS THAN (to_date('2014-04-01','YYYY-MM-DD'));

PAUSE

INSERT INTO t
SELECT rownum, to_date('2014-01-01','YYYY-MM-DD')+mod(rownum,90), mod(rownum,100)+1, rpad('*',100,'*')
FROM dual
CONNECT BY level <= 4000;

COMMIT;

PAUSE

REM
REM Copy statistics and display them
REM

BEGIN
  dbms_stats.copy_table_stats(ownname => user,
                              tabname => 't',
                              srcpartname => 'p_2013_q1',
                              dstpartname => 'p_2014_q1');
END;
/

PAUSE

REM The statistics at table level are only update if non-global statistics
REM are in place. In other words, if the gathering was performed with 
REM granularity => 'partition' 

SELECT partition_name, num_rows, blocks, global_stats
FROM user_tab_statistics
WHERE table_name = 'T'
ORDER BY partition_name NULLS FIRST;

PAUSE

SELECT column_name, 
       num_distinct, 
       convert_raw_value(low_value, data_type) AS low_value, 
       convert_raw_value(high_value, data_type) AS high_value, 
       global_stats
FROM user_tab_columns
WHERE table_name = 'T'
AND column_name IN ('P', 'SP')
ORDER BY column_name;

PAUSE

SELECT s.column_name, 
       s.partition_name, 
       s.num_distinct, 
       convert_raw_value(s.low_value, c.data_type) AS low_value, 
       convert_raw_value(s.high_value, c.data_type) AS high_value, 
       s.global_stats
FROM user_part_col_statistics s, user_tab_columns c
WHERE s.table_name = 'T'
AND s.column_name IN ('P', 'SP')
AND s.table_name = c.table_name
AND s.column_name = c.column_name
ORDER BY s.column_name, s.partition_name;

PAUSE

REM
REM Cleanup
REM

DROP TABLE t PURGE;
DROP FUnCTION convert_raw_value;
