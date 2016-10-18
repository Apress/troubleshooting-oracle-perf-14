SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: cpu_cost_column_access.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows the CPU cost estimated by the query
REM               optimizer when accessing a column, depending on its position
REM               in the table.
REM Notes.......: This scripts works as of Oracle Database 10gR2 only.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 31.05.2012 Changed note about requirements
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

@../connect.sql

COLUMN statement_id FORMAT A12
COLUMN io_cost FORMAT 999999

SET ECHO ON

DROP TABLE t;

DELETE plan_table;

CREATE TABLE t (c1 NUMBER, c2 NUMBER, c3 NUMBER, 
                c4 NUMBER, c5 NUMBER, c6 NUMBER, 
                c7 NUMBER, c8 NUMBER, c9 NUMBER);

INSERT INTO t VALUES (1, 2, 3, 4, 5, 6, 7, 8, 9);

execute dbms_stats.gather_table_stats(user,'t')

EXPLAIN PLAN SET STATEMENT_ID 'c1' FOR SELECT c1 FROM t;
EXPLAIN PLAN SET STATEMENT_ID 'c2' FOR SELECT c2 FROM t;
EXPLAIN PLAN SET STATEMENT_ID 'c3' FOR SELECT c3 FROM t;
EXPLAIN PLAN SET STATEMENT_ID 'c4' FOR SELECT c4 FROM t;
EXPLAIN PLAN SET STATEMENT_ID 'c5' FOR SELECT c5 FROM t;
EXPLAIN PLAN SET STATEMENT_ID 'c6' FOR SELECT c6 FROM t;
EXPLAIN PLAN SET STATEMENT_ID 'c7' FOR SELECT c7 FROM t;
EXPLAIN PLAN SET STATEMENT_ID 'c8' FOR SELECT c8 FROM t;
EXPLAIN PLAN SET STATEMENT_ID 'c9' FOR SELECT c9 FROM t;

SELECT statement_id, cpu_cost AS total_cpu_cost, 
       cpu_cost-lag(cpu_cost) OVER (ORDER BY statement_id) AS cpu_cost_1_coll,
       io_cost
FROM plan_table
WHERE id = 0 
ORDER BY statement_id;

DROP TABLE t;
PURGE TABLE t;
