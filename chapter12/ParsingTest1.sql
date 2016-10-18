SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: ParsingTest1.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This file contains an implementation of test case 1.
REM Notes.......: Run the script ParsingTest.sql to create the required objects.
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

SET ECHO ON

REM
REM  S T A T I C   S Q L
REM

REM it is not possible to implement test case 1 with static SQL

REM
REM  N A T I V E   D Y N A M I C   S Q L
REM

DECLARE
  TYPE t_cursor IS REF CURSOR;
  l_cursor t_cursor;
  l_pad    VARCHAR2(4000);
BEGIN
  FOR i IN 1..10000 
  LOOP
    OPEN l_cursor FOR 'SELECT pad FROM t WHERE val = ' || to_char(i);
    FETCH l_cursor INTO l_pad;
    CLOSE l_cursor;
  END LOOP;
END;
/

REM the following code is a bit different than the others because it fetches all rows

DECLARE
  TYPE t_pad IS TABLE OF VARCHAR2(4000);
  l_pad t_pad;
BEGIN
  FOR i IN 1..10000 
  LOOP
    BEGIN
      EXECUTE IMMEDIATE 'SELECT pad FROM t WHERE val = ' || to_char(i)
      BULK COLLECT INTO l_pad;
    EXCEPTION
      WHEN no_data_found THEN NULL;
    END;
  END LOOP;
END;
/

REM
REM  P A C K A G E   D B M S _ S Q L
REM

DECLARE
  l_cursor INTEGER;
  l_pad    VARCHAR2(4000);
  l_retval INTEGER;
BEGIN
  FOR i IN 1..10000
  LOOP
    l_cursor := dbms_sql.open_cursor;
    dbms_sql.parse(l_cursor, 'SELECT pad FROM t WHERE val = ' || to_char(i), 1);
    dbms_sql.define_column(l_cursor, 1, l_pad, 4000);
    l_retval := dbms_sql.execute(l_cursor);
    IF dbms_sql.fetch_rows(l_cursor) > 0 
    THEN  
      NULL;
    END IF;
    dbms_sql.close_cursor(l_cursor);
  END LOOP;
END;
/
