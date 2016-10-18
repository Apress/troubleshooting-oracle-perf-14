SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: invisible_index.sql
REM Author......: Christian Antognini
REM Date........: November 2013
REM Description.: This script shows how to change the visibility of an index,
REM               the impact of visibility on the query optimizer and how to
REM               use the optimizer_use_invisible_indexes parameter and the
REM               use_invisible_indexes hint.
REM Notes.......: -
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 31.12.2013 Added test to check whether a rebuild changes the visibility
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

COLUMN visibility FORMAT A10

@../connect.sql

ALTER SESSION SET optimizer_use_invisible_indexes = FALSE;

DROP TABLE t PURGE;

SET ECHO ON

REM
REM Setup test environment: create a test table (incl. PK and object statistics)
REM

CREATE TABLE t AS 
SELECT rownum AS id, rpad('*',50,'*') AS pad 
FROM all_objects
WHERE rownum <= 1000;

ALTER TABLE t ADD CONSTRAINT t_pk PRIMARY KEY (id);

execute dbms_stats.gather_table_stats(user,'t')

PAUSE

REM
REM obviously the primary key index is used when a restriction is 
REM based on the column composing it
REM

EXPLAIN PLAN FOR SELECT * FROM t WHERE id = 42;

SELECT * FROM table(dbms_xplan.display(format => 'basic +predicate'));

PAUSE

REM
REM change the visibility of the index
REM

SELECT visibility FROM user_indexes WHERE index_name = 'T_PK';

ALTER INDEX t_pk INVISIBLE;

SELECT visibility FROM user_indexes WHERE index_name = 'T_PK';

PAUSE

REM
REM check that the query optimizer no longer use the invisible index
REM

EXPLAIN PLAN FOR SELECT * FROM t WHERE id = 42;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +predicate'));

PAUSE

REM
REM also when a hint is specified the index cannot be used
REM

EXPLAIN PLAN FOR SELECT /*+ index(t t_pk) */ * FROM t WHERE id = 42;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +predicate'));

PAUSE

REM
REM the only exception is when USE_INVISIBLE_INDEXES is specified
REM

EXPLAIN PLAN FOR SELECT /*+ use_invisible_indexes */ * FROM t WHERE id = 42;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +predicate'));

PAUSE

REM
REM change the visibility of the index and check its utilization
REM

ALTER INDEX t_pk VISIBLE;

SELECT visibility FROM user_indexes WHERE index_name = 'T_PK';

EXPLAIN PLAN FOR SELECT * FROM t WHERE id = 42;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +predicate'));

PAUSE

REM
REM through the parameter optimizer_use_invisible_indexes it is 
REM possible to instruct the query optimizer to use an invisible index
REM

ALTER INDEX t_pk INVISIBLE;

SELECT visibility FROM user_indexes WHERE index_name = 'T_PK';

ALTER SESSION SET optimizer_use_invisible_indexes = TRUE;

EXPLAIN PLAN FOR SELECT * FROM t WHERE id = 42;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +predicate'));

PAUSE

EXPLAIN PLAN FOR SELECT /*+ no_use_invisible_indexes */ * FROM t WHERE id = 42;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +predicate'));

ALTER SESSION SET optimizer_use_invisible_indexes = FALSE;

set autotrace off

PAUSE

REM
REM in 11.1.0.6 only a rebuild changes the visibility of an index
REM

SELECT visibility FROM user_indexes WHERE index_name = 'T_PK';

PAUSE

ALTER INDEX t_pk REBUILD;

PAUSE

SELECT visibility FROM user_indexes WHERE index_name = 'T_PK';

PAUSE

REM
REM Cleanup environment
REM

DROP TABLE t PURGE;
