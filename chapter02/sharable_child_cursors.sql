SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: sharable_child_cursors.sql
REM Author......: Christian Antognini
REM Date........: March 2012
REM Description.: This script shows examples of child cursors that cannot be
REM               shared.
REM Notes.......: This script works as of 10g only.
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
SET SERVEROUTPUT OFF
SET LONG 1

@../connect.sql

COLUMN sql_text FORMAT A22
COLUMN optimizer_mode FORMAT A14
COLUMN optimizer_mode_mismatch FORMAT A1
COLUMN optimizer_mismatch FORMAT A1
COLUMN xml_reason FORMAT A80
COLUMN reason FORMAT A22
COLUMN optimizer_mode_cursor FORMAT A21
COLUMN optimizer_mode_current FORMAT A22
COLUMN language_mismatch FORMAT A17

COLUMN sql_id NEW_VALUE sql_id

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t;

CREATE TABLE t 
AS
SELECT rownum AS n, rpad('*',100,'*') AS pad 
FROM dual
CONNECT BY level <= 1000;

execute dbms_stats.gather_table_stats(ownname=>user, tabname=>'t')

ALTER SYSTEM FLUSH SHARED_POOL;

ALTER SESSION SET cursor_sharing = 'EXACT';

PAUSE

REM
REM The following SQL statements have the same parent cursor because the
REM text of the two SQL statements is equal. However, there are two child
REM cursors because the execution environment is not the same.
REM

ALTER SESSION SET optimizer_mode = all_rows;

SELECT count(*) FROM t;

ALTER SESSION SET optimizer_mode = first_rows_1;

SELECT count(*) FROM t;

ALTER SESSION SET optimizer_mode = first_rows_10;

SELECT count(*) FROM t;

ALTER SESSION SET optimizer_mode = first_rows_100;

SELECT count(*) FROM t;

ALTER SESSION SET optimizer_mode = first_rows_1000;

SELECT count(*) FROM t;

ALTER SESSION SET optimizer_mode = first_rows;

SELECT count(*) FROM t;

ALTER SESSION SET optimizer_mode = rule;

SELECT count(*) FROM t;

ALTER SESSION SET optimizer_mode = choose;

SELECT count(*) FROM t;

PAUSE

SELECT sql_id, child_number, optimizer_mode, plan_hash_value, executions
FROM v$sql
WHERE sql_text = 'SELECT count(*) FROM t';

PAUSE

SELECT *
FROM v$sql_shared_cursor
WHERE sql_id = '&sql_id'
AND child_number > 0;

PAUSE

COLUMN optimizer_mode_mismatch FORMAT A23
COLUMN optimizer_mismatch FORMAT A18

REM the OPTIMIZER_MISMATCH flag is set in 10.1 only

SELECT child_number, optimizer_mismatch
FROM v$sql_shared_cursor
WHERE sql_id = '&sql_id'
AND child_number > 0;

REM the OPTIMIZER_MODE_MISMATCH flag is set as of 10.2 only

SELECT child_number, optimizer_mode_mismatch
FROM v$sql_shared_cursor
WHERE sql_id = '&sql_id'
AND child_number > 0;

PAUSE

REM the REASON column exists as of 11.2.0.2 only

SET LONG 1000

SELECT xmltype('<Root>'||reason||'</Root>').
         extract('/Root/ChildNode[1]').
         getstringval() AS xml_reason
FROM v$sql_shared_cursor 
WHERE sql_id = '&sql_id';

PAUSE

SELECT x.child_number, x.reason, 
       decode(x.optimizer_mode_cursor, 1, 'ALL_ROWS',
                                       2, 'FIRST_ROWS', 
                                       3, 'RULE', 
                                       4, 'CHOOSE', x.optimizer_mode_cursor) AS optimizer_mode_cursor,
       decode(x.optimizer_mode_current, 1, 'ALL_ROWS',
                                        2, 'FIRST_ROWS', 
                                        3, 'RULE', 
                                        4, 'CHOOSE', x.optimizer_mode_current) AS optimizer_mode_current
FROM v$sql_shared_cursor s,
     XMLTable('/Root'
              PASSING XMLType('<Root>'||reason||'</Root>')
              COLUMNS child_number NUMBER                  PATH '/Root/ChildNode[1]/ChildNumber',
                      id NUMBER                            PATH '/Root/ChildNode[1]/ID',
                      reason VARCHAR2(100)                 PATH '/Root/ChildNode[1]/reason',
                      optimizer_mode_hinted_cursor NUMBER  PATH '/Root/ChildNode[1]/optimizer_mode_hinted_cursor',
                      optimizer_mode_cursor NUMBER         PATH '/Root/ChildNode[1]/optimizer_mode_cursor',
                      optimizer_mode_current NUMBER        PATH '/Root/ChildNode[1]/optimizer_mode_current'
                      ) x 
WHERE s.sql_id = '&sql_id';

PAUSE

REM
REM Show that the environment can change the output of a query
REM

TRUNCATE TABLE t;

INSERT INTO t VALUES (1, '1');
INSERT INTO t VALUES (2, '=');
INSERT INTO t VALUES (3, 'Z');
INSERT INTO t VALUES (4, 'z');
COMMIT;

PAUSE

ALTER SESSION SET nls_sort = binary;

SELECT * FROM t ORDER BY pad;

PAUSE

ALTER SESSION SET nls_sort = xgerman;

SELECT * FROM t ORDER BY pad;

PAUSE

SELECT sql_id, child_number, plan_hash_value, executions
FROM v$sql
WHERE sql_text = 'SELECT * FROM t ORDER BY pad';

PAUSE

SELECT child_number, language_mismatch
FROM v$sql_shared_cursor
WHERE sql_id = '&sql_id'
AND child_number > 0;

PAUSE

REM
REM Cleanup
REM

UNDEFINE sql_id

DROP TABLE t;
PURGE TABLE t;
