SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: depts_wo_emps.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script was used to generate the execution plans used as
REM               examples in the section "Altering the SQL Statement."
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

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE dept;

CREATE TABLE dept
       (deptno NUMBER(2),
        dname VARCHAR2(14),
        loc VARCHAR2(13) );

ALTER TABLE dept ADD CONSTRAINT dept_pk PRIMARY KEY (deptno);

INSERT INTO dept VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO dept VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO dept VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO dept VALUES (40, 'OPERATIONS', 'BOSTON');

execute dbms_stats.gather_table_stats(user, 'dept')

DROP TABLE emp;

CREATE TABLE emp
       (empno NUMBER(4) NOT NULL,
        ename VARCHAR2(10),
        job VARCHAR2(9),
        mgr NUMBER(4),
        hiredate DATE,
        sal NUMBER(7, 2),
        comm NUMBER(7, 2),
        deptno NUMBER(2));

ALTER TABLE emp ADD CONSTRAINT emp_pk PRIMARY KEY (empno);
ALTER TABLE emp ADD CONSTRAINT emp_dept_pk FOREIGN KEY (deptno) REFERENCING DEPT (deptno);

INSERT INTO emp VALUES
        (7369, 'SMITH',  'CLERK',     7902,
        to_date('17-DEC-1980', 'DD-MON-YYYY'),  800, NULL, 20);
INSERT INTO emp VALUES
        (7499, 'ALLEN',  'SALESMAN',  7698,
        to_date('20-FEB-1981', 'DD-MON-YYYY'), 1600,  300, 30);
INSERT INTO emp VALUES
        (7521, 'WARD',   'SALESMAN',  7698,
        to_date('22-FEB-1981', 'DD-MON-YYYY'), 1250,  500, 30);
INSERT INTO emp VALUES
        (7566, 'JONES',  'MANAGER',   7839,
        to_date('2-APR-1981', 'DD-MON-YYYY'),  2975, NULL, 20);
INSERT INTO emp VALUES
        (7654, 'MARTIN', 'SALESMAN',  7698,
        to_date('28-SEP-1981', 'DD-MON-YYYY'), 1250, 1400, 30);
INSERT INTO emp VALUES
        (7698, 'BLAKE',  'MANAGER',   7839,
        to_date('1-MAY-1981', 'DD-MON-YYYY'),  2850, NULL, 30);
INSERT INTO emp VALUES
        (7782, 'CLARK',  'MANAGER',   7839,
        to_date('9-JUN-1981', 'DD-MON-YYYY'),  2450, NULL, 10);
INSERT INTO emp VALUES
        (7788, 'SCOTT',  'ANALYST',   7566,
        to_date('09-DEC-1982', 'DD-MON-YYYY'), 3000, NULL, 20);
INSERT INTO emp VALUES
        (7839, 'KING',   'PRESIDENT', NULL,
        to_date('17-NOV-1981', 'DD-MON-YYYY'), 5000, NULL, 10);
INSERT INTO emp VALUES
        (7844, 'TURNER', 'SALESMAN',  7698,
        to_date('8-SEP-1981', 'DD-MON-YYYY'),  1500,    0, 30);
INSERT INTO emp VALUES
        (7876, 'ADAMS',  'CLERK',     7788,
        to_date('12-JAN-1983', 'DD-MON-YYYY'), 1100, NULL, 20);
INSERT INTO emp VALUES
        (7900, 'JAMES',  'CLERK',     7698,
        to_date('3-DEC-1981', 'DD-MON-YYYY'),   950, NULL, 30);
INSERT INTO emp VALUES
        (7902, 'FORD',   'ANALYST',   7566,
        to_date('3-DEC-1981', 'DD-MON-YYYY'),  3000, NULL, 20);
INSERT INTO emp VALUES
        (7934, 'MILLER', 'CLERK',     7782,
        to_date('23-JAN-1982', 'DD-MON-YYYY'), 1300, NULL, 10);

execute dbms_stats.gather_table_stats(user, 'emp')

PAUSE

REM
REM The test queries...
REM

EXPLAIN PLAN FOR
SELECT deptno
FROM dept
WHERE deptno NOT IN (SELECT deptno FROM emp);

SELECT * FROM table(dbms_xplan.display);

PAUSE

EXPLAIN PLAN FOR
SELECT deptno
FROM dept
WHERE NOT EXISTS (SELECT 1 FROM emp WHERE emp.deptno = dept.deptno);

SELECT * FROM table(dbms_xplan.display);

PAUSE

EXPLAIN PLAN FOR
SELECT deptno FROM dept
MINUS
SELECT deptno FROM emp;

SELECT * FROM table(dbms_xplan.display);

PAUSE

EXPLAIN PLAN FOR
SELECT dept.deptno
FROM dept, emp
WHERE dept.deptno = emp.deptno(+) AND emp.deptno IS NULL;

SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM Cleanup
REM

DROP TABLE emp;
PURGE TABLE emp;

DROP TABLE dept;
PURGE TABLE dept;
