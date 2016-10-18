SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: dbms_stats_job_11g.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows the actual configuration of the job aimed
REM               at automatically gathering object statistics, which is
REM               installed and scheduled during the creation of an 11g
REM               database.
REM Notes.......: This script works in Oracle Database 11g only.
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

@../connect.sql

COLUMN task_name FORMAT A17
COLUMN status FORMAT A7
COLUMN program_action FORMAT A41
COLUMN enabled FORMAT A7
COLUMN window_group FORMAT A14
COLUMN window_name FORMAT A16
COLUMN repeat_interval FORMAT A53
COLUMN duration FORMAT A13
COLUMN enabled FORMAT A7

SET ECHO ON

SELECT task_name, status
FROM dba_autotask_task
WHERE client_name = 'auto optimizer stats collection';

PAUSE

SELECT program_action, number_of_arguments, enabled
FROM dba_scheduler_programs
WHERE owner = 'SYS'
AND program_name = 'GATHER_STATS_PROG';

PAUSE

SELECT window_group
FROM dba_autotask_client
WHERE client_name = 'auto optimizer stats collection';

PAUSE

SELECT w.window_name, w.repeat_interval, w.duration, w.enabled
FROM dba_autotask_window_clients c, dba_scheduler_windows w
WHERE c.window_name = w.window_name
AND c.optimizer_stats = 'ENABLED';
