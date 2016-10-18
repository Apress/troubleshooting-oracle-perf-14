SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: optimizer_secure_view_merging_vpd.sql
REM Author......: Christian Antognini
REM Date........: September 2011
REM Description.: This script is based on optimizer_secure_view_merging.sql but
REM               uses VPD instead of a view to restrict the visibility of some
REM               rows.
REM Notes.......: This script creates and drops two users (U1 and U2) and 
REM               changes the initialization parameter 
REM               optimizer_secure_view_merging at system level.
REM               The initialization parameter optimizer_secure_view_merging 
REM               is available as of 10gR2 only. Therefore, this script only 
REM               works when executed in 10gR2 or 11g.
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

COLUMN service NEW_VALUE service
UNDEFINE service

@../connect.sql

SELECT sys_context('USERENV','SERVICE_NAME') AS service FROM dual;

CONNECT sys/&password_sys@&service AS sysdba

SET ECHO ON

REM
REM Setup test environment
REM

DROP USER u1 CASCADE;
DROP USER u2 CASCADE;

CREATE USER u1 IDENTIFIED BY u1 DEFAULT TABLESPACE users QUOTA UNLIMITED ON users;
CREATE USER u2 IDENTIFIED BY u2 DEFAULT TABLESPACE users QUOTA UNLIMITED ON users;

GRANT CREATE SESSION, CREATE TABLE, CREATE PROCEDURE, CREATE VIEW TO u1;
GRANT EXECUTE ON dbms_rls TO u1;
GRANT CREATE SESSION, CREATE PROCEDURE, CREATE SYNONYM TO u2;

REM GRANT MERGE ANY VIEW TO u2;

ALTER SYSTEM SET optimizer_secure_view_merging = &value scope=memory;

PAUSE

CONNECT u1/u1@&service

CREATE TABLE t (
  id NUMBER(10) PRIMARY KEY, 
  class NUMBER(10),
  pad VARCHAR2(10)
);

execute dbms_random.seed(0)

INSERT INTO t
SELECT rownum, mod(rownum,3), dbms_random.string('a',10)
FROM dual 
CONNECT BY level <= 6;

execute dbms_stats.gather_table_stats(user,'t')

PAUSE

CREATE OR REPLACE FUNCTION f (class number) RETURN NUMBER AS
BEGIN
  IF class = 1
  THEN
    RETURN 1;
  ELSE
    RETURN 0;
  END IF;
END;
/

PAUSE

ASSOCIATE STATISTICS WITH FUNCTIONS f DEFAULT SELECTIVITY 50;

PAUSE

CREATE OR REPLACE FUNCTION s (schema IN VARCHAR2, tab IN VARCHAR2) RETURN VARCHAR2 AS
BEGIN
  RETURN 'f(class) = 1';
END;
/

BEGIN
  dbms_rls.add_policy(object_schema   => 'U1',
                      object_name     => 'T',
                      policy_name     => 'T_SEC',
                      function_schema => 'U1',
                      policy_function => 'S');
END;
/

PAUSE

SELECT * FROM t;

PAUSE

GRANT SELECT ON t TO u2;

PAUSE

CONNECT u2/u2@&service

CREATE SYNONYM t FOR u1.t;

PAUSE

SELECT id, pad 
FROM t
WHERE id BETWEEN 1 AND 5;

PAUSE

CREATE OR REPLACE FUNCTION spy (id IN NUMBER, pad IN VARCHAR2) RETURN NUMBER AS
BEGIN
  dbms_output.put_line('id='||id||' pad='||pad);
  RETURN 1;
END;
/

PAUSE

ASSOCIATE STATISTICS WITH FUNCTIONS spy DEFAULT SELECTIVITY 0.000001;

PAUSE

SET SERVEROUTPUT ON

SELECT id, pad 
FROM t
WHERE id BETWEEN 1 AND 5;

PAUSE

SELECT id, pad
FROM t
WHERE id BETWEEN 1 AND 5
AND spy(id, pad) = 1;

PAUSE

REM
REM Cleanup
REM

@@../connect.sql

DROP USER u1 CASCADE;
DROP USER u2 CASCADE;

UNDEFINE service
COLUMN SERVICE CLEAR

ALTER SYSTEM SET optimizer_secure_view_merging = &value scope=memory;
