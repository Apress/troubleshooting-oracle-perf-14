SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: outline_unreproducible.sql
REM Author......: Christian Antognini
REM Date........: August 2013
REM Description.: This script shows that not because a stored outline is used
REM               it means that the expected execution plan is reproduced.
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
COLUMN plan_table_output FORMAT A100

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

CREATE INDEX i ON t (n);

execute dbms_stats.gather_table_stats(user, 't')

PAUSE

REM
REM Create outline and display the content of the data dictionary
REM

CREATE OR REPLACE OUTLINE outline_unreproducible
FOR CATEGORY test 
ON SELECT * FROM t WHERE n = 1970;

PAUSE

REM
REM Test outline
REM

ALTER SESSION SET use_stored_outlines = test;

SELECT * FROM t WHERE n = 1970;

SELECT * FROM table(dbms_xplan.display_cursor);

PAUSE

execute dbms_outln.clear_used(name => 'OUTLINE_UNREPRODUCIBLE')

SELECT category, sql_text, used
FROM user_outlines
WHERE name = 'OUTLINE_UNREPRODUCIBLE';

PAUSE

REM
REM What happens if index is dropped?
REM

DROP INDEX i;

SELECT * FROM t WHERE n = 1970;

SELECT * FROM table(dbms_xplan.display_cursor);

PAUSE

SELECT category, sql_text, used
FROM user_outlines
WHERE name = 'OUTLINE_UNREPRODUCIBLE';

PAUSE

SELECT sql_id, child_number, plan_hash_value 
FROM v$sql
WHERE outline_category = 'TEST';

PAUSE

REM
REM Cleanup
REM

DROP OUTLINE outline_unreproducible;

execute dbms_outln.drop_by_cat(cat => 'TEST')

DROP TABLE t;
PURGE TABLE t;
