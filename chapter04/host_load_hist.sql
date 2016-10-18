SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: host_load_hist.sql
REM Author......: Christian Antognini
REM Date........: May 2014
REM Description.: This script shows the CPU utilization at the database server
REM               level.
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

SET LINESIZE 66
SET TERMOUT OFF

COLUMN begin_time FORMAT A10
COLUMN duration FORMAT 90.00
COLUMN db_fg_cpu FORMAT 90.00
COLUMN db_bg_cpu FORMAT 90.00
COLUMN non_db_cpu FORMAT 90.00
COLUMN os_load FORMAT 90.00
COLUMN num_cpu FORMAT 999

COLUMN global_name NEW_VALUE global_name
COLUMN day NEW_VALUE day

SELECT global_name, to_char(sysdate,'yyyy-mm-dd') AS day
FROM global_name;

TTITLE CENTER '&global_name / &day' SKIP 2

SET TERMOUT ON

SELECT to_char(begin_time, 'HH24:MI:SS') AS begin_time, 
       duration, 
       db_fg_cpu, 
       db_bg_cpu, 
       host_cpu - db_fg_cpu - db_bg_cpu AS non_db_cpu, 
       os_load,
       (SELECT nvl(num_cpu_cores, num_cpus) FROM dual) AS num_cpu
FROM (
  SELECT begin_time, 
         intsize_csec/100 AS duration,
         sum(case when metric_name = 'Host CPU Usage Per Sec' then value/100 else 0 end) AS host_cpu, 
         sum(case when metric_name = 'CPU Usage Per Sec' then value/100 else 0 end) AS db_fg_cpu, 
         sum(case when metric_name = 'Background CPU Usage Per Sec' then value/100 else 0 end) AS db_bg_cpu,
         sum(case when metric_name = 'Current OS Load' then value else 0 end) AS os_load,
         (SELECT value FROM v$osstat WHERE stat_name = 'NUM_CPUS') AS num_cpus,
         (SELECT value FROM v$osstat WHERE stat_name = 'NUM_CPU_CORES') AS num_cpu_cores
  FROM v$metric_history 
  WHERE group_id = (SELECT group_id FROM v$metricgroup WHERE name = 'System Metrics Long Duration')
  AND metric_name IN ('Host CPU Usage Per Sec', 
                      'CPU Usage Per Sec', 
                      'Background CPU Usage Per Sec',
                      'Current OS Load')
  GROUP BY begin_time, intsize_csec
)
ORDER BY begin_time; 

TTITLE OFF

CLEAR COLUMNS
