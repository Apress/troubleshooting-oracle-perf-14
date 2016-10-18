SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: ash_activity.sql
REM Author......: Christian Antognini
REM Date........: January 2014
REM Description.: This script displays the average number of active sessions,
REM               as well as the percentage of contribution for each wait
REM               class. Data is aggregated by minute.
REM Notes.......: To run this script the Diagnostic Pack license is required. 
REM Parameters..: &1 either "all" or the sid of the session to focus on
REM               &2 either "all" or the SQL id of the statement to focus on
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 29.06.2014 Added header to the output
REM ***************************************************************************

SET TERMOUT OFF LINESIZE 110 SCAN ON VERIFY OFF FEEDBACK OFF

UNDEFINE sid
UNDEFINE sql_id

COLUMN sample_time FORMAT A5 HEADING TIME
COLUMN aas FORMAT 990.0 HEADING AvgActSes
COLUMN cpu_pct FORMAT 990.0 HEADING CPU%
COLUMN scheduler_pct FORMAT 990.0 HEADING Sched%
COLUMN user_io_pct FORMAT 990.0 HEADING UsrIO%
COLUMN system_io_pct FORMAT 990.0 HEADING SysIO%
COLUMN concurrency_pct FORMAT 990.0 HEADING Conc%
COLUMN application_pct FORMAT 990.0 HEADING Appl%
COLUMN commit_pct FORMAT 990.0 HEADING Commit%
COLUMN configuration_pct FORMAT 990.0 HEADING Config%
COLUMN administrative_pct FORMAT 990.0 HEADING Admin%
COLUMN network_pct FORMAT 990.0 HEADING Net%
COLUMN queueing_pct FORMAT 990.0 HEADING Queue%
COLUMN cluster_pct FORMAT 990.0 HEADING Cluster%
COLUMN other_pct FORMAT 990.0 HEADING Other%

DEFINE sid = &1
DEFINE sql_id = &2

COLUMN global_name NEW_VALUE global_name
COLUMN day NEW_VALUE day

SELECT global_name, to_char(sysdate,'yyyy-mm-dd') AS day
FROM global_name;

TTITLE CENTER '&global_name / &day' SKIP 2

SET TERMOUT ON

SELECT to_char(sample_time, 'HH24:MI') sample_time,
       round(db_time / 60, 1) AS aas,
       round(cpu_time / db_time * 100, 1) AS cpu_pct,
       round(scheduler_time / db_time * 100, 1) AS scheduler_pct,
       round(user_io_time / db_time * 100, 1) AS user_io_pct,
       round(system_io_time / db_time * 100, 1) AS system_io_pct,
       round(concurrency_time / db_time * 100, 1) AS concurrency_pct,
       round(application_time / db_time * 100, 1) AS application_pct,
       round(commit_time / db_time * 100, 1) AS commit_pct,
       round(configuration_time / db_time * 100, 1) AS configuration_pct,
       round(administrative_time / db_time * 100, 1) AS administrative_pct,
       round(network_time / db_time * 100, 1) AS network_pct,
       round(queueing_time / db_time * 100, 1) AS queueing_pct,
       round(cluster_time / db_time * 100, 1) AS cluster_pct,
       round(other_time / db_time * 100, 1) AS other_pct
FROM (
  SELECT sum(1) AS db_time,
         sum(decode(session_state, 'ON CPU', 1, 0)) AS cpu_time,
         sum(decode(session_state, 'WAITING', decode(wait_class, 'Scheduler', 1, 0), 0)) AS scheduler_time,
         sum(decode(session_state, 'WAITING', decode(wait_class, 'User I/O', 1, 0), 0)) AS user_io_time,
         sum(decode(session_state, 'WAITING', decode(wait_class, 'System I/O', 1, 0), 0)) AS system_io_time,
         sum(decode(session_state, 'WAITING', decode(wait_class, 'Concurrency', 1, 0), 0)) AS concurrency_time,
         sum(decode(session_state, 'WAITING', decode(wait_class, 'Application', 1, 0), 0)) AS application_time,
         sum(decode(session_state, 'WAITING', decode(wait_class, 'Commit', 1, 0), 0)) AS commit_time,
         sum(decode(session_state, 'WAITING', decode(wait_class, 'Configuration', 1, 0), 0)) AS configuration_time,
         sum(decode(session_state, 'WAITING', decode(wait_class, 'Administrative', 1, 0), 0)) AS administrative_time,
         sum(decode(session_state, 'WAITING', decode(wait_class, 'Network', 1, 0), 0)) AS network_time,
         sum(decode(session_state, 'WAITING', decode(wait_class, 'Queueing', 1, 0), 0)) AS queueing_time,
         sum(decode(session_state, 'WAITING', decode(wait_class, 'Cluster', 1, 0), 0)) AS cluster_time,
         sum(decode(session_state, 'WAITING', decode(wait_class, 'Other', 1, 0), 0)) AS other_time,
         round(sample_time, 'MI') AS sample_time
  FROM v$active_session_history
  WHERE sample_time >= systimestamp - INTERVAL '1' HOUR
  AND session_id = decode(lower('&sid'), 'all', session_id, to_number('&sid')) 
  AND sql_id = decode(lower('&sql_id'), 'all', sql_id, '&sql_id')
  GROUP BY round(sample_time, 'MI')
  ORDER BY round(sample_time, 'MI')
)
WHERE rownum <= 60;

UNDEFINE 1
UNDEFINE 2

UNDEFINE sid
UNDEFINE sql_id

TTITLE OFF

CLEAR COLUMNS
