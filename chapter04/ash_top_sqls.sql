SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: ash_top_sqls.sql
REM Author......: Christian Antognini
REM Date........: January 2014
REM Description.: 
REM Notes.......: To run this script the Diagnostic Pack license is required. 
REM Parameters..: &1 begin timestamp (format: YYYY-MM-DD_HH24:MI:SSXFF)
REM               &2 end timestamp (format: YYYY-MM-DD_HH24:MI:SSXFF)
REM               &3 either "all" or the sid of the session to focus on
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM
REM ***************************************************************************

SET TERMOUT ON LINESIZE 120 SCAN ON VERIFY OFF FEEDBACK OFF

UNDEFINE t1
UNDEFINE t2
UNDEFINE sid

COLUMN activity_pct FORMAT 990.0 HEADING "Activity%"
COLUMN db_time FORMAT 9,999,999 HEADING "DB Time"
COLUMN cpu_pct FORMAT 990.0 HEADING "CPU%"
COLUMN user_io_pct FORMAT 990.0 HEADING "UsrIO%"
COLUMN wait_pct FORMAT 990.0 HEADING "Wait%"
COLUMN sql_id FORMAT A13 HEADING "SQL Id"
COLUMN sql_opname FORMAT A28 TRUNCATE HEADING "SQL Type"

REMARK Timestamp format: YYYY-MM-DD_HH24:MI:SSXFF

DEFINE t1 = &1
DEFINE t2 = &2
DEFINE sid = &3

SELECT activity_pct,
       db_time,
       round(cpu_time / db_time * 100, 1) AS cpu_pct,
       round(user_io_time / db_time * 100, 1) AS user_io_pct,
       round(wait_time / db_time * 100, 1) AS wait_pct,
       sql_id,
       sql_opname
FROM (
  SELECT round(100 * ratio_to_report(sum(1)) OVER (), 1) AS activity_pct,
         sum(1) AS db_time,
         sum(decode(session_state, 'ON CPU', 1, 0)) AS cpu_time,
         sum(decode(session_state, 'WAITING', decode(wait_class, 'User I/O', 1, 0), 0)) AS user_io_time,
         sum(decode(session_state, 'WAITING', 1, 0)) - sum(decode(session_state, 'WAITING', decode(wait_class, 'User I/O', 1, 0), 0)) AS wait_time,
         sql_id,
         sql_opname
  FROM v$active_session_history
  WHERE sample_time > to_timestamp('&t1','YYYY-MM-DD_HH24:MI:SSXFF')
  AND sample_time <= to_timestamp('&t2','YYYY-MM-DD_HH24:MI:SSXFF')
  AND sql_id IS NOT NULL
  AND session_id = decode(lower('&sid'), 'all', session_id, to_number('&sid')) 
  GROUP BY sql_id, sql_opname
  ORDER BY sum(1) DESC
)
WHERE rownum <= 10;

UNDEFINE t1
UNDEFINE t2
UNDEFINE sid

UNDEFINE 1
UNDEFINE 2
UNDEFINE 3
