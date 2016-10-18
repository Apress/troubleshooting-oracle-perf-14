SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: system_stats_logging.sql
REM Author......: Christian Antognini
REM Date........: January 2013
REM Description.: This script shows which procedures used for the management of
REM               system statistics log information about their usage.
REM Notes.......: The script changes the system statistics.
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
SET LINESIZE 200
SET LONG 1000000
SET LONGCHUNK 1000000

@../connect.sql

VARIABLE now VARCHAR2(14)

COLUMN operation FORMAT A20
COLUMN start_time FORMAT A33
COLUMN duration FORMAT A12
COLUMN report FORMAT A200

SET ECHO ON

REM
REM Basic example
REM

BEGIN
  SELECT to_char(sysdate,'YYYYMMDDHH24MISS') INTO :now FROM dual;
  dbms_stats.delete_system_stats();
  dbms_stats.gather_system_stats('noworkload');
END;
/

PAUSE

SELECT operation, start_time,
       (end_time-start_time) DAY(1) TO SECOND(0) AS duration
FROM dba_optstat_operations
WHERE start_time > to_date(:now,'YYYYMMDDHH24MISS')
ORDER BY start_time;

PAUSE

REM The following queries work as of 12.1 only

SELECT x.*
FROM dba_optstat_operations o,
     XMLTable('/params/param'
              PASSING XMLType(notes)
              COLUMNS name VARCHAR2(20) PATH '@name',
                      value VARCHAR2(20) PATH '@val') x
WHERE start_time > to_date(:now,'YYYYMMDDHH24MISS')
AND operation = 'gather_system_stats';

PAUSE

SELECT dbms_stats.report_single_stats_operation(opid         => id,
                                                detail_level => 'all',
                                                format       => 'text')
FROM dba_optstat_operations
WHERE operation = 'gather_system_stats'
AND start_time > to_date(:now,'YYYYMMDDHH24MISS');

PAUSE

REM
REM Full example (all procedures are tested)
REM

execute dbms_stats.drop_stat_table(ownname => user, stattab => 'MYSTATS')

DECLARE
  l_status VARCHAR2(30);
  l_dstart VARCHAR2(30);
  l_dstop VARCHAR2(30);
  l_pvalue VARCHAR2(255);
BEGIN
  dbms_stats.create_stat_table(ownname => user, stattab => 'MYSTATS');
  --
  dbms_stats.gather_system_stats(gathering_mode => 'noworkload', 
                                 statown => user, 
                                 stattab => 'MYSTATS');
  dbms_stats.get_system_stats(status => l_status, 
                              dstart => l_dstart, 
                              dstop  => l_dstop, 
                              pname  => 'CPUSPEEDNW',
                              pvalue => l_pvalue,
                              statown => user, 
                              stattab => 'MYSTATS');
  dbms_stats.set_system_stats(pname => 'CPUSPEEDNW', 
                              pvalue => l_pvalue,
                              statown => user, 
                              stattab => 'MYSTATS');
  --
  dbms_stats.export_system_stats(statown => user, stattab => 'MYSTATS');
  dbms_stats.delete_system_stats();
  dbms_stats.gather_system_stats('noworkload');
  dbms_stats.get_system_stats(status => l_status, 
                              dstart => l_dstart, 
                              dstop  => l_dstop, 
                              pname  => 'CPUSPEEDNW',
                              pvalue => l_pvalue);
  dbms_stats.set_system_stats(pname => 'CPUSPEEDNW', 
                              pvalue => l_pvalue);
  dbms_stats.delete_system_stats();
  dbms_stats.import_system_stats(statown => user, stattab => 'MYSTATS');
  dbms_stats.restore_system_stats(to_date(:now,'YYYYMMDDHH24MISS'));
END;
/

PAUSE

SELECT operation, start_time,
       (end_time-start_time) DAY(1) TO SECOND(0) AS duration
FROM dba_optstat_operations
WHERE start_time > to_date(:now,'YYYYMMDDHH24MISS')
ORDER BY start_time;
