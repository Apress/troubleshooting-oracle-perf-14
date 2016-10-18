SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: distinct_elimination.sql
REM Author......: Christian Antognini
REM Date........: February 2013
REM Description.: This script provides examples of the "distinct elimination" 
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

DROP TABLE t PURGE;

CREATE TABLE t (
  id NUMBER PRIMARY KEY,
  nuk NUMBER NULL UNIQUE,
  nnuk NUMBER NOT NULL UNIQUE,
  n NUMBER NULL
);

ALTER SESSION SET tracefile_identifier = 'distinct_elimination';

REM id is the primary key --> transformation done

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT DISTINCT id, n FROM t;
ALTER SESSION SET events '10053 trace name context off';

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic'));

REM the primary key is modified --> transformation not done

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT DISTINCT trunc(id), n FROM t;
ALTER SESSION SET events '10053 trace name context off';

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic'));

REM nuk is a nullable unique key --> transformation not done

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT DISTINCT nuk, n FROM t;
ALTER SESSION SET events '10053 trace name context off';

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic'));

REM nnuk is a not nullable unique key --> transformation done

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT DISTINCT nnuk, n FROM t;
ALTER SESSION SET events '10053 trace name context off';

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic'));

REM rowid selected --> transformation done

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT DISTINCT n, rowid FROM t;
ALTER SESSION SET events '10053 trace name context off';

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic'));

REM a GROUP BY is not eliminated

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT id, n FROM t GROUP BY id, n;
ALTER SESSION SET events '10053 trace name context off';

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic'));
