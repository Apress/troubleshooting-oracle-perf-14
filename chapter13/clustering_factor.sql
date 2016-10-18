SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: clustering_factor.sql
REM Author......: Christian Antognini
REM Date........: September 2013
REM Description.: This script shows:
REM               * the impact of the clustering factor on logical I/Os
REM               * how the clustering factor is computed
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
SET FEEDBACK ON
SET VERIFY OFF
SET SCAN ON

COLUMN pad FORMAT A10 TRUNCATE
COLUMN index_name FORMAT A10

@../connect.sql

ALTER SESSION SET statistics_level = all;

DROP TABLE t CASCADE CONSTRAINTS PURGE;

SET ECHO ON

REM
REM Setup test environment
REM

CREATE TABLE t (
  id NUMBER,
  val NUMBER,
  pad VARCHAR2(4000),
  CONSTRAINT t_pk PRIMARY KEY (id)
);

execute dbms_random.seed(0)

INSERT INTO t
SELECT rownum, dbms_random.value, dbms_random.string('p',500)
FROM dual
CONNECT BY level <= 1000;

COMMIT;

CREATE INDEX t_val_i ON t (val);

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

SELECT blocks, num_rows 
FROM user_tables 
WHERE table_name = 'T';

SELECT blevel, leaf_blocks, clustering_factor 
FROM user_indexes 
WHERE index_name = 'T_PK';

PAUSE

REM
REM Test with optimal clustering factor
REM

set arraysize 2

PAUSE

SELECT /*+ index(t t_pk) */ * FROM t

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'allstats last'));

PAUSE

set arraysize 100

PAUSE

SELECT /*+ index(t t_pk) */ * FROM t

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'allstats last'));

PAUSE

REM
REM Reload data
REM

TRUNCATE TABLE t;

execute dbms_random.seed(0)

INSERT INTO t
SELECT rownum, dbms_random.value, dbms_random.string('p',500)
FROM dual
CONNECT BY level <= 1000
ORDER BY dbms_random.value;

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

SELECT blocks, num_rows 
FROM user_tables 
WHERE table_name = 'T';

SELECT blevel, leaf_blocks, clustering_factor 
FROM user_indexes 
WHERE index_name = 'T_PK';

PAUSE

REM
REM Test with poor clustering factor
REM

set arraysize 2

PAUSE

SELECT /*+ index(t t_pk) */ * FROM t

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'allstats last'));

PAUSE

set arraysize 100

PAUSE

SELECT /*+ index(t t_pk) */ * FROM t

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'allstats last'));

PAUSE

REM
REM How is the clustering factor computed?
REM

CREATE OR REPLACE FUNCTION clustering_factor (
  p_owner IN VARCHAR2, 
  p_table_name IN VARCHAR2,
  p_column_name IN VARCHAR2
) RETURN NUMBER IS
  l_cursor             SYS_REFCURSOR;
  l_clustering_factor  BINARY_INTEGER := 0;
  l_block_nr           BINARY_INTEGER := 0;
  l_previous_block_nr  BINARY_INTEGER := 0;
  l_file_nr            BINARY_INTEGER := 0;
  l_previous_file_nr   BINARY_INTEGER := 0;
BEGIN
  OPEN l_cursor FOR 
    'SELECT dbms_rowid.rowid_block_number(rowid) block_nr, '||
    '       dbms_rowid.rowid_to_absolute_fno(rowid, '''||
                                             p_owner||''','''||
                                             p_table_name||''') file_nr '||
    'FROM '||p_owner||'.'||p_table_name||' '||
    'WHERE '||p_column_name||' IS NOT NULL '||
    'ORDER BY ' || p_column_name ||', rowid';
  LOOP
    FETCH l_cursor INTO l_block_nr, l_file_nr;
    EXIT WHEN l_cursor%NOTFOUND;
    IF (l_previous_block_nr <> l_block_nr OR l_previous_file_nr <> l_file_nr)
    THEN
      l_clustering_factor := l_clustering_factor + 1;
    END IF;
    l_previous_block_nr := l_block_nr;
    l_previous_file_nr := l_file_nr;
  END LOOP;
  CLOSE l_cursor;
  RETURN l_clustering_factor;
END;
/

PAUSE

SELECT i.index_name, i.clustering_factor,
       clustering_factor(user, i.table_name, ic.column_name) AS my_clus_fact
FROM user_indexes i, user_ind_columns ic
WHERE i.table_name = 'T'
AND i.index_name = ic.index_name
ORDER BY i.index_name;

PAUSE

REM
REM Cleanup
REM

DROP TABLE t CASCADE CONSTRAINTS PURGE;
