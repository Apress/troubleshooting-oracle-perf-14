SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: dbms_profiler.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows how to profile a PL/SQL procedure and how
REM               to display the generated information.
REM Notes.......: The profiler must already be installed. As of 10g this is the
REM               default. In previous versions make sure that the package
REM               DBMS_PROFILE exists.
REM               This script calls two scripts:
REM               - perfect_triangles.sql to create the procedure used for the
REM                 test.
REM               - ?/rdbms/admin/proftab.sql to create the table used by the
REM                 profiler to store the gathered data.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 23.03.2014 Added examples with a package and a type
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

@../connect.sql

COLUMN line FORMAT 9,999 HEADING LINE#
COLUMN total_occur FORMAT 9,999,999 HEADING EXEC#
COLUMN time FORMAT 9,990.9 HEADING TIME%
COLUMN text FORMAT A100 HEADING CODE
COLUMN runid NEW_VALUE runid

SET ECHO ON

REM
REM Setup test environment
REM

@@perfect_triangles.sql

PAUSE

REM
REM Install the profiler tables
REM

@?/rdbms/admin/proftab.sql

PAUSE

REM
REM Enable the profiler
REM

SELECT dbms_profiler.start_profiler AS status
FROM dual;

PAUSE

REM
REM Execute the procedure perfect_triangles
REM

SET TIMING ON
execute perfect_triangles(1000)
execute perfect_triangles_pck.run(1000)
execute perfect_triangles_typ.run(1000)
SET TIMING OFF

PAUSE

REM
REM Stop the profiler
REM

SELECT dbms_profiler.stop_profiler AS status,
       plsql_profiler_runnumber.currval AS runid
FROM dual;

PAUSE

REM
REM Display the information gathered by the profiler
REM

REM Procedure

SELECT s.line, 
       round(ratio_to_report(p.total_time) OVER ()*100,1) AS time, 
       total_occur, 
       s.text
FROM all_source s,
     (SELECT u.unit_owner, u.unit_name, u.unit_type,
             d.line#, d.total_time, d.total_occur
      FROM plsql_profiler_units u, plsql_profiler_data d
      WHERE u.runid = &runid
      AND d.runid = u.runid
      AND d.unit_number = u.unit_number) p
WHERE s.owner = p.unit_owner (+)
AND s.name = p.unit_name (+)
AND s.type = p.unit_type (+)
AND s.line = p.line# (+)
AND s.owner = user
AND s.name = 'PERFECT_TRIANGLES'
AND s.type IN ('PROCEDURE', 'PACKAGE BODY', 'TYPE BODY')
ORDER BY s.line;

PAUSE

REM Package

SELECT s.line, 
       round(ratio_to_report(p.total_time) OVER ()*100,1) AS time, 
       total_occur, 
       s.text
FROM all_source s,
     (SELECT u.unit_owner, u.unit_name, u.unit_type,
             d.line#, d.total_time, d.total_occur
      FROM plsql_profiler_units u, plsql_profiler_data d
      WHERE u.runid = &runid
      AND d.runid = u.runid
      AND d.unit_number = u.unit_number) p
WHERE s.owner = p.unit_owner (+)
AND s.name = p.unit_name (+)
AND s.type = p.unit_type (+)
AND s.line = p.line# (+)
AND s.owner = user
AND s.name = 'PERFECT_TRIANGLES_PCK'
AND s.type IN ('PROCEDURE', 'PACKAGE BODY', 'TYPE BODY')
ORDER BY s.line;

PAUSE

REM Type

SELECT s.line, 
       round(ratio_to_report(p.total_time) OVER ()*100,1) AS time, 
       total_occur, 
       s.text
FROM all_source s,
     (SELECT u.unit_owner, u.unit_name, u.unit_type,
             d.line#, d.total_time, d.total_occur
      FROM plsql_profiler_units u, plsql_profiler_data d
      WHERE u.runid = &runid
      AND d.runid = u.runid
      AND d.unit_number = u.unit_number) p
WHERE s.owner = p.unit_owner (+)
AND s.name = p.unit_name (+)
AND s.type = p.unit_type (+)
AND s.line = p.line# (+)
AND s.owner = user
AND s.name = 'PERFECT_TRIANGLES_TYP'
AND s.type IN ('PROCEDURE', 'PACKAGE BODY', 'TYPE BODY')
ORDER BY s.line;

PAUSE

REM
REM Cleanup
REM

DROP PROCEDURE perfect_triangles;
DROP PACKAGE perfect_triangles_pck;
DROP TYPE perfect_triangles_typ;

UNDEFINE runid
