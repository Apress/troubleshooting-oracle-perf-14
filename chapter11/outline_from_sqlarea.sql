SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: outline_from_sqlarea.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows how to manually create a stored outline by
REM               referencing a cursor in the shared pool.
REM Notes.......: This script requires Oracle Database 10g or never.
REM               A dump can occur when the procedure create_outline is 
REM               executed (bug# 6336044?).
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
COLUMN sql_text FORMAT A30
COLUMN timestamp FORMAT A32

COLUMN hash_value NEW_VALUE hash_value
UNDEFINE hash_value

COLUMN child_number NEW_VALUE child_number
UNDEFINE child_number

COLUMN name NEW_VALUE name
UNDEFINE name

@../connect.sql

ALTER SESSION SET optimizer_index_cost_adj = 100;

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t;

CREATE TABLE t AS 
SELECT mod(rownum,100) AS n, rpad('*',100,'*') AS pad
FROM dual
CONNECT BY level <= 1000;

CREATE INDEX i ON t (n);

execute dbms_stats.gather_table_stats(user, 't')

PAUSE

REM
REM Run the test query and identify it in the shared pool
REM

SELECT * FROM t WHERE n = 1970;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor);

PAUSE

SELECT hash_value, child_number
FROM v$sql
WHERE sql_text = 'SELECT * FROM t WHERE n = 1970';

PAUSE

REM
REM Create outline and then rename it
REM

REM Change the environment to show that the execution plan is generated
REM instead of being taken from the referenced cursor

ALTER SESSION SET optimizer_index_cost_adj = 1000;

BEGIN
  dbms_outln.create_outline(
    hash_value => '&hash_value',
    child_number => &child_number,
    category => 'test'
  );
END;
/

PAUSE

SELECT name
FROM user_outlines
WHERE timestamp = (SELECT max(timestamp) FROM user_outlines);

PAUSE

ALTER OUTLINE &name RENAME TO outline_from_sqlarea;

PAUSE

REM
REM Display outline
REM

SELECT category, sql_text, signature
FROM user_outlines
WHERE name = 'OUTLINE_FROM_SQLAREA';

SELECT hint
FROM user_outline_hints
WHERE name = 'OUTLINE_FROM_SQLAREA';

PAUSE

REM
REM Test the outline
REM

SELECT * FROM t WHERE n = 1970;

SELECT * FROM table(dbms_xplan.display_cursor);

PAUSE

REM
REM Cleanup
REM

DROP OUTLINE outline_from_sqlarea;

DROP TABLE t;
PURGE TABLE t;
