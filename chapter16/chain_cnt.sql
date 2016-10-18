SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: chain_cnt.sql
REM Author......: Christian Antognini
REM Date........: November 2013
REM Description.: This script shows that the dbms_xplan package neither gathers
REM               nor overwrites the number of chained/migrated rows (chain_cnt).
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

@../connect.sql

SET SERVEROUTPUT ON
SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t PURGE;

CREATE TABLE t 
PCTFREE 0
AS 
SELECT rownum AS id, cast(rpad('*',500,'*') AS varchar2(1000)) AS pad 
FROM dual 
CONNECT BY LEVEL <= 1000;

REM migrate ten rows

UPDATE t SET pad = rpad('*',1000,'*') WHERE mod(id,100) = 1;

COMMIT;

PAUSE

REM
REM dbms_stats sets the value to "0" (wrong value)
REM

exec dbms_stats.gather_table_stats(user, 't')

PAUSE

SELECT num_rows, chain_cnt 
FROM user_tab_statistics 
WHERE table_name = 'T';

PAUSE

REM
REM ANALYZE TABLE sets the value to "10" (correct value)
REM

ANALYZE TABLE t COMPUTE STATISTICS;

PAUSE

SELECT num_rows, chain_cnt 
FROM user_tab_statistics 
WHERE table_name = 'T';

PAUSE

REM
REM dbms_stats does not overwrite an existing value
REM

INSERT INTO t SELECT * FROM t;

DELETE t WHERE mod(id,100) = 1;

COMMIT;

PAUSE

exec dbms_stats.gather_table_stats(user, 't')

PAUSE

SELECT num_rows, chain_cnt 
FROM user_tab_statistics 
WHERE table_name = 'T';

PAUSE

ANALYZE TABLE t COMPUTE STATISTICS;

PAUSE

SELECT num_rows, chain_cnt 
FROM user_tab_statistics 
WHERE table_name = 'T';

PAUSE

REM
REM Cleanup
REM

DROP TABLE t PURGE;
