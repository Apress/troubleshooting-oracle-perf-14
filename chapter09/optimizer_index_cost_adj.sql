SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: optimizer_index_cost_adj.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows the drawbacks of setting the initialization
REM               parameter optimizer_index_cost_adj.
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

@../connect.sql

SET ECHO ON

COLUMN INDEX_NAME FORMAT A10

REM
REM Setup test environment
REM

DROP TABLE t;

CREATE TABLE t (id, val1, val2, val3)
PCTFREE 80 PCTUSED 20
AS 
SELECT rownum, mod(floor(rownum/2),1000), mod(floor(rownum/10),1000), rpad('-',50,'-')
FROM dual 
CONNECT BY level <= 10000;

CREATE INDEX t_val1_i ON t (val1);

CREATE INDEX t_val2_i ON t (val2);

PAUSE

BEGIN
 dbms_stats.gather_table_stats(
   ownname=>user, 
   tabname=>'T',
   cascade=>TRUE);
END;
/

REM set parameters to let the demo work on different releases

ALTER SESSION SET "_b_tree_bitmap_plans" = FALSE;
ALTER SESSION SET "_optimizer_cost_model" = IO;

PAUSE

REM
REM show index statistics, t_val2_i has a much better clustering factor hen t_val1_i
REM

SELECT blocks 
FROM user_tables 
WHERE table_name = 'T';

SELECT index_name, num_rows, distinct_keys, blevel, leaf_blocks, clustering_factor
FROM user_indexes
WHERE table_name = 'T';

PAUSE

REM
REM test with OPTIMIZER_INDEX_COST_ADJ=100
REM

ALTER SESSION SET OPTIMIZER_INDEX_COST_ADJ=100;


EXPLAIN PLAN FOR 
SELECT * FROM t WHERE val1 = 11 AND val2 = 11;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM test with OPTIMIZER_INDEX_COST_ADJ=10
REM

ALTER SESSION SET OPTIMIZER_INDEX_COST_ADJ=10;

EXPLAIN PLAN FOR 
SELECT * FROM t WHERE val1 = 11 AND val2 = 11;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM rename t_val1_i to t_val3_i and test again with OPTIMIZER_INDEX_COST_ADJ=10
REM

ALTER INDEX t_val1_i RENAME TO t_val3_i;

PAUSE

EXPLAIN PLAN FOR 
SELECT * FROM t WHERE val1 = 11 AND val2 = 11;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM Cleanup
REM

DROP TABLE t;
PURGE TABLE t;
