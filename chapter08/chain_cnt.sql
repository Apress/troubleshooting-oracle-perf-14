SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: chain_cnt.sql
REM Author......: Christian Antognini
REM Date........: May 2014
REM Description.: This script shows that even though the query optimizre uses
REM               information about chained rows (CHAIN_CNT), the dbms_stats
REM               package does not gather it.
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

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t PURGE;

CREATE TABLE t
AS
SELECT rownum AS id, rpad('*',1000,'*') AS pad1, cast(NULL AS VARCHAR2(1000)) AS pad2
FROM dual
CONNECT BY level <= 1000;

UPDATE t SET pad2 = rpad('*',1000,'*');

COMMIT;

ALTER TABLE t ADD CONSTRAINT t_pk PRIMARY KEY (id);

REM
REM dbms_stats sets CHAIN_CNT to 0
REM

execute dbms_stats.gather_table_stats(user, 't')

SELECT chain_cnt
FROM user_tab_statistics
WHERE table_name = 'T';

PAUSE

EXPLAIN PLAN FOR SELECT /*+ index(t) */ * FROM t WHERE id BETWEEN 100 AND 200;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM ANALZE gathers CHAIN_CNT
REM

ANALYZE TABLE t COMPUTE STATISTICS;

SELECT chain_cnt
FROM user_tab_statistics
WHERE table_name = 'T';

PAUSE

EXPLAIN PLAN FOR SELECT /*+ index(t) */ * FROM t WHERE id BETWEEN 100 AND 200;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM dbms_stats does not overwrites CHAIN_CNT
REM

execute dbms_stats.gather_table_stats(user, 't')

SELECT chain_cnt
FROM user_tab_statistics
WHERE table_name = 'T';

PAUSE

execute dbms_stats.delete_table_stats(user, 't')
execute dbms_stats.gather_table_stats(user, 't')

SELECT chain_cnt
FROM user_tab_statistics
WHERE table_name = 'T';

PAUSE

REM
REM Cleanup
REM

DROP TABLE t PURGE;
