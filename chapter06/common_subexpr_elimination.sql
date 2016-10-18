SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: common_subexpr_elimination.sql
REM Author......: Christian Antognini
REM Date........: February 2013
REM Description.: This script provides examples of the "common sub-expression 
REM               elimination" query transformation.
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
  n1 NUMBER NULL, 
  n2 NUMBER NULL
);

ALTER SESSION SET tracefile_identifier = 'common_subexpr_elimination';

REM transformation disabled

ALTER SESSION SET "_eliminate_common_subexpr" = FALSE;

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT * FROM t WHERE (n1 = 1 AND n2 = 2) OR (n1 = 1);
ALTER SESSION SET events '10053 trace name context off';

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));

REM transformation enabled

ALTER SESSION SET "_eliminate_common_subexpr" = TRUE;

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT * FROM t WHERE (n1 = 1 AND n2 = 2) OR (n1 = 1);
ALTER SESSION SET events '10053 trace name context off';

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic predicate'));
