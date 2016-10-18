SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: tune_last_statement.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script is used to instruct the SQL Tuning Advisor to
REM               analyze the last SQL statement executed by the current session. 
REM               When the processing is over, the analysis report is shown.
REM               Before executing the SQL statement to be analyzed SERVEROUTPUT
REM               must be switched off.
REM Notes.......: This script requires Oracle Database 10g or never.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 24.06.2010 Added SET SERVEROUTPUT OFF in the initialization part
REM 08.09.2010 Removed SET SERVEROUTPUT OFF in the initialization part +
REM            Added comment about SERVEROUTPUT
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON
SET LONG 1000000
SET ECHO ON

VARIABLE tuning_task VARCHAR2(30)

DECLARE
  l_sql_id v$session.prev_sql_id%TYPE;
BEGIN
  SELECT prev_sql_id INTO l_sql_id
  FROM v$session
  WHERE audsid = sys_context('userenv','sessionid');
  
  :tuning_task := dbms_sqltune.create_tuning_task(sql_id => l_sql_id);
  dbms_sqltune.execute_tuning_task(:tuning_task);
END;
/

SELECT dbms_sqltune.report_tuning_task(:tuning_task) 
FROM dual;
