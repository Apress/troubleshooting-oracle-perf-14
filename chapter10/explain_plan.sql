SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: explain_plan.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows which SQL statements are supported by
REM               EXPLAIN PLAN.
REM Notes.......: A plan table named PLAN_TABLE must exist.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 08.03.2009 Fixed wrong CTAS in "Setup test environment"
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE o;
DROP TABLE t;

CREATE TABLE o 
AS
SELECT * 
FROM all_objects 
WHERE rownum <= 1000;

execute dbms_stats.gather_table_stats(user, 'o')

PAUSE

REM
REM CREATE TABLE AS SELECT
REM

EXPLAIN PLAN FOR CREATE TABLE t AS SELECT * FROM o;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM CREATE INDEX
REM

CREATE TABLE t AS SELECT * FROM o;

execute dbms_stats.gather_table_stats(user, 't')

EXPLAIN PLAN FOR CREATE INDEX i ON t (object_id);

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM ALTER INDEX
REM

CREATE INDEX i ON t (object_id);

EXPLAIN PLAN FOR ALTER INDEX i REBUILD;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM SELECT
REM

EXPLAIN PLAN FOR SELECT * FROM t;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM INSERT
REM

EXPLAIN PLAN FOR INSERT INTO t SELECT * FROM o WHERE rownum = 1;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM UPDATE
REM

EXPLAIN PLAN FOR UPDATE t SET subobject_name = object_name;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM MERGE
REM

EXPLAIN PLAN FOR MERGE INTO t 
                 USING (SELECT * FROM o) o 
                 ON (t.object_id = o.object_id)
                 WHEN MATCHED THEN UPDATE SET t.subobject_name = o.subobject_name
                 WHEN NOT MATCHED THEN INSERT (owner, object_name, object_id, created, last_ddl_time)
                                       VALUES (o.owner, o.object_name, o.object_id, o.created, o.last_ddl_time);

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM UPDATE
REM

EXPLAIN PLAN FOR DELETE FROM t;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM Cleanup
REM

DROP TABLE o;
PURGE TABLE o;

DROP TABLE t;
PURGE TABLE t;
