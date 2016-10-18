SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: statistics_history_alter_index.sql
REM Author......: Christian Antognini
REM Date........: May 2011
REM Description.: Up to 11.1 a rebuild does not save old statistics in 
REM               the history.
REM Notes.......: This script works as of Oracle Database 11g only.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 
REM ***************************************************************************

SET ECHO ON TERMOUT ON SERVEROUTPUT OFF FEEDBACK OFF PAGESIZE 100 LINESIZE 80

CLEAR SCREEN

REM
REM Setup environment
REM

VARIABLE t varchar2(20)

DROP TABLE t PURGE;

CREATE TABLE t as SELECT rownum AS id FROM dual CONNECT BY level <= 1000;

CREATE INDEX i ON t (id);

INSERT INTO t SELECT rownum AS id FROM dual CONNECT BY level <= 1000;

COMMIT;

PAUSE

REM
REM Show whether ALTER INDEX puts object statistics in the history
REM

execute SELECT to_char(systimestamp,'dd.mm.yyyy hh24:mi:ss') INTO :t FROM dual;

SELECT num_rows 
FROM user_indexes 
where index_name = 'I';

ALTER INDEX I REBUILD;

SELECT num_rows 
FROM user_indexes 
WHERE index_name = 'I';

execute dbms_stats.restore_table_stats(user,'t',to_date(:t,'dd.mm.yyyy hh24:mi:ss'))

SELECT num_rows 
FROM user_indexes 
WHERE index_name = 'I';

PAUSE

REM
REM Cleanup environment
REM

DROP TABLE t PURGE;
