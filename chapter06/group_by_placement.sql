SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: group_by_placement.sql
REM Author......: Christian Antognini
REM Date........: February 2013
REM Description.: This script provides examples of the "group-by placement" 
REM               query transformation.
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

SET TERMOUT ON FEEDBACK OFF

@../connect.sql

SET ECHO ON

DROP TABLE t1 CASCADE CONSTRAINTS PURGE;
DROP TABLE t2 CASCADE CONSTRAINTS PURGE;

CREATE TABLE t1 (
  id NUMBER PRIMARY KEY,
  n1 NUMBER NULL,
  n2 NUMBER NULL
);

INSERT INTO t1 SELECT rownum, mod(rownum,42), rownum FROM dual CONNECT BY level <= 100;
COMMIT;

execute dbms_stats.gather_table_stats(user, 'T1')

CREATE TABLE t2 (
  id NUMBER PRIMARY KEY,
  t1_id NUMBER NULL,
  n1 NUMBER NULL,
  n2 NUMBER NULL
);

REM the foreign key is not required
REM ALTER TABLE t2 DROP FOREIGN KEY (t1_id) REFERENCES t1 (id);

INSERT INTO t2 SELECT rownum, t1.id, mod(rownum,42), mod(rownum,4200) FROM (SELECT null FROM dual CONNECT BY level <= 2000) d, t1;
COMMIT;

execute dbms_stats.gather_table_stats(user, 'T2')


ALTER SESSION SET tracefile_identifier = 'group_by_placement';


REM the number of distinct values of t2.n1 is low --> transformation done

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT t1.n2, t2.n1, count(*) FROM t1, t2 WHERE t1.id = t2.t1_id GROUP BY t1.n2, t2.n1;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic rows'));

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT /*+ no_place_group_by(@sel$1) */ t1.n2, t2.n1, count(*) FROM t1, t2 WHERE t1.id = t2.t1_id GROUP BY t1.n2, t2.n1;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic rows'));


REM the number of distinct values of t2.n2 is high --> transformation not done

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT t1.n2, t2.n2, count(*) FROM t1, t2 WHERE t1.id = t2.t1_id GROUP BY t1.n2, t2.n2;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic rows'));

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT /*+ place_group_by(@sel$1 (t2@sel$1)) */ t1.n2, t2.n2, count(*) FROM t1, t2 WHERE t1.id = t2.t1_id GROUP BY t1.n2, t2.n2;
ALTER SESSION SET events '10053 trace name context off';
SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic rows'));
