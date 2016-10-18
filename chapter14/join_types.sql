SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: join_types.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script provides an example for each type of join.
REM Notes.......: -
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 05.03.2014 Added examples with ANY and SOME
REM 14.03.2014 Added examples with LATERAL, OUTER APPLY and CROSS APPLY
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

DROP TABLE dept CASCADE CONSTRAINT PURGE;

CREATE TABLE dept
       (deptno NUMBER(2),
        dname VARCHAR2(14),
        loc VARCHAR2(13) );

DROP TABLE emp CASCADE CONSTRAINT PURGE;

CREATE TABLE emp
       (empno NUMBER(4) NOT NULL,
        ename VARCHAR2(10),
        job VARCHAR2(9),
        mgr NUMBER(4),
        hiredate DATE,
        sal NUMBER(7, 2),
        comm NUMBER(7, 2),
        deptno NUMBER(2));

DROP TABLE salgrade PURGE;

CREATE TABLE salgrade
        (GRADE NUMBER,
         LOSAL NUMBER,
         HISAL NUMBER);

PAUSE

SET AUTOTRACE TRACEONLY EXPLAIN

REM
REM cross join
REM

SELECT emp.ename, dept.dname
FROM emp, dept;

PAUSE

SELECT emp.ename, dept.dname 
FROM emp CROSS JOIN dept;

PAUSE

REM
REM theta join
REM

SELECT emp.ename, salgrade.grade 
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

PAUSE

SELECT emp.ename, salgrade.grade 
FROM emp JOIN salgrade ON emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

PAUSE

SELECT emp.ename, salgrade.grade 
FROM emp INNER JOIN salgrade ON emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

PAUSE

REM
REM equi join 
REM

SELECT emp.ename, dept.dname 
FROM emp, dept 
WHERE emp.deptno = dept.deptno;

PAUSE

SELECT emp.ename, dept.dname 
FROM emp JOIN dept ON emp.deptno = dept.deptno;

PAUSE

SELECT emp.ename, dept.dname 
FROM emp INNER JOIN dept ON emp.deptno = dept.deptno;

PAUSE

REM
REM self join
REM

SELECT emp.ename, mgr.ename
FROM emp, emp mgr
WHERE emp.mgr = mgr.empno;

PAUSE

SELECT emp.ename, mgr.ename
FROM emp JOIN emp mgr ON emp.mgr = mgr.empno;

PAUSE

REM
REM outer join
REM

SELECT emp.ename, mgr.ename
FROM emp, emp mgr
WHERE emp.mgr = mgr.empno(+);

PAUSE

SELECT emp.ename, mgr.ename
FROM emp LEFT JOIN emp mgr ON emp.mgr = mgr.empno;

PAUSE

SELECT emp.ename, mgr.ename
FROM emp mgr RIGHT JOIN emp ON emp.mgr = mgr.empno;

PAUSE

SELECT emp.ename, mgr.ename
FROM emp FULL OUTER JOIN emp mgr ON emp.mgr = mgr.empno;

PAUSE

SELECT emp.ename, mgr.ename
FROM emp LEFT OUTER JOIN emp mgr ON emp.mgr = mgr.empno;

PAUSE

SELECT emp.ename, mgr.ename
FROM emp mgr RIGHT OUTER JOIN emp ON emp.mgr = mgr.empno;

PAUSE

SELECT dept.dname, count(emp.empno)
FROM dept LEFT JOIN emp PARTITION BY (emp.job) ON emp.deptno = dept.deptno
WHERE emp.job = 'MANAGER'
GROUP BY dept.dname;

PAUSE

REM
REM semi join
REM

SELECT deptno, dname, loc
FROM dept 
WHERE deptno IN (SELECT deptno FROM emp);

PAUSE

SELECT deptno, dname, loc
FROM dept 
WHERE EXISTS (SELECT deptno FROM emp WHERE emp.deptno = dept.deptno);

PAUSE

SELECT deptno, dname, loc
FROM dept 
WHERE deptno = ANY (SELECT deptno FROM emp);

PAUSE

SELECT deptno, dname, loc
FROM dept 
WHERE deptno = SOME (SELECT deptno FROM emp);

PAUSE

REM
REM anti join
REM

SELECT deptno, dname, loc
FROM dept 
WHERE deptno NOT IN (SELECT deptno FROM emp);

PAUSE

SELECT deptno, dname, loc
FROM dept 
WHERE NOT EXISTS (SELECT deptno FROM emp WHERE emp.deptno = dept.deptno);

PAUSE

REM
REM Later inline views (work from 12.1 onward only)
REM

SELECT dname, ename
FROM dept, lateral(SELECT * FROM emp WHERE dept.deptno = emp.deptno);

PAUSE

REM the following raises an error

SELECT dname, empno
FROM dept, (SELECT * FROM emp WHERE dept.deptno = emp.deptno);

PAUSE

SELECT dname, ename
FROM dept CROSS APPLY (SELECT ename FROM emp WHERE dept.deptno = emp.deptno);

PAUSE

REM the following raises an error

SELECT dname, ename
FROM dept CROSS JOIN (SELECT ename FROM emp WHERE dept.deptno = emp.deptno);

PAUSE

SELECT dname, ename
FROM dept OUTER APPLY (SELECT ename FROM emp WHERE dept.deptno = emp.deptno);

REM
REM Cleanup
REM

DROP TABLE dept PURGE;
DROP TABLE emp PURGE;
DROP TABLE salgrade PURGE;
