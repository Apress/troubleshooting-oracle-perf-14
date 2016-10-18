SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: column_order.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows that the position of a column in a row
REM               determines the amount of processing needed to access it.
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

DROP TABLE t;

DECLARE
  l_sql VARCHAR2(32767);
BEGIN
  l_sql := 'CREATE TABLE t (';
  FOR i IN 1..250 
  LOOP
    l_sql := l_sql || 'n' || i || ' NUMBER,';
  END LOOP;
  l_sql := l_sql || 'pad VARCHAR2(1000)) PCTFREE 10';
  EXECUTE IMMEDIATE l_sql;
END;
/

DECLARE
  l_sql VARCHAR2(32767);
BEGIN
  l_sql := 'INSERT INTO t SELECT ';
  FOR i IN 1..250 
  LOOP
    l_sql := l_sql || '0,';
  END LOOP;
  l_sql := l_sql || 'NULL FROM dual CONNECT BY level <= 10000';
  EXECUTE IMMEDIATE l_sql;
  COMMIT;
END;
/

execute dbms_stats.gather_table_stats(ownname=>user, tabname=>'t')

SELECT num_rows, blocks FROM user_tables WHERE table_name = 'T';

PAUSE

REM
REM Run test
REM

DECLARE
  l_dummy PLS_INTEGER;
  l_start PLS_INTEGER;
  l_stop PLS_INTEGER;
  l_sql VARCHAR2(100);
BEGIN
  l_start := dbms_utility.get_time;
  FOR j IN 1..1000
  LOOP
    EXECUTE IMMEDIATE 'SELECT count(*) FROM t' INTO l_dummy;
  END LOOP;
  l_stop := dbms_utility.get_time;
  dbms_output.put_line((l_stop-l_start)/100);

  FOR i IN 1..250
  LOOP
    l_sql := 'SELECT count(n' || i || ') FROM t';
    l_start := dbms_utility.get_time;
    FOR j IN 1..1000
    LOOP
      EXECUTE IMMEDIATE l_sql INTO l_dummy;
    END LOOP;
    l_stop := dbms_utility.get_time;
    dbms_output.put_line((l_stop-l_start)/100);
  END LOOP;
END;
/

PAUSE

REM
REM Cleanup
REM

DROP TABLE t;
PURGE TABLE t;
