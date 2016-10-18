SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: related-combine.sql 
REM Author......: Christian Antognini
REM Date........: February 2014
REM Description.: This script shows examples of related-combine operations.
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
SET SERVEROUTPUT OFF

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE bonus PURGE;
DROP TABLE emp PURGE;
DROP TABLE dept PURGE;

CREATE TABLE dept
       (deptno NUMBER(2),
        dname VARCHAR2(14),
        loc VARCHAR2(13) );

INSERT INTO dept VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO dept VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO dept VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO dept VALUES (40, 'OPERATIONS', 'BOSTON');

ALTER TABLE dept ADD CONSTRAINT dept_pk PRIMARY KEY (deptno);

execute dbms_stats.gather_table_stats(user, 'dept')

CREATE TABLE emp
       (empno NUMBER(4) NOT NULL,
        ename VARCHAR2(10),
        job VARCHAR2(9),
        mgr NUMBER(4),
        hiredate DATE,
        sal NUMBER(7, 2),
        comm NUMBER(7, 2),
        deptno NUMBER(2));

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

ALTER TABLE emp ADD CONSTRAINT emp_pk PRIMARY KEY (empno);
ALTER TABLE emp ADD CONSTRAINT emp_dept_pk FOREIGN KEY (deptno) REFERENCING DEPT (deptno);

CREATE INDEX emp_job_i ON emp (job);
CREATE INDEX emp_mgr_i ON emp (mgr);

execute dbms_stats.gather_table_stats(user, 'emp')

CREATE TABLE bonus
        (ename VARCHAR2(10),
         job   VARCHAR2(9),
         sal   NUMBER,
         comm  NUMBER);

execute dbms_stats.gather_table_stats(user, 'bonus')

ALTER SESSION SET statistics_level = all;

PAUSE

REM
REM Operation NESTED LOOPS
REM

SELECT /*+ ordered use_nl(dept) index(dept) optimizer_features_enable('10.2.0.5') */ *
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.comm IS NULL
AND dept.dname != 'SALES';

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

REM
REM Operation FILTER
REM

SELECT *
FROM emp
WHERE NOT EXISTS (SELECT /*+ no_unnest */ 0 
                  FROM dept 
                  WHERE dept.dname = 'SALES' AND dept.deptno = emp.deptno)
AND NOT EXISTS (SELECT /*+ no_unnest */ 0 
                FROM bonus 
                WHERE bonus.ename = emp.ename);

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

REM With EXPLAIN PLAN to have the correct predicate information

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE NOT EXISTS (SELECT /*+ no_unnest */ 0 
                  FROM dept 
                  WHERE dept.dname = 'SALES' AND dept.deptno = emp.deptno)
AND NOT EXISTS (SELECT /*+ no_unnest */ 0 
                FROM bonus 
                WHERE bonus.ename = emp.ename);

SELECT * FROM table(dbms_xplan.display);

PAUSE

SELECT dname, count(*)
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY dname;

REM
REM Operation UPDATE
REM

UPDATE emp e1
SET sal = (SELECT avg(sal) FROM emp e2 WHERE e2.deptno = e1.deptno),
    comm = (SELECT avg(comm) FROM emp e3);

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

ROLLBACK;

PAUSE

REM
REM Operation CONNECT BY WITH FILTERING
REM

COLUMN ename FORMAT A10
COLUMN manager FORMAT A10

SELECT /*+ connect_by_filtering */ level, rpad('-',level-1,'-')||ename AS ename, prior ename AS manager
FROM emp
START WITH mgr IS NULL
CONNECT BY PRIOR empno = mgr;

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

SELECT /*+ connect_by_filtering full(emp) */ level, emp.*
FROM emp
START WITH mgr = 7839
CONNECT BY PRIOR empno = mgr;

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

REM
REM UNION ALL (RECURSIVE WITH)
REM

WITH
  e (xlevel, empno, ename, job, mgr, hiredate, sal, comm, deptno)
  AS (
    SELECT 1, empno, ename, job, mgr, hiredate, sal, comm, deptno
    FROM emp
    WHERE mgr IS NULL
    UNION ALL
    SELECT mgr.xlevel+1, emp.empno, emp.ename, emp.job, emp.mgr, emp.hiredate, emp.sal, emp.comm, emp.deptno
    FROM emp, e mgr
    WHERE emp.mgr = mgr.empno
  )
SELECT *
FROM e;

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

REM
REM Cleanup
REM

DROP TABLE bonus PURGE;
DROP TABLE emp PURGE;
DROP TABLE dept PURGE;
