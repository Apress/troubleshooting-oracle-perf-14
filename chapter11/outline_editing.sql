SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: outline_editing.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows how to manually edit a stored outline.
REM Notes.......: -
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 25.07.2013 Removed 9i content + implemented swapping of stored outlines
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON
SET LINESIZE 80

COLUMN hint# FORMAT 999999
COLUMN hint_text FORMAT A50
COLUMN user_table_name FORMAT A16

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

CREATE INDEX i ON t(n);

ALTER SESSION SET OPTIMIZER_MODE = ALL_ROWS;

PAUSE

REM
REM Show the initial execution plan
REM

EXPLAIN PLAN FOR SELECT * FROM t WHERE n = 1970;
SELECT * FROM table(dbms_xplan.display(NULL,NULL,'basic +note'));

PAUSE

REM
REM Create the outline
REM

CREATE OR REPLACE OUTLINE outline_editing
ON SELECT * FROM t WHERE n = 1970;

PAUSE

REM
REM Create private outline
REM

CREATE PRIVATE OUTLINE p_outline_editing FROM PUBLIC outline_editing;

CREATE OR REPLACE PRIVATE OUTLINE p_outline_editing
ON SELECT * FROM t WHERE n = 1970;

PAUSE

REM
REM Create private outline with hint to force a full table scan
REM

CREATE OR REPLACE PRIVATE OUTLINE p_outline_editing_hinted
ON SELECT /*+ full(t) */ * FROM t WHERE n = 1970;

PAUSE

REM
REM Swap hints between private outlines
REM

SELECT hint_text
FROM ol$hints 
WHERE ol_name = 'P_OUTLINE_EDITING'
ORDER BY hint#;

PAUSE

UPDATE ol$
SET hintcount = (SELECT hintcount
                 FROM ol$
                 WHERE ol_name = 'P_OUTLINE_EDITING_HINTED')
WHERE ol_name = 'P_OUTLINE_EDITING';

DELETE ol$hints 
WHERE ol_name = 'P_OUTLINE_EDITING';

UPDATE ol$hints 
SET ol_name = 'P_OUTLINE_EDITING'
WHERE ol_name = 'P_OUTLINE_EDITING_HINTED';

PAUSE

SELECT hint_text
FROM ol$hints 
WHERE ol_name = 'P_OUTLINE_EDITING'
ORDER BY hint#;

PAUSE

REM
REM Resynchronize private outline
REM

execute dbms_outln_edit.refresh_private_outline('P_OUTLINE_EDITING')

PAUSE

REM
REM Test if outline used
REM

ALTER SESSION SET use_stored_outlines = FALSE;
ALTER SESSION SET use_private_outlines = TRUE;

EXPLAIN PLAN FOR SELECT * FROM t WHERE n = 1970;
SELECT * FROM table(dbms_xplan.display(NULL,NULL,'basic +note'));

PAUSE

ALTER SESSION SET use_stored_outlines = TRUE;
ALTER SESSION SET use_private_outlines = FALSE;

EXPLAIN PLAN FOR SELECT * FROM t WHERE n = 1970;
SELECT * FROM table(dbms_xplan.display(NULL,NULL,'basic +note'));

PAUSE

REM
REM Save outline in the data dictionary
REM

CREATE OR REPLACE OUTLINE outline_editing FROM PRIVATE p_outline_editing;

PAUSE

ALTER SESSION SET use_stored_outlines = FALSE;

EXPLAIN PLAN FOR SELECT * FROM t WHERE n = 1970;
SELECT * FROM table(dbms_xplan.display(NULL,NULL,'basic +note'));

PAUSE

ALTER SESSION SET use_stored_outlines = TRUE;

EXPLAIN PLAN FOR SELECT * FROM t WHERE n = 1970;
SELECT * FROM table(dbms_xplan.display(NULL,NULL,'basic +note'));

PAUSE

REM
REM Cleanup
REM

execute dbms_outln_edit.drop_edit_tables

DROP OUTLINE outline_editing;
DROP PRIVATE OUTLINE p_outline_editing;

DROP TABLE t;
PURGE TABLE t;
