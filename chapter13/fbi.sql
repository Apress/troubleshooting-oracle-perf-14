SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: fbi.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows an example of function-based index.
REM Notes.......: -
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 10.06.2009 To avoid index joins set _index_join_enabled to FALSE
REM 30.10.2013 Added/modified SQL statements to show misestimates
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

DROP TABLE t;

CREATE TABLE t (
  id NUMBER,
  c1 VARCHAR2(20),
  CONSTRAINT t_pk PRIMARY KEY (id)
);

INSERT INTO t 
SELECT rownum, chr(65+mod(rownum-1,26))
FROM dual
CONNECT BY level <= 104;

INSERT INTO t 
SELECT rownum+104, rpad('*',20,'*')
FROM dual
CONNECT BY level <= 10000-104;

UPDATE t SET c1 = 'SELDON' WHERE c1 = 'S';

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

ALTER SESSION SET "_index_join_enabled" = FALSE;

ALTER SESSION SET statistics_level = all;

PAUSE

REM
REM "Regular" index
REM

CREATE INDEX i_c1 ON t (c1);

PAUSE

SELECT * FROM t WHERE upper(c1) = 'SELDON'

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats rows'));

PAUSE

REM notice that also the cardinality estimation is wrong (it should be 4)

SELECT * FROM t WHERE c1 = 'SELDON'

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats rows'));

PAUSE

REM
REM "Regular" index with constraint
REM

ALTER TABLE t MODIFY (c1 NOT NULL);

ALTER TABLE t ADD CONSTRAINT t_c1_upper CHECK (c1 = upper(c1));

PAUSE

REM only the estimates of the INDEX RANGE SCAN are accurate

SELECT * FROM t WHERE upper(c1) = 'SELDON'

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats rows'));

PAUSE

ALTER TABLE t DROP CONSTRAINT t_c1_upper;

PAUSE

REM
REM Function-based index
REM

CREATE INDEX i_c1_upper ON t (upper(c1));

PAUSE

SELECT * FROM t WHERE upper(c1) = 'SELDON'

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats rows'));

PAUSE

REM gather statistics on the new column to fix the cardinality estimates

BEGIN
  dbms_stats.gather_table_stats(
    ownname          => user,
    tabname          => 'T',
    estimate_percent => 100,
    method_opt       => 'for all columns size skewonly',
    cascade          => TRUE,
    no_invalidate    => FALSE
  );
END;
/

PAUSE

SELECT * FROM t WHERE upper(c1) = 'SELDON'

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats rows'));

PAUSE

REM the estimates are accurate also when the FBI is not used

SELECT /*+ full(t) */ * FROM t WHERE upper(c1) = 'SELDON'

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats rows'));

PAUSE

DROP INDEX i_c1_upper;

PAUSE

REM
REM Bitmap function-based index
REM

CREATE BITMAP INDEX i_c1_upper ON t (upper(c1));

PAUSE

SELECT * FROM t WHERE upper(c1) = 'SELDON'

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats rows'));

PAUSE

REM gather statistics on the new column

BEGIN
  dbms_stats.gather_table_stats(
    ownname          => user,
    tabname          => 'T',
    estimate_percent => 100,
    method_opt       => 'for all columns size skewonly',
    cascade          => TRUE,
    no_invalidate    => FALSE
  );
END;
/

PAUSE

SELECT * FROM t WHERE upper(c1) = 'SELDON'

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats rows'));

PAUSE

DROP INDEX i_c1_upper;

PAUSE

REM
REM The following SQL statements works as of Oracle Database 11g only
REM

PAUSE

REM
REM Index based on a virtual column
REM

ALTER TABLE t ADD (c1_upper AS (upper(c1)));

CREATE INDEX i_c1_upper ON t (c1_upper);

PAUSE

SELECT * FROM t WHERE c1_upper = 'SELDON'

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats rows'));

PAUSE

REM gather statistics on the new column to fix the cardinality estimates

BEGIN
  dbms_stats.gather_table_stats(
    ownname          => user,
    tabname          => 'T',
    estimate_percent => 100,
    method_opt       => 'for all columns size skewonly',
    cascade          => TRUE,
    no_invalidate    => FALSE
  );
END;
/

PAUSE

SELECT * FROM t WHERE c1_upper = 'SELDON'

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats rows'));

PAUSE

DROP INDEX i_c1_upper;

ALTER TABLE t DROP COLUMN c1_upper;

PAUSE

REM
REM Bitmap index based on a virtual column
REM

ALTER TABLE t ADD (c1_upper AS (upper(c1)));

CREATE BITMAP INDEX i_c1_upper ON t (c1_upper);

PAUSE

SELECT * FROM t WHERE c1_upper = 'SELDON'

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats rows'));

PAUSE

REM gather statistics on the new column to fix the cardinality estimates

BEGIN
  dbms_stats.gather_table_stats(
    ownname          => user,
    tabname          => 'T',
    estimate_percent => 100,
    method_opt       => 'for all columns size skewonly',
    cascade          => TRUE,
    no_invalidate    => FALSE
  );
END;
/

PAUSE

SELECT * FROM t WHERE c1_upper = 'SELDON'

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats rows'));

PAUSE

DROP INDEX i_c1_upper;

PAUSE

REM
REM Cleanup
REM

DROP TABLE t;
PURGE TABLE t;
