SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: sharable_parent_cursors.sql
REM Author......: Christian Antognini
REM Date........: March 2012
REM Description.: This script shows examples of parent cursors that
REM               cannot be shared.
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

@../connect.sql

COLUMN sql_text FORMAT A36
COLUMN optimizer_mode FORMAT A14
COLUMN optimizer_mode_mismatch FORMAT A23
COLUMN optimizer_mismatch FORMAT A18

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
REM Even though the following SQL statements perform exactly the same operation,
REM four different parent cursors are created. This is because only two of them 
REM have the same text.
REM

SELECT * FROM t WHERE n = 1234;

select * from t where n = 1234;

SELECT  *  FROM  t  WHERE  n=1234;

SELECT * FROM t WHERE n = 1234;

SELECT * FROM t WHERE n = 01234;

PAUSE

SELECT sql_id, sql_text, executions
FROM v$sqlarea
WHERE sql_text LIKE '%1234';

PAUSE

REM
REM If CURSOR_SHARING is set to FORCE/SIMILAR, differences due to litteral
REM values are not relevant for sharing a parent cursor. 
REM

ALTER SESSION SET cursor_sharing = 'FORCE';

PAUSE

SELECT * FROM t WHERE n = 1001;

SELECT * FROM t WHERE n = 2001;

SELECT * FROM t WHERE n = 3001;

select * from t where n = 3001;

PAUSE

SELECT sql_id, sql_text, executions
FROM v$sqlarea
WHERE upper(sql_text) LIKE 'SELECT * FROM T WHERE N = %SYS_B_%';

PAUSE

ALTER SESSION SET cursor_sharing = 'SIMILAR';

PAUSE

SELECT * FROM t WHERE n = 1002;

SELECT * FROM t WHERE n = 2002;

SELECT * FROM t WHERE n = 3002;

select * from t where n = 3002;

PAUSE

SELECT sql_id, sql_text, executions
FROM v$sqlarea
WHERE upper(sql_text) LIKE 'SELECT * FROM T WHERE N = %SYS_B_%';

PAUSE

REM
REM Cleanup
REM

UNDEFINE sql_id

DROP TABLE t;
PURGE TABLE t;
