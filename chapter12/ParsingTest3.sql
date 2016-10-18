SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: ParsingTest3.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This file contains an implementation of test case 3.
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

REM it is not possible to implement test case 3 with static SQL


REM
REM  N A T I V E   D Y N A M I C   S Q L
REM

REM it is not possible to implement test case 3 with native dynamic SQL


REM
REM  P A C K A G E   D B M S _ S Q L
REM

DECLARE
  l_cursor INTEGER;
  l_pad VARCHAR2(4000);
  l_retval INTEGER;
BEGIN
  l_cursor := dbms_sql.open_cursor;
  dbms_sql.parse(l_cursor, 'SELECT pad FROM t WHERE val = :1', 1);
  dbms_sql.define_column(l_cursor, 1, l_pad, 10);
  FOR i IN 1..10000
  LOOP
    dbms_sql.bind_variable(l_cursor, ':1', i);
    l_retval := dbms_sql.execute(l_cursor);
    IF dbms_sql.fetch_rows(l_cursor) > 0 
    THEN  
      NULL;
    END IF;
  END LOOP;
  dbms_sql.close_cursor(l_cursor);
END;
/
