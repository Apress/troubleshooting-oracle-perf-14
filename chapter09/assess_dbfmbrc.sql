SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: assess_dbfmbrc.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script is used to test the performance of multiblock
REM               reads for different values of the initialization parameter
REM               db_file_multiblock_read_count. The idea is to determine
REM               the value of this parameter that provides optimal
REM               performance.
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

UNDEFINE OWNER
UNDEFINE TABLE_NAME

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE &&owner . &&table_name;

CREATE TABLE &&owner . &&table_name
NOLOGGING
TABLESPACE &tablespace
AS
WITH 
  t AS (
    SELECT /*+ materialize */ dbms_random.string('p',50) AS pad
    FROM dual
    CONNECT BY level <= 4000
    ORDER BY dbms_random.normal
  )
SELECT /*+ ordered */ rownum AS id, 
       t1.pad AS pad01, t1.pad AS pad02, t1.pad AS pad03, t1.pad AS pad04, t1.pad AS pad05, 
       t1.pad AS pad06, t1.pad AS pad07, t1.pad AS pad08, t1.pad AS pad09, t1.pad AS pad10
FROM t t1, t t2;

execute dbms_stats.gather_table_stats('&&owner', '&&table_name')

SET SERVEROUTPUT ON

PAUSE

REM
REM Test performance for different values of db_file_multiblock_read_count
REM

DECLARE
  l_count PLS_INTEGER;
  l_time NUMBER(10,1);
  l_starting_time PLS_INTEGER;
  l_ending_time PLS_INTEGER;
  l_blocks PLS_INTEGER;
  l_starting_blocks PLS_INTEGER;
  l_ending_blocks PLS_INTEGER;
  l_starting_cpu PLS_INTEGER;
  l_ending_cpu PLS_INTEGER;
  l_cpu PLS_INTEGER;
  l_dbfmbrc PLS_INTEGER;
BEGIN
  dbms_output.put_line('dbfmbrc blocks seconds cpu');
  FOR i IN 0..10
  LOOP
    l_dbfmbrc := power(2,i);
    
    EXECUTE IMMEDIATE 'ALTER SESSION SET db_file_multiblock_read_count = '||l_dbfmbrc;
    EXECUTE IMMEDIATE 'ALTER SYSTEM FLUSH BUFFER_CACHE';
    
    SELECT sum(decode(name, 'physical reads', value)),
           sum(decode(name, 'CPU used by this session', value)) 
    INTO l_starting_blocks, l_starting_cpu
    FROM v$mystat ms JOIN v$statname USING (statistic#) 
    WHERE name IN ('physical reads','CPU used by this session');

    l_starting_time := dbms_utility.get_time();

    SELECT count(*) INTO l_count FROM &&owner . &&table_name t;

    l_ending_time := dbms_utility.get_time();
    
    SELECT sum(decode(name, 'physical reads', value)),
           sum(decode(name, 'CPU used by this session', value)) 
    INTO l_ending_blocks, l_ending_cpu
    FROM v$mystat ms JOIN v$statname USING (statistic#) 
    WHERE name IN ('physical reads','CPU used by this session');

    l_time := round((l_ending_time-l_starting_time)/100,1);
    l_blocks := l_ending_blocks-l_starting_blocks;
    l_cpu := l_ending_cpu-l_starting_cpu;
    dbms_output.put_line(l_dbfmbrc||' '||l_blocks||' '||to_char(l_time)||' '||to_char(l_cpu));
  END LOOP;
END;
/

REM
REM Cleanup
REM

DROP TABLE &&owner . &&table_name;
PURGE TABLE &&owner . &&table_name;

UNDEFINE OWNER
UNDEFINE TABLE_NAME
