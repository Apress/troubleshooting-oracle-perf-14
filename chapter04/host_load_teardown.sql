SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: host_load_teardown.sql
REM Author......: Christian Antognini
REM Date........: May 2014
REM Description.: This script de-installs the HOST_LOAD function used by the
REM               host_load.sql script. The script has to be executed as SYS.
REM Notes.......: -
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 
REM ***************************************************************************

SET ECHO ON

DROP TYPE t_host_load_tab;
DROP TYPE t_host_load;

DROP FUNCTION host_load;

DROP PUBLIC SYNONYM host_load;
