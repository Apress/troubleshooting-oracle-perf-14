SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: dbms_stats_job_10g.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows the actual configuration of the job aimed
REM               at automatically gathering object statistics, which is
REM               installed and scheduled during the creation of a 10g database.
REM Notes.......: This script works in Oracle Database 10g only.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 01.06.2012 Removed reference to schedule_type
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

@../connect.sql

COLUMN program_owner FORMAT A13
COLUMN program_name FORMAT A17
COLUMN schedule_owner FORMAT A14
COLUMN schedule_name FORMAT A24
COLUMN schedule_type FORMAT A15
COLUMN enabled FORMAT A7
COLUMN state FORMAT A9
COLUMN program_type FORMAT A16
COLUMN program_action FORMAT A41
COLUMN enabled FORMAT A7
COLUMN window_name FORMAT A16
COLUMN repeat_interval FORMAT A37
COLUMN duration FORMAT A13
COLUMN enabled FORMAT A7

SET ECHO ON

SELECT program_name, schedule_name, enabled, state
FROM dba_scheduler_jobs
WHERE owner = 'SYS' 
AND job_name = 'GATHER_STATS_JOB';

PAUSE

SELECT program_action, number_of_arguments, enabled
FROM dba_scheduler_programs
WHERE owner = 'SYS'
AND program_name = 'GATHER_STATS_PROG';

PAUSE

SELECT w.window_name, w.repeat_interval, w.duration, w.enabled
FROM dba_scheduler_jobs j, dba_scheduler_wingroup_members m, 
     dba_scheduler_windows w
WHERE j.schedule_name = m.window_group_name
AND m.window_name = w.window_name
AND j.owner = 'SYS' 
AND j.job_name = 'GATHER_STATS_JOB';

PAUSE

SELECT w.window_name, w.repeat_interval, w.duration, w.enabled
FROM dba_scheduler_wingroup_members m, dba_scheduler_windows w
WHERE m.window_name = w.window_name
AND m.window_group_name = 'MAINTENANCE_WINDOW_GROUP';
