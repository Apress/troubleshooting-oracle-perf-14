SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: active_sessions.sql
REM Author......: Christian Antognini
REM Date........: October 2011
REM Description.: This script shows the top-n sessions. DB time utilization is
REM               the sorting criteria.
REM Notes.......: Before using this script for the first time, it is required 
REM               to install the ACTIVE_SESSIONS function. To install it, run 
REM               active_sessions_setup.sql as SYS.
REM Parameters..: &1: interval between two samples
REM               &2: number of samples
REM               &3: number of sessions to show
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 
REM ***************************************************************************

SET TERMOUT OFF FEEDBACK OFF SCAN ON VERIFY OFF ARRAYSIZE 1 PAGESIZE 10000 LINESIZE 90

CLEAR BREAKS
BREAK ON time SKIP PAGE ON sessions ON logins

CLEAR COLUMNS
COLUMN time FORMAT A8 HEADING "Time"
COLUMN sessions FORMAT 999,999 HEADING "#Sessions"
COLUMN logins FORMAT 99,999 HEADING "#Logins"
COLUMN sid FORMAT A15 TRUNCATE HEADING "SessionId"
COLUMN username FORMAT A20 TRUNCATE HEADING "Username"
COLUMN program FORMAT A16 TRUNCATE HEADING "Program" 
COLUMN activity FORMAT 990.0 HEADING  "Activity%"

COLUMN global_name NEW_VALUE global_name
COLUMN day NEW_VALUE day

SELECT global_name, to_char(sysdate,'yyyy-mm-dd') AS day
FROM global_name;

TTITLE CENTER '&global_name / &day' SKIP 2

SET TERMOUT ON

SELECT to_char(tstamp,'hh24:mi:ss') AS time, sessions, logins, sid, username, program, activity
FROM table(active_sessions(&1,&2,&3));

UNDEFINE 1
UNDEFINE 2
UNDEFINE 3
UNDEFINE global_name
UNDEFINE day

TTITLE OFF

CLEAR BREAKS
CLEAR COLUMNS
