SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: exec_env_trigger.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script creates a configuration table and a database 
REM               trigger to control the execution environment at the session
REM               level.
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

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON
SET ECHO ON

CONNECT &user/&password@&service AS SYSDBA

PAUSE

CREATE TABLE exec_env_conf (
  username  VARCHAR2(30),
  parameter VARCHAR2(80),
  value     VARCHAR2(512)
);

PAUSE

REM Examples...

INSERT INTO exec_env_conf VALUES ('OPS$CHA', 'optimizer_mode', 'first_rows_10');
INSERT INTO exec_env_conf VALUES ('OPS$CHA', 'optimizer_dynamic_sampling', '0');
COMMIT;

PAUSE

CREATE OR REPLACE TRIGGER execution_environment AFTER LOGON ON DATABASE
BEGIN
  FOR c IN (SELECT parameter, value
            FROM exec_env_conf
            WHERE username = sys_context('userenv','session_user'))
  LOOP
    EXECUTE IMMEDIATE 'ALTER SESSION SET ' || c.parameter || '=' || c.value;
  END LOOP;
END;
/
