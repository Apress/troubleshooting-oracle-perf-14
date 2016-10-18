SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: count_transformation.sql
REM Author......: Christian Antognini
REM Date........: February 2013
REM Description.: This script provides examples of the "count transformation"
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
  v VARCHAR2(10) NULL,
  n1 NUMBER NULL, 
  n2 NUMBER NOT NULL,
  n3 NUMBER NULL CHECK (n3 IS NOT NULL)
);

ALTER SESSION SET tracefile_identifier = 'count_transformation';
ALTER SESSION SET events '10053 trace name context forever';

REM PK is in place --> transformation done

EXPLAIN PLAN FOR SELECT count(id) FROM t;

REM n1 is nullable --> transformation not done

EXPLAIN PLAN FOR SELECT count(n1) FROM t;
EXPLAIN PLAN FOR SELECT v, count(n1) FROM t GROUP BY v;

REM n2 is not nullable --> trasformation done

EXPLAIN PLAN FOR SELECT count(n2) FROM t;
EXPLAIN PLAN FOR SELECT v, count(n2) FROM t GROUP BY v;

REM n3 is nullable and the check constraint is not considered --> transformation not done

EXPLAIN PLAN FOR SELECT count(n3) FROM t;

REM also this query is rewritten

EXPLAIN PLAN FOR SELECT count(1) FROM t;

ALTER SESSION SET events '10053 trace name context off';

REM
REM grep -e "^EXPLAIN" -e CNT -e "^SELECT" -e " END " <tracefile>
REM
