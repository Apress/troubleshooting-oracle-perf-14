SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************ http://top.antognini.ch **************************
REM ***************************************************************************
REM
REM File name...: bind_variables_peeking.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows the pros and cons of bind variable peeking.
REM Notes.......: -
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 04.03.2012 Moved part about adaptive cursor sharing in the script
REM            adaptive_cursor_sharing.sql + removed irrelevant notes
REM 08.23.2012 Added test for implicit datatype conversion
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

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'basic +rows'));

PAUSE

SELECT count(pad) FROM t WHERE id < 10;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'basic +rows'));

PAUSE

REM
REM With bind variables the same execution plan is used. Depending on the 
REM peeked value (10 or 990), a full table scan or an index range scan is used.
REM

EXECUTE :id := 990;

SELECT count(pad) FROM t WHERE id < :id;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'basic +rows'));

PAUSE

EXECUTE :id := 10;

SELECT count(pad) FROM t WHERE id < :id;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'basic +rows'));

PAUSE

EXECUTE :id := 10;

select count(pad) from t where id < :id;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'basic +rows'));

PAUSE

EXECUTE :id := 990;

select count(pad) from t where id < :id;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'basic +rows'));

PAUSE

REM
REM Bind variable peeking works also when an implicit datatype conversion
REM takes place
REM

VARIABLE idv VARCHAR2(10)

EXECUTE :idv := '42';

SELECT count(pad) FROM t WHERE id < :idv;

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'basic +rows peeked_binds'));

REM
REM Cleanup
REM

UNDEFINE sql_id

DROP TABLE t;
PURGE TABLE t;
