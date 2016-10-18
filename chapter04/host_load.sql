SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: host_load.sql
REM Author......: Christian Antognini
REM Date........: May 2014
REM Description.: This script shows the CPU utilization at the database server
REM               level.
REM Notes.......: Before using this script for the first time, it is required 
REM               to install the HOST_LOAD function. To install it, run 
REM               host_load_setup.sql as SYS.
REM Parameters..: &1: length of the monitoring period in minutes
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 
REM ***************************************************************************

SET ECHO OFF TERMOUT OFF FEEDBACK OFF SCAN ON VERIFY OFF ARRAYSIZE 1 PAGESIZE 25 LINESIZE 70 HEADING ON

CLEAR BREAKS
CLEAR COLUMNS

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
    	 non_db_cpu,
    	 os_load,
    	 num_cpu
FROM table(host_load(&1));

UNDEFINE 1
UNDEFINE global_name
UNDEFINE day

TTITLE OFF

CLEAR BREAKS
CLEAR COLUMNS
