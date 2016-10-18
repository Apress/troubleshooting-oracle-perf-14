SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: ash_top_clients.sql
REM Author......: Christian Antognini
REM Date........: January 2014
REM Description.: 
REM Notes.......: To run this script the Diagnostic Pack license is required. 
REM Parameters..: &1 begin timestamp (format: YYYY-MM-DD_HH24:MI:SSXFF)
REM               &2 end timestamp (format: YYYY-MM-DD_HH24:MI:SSXFF)
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

COLUMN activity_pct FORMAT 990.00
COLUMN db_time FORMAT 9,999,999
COLUMN cpu_pct FORMAT 990.00
COLUMN user_io_pct FORMAT 990.00
COLUMN wait_pct FORMAT 990.00
COLUMN client_id FORMAT A40 TRUNCATE

DEFINE t1 = &1
DEFINE t2 = &2

SELECT ash.activity_pct,
       ash.db_time,
       round(ash.cpu_time / ash.db_time * 100, 2) AS cpu_pct,
       round(ash.user_io_time / ash.db_time * 100, 2) AS user_io_pct,
       round(ash.wait_time / ash.db_time * 100, 2) AS wait_pct,
       ash.client_id
FROM (
  SELECT round(100 * ratio_to_report(sum(1)) OVER (), 2) AS activity_pct,
         sum(1) AS db_time,
         sum(decode(session_state, 'ON CPU', 1, 0)) AS cpu_time,
         sum(decode(session_state, 'WAITING', decode(wait_class, 'User I/O', 1, 0), 0)) AS user_io_time,
         sum(decode(session_state, 'WAITING', 1, 0)) - sum(decode(session_state, 'WAITING', decode(wait_class, 'User I/O', 1, 0), 0)) AS wait_time,
         client_id 
  FROM v$active_session_history
  WHERE sample_time > to_timestamp('&t1','YYYY-MM-DD_HH24:MI:SSXFF')
  AND sample_time <= to_timestamp('&t2','YYYY-MM-DD_HH24:MI:SSXFF')
  GROUP BY client_id
  ORDER BY sum(1) DESC
) ash
WHERE rownum <= 10;

UNDEFINE t1
UNDEFINE t2

UNDEFINE 1
UNDEFINE 2
