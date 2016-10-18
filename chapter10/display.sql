SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: display.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows examples of how to use the function display
REM               in the package dbms_xplan.
REM Notes.......: Several SQL statements requires at last Oracle Database 10g
REM               Release 2. A plan table named PLAN_TABLE must exist.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 20.02.2014 Added example with plan table containing runtime statistics
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

DROP TABLE t PURGE;

CREATE TABLE t 
AS 
SELECT rownum AS n, rpad('*',50,'*') AS pad 
FROM dual 
CONNECT BY level <= 1000;

execute dbms_stats.gather_table_stats(user, 't')

DROP TABLE my_plan_table PURGE;

CREATE TABLE my_plan_table (
  statement_id      VARCHAR2(30),
  timestamp         DATE,
  remarks           VARCHAR2(80),
  operation         VARCHAR2(30),
  options           VARCHAR2(255),
  object_node       VARCHAR2(128),
  object_owner      VARCHAR2(30),
  object_name       VARCHAR2(30),
  object_instance   NUMERIC,
  object_type       VARCHAR2(30),
  optimizer         VARCHAR2(255),
  search_columns    NUMBER,
  id                NUMERIC,
  parent_id         NUMERIC,
  position          NUMERIC,
  cost              NUMERIC,
  cardinality       NUMERIC,
  bytes             NUMERIC,
  other_tag         VARCHAR2(255),
  partition_start   VARCHAR2(255),
  partition_stop    VARCHAR2(255),
  partition_id      NUMERIC,
  distribution      VARCHAR2(30),
  cpu_cost          NUMERIC,
  io_cost           NUMERIC,
  temp_space        NUMERIC,
  access_predicates VARCHAR2(4000),
  filter_predicates VARCHAR2(4000)
);

PAUSE

REM
REM Use a user-defined PLAN_TABLE
REM

EXPLAIN PLAN FOR SELECT * FROM t WHERE pad = 'my_plan_table';

INSERT INTO my_plan_table 
SELECT statement_id, timestamp, remarks, operation, options, object_node, object_owner, object_name, 
       object_instance, object_type, optimizer, search_columns, id, parent_id, position, cost, 
       cardinality, bytes, other_tag, partition_start, partition_stop, partition_id, distribution,
       cpu_cost, io_cost, temp_space, access_predicates, filter_predicates 
FROM plan_table;

SELECT * FROM table(dbms_xplan.display('my_plan_table'));

PAUSE

REM
REM Display the execution plan related to a specific STATEMENT_ID
REM

EXPLAIN PLAN SET STATEMENT_ID='test1' FOR SELECT * FROM t WHERE n=1;
EXPLAIN PLAN SET STATEMENT_ID='test2' FOR SELECT * FROM t WHERE n=2;

PAUSE

REM Last execution

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM STATEMENT_ID=test1

SELECT * FROM table(dbms_xplan.display(NULL,'test1'));

PAUSE

REM STATEMENT_ID=test2

SELECT * FROM table(dbms_xplan.display(NULL,'test2'));

PAUSE

REM
REM Format the output with the parameter FORMAT
REM

EXPLAIN PLAN FOR SELECT count(*) FROM t WHERE n BETWEEN 6 AND 19;

PAUSE

SELECT * FROM table(dbms_xplan.display(NULL,NULL,'basic'));

PAUSE

SELECT * FROM table(dbms_xplan.display(NULL,NULL,'typical'));

PAUSE

SELECT * FROM table(dbms_xplan.display(NULL,NULL,'all'));

PAUSE

REM The following SQL statements requires Oracle Database 10g Release 2

PAUSE

SELECT * FROM table(dbms_xplan.display(NULL,NULL,'advanced'));

PAUSE

SELECT * FROM table(dbms_xplan.display(NULL,NULL,'typical +outline'));

PAUSE

SELECT * FROM table(dbms_xplan.display(NULL,NULL,'basic +predicate'));

PAUSE

SELECT * FROM table(dbms_xplan.display(NULL,NULL,'typical -bytes -note'));

PAUSE

REM
REM Use the parameter FILTER_PREDS to get only part of the output
REM

EXPLAIN PLAN SET STATEMENT_ID='test3' FOR SELECT * FROM t WHERE n=31;
EXPLAIN PLAN SET STATEMENT_ID='test3' FOR SELECT * FROM t WHERE n=32;
EXPLAIN PLAN SET STATEMENT_ID='test3' FOR SELECT * FROM t WHERE n=33;

PAUSE

SELECT * FROM table(dbms_xplan.display(NULL,NULL,'typical','statement_id=''test3'''));

PAUSE

SELECT * FROM table(dbms_xplan.display(NULL,NULL,'typical','plan_id = (SELECT max(plan_id)
                                                                       FROM plan_table 
                                                                       WHERE statement_id=''test3'')'));

PAUSE

SELECT * FROM table(dbms_xplan.display(NULL,NULL,'typical','plan_id = (SELECT max(plan_id) 
                                                                       FROM plan_table 
                                                                       WHERE filter_predicates LIKE ''%32%'')'));

PAUSE

SELECT * FROM table(dbms_xplan.display(NULL,NULL,'typical','id = 1 AND
                                                            plan_id = (SELECT max(plan_id) 
                                                                       FROM plan_table 
                                                                       WHERE statement_id=''test3'')'));

PAUSE

REM
REM Use a plan table containing runtime statistics
REM

DROP TABLE my_plan_table PURGE;

SELECT /*+ gather_plan_statistics */ count(*) FROM t;

PAUSE

CREATE TABLE my_plan_table
AS
SELECT cast(1 AS VARCHAR2(30)) AS plan_id, p.* 
FROM v$sql_plan_statistics_all p
WHERE (sql_id, child_number) = (SELECT prev_sql_id, prev_child_number
                                FROM v$session
                                WHERE sid = sys_context('userenv','sid'));
PAUSE

SELECT * FROM table(dbms_xplan.display('my_plan_table', NULL, 'iostats'));

PAUSE

REM
REM Cleanup
REM

DROP TABLE t PURGE;

DROP TABLE my_plan_table PURGE;
