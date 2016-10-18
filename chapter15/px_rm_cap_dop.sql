SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: px_rm_cap_dop.sql
REM Author......: Christian Antognini
REM Date........: January 2014
REM Description.: This script shows how to setup the resource manager to cap
REM               the degree of parallelism of the SQL statements executed by
REM               a specific user. The script leaves the configuration in place.
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

UNDEFINE user

@../connect.sql

SET ECHO ON

REM
REM Enable DEFAULT_PLAN
REM

ALTER SYSTEM SET resource_manager_plan = default_plan;

PAUSE

REM
REM Make sure that a plan called CONTROL_DOP does not exist
REM

DECLARE
  resource_plan_does_not_exist EXCEPTION;
  PRAGMA EXCEPTION_INIT(resource_plan_does_not_exist, -29358);
BEGIN
  dbms_resource_manager.clear_pending_area();
  dbms_resource_manager.create_pending_area();
  dbms_resource_manager.delete_plan_cascade(plan => 'CONTROL_DOP');
  dbms_resource_manager.submit_pending_area();
EXCEPTION
  WHEN resource_plan_does_not_exist THEN
    dbms_resource_manager.clear_pending_area();
END;
/

PAUSE

REM
REM Create a plan called CONTROL_DOP that limits the degree of parallelism
REM

BEGIN
  dbms_resource_manager.create_pending_area();
  dbms_resource_manager.create_plan(
    plan    => 'CONTROL_DOP',
    comment => 'Control the degree of parallelism'
  );
  dbms_resource_manager.create_consumer_group (
    consumer_group => 'CAP_DOP',
    comment        => 'Users with a restricted degree of parallelism'
  );
  dbms_resource_manager.create_plan_directive(
    plan                     => 'CONTROL_DOP',
    group_or_subplan         => 'CAP_DOP',
    comment                  => 'Cap degree of parallelism',
    parallel_degree_limit_p1 => &dop
  );
  dbms_resource_manager.create_plan_directive(
    plan             => 'CONTROL_DOP',
    group_or_subplan => 'OTHER_GROUPS',
    comment          => 'Unrestricted degree of parallelism'
  );
  dbms_resource_manager.validate_pending_area();
  dbms_resource_manager.submit_pending_area();
END;
/

PAUSE

REM
REM Provide to a specific user the privilege to switch to the CAP_DOP consumer group
REM

BEGIN
  dbms_resource_manager_privs.grant_switch_consumer_group(
    grantee_name    => &&user,
    consumer_group  => 'CAP_DOP',
    grant_option    => FALSE
  );
END;
/

PAUSE

REM
REM Map the sessions of a specific user (CHRIS) to the CAP_DOP consumer group
REM

BEGIN
  IF dbms_db_version.ver_le_11 
  THEN
    dbms_resource_manager.set_initial_consumer_group(
      user           => &&user,
      consumer_group => 'CAP_DOP'
    );
  ELSE
    dbms_resource_manager.create_pending_area();
    dbms_resource_manager.set_consumer_group_mapping(
      attribute      => 'ORACLE_USER',
      value          => &&user,
      consumer_group => 'CAP_DOP'
    );
    dbms_resource_manager.submit_pending_area();
  END IF;
END;
/

PAUSE

REM
REM Enable the CONTROL_DOP plan at the system level
REM

ALTER SYSTEM SET resource_manager_plan = control_dop;

PAUSE

REM
REM Clenaup
REM

/* Run the following statements to remove the configuration

ALTER SYSTEM SET resource_manager_plan = default_plan;

BEGIN
  dbms_resource_manager.clear_pending_area();
  dbms_resource_manager.create_pending_area();
  dbms_resource_manager.delete_plan_cascade(plan => 'CONTROL_DOP');
  dbms_resource_manager.submit_pending_area();
END;
/

*/

UNDEFINE user
