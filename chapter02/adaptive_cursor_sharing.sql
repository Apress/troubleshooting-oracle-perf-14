SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************ http://top.antognini.ch **************************
REM ***************************************************************************
REM
REM File name...: adaptive_cursor_sharing.sql
REM Author......: Christian Antognini
REM Date........: March 2012
REM Description.: This script shows the pros and cons of adaptive cursor sharing.
REM Notes.......: This script works as of 11gR1 only.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 08.23.2012 Added test for implicit datatype conversion
REM 10.12.2012 Added child cursor invalidation for extending its selectivity
REM 07.12.2013 Added test for missing object statistics
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

@../connect.sql

VARIABLE id NUMBER

COLUMN is_bind_sensitive FORMAT A17
COLUMN is_bind_aware FORMAT A13
COLUMN is_shareable FORMAT A12
COLUMN peeked FORMAT A6
COLUMN predicate FORMAT A9 TRUNC

COLUMN sql_id NEW_VALUE sql_id

SET ECHO ON

REM
REM Setup test environment
REM

ALTER SYSTEM FLUSH SHARED_POOL;

ALTER SESSION SET cursor_sharing = 'EXACT';

DROP TABLE t;

CREATE TABLE t 
AS 
SELECT rownum AS id, rpad('*',100,'*') AS pad 
FROM dual
CONNECT BY level <= 1000;

ALTER TABLE t ADD CONSTRAINT t_pk PRIMARY KEY (id);

BEGIN
  dbms_stats.gather_table_stats(
    ownname          => user, 
    tabname          => 't', 
    estimate_percent => 100, 
    method_opt       => 'for all columns size 1'
  );
END;
/

SELECT count(id), count(DISTINCT id), min(id), max(id) FROM t;

PAUSE

REM
REM Without bind variables different execution plans are used if the value
REM used in the WHERE clause change. This is because the query optimizer
REM recognize the different selectivity of the two predicates.
REM

SELECT count(pad) FROM t WHERE id < 990;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'basic'));

PAUSE

SELECT count(pad) FROM t WHERE id < 10;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'basic'));

PAUSE

REM
REM By default with bind variables the child cursor can be shared. Depending on 
REM the peeked value (10 or 990), a full table scan or an index range scan is used.
REM

EXECUTE :id := 10;

SELECT count(pad) FROM t WHERE id < :id;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'basic'));

PAUSE

EXECUTE :id := 990;

SELECT count(pad) FROM t WHERE id < :id;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'basic'));

PAUSE

REM
REM Display information about the associated child cursor
REM

SELECT sql_id
FROM v$sqlarea
WHERE sql_text = 'SELECT count(pad) FROM t WHERE id < :id';

SELECT child_number, is_bind_sensitive, is_bind_aware, is_shareable, plan_hash_value
FROM v$sql
WHERE sql_id = '&sql_id';

PAUSE

REM
REM After the previous (sub-optimal) execution the initial execution plan
REM is invalidated.
REM

SELECT count(pad) FROM t WHERE id < :id;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'basic'));

PAUSE

EXECUTE :id := 10;

SELECT count(pad) FROM t WHERE id < :id;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'basic'));

PAUSE

REM
REM Display information about the associated child cursors
REM

SELECT child_number, is_bind_sensitive, is_bind_aware, is_shareable, plan_hash_value
FROM v$sql
WHERE sql_id = '&sql_id'
ORDER BY child_number;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor('&sql_id', NULL, 'basic'));

PAUSE

SELECT child_number, peeked, executions, rows_processed, buffer_gets
FROM v$sql_cs_statistics 
WHERE sql_id = '&sql_id'
ORDER BY child_number;

PAUSE

SELECT child_number, trim(predicate) AS predicate, low, high
FROM v$sql_cs_selectivity 
WHERE sql_id = '&sql_id'
ORDER BY child_number;

PAUSE

SELECT child_number, bucket_id, count
FROM v$sql_cs_histogram 
WHERE sql_id = '&sql_id'
ORDER BY child_number, bucket_id;

PAUSE

REM
REM Child cursors can be made unshareable to extend the predicate selectivity
REM associated to them

SELECT child_number, trim(predicate) AS predicate, low, high
FROM v$sql_cs_selectivity 
WHERE sql_id = '&sql_id'
ORDER BY child_number;

PAUSE

EXECUTE :id := 500;

SELECT count(pad) FROM t WHERE id < :id;

PAUSE

SELECT child_number, is_bind_sensitive, is_bind_aware, is_shareable, plan_hash_value
FROM v$sql
WHERE sql_id = '&sql_id'
ORDER BY child_number;

PAUSE

SELECT child_number, trim(predicate) AS predicate, low, high
FROM v$sql_cs_selectivity 
WHERE sql_id = '&sql_id'
ORDER BY child_number;

PAUSE

REM
REM As of 11.1.0.7 it is possible to create a bind-aware cursor by specifying
REM the BIND_AWARE hint
REM

EXECUTE :id := 10;

SELECT /*+ bind_aware */ count(pad) FROM t WHERE id < :id;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'basic'));

PAUSE

EXECUTE :id := 990;

SELECT /*+ bind_aware */ count(pad) FROM t WHERE id < :id;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'basic'));

PAUSE

SELECT sql_id, child_number, is_bind_sensitive, is_bind_aware, is_shareable
FROM v$sql
WHERE sql_text = 'SELECT /*+ bind_aware */ count(pad) FROM t WHERE id < :id'
ORDER BY child_number;

PAUSE

REM
REM Show that adaptive cursor sharing is not used when an implicit datatype
REM conversion takes place
REM

VARIABLE idv VARCHAR2(10)

EXECUTE :idv := 10;

SELECT /*+ bind_aware */ count(pad) FROM t WHERE id < :idv;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'basic'));

PAUSE

EXECUTE :id := 990;

SELECT /*+ bind_aware */ count(pad) FROM t WHERE id < :idv;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'basic'));

PAUSE

SELECT sql_id, child_number, is_bind_sensitive, is_bind_aware, is_shareable
FROM v$sql
WHERE sql_text = 'SELECT /*+ bind_aware */ count(pad) FROM t WHERE id < :idv'
ORDER BY child_number;

PAUSE

REM
REM Show that adaptive cursor sharing is not used when no object statistics  
REM are available (note that to avoid sharing another cursor the text of the
REM SQL statement is written with lowercase characters)
REM

BEGIN
  dbms_stats.delete_table_stats(
    ownname          => user, 
    tabname          => 't', 
    cascade_indexes  => true
  );
END;
/

EXECUTE :id := 10;

select /*+ bind_aware */ count(pad) from t where id < :id;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'basic'));

PAUSE

EXECUTE :id := 990;

select /*+ bind_aware */ count(pad) from t where id < :id;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'basic'));

PAUSE

SELECT sql_id, child_number, is_bind_sensitive, is_bind_aware, is_shareable
FROM v$sql
WHERE sql_text = 'select /*+ bind_aware */ count(pad) from t where id < :id'
ORDER BY child_number;

PAUSE

REM
REM Cleanup
REM

UNDEFINE sql_id

DROP TABLE t;
PURGE TABLE t;
