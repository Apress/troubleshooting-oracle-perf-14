SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: dbms_hprof_triggers.sql
REM Author......: Christian Antognini
REM Date........: March 2014
REM Description.: You can use this script to create two triggers that enable
REM               and disable the hierarchical profiler. It must be run as SYS.
REM Notes.......: This script works from 11g onward.
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

CREATE ROLE hprof_profile;

PAUSE

CREATE DIRECTORY plshprof_dir AS '&directory_path';

PAUSE

CREATE TRIGGER start_hprof_profiler AFTER LOGON ON DATABASE
BEGIN
  IF (dbms_session.is_role_enabled('HPROF_PROFILE')) 
  THEN
    dbms_hprof.start_profiling(
      location => 'PLSHPROF_DIR',
      filename => 'dbms_hprof_'||sys_context('userenv','sessionid')||'.trc'
    );
  END IF;
END;
/

PAUSE

CREATE TRIGGER stop_hprof_profiler BEFORE LOGOFF ON DATABASE
BEGIN
  IF (dbms_session.is_role_enabled('HPROF_PROFILE')) 
  THEN
    dbms_hprof.stop_profiling();
  END IF;
END;
/
