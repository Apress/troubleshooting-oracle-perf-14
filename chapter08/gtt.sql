SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: gtt.sql
REM Author......: Christian Antognini
REM Date........: June 2014
REM Description.: This script shows that in 12c global temporary tables have
REM               session-level statistics.
REM Notes.......: The script only works in 12c.
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
SET SERVEROUTPUT OFF

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t PURGE;

CREATE GLOBAL TEMPORARY TABLE t (id NUMBER, pad VARCHAR2(1000));

INSERT INTO t SELECT rownum, rpad('*',1000,'*') FROM dual CONNECT BY level <= 1000;

execute dbms_stats.gather_table_stats(ownname => user, tabname => 't')

PAUSE

REM
REM Show session-level statistics
REM

SELECT num_rows, blocks, avg_row_len, scope
FROM user_tab_statistics
WHERE table_name = 'T';

PAUSE

SELECT count(*)
FROM t
WHERE id BETWEEN 10 AND 100;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor);

PAUSE

REM
REM Clean up
REM

DROP TABLE t PURGE;
