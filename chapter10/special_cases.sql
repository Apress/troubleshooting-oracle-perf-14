SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: special_cases.sql
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

DROP TABLE t1 PURGE;
DROP TABLE t2 PURGE;
DROP TABLE t3 PURGE;

CREATE TABLE t1 AS SELECT rownum AS id, mod(rownum,11) AS n1, mod(rownum,13) AS n2, rpad('*',100,'*') AS pad FROM DUAL CONNECT BY level <= 1000;
CREATE INDEX i1 ON t1 (n1,n2);
CREATE TABLE t2 AS SELECT rownum AS id, mod(rownum,11) AS n1, mod(rownum,13) AS n2, rpad('*',100,'*') AS pad FROM DUAL CONNECT BY level <= 1000;
CREATE TABLE t3 AS SELECT rownum AS id, mod(rownum,11) AS n1, mod(rownum,13) AS n2, rpad('*',100,'*') AS pad FROM DUAL CONNECT BY level <= 1000;

execute dbms_stats.gather_table_stats(user,'t1')
execute dbms_stats.gather_table_stats(user,'t2')
execute dbms_stats.gather_table_stats(user,'t3')

ALTER SESSION SET statistics_level = all;

PAUSE

REM
REM Subquery in the SELECT Clause
REM

SELECT ename, (SELECT dname FROM dept WHERE dept.deptno = emp.deptno)
FROM emp;

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

REM
REM Subquery in the WHERE Clause #1
REM

SELECT /*+ optimizer_features_enable('10.2.0.5') */ deptno
FROM dept
WHERE deptno NOT IN (SELECT deptno FROM emp);

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

EXPLAIN PLAN FOR 
SELECT /*+ optimizer_features_enable('10.2.0.5') */ deptno
FROM dept
WHERE deptno NOT IN (SELECT deptno FROM emp);

SELECT * FROM table(dbms_xplan.display);

PAUSE

SELECT deptno
FROM dept
WHERE deptno NOT IN (SELECT deptno FROM emp);

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats last'));

PAUSE

REM
REM Subquery in the WHERE Clause #2
REM

REM with the value 42 (instead of 8 and 4) it generates the same execution plan as with hints

SELECT /*+
			    ALL_ROWS
			    OUTLINE_LEAF(@"SEL$2")
			    OUTLINE_LEAF(@"SEL$1")
			    INDEX_RS_ASC(@"SEL$1" "T1"@"SEL$1" ("T1"."N1" "T1"."N2"))
			    PUSH_SUBQ(@"SEL$2")
			    FULL(@"SEL$2" "T3"@"SEL$2")
			    FULL(@"SEL$2" "T2"@"SEL$2")
			    LEADING(@"SEL$2" "T3"@"SEL$2" "T2"@"SEL$2")
			    USE_HASH(@"SEL$2" "T2"@"SEL$2")
			 */ * 
FROM t1 
WHERE n1 = 8 AND n2 IN (SELECT t2.n1 
                        FROM t2, t3 
                        WHERE t2.id = t3.id AND t3.n1 = 4);
SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'allstats last'));

PAUSE

EXPLAIN PLAN FOR
SELECT /*+
			    ALL_ROWS
			    OUTLINE_LEAF(@"SEL$2")
			    OUTLINE_LEAF(@"SEL$1")
			    INDEX_RS_ASC(@"SEL$1" "T1"@"SEL$1" ("T1"."N1" "T1"."N2"))
			    PUSH_SUBQ(@"SEL$2")
			    FULL(@"SEL$2" "T3"@"SEL$2")
			    FULL(@"SEL$2" "T2"@"SEL$2")
			    LEADING(@"SEL$2" "T3"@"SEL$2" "T2"@"SEL$2")
			    USE_HASH(@"SEL$2" "T2"@"SEL$2")
			 */ * 
FROM t1 
WHERE n1 = 8 AND n2 IN (SELECT t2.n1 
                        FROM t2, t3 
                        WHERE t2.id = t3.id AND t3.n1 = 4);
SELECT * FROM table(dbms_xplan.display);

PAUSE

REM
REM Cleanup
REM

DROP TABLE bonus PURGE;
DROP TABLE emp PURGE;
DROP TABLE dept PURGE;

DROP TABLE t1 PURGE;
DROP TABLE t2 PURGE;
DROP TABLE t3 PURGE;
