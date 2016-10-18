SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: relationship.sql
REM Author......: Christian Antognini
REM Date........: February 2014
REM Description.: This script was used to generated the execution plans of the
REM               Parent-Child Relationship section.
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

DROP TABLE t PURGE;

CREATE TABLE t (
  id NUMBER, 
  val NUMBER, 
  pad VARCHAR2(1000), 
  CONSTRAINT t_pk PRIMARY KEY (id)
);

CREATE INDEX i ON t (val);

execute dbms_stats.gather_table_stats(user, 't')

PAUSE

REM
REM Parent-Child Relationship
REM

UPDATE t
SET val = (SELECT /*+ index(t) */ max(val) FROM t WHERE id BETWEEN 6 AND 19),
    pad = (SELECT pad FROM t WHERE id = 6)
WHERE id IN (SELECT id FROM t WHERE id BETWEEN 6 AND 19);

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'basic'));

PAUSE

SELECT *
FROM t
WHERE id < 7788
ORDER BY val;

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'basic'));

PAUSE

REM
REM Cleanup
REM

DROP TABLE t PURGE;
