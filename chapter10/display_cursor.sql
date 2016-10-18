SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: display_cursor.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows examples of how to use the function
REM               display_cursor in the package dbms_xplan.
REM Notes.......: -
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 12.07.2012 Removed 10.1 content
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

UNDEFINE sql_id

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t;

CREATE TABLE t 
AS 
SELECT rownum AS n, lpad('*',1000,'*') AS pad 
FROM dual
CONNECT BY level <= 1000;

execute dbms_stats.gather_table_stats(ownname=>user, tabname=>'t')

CREATE INDEX i ON t (n);

ALTER SESSION SET workarea_size_policy = manual;
ALTER SESSION SET sort_area_size = 65536;

PAUSE

REM
REM Execute the same SQL statement with different optimizer environments
REM

ALTER SESSION SET optimizer_mode = all_rows;

SELECT * FROM t WHERE n > 19

SET TERMOUT OFF
/
SET TERMOUT ON

ALTER SESSION SET optimizer_mode = first_rows_10;

SELECT * FROM t WHERE n > 19

SET TERMOUT OFF
/
SET TERMOUT ON

REM Display information about the last execution

SELECT * FROM table(dbms_xplan.display_cursor);

REM Display a specific SQL_ID without specifying a child number (0 is used by default!)
REM (take the value from the previous output)

SELECT * FROM table(dbms_xplan.display_cursor('&&sql_id'));

PAUSE

REM Specify the child cursor

SELECT * FROM table(dbms_xplan.display_cursor('&&sql_id',0));

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor('&&sql_id',1));

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor('&&sql_id',NULL));

PAUSE

REM
REM Display execution statistics
REM

DROP INDEX i;

SELECT /*+ gather_plan_statistics */ count(pad) 
FROM (SELECT rownum AS rn, pad FROM t ORDER BY n)
WHERE rn = 1;

UNDEFINE sql_id
UNDEFINE child_number

SELECT * FROM table(dbms_xplan.display_cursor);

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor('&&sql_id',&&child_number,'iostats last'));

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor('&&sql_id',&&child_number,'runstats_last'));

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor('&&sql_id',&&child_number,'memstats last'));

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor('&&sql_id',&&child_number,'allstats last'));

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor('&&sql_id',&&child_number,'iostats'));

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor('&&sql_id',&&child_number,'runstats_tot'));

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor('&&sql_id',&&child_number,'memstats'));

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor('&&sql_id',&&child_number,'allstats'));

PAUSE

REM
REM Check if the 10.1 and 10.2 modifiers lead to the same output
REM

SELECT * FROM table(dbms_xplan.display_cursor('&&sql_id',&&child_number,'iostats last'))
MINUS
SELECT * FROM table(dbms_xplan.display_cursor('&&sql_id',&&child_number,'runstats_last'));

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor('&&sql_id',&&child_number,'runstats_last'))
MINUS
SELECT * FROM table(dbms_xplan.display_cursor('&&sql_id',&&child_number,'iostats last'));

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor('&&sql_id',&&child_number,'iostats'))
MINUS
SELECT * FROM table(dbms_xplan.display_cursor('&&sql_id',&&child_number,'runstats_tot'));

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor('&&sql_id',&&child_number,'runstats_tot'))
MINUS
SELECT * FROM table(dbms_xplan.display_cursor('&&sql_id',&&child_number,'iostats'));

REM
REM Cleanup
REM

DROP TABLE t;
PURGE TABLE t;

UNDEFINE sql_id
UNDEFINE child_number
