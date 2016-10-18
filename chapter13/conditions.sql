SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: conditions.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows how you can use B-tree and bitmap indexes
REM               to apply several types of conditions.
REM Notes.......: -
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 24.06.2010 Added queries containing NOT IN condition
REM 17.02.2011 Added queries containing IS NOT NULL condition
REM 11.10.2013 Replaced 10gR1 code + turned off output of the result sets
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

DROP TABLE t PURGE;

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
CREATE INDEX i_c1 ON t (c1);
CREATE BITMAP INDEX i_c2 ON t (c2);

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
REM Equality Conditions
REM

SELECT /*+ index(t) */ * FROM t WHERE id = 6

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index_asc(t) */ * FROM t WHERE n1 = 6

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index_desc(t) */ * FROM t WHERE n1 = 6

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t i_n4) */ * FROM t WHERE n4 = 6

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

REM
REM IS NULL Conditions 
REM

SELECT /*+ index(t i_n1) */ * FROM t WHERE n1 IS NULL

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t i_n1) */ * FROM t WHERE n1 IS NOT NULL

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t) */ * FROM t WHERE n1 = 6 AND n2 IS NULL

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t) */ * FROM t WHERE n1 IS NULL AND n2 = 8

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t) */ * FROM t WHERE n1 IS NOT NULL AND n2 IS NULL

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t) */ * FROM t WHERE n1 IS NULL AND n2 IS NOT NULL

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t) */ * FROM t WHERE n1 IS NULL AND n3 IS NOT NULL

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

CREATE INDEX i_n1_nn ON t (n1,d1);

SELECT /*+ index(t) */ * FROM t WHERE n1 IS NULL

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

DROP INDEX i_n1_nn;

PAUSE

CREATE INDEX i_n1_nn ON t (n1,0);

SELECT /*+ index(t) */ * FROM t WHERE n1 IS NULL

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

DROP INDEX i_n1_nn;

PAUSE

SELECT /*+ index(t i_n4) */ * FROM t WHERE n4 IS NULL

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t i_n4) */ * FROM t WHERE n4 IS NOT NULL

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

REM
REM Range Conditions
REM 

SELECT /*+ index(t (t.id)) */ * FROM t WHERE id BETWEEN 6 AND 19

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index_asc(t (t.id)) */ * FROM t WHERE id BETWEEN 6 AND 19 ORDER BY id DESC

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index_desc(t (t.id)) */ * FROM t WHERE id BETWEEN 6 AND 19 ORDER BY id DESC

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t (t.n4)) */ * FROM t WHERE n4 BETWEEN 6 AND 19

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t (t.n4)) */ * FROM t WHERE n4 BETWEEN 6 AND 19 ORDER BY n4 DESC

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

REM
REM IN Conditions
REM

SELECT /*+ index(t t_pk) */ * FROM t WHERE id IN (6, 8, 19, 28)

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t t_pk) */ * FROM t WHERE id NOT IN (6, 8, 19, 28)

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t i_n1) */ * FROM t WHERE n1 IN (6, 8, 19, 28)

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t i_n1) */ * FROM t WHERE n1 NOT IN (6, 8, 19, 28)

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t i_n4) */ * FROM t WHERE n4 IN (6, 8, 19, 28)

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t i_n4) */ * FROM t WHERE n4 NOT IN (6, 8, 19, 28)

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

REM
REM LIKE Conditions
REM

SELECT /*+ index(t i_c1) */ * FROM t WHERE c1 LIKE 'A%'

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t i_c1) */ * FROM t WHERE c1 LIKE '%A%'

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t i_c2) */ * FROM t WHERE c2 LIKE 'A%'

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t i_c2) */ * FROM t WHERE c2 LIKE '%A%'

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

REM
REM REGEXP_LIKE Conditions
REM

SELECT /* index(t i_c1) */ * FROM t WHERE regexp_like(c1, '^A')

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /* index(t i_c1) */ * FROM t WHERE regexp_like(c1, 'A')

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /* index(t i_c2) */ * FROM t WHERE regexp_like(c2, '^A')

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /* index(t i_c2) */ * FROM t WHERE regexp_like(c2, 'A')

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

REM
REM Inequality Conditions
REM

SELECT /*+ full(t) */ * FROM t WHERE id != 6

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t t_pk) */ * FROM t WHERE id != 6

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t t_pk) */ * FROM t WHERE id < 6 OR id > 6

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t t_pk) */ * FROM t WHERE id < 6
UNION ALL
SELECT /*+ index(t t_pk) */ * FROM t WHERE id > 6

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT * FROM t WHERE n1 != 6

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t i_n1) */ * FROM t WHERE n1 != 6

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t i_n4) */ * FROM t WHERE n4 != 6

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t i_n4) */ * FROM t WHERE n4 != 6 AND n5 = 6

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

REM
REM Min/Max Functions
REM

SELECT /*+ index(t t_pk) */ min(id) FROM t

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t t_pk) */ min(id) FROM t WHERE id > 42

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t i_n1) */ min(n1) FROM t

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t i_n1) */ min(n1) FROM t WHERE n1 > 42

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t i_n4) */ min(n4) FROM t

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t i_n4) */ min(n4) FROM t WHERE n4 > 42

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t t_pk) */ max(id) FROM t

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t t_pk) */ min(id), max(id) FROM t

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

REM
REM Cleanup
REM

DROP TABLE t PURGE;
