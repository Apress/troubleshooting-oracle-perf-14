SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: pga_auto_target.sql
REM Author......: Christian Antognini
REM Date........: July 2013
REM Description.: This script shows that "aggregate PGA auto target" depends
REM               on the amount of memory that cannot be controlled by the 
REM               memory manager.
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

COLUMN name FORMAT A30
COLUMN value FORMAT 9999999999
COLUMN unit FORMAT A5

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

CREATE OR REPLACE PACKAGE pga_pkg AS
  PROCEDURE allocate(p_kbytes IN INTEGER);
  FUNCTION allocate_workarea(p_kbytes IN INTEGER) RETURN SYS_REFCURSOR;
END pga_pkg;
/

CREATE OR REPLACE PACKAGE BODY pga_pkg AS

  TYPE t_array IS TABLE OF CHAR(1000);
  g_array t_array;

  PROCEDURE allocate(p_kbytes IN INTEGER) AS
  BEGIN
    g_array := t_array();
    g_array.extend(p_kbytes);
    FOR i IN 1..p_kbytes
    LOOP
      g_array(i) := rpad('*',1000,'*');
    END LOOP;
  END allocate;

  FUNCTION allocate_workarea(p_kbytes IN INTEGER) RETURN SYS_REFCURSOR AS
    l_cursor SYS_REFCURSOR;
    l_dummy1 PLS_INTEGER;
    l_dummy2 VARCHAR2(1000);
  BEGIN
    OPEN l_cursor FOR q'[SELECT rownum, rpad(dbms_random.string('p',10),1000,'*') 
                         FROM dual
                         CONNECT BY level <= :p_kbytes
                         ORDER BY 1,2]' USING p_kbytes;
    FETCH l_cursor INTO l_dummy1, l_dummy2;
    RETURN l_cursor;
  END allocate_workarea;
END pga_pkg;
/

PAUSE

REM
REM How much PGA is configured/available?
REM

SELECT name, value, unit
FROM v$pgastat
WHERE name LIKE 'aggregate PGA %' OR name = 'total PGA allocated';

PAUSE

REM
REM Allocate some PGA
REM

execute pga_pkg.allocate(&kilobytes_to_allocate)
execute dbms_lock.sleep(15)

PAUSE

REM
REM Check whether "aggregate PGA auto target" has changed (the memory allocated
REM through the pga_pkg package is no longer available to the memory manager)
REM

SELECT name, value, unit
FROM v$pgastat
WHERE name LIKE 'aggregate PGA %' OR name = 'total PGA allocated';

PAUSE

REM
REM Free the memory allocated through the pga_pkg package
REM

execute dbms_session.reset_package
execute dbms_lock.sleep(15)

PAUSE

REM
REM Check whether "aggregate PGA auto target" has changed
REM

SELECT name, value, unit
FROM v$pgastat
WHERE name LIKE 'aggregate PGA %' OR name = 'total PGA allocated';

PAUSE

REM
REM Cleanup
REM

DROP PACKAGE pga_pkg;
