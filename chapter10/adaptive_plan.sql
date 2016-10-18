SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: adaptive_plan.sql
REM Author......: Christian Antognini
REM Date........: February 2014
REM Description.: This script shows examples related to adaptive execution
REM               plans, with and without the reporting mode enabled.
REM Notes.......: This script works only with Enterprise Edition as of 12.1
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

COLUMN table_name FORMAT A30
COLUMN column_name FORMAT A30
COLUMN pad FORMAT A10 TRUNC
COLUMN is_resolved_adaptive_plan FORMAT A25

UNDEFINE sql_id
UNDEFINE child_number

COLUMN prev_sql_id NEW_VALUE sql_id
COLUMN prev_child_number NEW_VALUE child_number

SET ECHO ON

REM
REM Setup test environment
REM

ALTER SYSTEM FLUSH SHARED_POOL;

DROP TABLE t1 PURGE;
DROP TABLE t2 PURGE;

CREATE TABLE t1 (id, n, pad)
AS
SELECT rownum, rownum, lpad('*',100,'*')
FROM dual
CONNECT BY level <= 10000;

INSERT INTO t1
SELECT 10000+rownum, 666, lpad('*',100,'*')
FROM dual
CONNECT BY level <= 50;

COMMIT;

ALTER TABLE t1 ADD CONSTRAINT t1_pk PRIMARY KEY (id);

execute dbms_stats.gather_table_stats(user,'t1')

CREATE TABLE t2 (id, n, pad)
AS
SELECT rownum, rownum, lpad('*',100,'*')
FROM dual
CONNECT BY level <= 10000;

ALTER TABLE t2 ADD CONSTRAINT t2_pk PRIMARY KEY (id);

execute dbms_stats.gather_table_stats(user,'t2')

ALTER SYSTEM FLUSH SHARED_POOL;

ALTER SESSION SET optimizer_adaptive_features = TRUE;
ALTER SESSION SET optimizer_adaptive_reporting_only = FALSE;

PAUSE

REM
REM Show default execution plan
REM

REM ALTER SESSION SET events = '10053 trace name context forever';

EXPLAIN PLAN FOR
SELECT *
FROM t1, t2
WHERE t1.id = t2.id
AND t1.n = 666;

REM ALTER SESSION SET events = '10053 trace name context off';

PAUSE

SELECT * FROM table(dbms_xplan.display(format=>'basic +predicate +note'));

PAUSE

SELECT * FROM table(dbms_xplan.display(format=>'basic +predicate +note +adaptive'));

PAUSE

REM
REM Execution without adaptive optimization
REM

ALTER SESSION SET optimizer_adaptive_features = FALSE;

PAUSE

SELECT *
FROM t1, t2
WHERE t1.id = t2.id
AND t1.n = 666;

PAUSE

SELECT prev_sql_id, prev_child_number
FROM v$session
WHERE sid = sys_context('userenv','sid');

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor('&sql_id', &child_number, 'basic +predicate +note'));

PAUSE

SELECT sql_id, child_number, is_resolved_adaptive_plan
FROM v$sql
WHERE sql_id = '&sql_id';

PAUSE

REM
REM Execution with adaptive optimization
REM

ALTER SESSION SET optimizer_adaptive_features = TRUE;

PAUSE

SELECT *
FROM t1, t2
WHERE t1.id = t2.id
AND t1.n = 666;

PAUSE

SELECT prev_sql_id, prev_child_number
FROM v$session
WHERE sid = sys_context('userenv','sid');

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor('&sql_id', &child_number, 'basic +predicate +note'));

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor('&sql_id', &child_number, 'basic +predicate +note +adaptive'));

PAUSE

SELECT sql_id, child_number, is_resolved_adaptive_plan
FROM v$sql
WHERE sql_id = '&sql_id';

PAUSE

REM
REM Execution with reporting mode enabled
REM

ALTER SESSION SET optimizer_adaptive_reporting_only = TRUE;

PAUSE

SELECT *
FROM t1, t2
WHERE t1.id = t2.id
AND t1.n = 666;

PAUSE

SELECT prev_sql_id, prev_child_number
FROM v$session
WHERE sid = sys_context('userenv','sid');

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor('&sql_id', &child_number, 'basic +predicate +note +report'));

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor('&sql_id', &child_number, 'basic +predicate +note +report +adaptive'));

PAUSE

DROP TABLE t1 PURGE;
DROP TABLE t2 PURGE;

UNDEFINE sql_id
UNDEFINE child_number
