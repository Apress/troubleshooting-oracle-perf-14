SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: iot_guess.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows the impact of stale guesses on logical reads.
REM Notes.......: -
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 14.10.2013 Replaced AUTOTRACE with dbms_xplan.display_cursor
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

CREATE TABLE t (
  id,
  n,
  pad,
  CONSTRAINT t_pk PRIMARY KEY (id)
)
ORGANIZATION INDEX
AS
SELECT rownum, rownum, rpad('*',1000,'*')
FROM dual
CONNECT BY level <= 1000;

CREATE INDEX i ON t (n);

execute dbms_stats.gather_table_stats(ownname=>user, tabname=>'t', cascade=>TRUE);

ALTER SESSION SET statistics_level = ALL;

PAUSE

REM
REM All guess are correct
REM

SELECT index_name, blevel, leaf_blocks, distinct_keys, pct_direct_access 
FROM user_indexes 
WHERE table_name = 'T';

PAUSE

SELECT /*+ index(t i) */ count(pad) FROM t WHERE n > 0

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

REM
REM About 25% of the guess are wrong
REM

UPDATE t SET id = -id WHERE rownum <= 250;
COMMIT;

execute dbms_stats.gather_table_stats(ownname=>user, tabname=>'t', cascade=>TRUE);

SELECT index_name, blevel, leaf_blocks, distinct_keys, pct_direct_access 
FROM user_indexes 
WHERE table_name = 'T';

PAUSE

SELECT /*+ index(t i) */ count(pad) FROM t WHERE n > 0

SET TERMOUT OFF
/
SET TERMOUT ON

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

REM
REM Recompute guesses
REM

ALTER INDEX i UPDATE BLOCK REFERENCES;
REM ALTER INDEX i REBUILD;

execute dbms_stats.gather_index_stats(ownname=>user, indname=>'i')

SELECT index_name, blevel, leaf_blocks, distinct_keys, pct_direct_access 
FROM user_indexes 
WHERE table_name = 'T';

PAUSE

SELECT /*+ index(t i) */ count(pad) FROM t WHERE n > 0

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
