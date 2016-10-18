SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: time_model_teardown.sql
REM Author......: Christian Antognini
REM Date........: October 2011
REM Description.: This script de-installs the objects required by the  
REM               time_model.sql script. It has to be executed as SYS.
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

DROP TYPE t_time_model_tab;
DROP TYPE t_time_model;
DROP TYPE t_sys_time_model_tab;
DROP TYPE t_sys_time_model;

DROP FUNCTION time_model;

DROP PUBLIC SYNONYM time_model;
