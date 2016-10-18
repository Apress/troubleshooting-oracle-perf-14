SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: composite_index.sql
REM Author......: Christian Antognini
REM Date........: October 2013
REM Description.: This script shows several queries taking advantage of 
REM               composite indexes and bitmap plans.
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

COLUMN pad FORMAT A10 TRUNC
COLUMN c1 FORMAT A10 TRUNC
COLUMN c2 FORMAT A10 TRUNC

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t;

CREATE TABLE t (
  id NUMBER,
  d1 DATE,
  n1 NUMBER,
  n2 NUMBER,
  n3 NUMBER,
  n4 NUMBER,
  n5 NUMBER,
  n6 NUMBER,
  c1 VARCHAR2(20),
  c2 VARCHAR2(20),
  pad VARCHAR2(4000),
  CONSTRAINT t_pk PRIMARY KEY (id)
);

execute dbms_random.seed(0)

INSERT INTO t
SELECT rownum AS id,
       trunc(to_date('2007-01-01','yyyy-mm-dd')+rownum/27.4) AS d1,
       nullif(1+mod(rownum,19),10) AS n1,
       nullif(1+mod(rownum,113),10) AS n2,
       nullif(1+mod(rownum,61),10) AS n3,
       nullif(1+mod(rownum,19),10) AS n4,
       nullif(1+mod(rownum,113),10) AS n5,
       nullif(1+mod(rownum,61),10) AS n6,
       dbms_random.string('p',20) AS c1,
       dbms_random.string('p',20) AS c2,
       dbms_random.string('p',255) AS pad
FROM dual
CONNECT BY level <= 10000
ORDER BY dbms_random.value;

CREATE INDEX i_n1 ON t (n1);
CREATE INDEX i_n2 ON t (n2);
CREATE INDEX i_n3 ON t (n3);
CREATE INDEX i_n123 ON t (n1, n2, n3);
CREATE BITMAP INDEX i_n4 ON t (n4);
CREATE BITMAP INDEX i_n5 ON t (n5);
CREATE BITMAP INDEX i_n6 ON t (n6);
CREATE BITMAP INDEX i_n456 ON t (n4, n5, n6);

BEGIN
  dbms_stats.gather_table_stats(
    ownname          => user,
    tabname          => 'T',
    estimate_percent => 100,
    method_opt       => 'for all columns size skewonly',
    cascade          => TRUE
  );
END;
/

ALTER SESSION SET statistics_level = all;

PAUSE

REM
REM B-tree indexes
REM

SELECT /*+ index(t i_n1) */ * FROM t WHERE n1 = 6 AND n2 = 42 AND n3 = 11

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t i_n2) */ * FROM t WHERE n1 = 6 AND n2 = 42 AND n3 = 11

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t i_n3) */ * FROM t WHERE n1 = 6 AND n2 = 42 AND n3 = 11

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT column_name, num_distinct
FROM user_tab_columns
WHERE table_name = 'T' AND column_name IN ('ID', 'N1', 'N2', 'N3');

PAUSE

SELECT /*+ index(t i_n123) */ * FROM t WHERE n1 = 6 AND n2 = 42 AND n3 = 11

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t i_n123) */ * FROM t WHERE n1 = 6 AND n3 = 11

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index_ss(t i_n123) */ * FROM t WHERE n2 = 42 AND n3 = 11

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

REM
REM Index compression
REM

ANALYZE INDEX i_n123 VALIDATE STRUCTURE;

PAUSE

SELECT opt_cmpr_count, opt_cmpr_pctsave FROM index_stats;

PAUSE

SELECT blocks FROM index_stats;

PAUSE

ALTER INDEX i_n123 REBUILD COMPRESS 2;

PAUSE

ANALYZE INDEX i_n123 VALIDATE STRUCTURE;

PAUSE

SELECT blocks FROM index_stats;

PAUSE

REM
REM Bitmap indexes
REM

SELECT /*+ index_combine(t i_n4 i_n5 i_n6) */ * FROM t WHERE n4 = 6 AND n5 = 42 AND n6 = 11

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t i_n456) */ * FROM t WHERE n4 = 6 AND n5 = 42 AND n6 = 11

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index_combine(t i_n4 i_n5 i_n6) */ * FROM t WHERE n4 = 6 OR n5 = 42 OR n6 = 11

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index_combine(t i_n4 i_n5 i_n6) */ * FROM t WHERE n4 != 6 AND n5 = 42 AND n6 = 11

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

REM
REM Bitmap Plans for B-tree Indexes 
REM

SELECT /*+ index_combine(t i_n1 i_n2 i_n3) */ *
FROM t
WHERE n1 = 6 AND n2 = 42 AND n3 = 11

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index_combine(t i_n1 i_n2 i_n3) */ *
FROM t
WHERE n1 = 6 OR n2 = 42 OR n3 = 11

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index_combine(t i_n1 i_n2 i_n3) */ *
FROM t
WHERE n1 != 6 AND n2 = 42 AND n3 = 11

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

REM
REM Cleanup
REM

DROP TABLE t;
PURGE TABLE t;
