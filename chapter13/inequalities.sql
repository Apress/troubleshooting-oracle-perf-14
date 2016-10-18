SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: inequalities.sql
REM Author......: Christian Antognini
REM Date........: November 2013
REM Description.: This script shows how you can rewrite inequalities to achieve 
REM               better performance.
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
SET SCAN OFF

COLUMN pad FORMAT A10 TRUNC

@../connect.sql

DROP TABLE t PURGE;

SET ECHO ON

REM
REM Setup test environment
REM

CREATE TABLE t AS
SELECT rownum AS id, 
       CASE
         WHEN rownum <= 7 THEN 'A'
         WHEN rownum <= 15 THEN 'X'
         WHEN rownum <= 19 THEN 'R'
         ELSE 'P'
       END AS status,
       rpad('*',1000,'*') AS pad
FROM dual
CONNECT BY level <= 10000;

INSERT INTO t SELECT 10000+id, 'P', pad FROM t;
INSERT INTO t SELECT 20000+id, 'P', pad FROM t;
INSERT INTO t SELECT 40000+id, 'P', pad FROM t;
INSERT INTO t SELECT 80000+id, 'P', pad FROM t;
COMMIT;

ALTER TABLE t ADD CONSTRAINT t_pk PRIMARY KEY (id);

CREATE INDEX i_status ON t (status);

BEGIN
  dbms_stats.gather_table_stats(ownname => user,
                                tabname => 'T',
                                method_opt => 'FOR ALL COLUMNS SIZE 254');
END;
/

ALTER SESSION SET statistics_level = all;

SELECT status, count(*)
FROM t
GROUP BY status;

PAUSE

REM
REM Initial query with an inequality
REM

SELECT * FROM t WHERE status != 'P'

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'iostats last -rows'));

PAUSE

REM
REM Use an IN-list containing all the values that are not excluded
REM

SELECT * FROM t WHERE status IN ('A','R','X')

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'iostats last -rows'));

PAUSE

REM
REM Use two disjunct range predicates 
REM (Does or expansion kick in? It does not happen in all versions)
REM

SELECT * FROM t WHERE status < 'P' OR status > 'P'

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'iostats last -rows'));

PAUSE

REM
REM If or expansion does not kick in, the query can be manually rewritten
REM

SELECT /*+ index(t) */ * FROM t WHERE status < 'P'
UNION ALL
SELECT /*+ index(t) */ * FROM t WHERE status > 'P'

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'iostats last -rows'));

PAUSE

REM
REM Using an index full scan is also an option
REM

SELECT /*+ index(t) */ * FROM t WHERE status != 'P'

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'iostats last -rows'));

PAUSE

REM
REM To improve the performance of the index full scan it is possible to
REM replace the index with an FBI excluding the most popular value
REM

DROP INDEX i_status;

CREATE INDEX i_status ON t (nullif(status, 'P'));

PAUSE

SELECT * FROM t WHERE nullif(status, 'P') IS NOT NULL

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'iostats last -rows'));

PAUSE

REM
REM To improve the performance of the index full scan it is possible to
REM replace the most popular value with NULL
REM

UPDATE t SET status = NULL WHERE status = 'P';
COMMIT;

PAUSE

DROP INDEX i_status;

CREATE INDEX i_status ON t (status);

PAUSE

SELECT * FROM t WHERE status IS NOT NULL

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'iostats last -rows'));

PAUSE

REM
REM Cleanup
REM

DROP TABLE t PURGE;
