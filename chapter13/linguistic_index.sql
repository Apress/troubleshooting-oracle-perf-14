SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: linguistic_index.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows an example of a linguistic index.
REM Notes.......: Oracle Database 10g Release 2 or newer is required.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 24.02.2014 Added examples with ORDER BY optimization
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t PURGE;

CREATE TABLE t (c1 VARCHAR2(20), pad VARCHAR2(4000)); 

INSERT INTO t (c1) VALUES ('Leon');
INSERT INTO t (c1) VALUES ('L'||chr(233)||'on');
INSERT INTO t (c1) VALUES ('LEON');
INSERT INTO t (c1) VALUES ('L'||chr(201)||'ON');
COMMIT;

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

PAUSE

REM
REM Run function test
REM

SELECT c1 FROM t;

PAUSE

ALTER SESSION SET nls_sort = generic_m;
ALTER SESSION SET nls_comp = binary;
SELECT c1 FROM t WHERE c1 = 'LEON';

PAUSE

ALTER SESSION SET nls_sort = generic_m;
ALTER SESSION SET nls_comp = linguistic;
SELECT c1 FROM t WHERE c1 = 'LEON';

PAUSE

ALTER SESSION SET nls_sort = generic_m_ci;
ALTER SESSION SET nls_comp = linguistic;
SELECT c1 FROM t WHERE c1 = 'LEON';

PAUSE

ALTER SESSION SET nls_sort = generic_m_ai;
ALTER SESSION SET nls_comp = linguistic;
SELECT c1 FROM t WHERE c1 = 'LEON';

PAUSE

REM
REM Check execution plan
REM

SET AUTOTRACE TRACEONLY EXPLAIN

REM Regular index

CREATE INDEX i_c1 ON t (c1);
ALTER SESSION SET nls_sort = generic_m_ai;

ALTER SESSION SET nls_comp = binary;
SELECT /*+ index(t) */ * FROM t WHERE c1 = 'LEON';

PAUSE

ALTER SESSION SET nls_comp = linguistic;
SELECT /*+ index(t) */ * FROM t WHERE c1 = 'LEON';

PAUSE

REM Linguistic index
REM (index range scan is supported as of Oracle Database 11g only)

CREATE INDEX i_c1_linguistic ON t (nlssort(c1,'nls_sort=generic_m_ai'));
SELECT /*+ index(t) */ * FROM t WHERE c1 = 'LEON';
SELECT /*+ index(t) */ * FROM t WHERE c1 LIKE 'LE%';

PAUSE

DROP INDEX i_c1_linguistic;

REM Bitmap linguistic index
REM (index range scan is supported as of Oracle Database 11g only)

CREATE BITMAP INDEX i_c1_linguistic ON t (nlssort(c1,'nls_sort=generic_m_ai'));
SELECT /*+ index(t) */ * FROM t WHERE c1 = 'LEON';
SELECT /*+ index(t) */ * FROM t WHERE c1 LIKE 'LE%';

PAUSE

REM
REM ORDER BY
REM

DROP INDEX i_c1_linguistic;
CREATE INDEX i_c1_linguistic ON t (nlssort(c1,'nls_sort=generic_m_ai'));

PAUSE

ALTER SESSION SET nls_sort = binary;
ALTER SESSION SET nls_comp = binary;

SELECT /*+ index(t) */ * FROM t WHERE c1 BETWEEN 'L' AND 'M' ORDER BY c1;

PAUSE

ALTER SESSION SET nls_sort = generic_m_ai;

SELECT /*+ index(t) */ * FROM t WHERE c1 BETWEEN 'L' AND 'M' ORDER BY c1;

PAUSE

ALTER SESSION SET nls_comp = linguistic;

SELECT /*+ index(t) */ * FROM t WHERE c1 BETWEEN 'L' AND 'M' ORDER BY c1;

PAUSE

REM
REM Cleanup
REM

SET AUTOTRACE OFF

DROP TABLE t PURGE;
