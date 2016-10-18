SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: dbms_profiler_triggers.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: You can use this script to create two triggers enabling and
REM               disabling the PL/SQL profiler.
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

@../connect.sql

SET ECHO ON

REM
REM The triggers will start/stop the profiler for each user having the
REM following role enabled while connecting/disconnecting the database.
REM

CREATE ROLE profile;

PAUSE

CREATE TRIGGER start_profiler AFTER LOGON ON DATABASE
BEGIN
  IF (dbms_session.is_role_enabled('PROFILE')) 
  THEN
    dbms_profiler.start_profiler();
  END IF;
END;
/

PAUSE

CREATE TRIGGER stop_profiler BEFORE LOGOFF ON DATABASE
BEGIN
  IF (dbms_session.is_role_enabled('PROFILE')) 
  THEN
    dbms_profiler.stop_profiler();
  END IF;
END;
/
