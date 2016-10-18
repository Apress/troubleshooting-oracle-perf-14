SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: system_stats_history_job.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script can be used to create a table and a job to store
REM               the evolution of workload statistics over several days.
REM Notes.......: The script must be executed while connected as SYSDBA.
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
SET ECHO ON

execute dbms_stats.create_stat_table('sys','aux_stats_history')

VARIABLE job NUMBER

execute dbms_job.submit(:job,'declare statid varchar2(30) := ''S''||to_char(sysdate,''yyyymmddhh24miss''); begin dbms_stats.gather_system_stats(''start'', null, ''aux_stats_history'', statid, ''sys''); dbms_lock.sleep(3600); dbms_stats.gather_system_stats(''stop'', null, ''aux_stats_history'', statid, ''sys''); end;',sysdate,'sysdate+1/24')

COMMIT;

PRINT job

REM
REM a couple of days later...
REM 
REM execute dbms_job.remove(:job)
REM
