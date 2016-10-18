SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: search_space.sql
REM Author......: Christian Antognini
REM Date........: October 2014
REM Description.: This script uses hints to produce more than a hundred
REM               execution plans for a single query.
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

SET TERMOUT ON FEEDBACK OFF

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t2 PURGE;
DROP TABLE t1 PURGE;

CREATE TABLE t1 (id INTEGER, n NUMBER, pad VARCHAR2(1000));

CREATE INDEX t1_id ON t1 (id);
CREATE INDEX t1_n ON t1 (n);

CREATE TABLE t2 (id INTEGER, t1_id INTEGER, n NUMBER, pad VARCHAR2(1000));

CREATE INDEX t2_id ON t2 (id);
CREATE INDEX t2_t1_id ON t2 (t1_id);
CREATE INDEX t2_n ON t2 (n);

INSERT INTO t1 
SELECT rownum, rownum, rpad('*',1000,'*')
FROM dual
CONNECT BY level <= 1500;

INSERT INTO t2
SELECT rownum, a.id, mod(a.n,500), a.pad
FROM t1 a, t1 b
WHERE rownum <= 5E5;

COMMIT;

BEGIN
  dbms_stats.gather_table_stats(user, 't1');
  dbms_stats.gather_table_stats(user, 't2');
END;
/

PAUSE

REM
REM leading(t1) use_hash(t2)
REM

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           full(t2) 
           leading(t1)
           use_hash(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           index(t2 t2_t1_id) 
           leading(t1)
           use_hash(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           index_desc(t2 t2_t1_id) 
           leading(t1)
           use_hash(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           index(t2 t2_n) 
           leading(t1)
           use_hash(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           index_desc(t2 t2_n) 
           leading(t1)
           use_hash(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           full(t2) 
           leading(t1)
           use_hash(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           full(t2) 
           leading(t1)
           use_hash(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           index(t2 t2_t1_id) 
           leading(t1)
           use_hash(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           index(t2 t2_t1_id) 
           leading(t1)
           use_hash(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           index_desc(t2 t2_t1_id) 
           leading(t1)
           use_hash(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           index_desc(t2 t2_t1_id) 
           leading(t1)
           use_hash(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           index(t2 t2_n) 
           leading(t1)
           use_hash(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           index(t2 t2_n) 
           leading(t1)
           use_hash(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           index_desc(t2 t2_n) 
           leading(t1)
           use_hash(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           index_desc(t2 t2_n) 
           leading(t1)
           use_hash(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           full(t2) 
           leading(t1)
           use_hash(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           full(t2) 
           leading(t1)
           use_hash(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           index(t2 t2_t1_id) 
           leading(t1)
           use_hash(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           index(t2 t2_t1_id) 
           leading(t1)
           use_hash(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           index_desc(t2 t2_t1_id) 
           leading(t1)
           use_hash(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           index_desc(t2 t2_t1_id) 
           leading(t1)
           use_hash(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           index(t2 t2_n) 
           leading(t1)
           use_hash(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           index(t2 t2_n) 
           leading(t1)
           use_hash(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           index_desc(t2 t2_n) 
           leading(t1)
           use_hash(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           index_desc(t2 t2_n) 
           leading(t1)
           use_hash(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

REM
REM leading(t2) use_hash(t1)
REM

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           full(t2) 
           leading(t2)
           use_hash(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           index(t2 t2_t1_id) 
           leading(t2)
           use_hash(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           index_desc(t2 t2_t1_id) 
           leading(t2)
           use_hash(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           index(t2 t2_n) 
           leading(t2)
           use_hash(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           index_desc(t2 t2_n) 
           leading(t2)
           use_hash(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           full(t2) 
           leading(t2)
           use_hash(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           full(t2) 
           leading(t2)
           use_hash(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           index(t2 t2_t1_id) 
           leading(t2)
           use_hash(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           index(t2 t2_t1_id) 
           leading(t2)
           use_hash(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           index_desc(t2 t2_t1_id) 
           leading(t2)
           use_hash(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           index_desc(t2 t2_t1_id) 
           leading(t2)
           use_hash(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           index(t2 t2_n) 
           leading(t2)
           use_hash(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           index(t2 t2_n) 
           leading(t2)
           use_hash(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           index_desc(t2 t2_n) 
           leading(t2)
           use_hash(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           index_desc(t2 t2_n) 
           leading(t2)
           use_hash(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           full(t2) 
           leading(t2)
           use_hash(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           full(t2) 
           leading(t2)
           use_hash(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           index(t2 t2_t1_id) 
           leading(t2)
           use_hash(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           index(t2 t2_t1_id) 
           leading(t2)
           use_hash(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           index_desc(t2 t2_t1_id) 
           leading(t2)
           use_hash(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           index_desc(t2 t2_t1_id) 
           leading(t2)
           use_hash(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           index(t2 t2_n) 
           leading(t2)
           use_hash(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           index(t2 t2_n) 
           leading(t2)
           use_hash(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           index_desc(t2 t2_n) 
           leading(t2)
           use_hash(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           index_desc(t2 t2_n) 
           leading(t2)
           use_hash(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

REM
REM leading(t1) use_merge(t2)
REM

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           full(t2) 
           leading(t1)
           use_merge(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           index(t2 t2_t1_id) 
           leading(t1)
           use_merge(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           index_desc(t2 t2_t1_id) 
           leading(t1)
           use_merge(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           index(t2 t2_n) 
           leading(t1)
           use_merge(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           index_desc(t2 t2_n) 
           leading(t1)
           use_merge(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           full(t2) 
           leading(t1)
           use_merge(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           full(t2) 
           leading(t1)
           use_merge(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           index(t2 t2_t1_id) 
           leading(t1)
           use_merge(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           index(t2 t2_t1_id) 
           leading(t1)
           use_merge(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           index_desc(t2 t2_t1_id) 
           leading(t1)
           use_merge(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           index_desc(t2 t2_t1_id) 
           leading(t1)
           use_merge(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           index(t2 t2_n) 
           leading(t1)
           use_merge(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           index(t2 t2_n) 
           leading(t1)
           use_merge(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           index_desc(t2 t2_n) 
           leading(t1)
           use_merge(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           index_desc(t2 t2_n) 
           leading(t1)
           use_merge(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           full(t2) 
           leading(t1)
           use_merge(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           full(t2) 
           leading(t1)
           use_merge(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           index(t2 t2_t1_id) 
           leading(t1)
           use_merge(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           index(t2 t2_t1_id) 
           leading(t1)
           use_merge(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           index_desc(t2 t2_t1_id) 
           leading(t1)
           use_merge(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           index_desc(t2 t2_t1_id) 
           leading(t1)
           use_merge(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           index(t2 t2_n) 
           leading(t1)
           use_merge(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           index(t2 t2_n) 
           leading(t1)
           use_merge(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           index_desc(t2 t2_n) 
           leading(t1)
           use_merge(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           index_desc(t2 t2_n) 
           leading(t1)
           use_merge(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

REM
REM leading(t2) use_merge(t1)
REM

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           full(t2) 
           leading(t2)
           use_merge(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           index(t2 t2_t1_id) 
           leading(t2)
           use_merge(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           index_desc(t2 t2_t1_id) 
           leading(t2)
           use_merge(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           index(t2 t2_n) 
           leading(t2)
           use_merge(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           index_desc(t2 t2_n) 
           leading(t2)
           use_merge(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           full(t2) 
           leading(t2)
           use_merge(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           full(t2) 
           leading(t2)
           use_merge(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           index(t2 t2_t1_id) 
           leading(t2)
           use_merge(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           index(t2 t2_t1_id) 
           leading(t2)
           use_merge(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           index_desc(t2 t2_t1_id) 
           leading(t2)
           use_merge(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           index_desc(t2 t2_t1_id) 
           leading(t2)
           use_merge(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           index(t2 t2_n) 
           leading(t2)
           use_merge(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           index(t2 t2_n) 
           leading(t2)
           use_merge(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           index_desc(t2 t2_n) 
           leading(t2)
           use_merge(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           index_desc(t2 t2_n) 
           leading(t2)
           use_merge(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           full(t2) 
           leading(t2)
           use_merge(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           full(t2) 
           leading(t2)
           use_merge(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           index(t2 t2_t1_id) 
           leading(t2)
           use_merge(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           index(t2 t2_t1_id) 
           leading(t2)
           use_merge(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           index_desc(t2 t2_t1_id) 
           leading(t2)
           use_merge(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           index_desc(t2 t2_t1_id) 
           leading(t2)
           use_merge(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           index(t2 t2_n) 
           leading(t2)
           use_merge(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           index(t2 t2_n) 
           leading(t2)
           use_merge(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           index_desc(t2 t2_n) 
           leading(t2)
           use_merge(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           index_desc(t2 t2_n) 
           leading(t2)
           use_merge(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

REM
REM leading(t1) use_nl(t2)
REM

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           full(t2) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           index(t2 t2_t1_id) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           index_desc(t2 t2_t1_id) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           index(t2 t2_n) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           index_desc(t2 t2_n) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           index_combine(t2 t2_t1_id t2_n) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           full(t2) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           full(t2) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           index(t2 t2_t1_id) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           index(t2 t2_t1_id) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           index_desc(t2 t2_t1_id) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           index_desc(t2 t2_t1_id) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           index(t2 t2_n) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           index(t2 t2_n) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           index_desc(t2 t2_n) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           index_desc(t2 t2_n) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           index_combine(t2 t2_t1_id t2_n) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           index_combine(t2 t2_t1_id t2_n) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           full(t2) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           full(t2) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           index(t2 t2_t1_id) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           index(t2 t2_t1_id) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           index_desc(t2 t2_t1_id) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           index_desc(t2 t2_t1_id) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           index(t2 t2_n) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           index(t2 t2_n) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           index_desc(t2 t2_n) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           index_desc(t2 t2_n) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           index_combine(t2 t2_t1_id t2_n) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           index_combine(t2 t2_t1_id t2_n) 
           leading(t1)
           use_nl(t2) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

REM
REM leading(t2) use_nl(t1)
REM

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           full(t2) 
           leading(t2)
           use_nl(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           index(t2 t2_t1_id) 
           leading(t2)
           use_nl(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           index_desc(t2 t2_t1_id) 
           leading(t2)
           use_nl(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           index(t2 t2_n) 
           leading(t2)
           use_nl(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ full(t1)
           index_desc(t2 t2_n) 
           leading(t2)
           use_nl(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           full(t2) 
           leading(t2)
           use_nl(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           full(t2) 
           leading(t2)
           use_nl(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           index(t2 t2_t1_id) 
           leading(t2)
           use_nl(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           index(t2 t2_t1_id) 
           leading(t2)
           use_nl(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           index_desc(t2 t2_t1_id) 
           leading(t2)
           use_nl(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           index_desc(t2 t2_t1_id) 
           leading(t2)
           use_nl(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           index(t2 t2_n) 
           leading(t2)
           use_nl(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           index(t2 t2_n) 
           leading(t2)
           use_nl(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_id)
           index_desc(t2 t2_n) 
           leading(t2)
           use_nl(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_id)
           index_desc(t2 t2_n) 
           leading(t2)
           use_nl(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           full(t2) 
           leading(t2)
           use_nl(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           full(t2) 
           leading(t2)
           use_nl(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           index(t2 t2_t1_id) 
           leading(t2)
           use_nl(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           index(t2 t2_t1_id) 
           leading(t2)
           use_nl(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           index_desc(t2 t2_t1_id) 
           leading(t2)
           use_nl(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           index_desc(t2 t2_t1_id) 
           leading(t2)
           use_nl(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           index(t2 t2_n) 
           leading(t2)
           use_nl(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           index(t2 t2_n) 
           leading(t2)
           use_nl(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index(t1 t1_n)
           index_desc(t2 t2_n) 
           leading(t2)
           use_nl(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_desc(t1 t1_n)
           index_desc(t2 t2_n) 
           leading(t2)
           use_nl(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_combine(t1 t1_id t1_n)
           index(t2 t2_n) 
           leading(t2)
           use_nl(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

EXPLAIN PLAN FOR
SELECT /*+ index_combine(t1 t1_id t1_n)
           index_desc(t2 t2_n) 
           leading(t2)
           use_nl(t1) */ *
FROM t1 JOIN t2 ON t1.id = t2.t1_id
WHERE t1.n = 1 AND t2.n = 2;

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic +rows +cost'));

PAUSE

REM
REM Cleanup
REM

DROP TABLE t2 PURGE;
DROP TABLE t1 PURGE;
