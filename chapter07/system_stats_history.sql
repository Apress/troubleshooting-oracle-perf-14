SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: system_stats_history.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script is used to extract workload statistics from the
REM               history table created by the script 
REM               system_stats_history_job.sql. The output can be imported
REM               into the spreadsheet system_stats_history.xls.
REM Notes.......: -
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 19.09.2012 Added column with start date and time
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

@../connect.sql

SET ECHO ON

SELECT to_date(substr(statid,2),'yyyymmddhh24miss') AS tstamp, n1 AS sreadtim, n2 AS mreadtim, n3 AS cpuspeed, n11 AS mbrc 
FROM sys.aux_stats_history 
WHERE c4 = 'CPU_SERIO' 
ORDER BY statid;

SELECT to_date(substr(statid,2),'yyyymmddhh24miss') AS tstamp, n1 AS maxthr, n2 AS slavethr 
FROM sys.aux_stats_history 
WHERE c4 = 'PARIO' 
ORDER BY statid;
