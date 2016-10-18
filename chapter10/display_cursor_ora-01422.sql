SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: display_cursor_ora-01422.sql
REM Author......: Christian Antognini
REM Date........: July 2013
REM Description.: Up to and including 11.2.0.3 this script can be exectued to
REM               reproduce bug 14585499.
REM Notes.......: A large shared pool is required. 
REM               Maximum number of children per parent:
REM               - 10.2.0.1: 1026
REM               - 11.1.0.6: 1026
REM               - 11.1.0.7: 32568
REM               - 11.2.0.2: 65536
REM               - 11.2.0.3: 100 (_cursor_obsolete_threshold)
REM               - 12.1.0.1: 1024 (_cursor_obsolete_threshold)
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 20.02.2014 Added example with plan table containing runtime statistics
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

ALTER SYSTEM FLUSH SHARED_POOL;

DROP TABLE t PURGE;

CREATE TABLE t (n NUMBER);

INSERT INTO t VALUES (1);

COMMIT;

execute dbms_stats.gather_table_stats(user,'t')

PAUSE

REM
REM Parse 100,000 cursors
REM

DECLARE
  l_count PLS_INTEGER;
BEGIN
	FOR oic IN 1..10
  LOOP
    EXECUTE IMMEDIATE 'ALTER SESSION SET optimizer_index_caching = '||oic;
    FOR oica IN 1..10000
    LOOP
      EXECUTE IMMEDIATE 'ALTER SESSION SET optimizer_index_cost_adj = '||oica;
      EXECUTE IMMEDIATE 'SELECT count(*) FROM t' into l_count;
    END LOOP;
  END LOOP;
END;
/

PAUSE

REM
REM How many parent/child cursors exist?
REM

SELECT address, sql_id, version_count
FROM v$sqlarea
WHERE sql_text = 'SELECT count(*) FROM t';

PAUSE

SELECT address, sql_id, count(DISTINCT child_number)
FROM v$sql
WHERE sql_text = 'SELECT count(*) FROM t'
GROUP BY address, sql_id;

PAUSE

REM
REM Raise ORA-01422
REM

SELECT * 
FROM table(dbms_xplan.display_cursor('5tjqf7sx5dzmj',0))
WHERE rownum <= 20;

PAUSE

REM
REM Clean up
REM

DROP TABLE t PURGE;
