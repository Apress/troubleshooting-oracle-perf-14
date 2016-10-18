SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: session_attributes.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows how to get and set the client identifier, 
REM               client information, module name, and action name.
REM Notes.......: - 
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 31.01.2012 Added query and note for 9i
REM 07.12.2013 Renamed from session_info.sql to session_attributes.sql +
REM            removed 9i code and comments
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

@../connect.sql

COLUMN client_identifier FORMAT A20
COLUMN client_info FORMAT A12
COLUMN module_name FORMAT A22
COLUMN action_name FORMAT A24

SET ECHO ON

REM
REM Set client identifier, client information, module name and action name
REM

BEGIN
  dbms_session.set_identifier(client_id=>'helicon.antognini.ch');
  dbms_application_info.set_client_info(client_info=>'Linux x86_64');
  dbms_application_info.set_module(module_name=>'session_attributes.sql', 
                                   action_name=>'test session information');
END;
/

PAUSE

REM
REM Get client identifier, client information, module name and action name
REM

REM From the userenv context... 

SELECT sys_context('userenv','client_identifier') AS client_identifier,
       sys_context('userenv','client_info') AS client_info,
       sys_context('userenv','module') AS module_name,
       sys_context('userenv','action') AS action_name
FROM dual;

PAUSE

REM From v$session

SELECT client_identifier, 
       client_info, 
       module AS module_name, 
       action AS action_name
FROM v$session
WHERE sid = sys_context('userenv','sid');

PAUSE

REM
REM Another sample code used for Figure 3-3
REM

BEGIN
  dbms_session.set_identifier(client_id=>'helicon.antognini.ch');
  dbms_application_info.set_module(module_name=>'Module 1', 
                                   action_name=>'Action 11');
  -- code module 1, action 11
  COMMIT;
  dbms_application_info.set_module(module_name=>'Module 1', 
                                   action_name=>'Action 12');
  -- code module 1, action 12
  COMMIT;
  dbms_application_info.set_module(module_name=>'Module 1', 
                                   action_name=>'Action 13');
  -- code module 1, action 13
  COMMIT;
  dbms_application_info.set_module(module_name=>'Module 2', 
                                   action_name=>'Action 21');
  -- code module 2, action 21
  COMMIT;
  dbms_application_info.set_module(module_name=>'Module 2', 
                                   action_name=>'Action 22');
  -- code module 2, action 22
  COMMIT;
END;
/
