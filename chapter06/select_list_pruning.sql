SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: select_list_pruning.sql
REM Author......: Christian Antognini
REM Date........: February 2013
REM Description.: This script provides examples of the "select list pruning" 
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
  n2 NUMBER NULL,
  n3 NUMBER NULL
);

ALTER SESSION SET tracefile_identifier = 'select_list_pruning';

REM disable view merging

ALTER SESSION SET "_simple_view_merging" = FALSE;

REM all columns are referenced --> transformation not done

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT n1, n2, n3 FROM (SELECT n1, n2, n3 FROM t);
ALTER SESSION SET events '10053 trace name context off';

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic projection'));

REM only one column is referenced --> transformation done

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT n1 FROM (SELECT n1, n2, n3 FROM t);
ALTER SESSION SET events '10053 trace name context off';

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic projection'));  

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT n1 FROM (SELECT * FROM t);

ALTER SESSION SET events '10053 trace name context off';

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic projection'));  

ALTER SESSION SET events '10053 trace name context forever';
EXPLAIN PLAN FOR SELECT n1 FROM (SELECT n1, n2+n3 AS n4 FROM t);
ALTER SESSION SET events '10053 trace name context off';

SELECT * FROM table(dbms_xplan.display(NULL, NULL, 'basic projection'));  
