SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: outline_cursor_sharing.sql
REM Author......: Christian Antognini
REM Date........: July 2013
REM Description.: This script shows the impact of cursor_sharing<>EXACT
REM               on the creation and selection of stored outlines.
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

COLUMN category FORMAT A8
COLUMN sql_text FORMAT A36
COLUMN timestamp FORMAT A32

COLUMN name NEW_VALUE name
UNDEFINE name

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t;

CREATE TABLE t AS 
SELECT rownum AS n, rpad('*',100,'*') AS pad
FROM dual
CONNECT BY level <= 1000;

execute dbms_stats.gather_table_stats(user, 't')

PAUSE

REM
REM Set cursor sharing to FORCE and create a stored outline with a literal
REM

ALTER SESSION SET cursor_sharing = FORCE;

PAUSE

CREATE OR REPLACE OUTLINE outline_cursor_sharing
ON SELECT * FROM t WHERE n = 1970;

PAUSE

SELECT category, sql_text
FROM user_outlines
WHERE name = 'OUTLINE_CURSOR_SHARING';

PAUSE

REM
REM Test stored outline utilization
REM

ALTER SESSION SET use_stored_outlines = TRUE;

PAUSE

REM With cursor_sharing set to FORCE it is not used

SELECT * FROM t WHERE n = 1970;

SELECT * FROM table(dbms_xplan.display_cursor);

PAUSE

REM With cursor_sharing set to EXACT it is not used

ALTER SESSION SET cursor_sharing = EXACT;

PAUSE

SELECT * FROM t WHERE n = 1970;

SELECT * FROM table(dbms_xplan.display_cursor);

PAUSE

REM
REM Recreate stored outline by setting create_stored_outlines 
REM

ALTER SESSION SET cursor_sharing = FORCE;

PAUSE

ALTER SESSION SET create_stored_outlines = TRUE;

SELECT * FROM t WHERE n = 1971;

ALTER SESSION SET create_stored_outlines = FALSE;

PAUSE

SELECT name
FROM user_outlines
WHERE timestamp = (SELECT max(timestamp) FROM user_outlines);

PAUSE

SELECT category, sql_text
FROM user_outlines
WHERE name = '&name';

PAUSE

REM
REM Test stored outline utilization
REM

SELECT * FROM t WHERE n = 1971;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor);

PAUSE

SELECT * FROM t WHERE n = 1972;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor);

PAUSE

REM
REM Cleanup
REM

DROP OUTLINE outline_cursor_sharing;
DROP OUTLINE &name;

DROP TABLE t;
PURGE TABLE t;
