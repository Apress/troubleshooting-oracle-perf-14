SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: index_only_scan.sql
REM Author......: Christian Antognini
REM Date........: October 2013
REM Description.: This script shows several queries taking advantage of 
REM               index-only scans.
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

CREATE INDEX i_c1 ON t (c1);
CREATE INDEX i_c1n1 ON t (c1,n1);
CREATE BITMAP INDEX i_c2 ON t (c2);
CREATE BITMAP INDEX i_c2n2 ON t (c2,n2);

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

SELECT /*+ index(t i_c1) */ c1 FROM t WHERE c1 LIKE 'A%'

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t i_c1) */ n1 FROM t WHERE c1 LIKE 'A%'

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t i_c1n1) */ n1 FROM t WHERE c1 LIKE 'A%'

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

REM
REM Bitmap indexes
REM

SELECT /*+ index(t i_c2) */ c2 FROM t WHERE c2 LIKE 'A%'

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t i_c2) */ n2 FROM t WHERE c2 LIKE 'A%'

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ index(t i_c2n2) */ n2 FROM t WHERE c2 LIKE 'A%'

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
