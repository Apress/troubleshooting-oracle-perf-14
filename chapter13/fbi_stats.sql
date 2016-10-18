SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: fbi_stats.sql
REM Author......: Christian Antognini
REM Date........: December 2013
REM Description.: This script shows that column statistics (incl. histograms)  
REM               are gathered also for the hidden columns associated to the 
REM               function-based indexes.
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

COLUMN column_name FORMAT A12
COLUMN low_value FORMAT A10 TRUNC
COLUMN high_value FORMAT A10 TRUNC

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t PURGE;

CREATE TABLE t 
AS 
SELECT rownum AS id, rpad('*',100,'*') AS pad 
FROM dual 
CONNECT BY level <= 1000;

PAUSE

CREATE OR REPLACE FUNCTION f(n IN NUMBER) RETURN NUMBER DETERMINISTIC AS
BEGIN
  IF n <= 10
  THEN 
    RETURN 0;
  ELSE
    RETURN 1;
  END IF;
END F;
/

PAUSE

CREATE INDEX i ON t (f(id));

PAUSE

execute dbms_stats.gather_table_stats(user, 't', method_opt=>'for all columns size 100')

PAUSE

REM
REM Show column statistics
REM

SELECT column_name, num_distinct, low_value, high_value, density, num_nulls, avg_col_len
FROM user_tab_cols 
WHERE table_name = 'T';

PAUSE

SELECT column_name, num_buckets, histogram 
FROM user_tab_cols 
WHERE table_name = 'T';

PAUSE

REM
REM Show that the histogram of the hidden column is used to
REM estimate the cardinality
REM

EXPLAIN PLAN FOR SELECT * FROM t WHERE f(id) = 0;

SELECT * FROM table(dbms_xplan.display);

PAUSE

EXPLAIN PLAN FOR SELECT * FROM t WHERE f(id) = 1;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM Cleanup
REM

DROP TABLE t PURGE;

DROP FUNCTION f;
