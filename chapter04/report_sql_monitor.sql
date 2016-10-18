SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: report_sql_monitor.sql
REM Author......: Christian Antognini
REM Date........: February 2014
REM Description.: This script can be used to generate, from SQL*Plus, an active  
REM               real-time monitoring report for the last execution of a 
REM               statement identified by its SQL id.
REM Notes.......: -
REM Parameters..: &1: SQL id of the statement to be reported
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM
REM ***************************************************************************

SET TRIMSPOOL ON
SET TRIM ON
SET PAGESIZE 0
SET LINESIZE 1000
SET LONG 1000000
SET LONGCHUNKSIZE 1000000
SET SCAN ON
SET FEEDBACK OFF
SET VERIFY OFF

DEFINE sql_id = &1

SPOOL sqlmon_&sql_id..html

SELECT dbms_sqltune.report_sql_monitor(sql_id => '&sql_id', 
                                       type => 'active') 
FROM dual;

SPOOL OFF

HOST sqlmon_&sql_id..html

UNDEFINE sql_id
UNDEFINE 1
