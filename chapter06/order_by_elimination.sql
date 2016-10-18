SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: order_by_elimination.sql
REM Author......: Christian Antognini
REM Date........: February 2013
REM Description.: This script provides examples of the "order-by elimination" 
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
  n1 NUMBER NULL,
  n2 NUMBER NULL
);

ALTER SESSION SET tracefile_identifier = 'order_by_elimination';

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT n2, count(*) FROM (SELECT n1, n2 FROM t ORDER BY n1) GROUP BY n2;
ALTER SESSION SET events '10053 trace name context off';

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic'));
