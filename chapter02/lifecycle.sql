SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: lifecycle.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows the difference between implicit and
REM               explicit cursor management.
REM Notes.......: -
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 12.12.2011 Changed INSERT statement to avoid ORA-01843
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

DROP TABLE emp;

CREATE TABLE emp (
  empno NUMBER(4) NOT NULL,
  ename VARCHAR2(10),
  job VARCHAR2(9),
  mgr NUMBER(4),
  hiredate DATE,
  sal NUMBER(7, 2),
  comm NUMBER(7, 2),
  deptno NUMBER(2)
);

INSERT INTO emp 
VALUES (7788, 'SCOTT', 'ANALYST', 7566, to_date('09-12-1982', 'DD-MM-YYYY'), 3000, NULL, 20);
COMMIT;

PAUSE

REM
REM Implicit cursor management
REM

DECLARE
  l_ename emp.ename%TYPE := 'SCOTT';
  l_empno emp.empno%TYPE;
BEGIN
  SELECT empno INTO l_empno
  FROM emp
  WHERE ename = l_ename;
  dbms_output.put_line(l_empno);
END;
/

PAUSE

REM
REM Explicit cursor management
REM

DECLARE
  l_ename emp.ename%TYPE := 'SCOTT';
  l_empno emp.empno%TYPE;
  l_cursor INTEGER;
  l_retval INTEGER;
BEGIN
  l_cursor := dbms_sql.open_cursor;
  dbms_sql.parse(l_cursor, 'SELECT empno FROM emp WHERE ename = :ename', 1);
  dbms_sql.define_column(l_cursor, 1, l_empno);
  dbms_sql.bind_variable(l_cursor, ':ename', l_ename);
  l_retval := dbms_sql.execute(l_cursor);
  IF dbms_sql.fetch_rows(l_cursor) > 0 
  THEN  
    dbms_sql.column_value(l_cursor, 1, l_empno);
    dbms_output.put_line(l_empno);
  END IF;
  dbms_sql.close_cursor(l_cursor);
END;
/

PAUSE

REM
REM Cleanup
REM

DROP TABLE emp;
PURGE TABLE emp;
