SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: time_model.sql
REM Author......: Christian Antognini
REM Date........: October 2011
REM Description.: This script shows how the DB time is spent over a period
REM               of time.
REM Notes.......: Before using this script for the first time, it is required 
REM               to install the TIME_MODEL function. To install it, run 
REM               time_model_setup.sql as SYS.
REM Parameters..: &1: interval between two samples
REM               &2: number of samples
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 
REM ***************************************************************************

SET TERMOUT OFF FEEDBACK OFF SCAN ON VERIFY OFF ARRAYSIZE 1 PAGESIZE 50 LINESIZE 80

CLEAR BREAKS
BREAK ON time SKIP PAGE

CLEAR COLUMNS
COLUMN time FORMAT A8 TRUNCATE HEADING "Time"
COLUMN stat_name FORMAT A50 TRUNCATE HEADING "Statistic"
COLUMN aas FORMAT 999,990.0 HEADING "AvgActSess"
COLUMN activity FORMAT 990.0 HEADING "Activity%"

COLUMN global_name NEW_VALUE global_name
COLUMN day NEW_VALUE day

SELECT global_name, to_char(sysdate,'yyyy-mm-dd') AS day
FROM global_name;

TTITLE CENTER '&global_name / &day' SKIP 2

SET TERMOUT ON

SELECT to_char(tstamp,'hh24:mi:ss') AS time, stat_name, aas, activity 
FROM table(time_model(&1,&2)) 
WHERE aas >= 0.01;

UNDEFINE 1
UNDEFINE 2
UNDEFINE global_name
UNDEFINE day

TTITLE OFF

CLEAR BREAKS
CLEAR COLUMNS
