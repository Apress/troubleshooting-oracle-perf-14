SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: outline_from_text.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows how to manually create a stored outline as
REM               well as how to manage and use it.
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
COLUMN sql_text FORMAT A30
COLUMN timestamp FORMAT A32

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
REM Create outline and display the content of the data dictionary
REM

CREATE OR REPLACE OUTLINE outline_from_text
FOR CATEGORY test 
ON SELECT * FROM t WHERE n = 1970;

SELECT category, sql_text, signature
FROM user_outlines
WHERE name = 'OUTLINE_FROM_TEXT';

SELECT hint 
FROM user_outline_hints 
WHERE name = 'OUTLINE_FROM_TEXT';

PAUSE

REM
REM Test outline
REM

CREATE INDEX i ON t (n);

ALTER SESSION SET use_stored_outlines = default;

EXPLAIN PLAN FOR
SELECT * FROM t WHERE n = 1970;

SELECT * FROM table(dbms_xplan.display);

PAUSE

ALTER SESSION SET use_stored_outlines = test;

EXPLAIN PLAN FOR
SELECT * FROM t WHERE n = 1970;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM The following SQL statement requires Oracle Database 10g or never

ALTER OUTLINE outline_from_text DISABLE;

EXPLAIN PLAN FOR
SELECT * FROM t WHERE n = 1970;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM The following SQL statement requires Oracle Database 10g or never

ALTER OUTLINE outline_from_text ENABLE;

EXPLAIN PLAN FOR
SELECT * FROM t WHERE n = 1970;

SELECT * FROM table(dbms_xplan.display);

PAUSE

EXPLAIN PLAN FOR
select   *
from     t
where    n=1970;

SELECT * FROM table(dbms_xplan.display);

PAUSE

ALTER SESSION SET use_stored_outlines = default;

ALTER OUTLINE outline_from_text REBUILD;

ALTER SESSION SET use_stored_outlines = test;

EXPLAIN PLAN FOR
SELECT * FROM t WHERE n = 1970;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM How to check if an outline is used?
REM

ALTER SESSION SET use_stored_outlines = test;

execute dbms_outln.clear_used(name => 'OUTLINE_FROM_TEXT')

SELECT used
FROM user_outlines
WHERE name = 'OUTLINE_FROM_TEXT';

PAUSE

SELECT * FROM t WHERE n = 1970;

SELECT used
FROM user_outlines
WHERE name = 'OUTLINE_FROM_TEXT';

PAUSE

REM
REM Change the category of an outline
REM

ALTER OUTLINE outline_from_text CHANGE CATEGORY TO DEFAULT;

execute dbms_outln.update_by_cat(oldcat => 'TEST', newcat => 'DEFAULT')

SELECT category
FROM user_outlines
WHERE name = 'OUTLINE_FROM_TEXT';

PAUSE

REM
REM Cleanup
REM

DROP OUTLINE outline_from_text;

execute dbms_outln.drop_by_cat(cat => 'TEST')

DROP TABLE t;
PURGE TABLE t;
