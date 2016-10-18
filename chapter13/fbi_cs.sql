SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: fbi_cs.sql
REM Author......: Christian Antognini
REM Date........: Februar 2014
REM Description.: This script shows that a function-based index based on a
REM               function that takes literals as parameter might not be
REM               selected for an index range scan when the CURSOR_SHARING
REM               initialization parameter is set to either FORCE or
REM               SIMILAR.
REM Notes.......: The behavior depends on the Oracle Database version and on
REM               the function. In fact, while the query with the SUBSTR
REM               function uses an execution plan with an index full scan in all
REM               versions, the query with the WIDTH_BUCKET uses an index range
REM               scan up to and including 11.2.0.3 and an index full scan as of
REM               11.2.0.4.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 23.10.2014 Added notes and comments to provide information about the
REM            expected behavior.
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

@../connect.sql

COLUMN v FORMAT A10 TRUNC

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t PURGE;

CREATE TABLE t (
  id NUMBER,
  n NUMBER,
  v VARCHAR2(1000),
  CONSTRAINT t_pk PRIMARY KEY (id)
);

INSERT INTO t 
SELECT rownum, mod(rownum,1000), rpad('*',255,'*') AS pad
FROM dual
CONNECT BY level <= 1E4;

CREATE INDEX i_n_bucket ON t (width_bucket(n, 0, 1000, 100));
CREATE INDEX i_v_substr ON t (substr(v, 1, 10));

SELECT column_name, hidden_column, virtual_column
FROM user_tab_cols
WHERE table_name = 'T'
ORDER BY column_id;

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
REM EXACT
REM

ALTER SESSION SET cursor_sharing = EXACT;

REM for both queries an INDEX RANGE SCAN should be used

PAUSE

SELECT /*EXACT*/ /*+ index(t) */ * FROM t WHERE width_bucket(n, 0, 1000, 100) = -1;

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'basic predicate'));

PAUSE

SELECT /*EXACT*/ /*+ index(t) */ * FROM t WHERE substr(v, 1, 10) = 'ABCDEDFGHI';

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'basic predicate'));

PAUSE

REM
REM FORCE
REM

ALTER SESSION SET cursor_sharing = FORCE;

REM depending on the version either both or only the first query uses
REM an INDEX RANGE SCAN; in case an INDEX FULL SCAN is used, the predicate
REM section shows no rewrite (i.e. no SYS_NC column is referenced)

PAUSE

SELECT /*FORCE*/ /*+ index(t) */ * FROM t WHERE width_bucket(n, 0, 1000, 100) = -1;

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'basic predicate'));

PAUSE

SELECT /*FORCE*/ /*+ index(t) */ * FROM t WHERE substr(v, 1, 10) = 'ABCDEDFGHI';

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'basic predicate'));

PAUSE

REM
REM SIMILAR
REM

ALTER SESSION SET cursor_sharing = SIMILAR;

REM depending on the version either both or only the first query uses
REM an INDEX RANGE SCAN; in case an INDEX FULL SCAN is used, the predicate
REM section shows no rewrite (i.e. no SYS_NC column is referenced)

PAUSE

SELECT /*SIMILAR*/ /*+ index(t) */ * FROM t WHERE width_bucket(n, 0, 1000, 100) = -1;

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'basic predicate'));

PAUSE

SELECT /*SIMILAR*/ /*+ index(t) */ * FROM t WHERE substr(v, 1, 10) = 'ABCDEDFGHI';

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'basic predicate'));

PAUSE

REM
REM Cleanup
REM

DROP TABLE t PURGE;
