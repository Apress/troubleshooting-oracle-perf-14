SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: system_activity_teardown.sql
REM Author......: Christian Antognini
REM Date........: October 2011
REM Description.: This script de-installs the objects required by the  
REM               system_activity.sql script. It has to be executed as SYS.
REM Notes.......: -
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 

SET ECHO ON

DROP TYPE t_system_activity_tab;
DROP TYPE t_system_activity;
DROP TYPE t_system_wait_class_tab;
DROP TYPE t_system_wait_class;

DROP FUNCTION system_activity;

DROP PUBLIC SYNONYM system_activity;
