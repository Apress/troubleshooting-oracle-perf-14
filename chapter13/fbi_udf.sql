SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: fbi_udf.sql
REM Author......: Christian Antognini
REM Date........: October 2013
REM Description.: This script shows an example of a function-based index based
REM               on a user-defined function. 
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

@../connect.sql

COLUMN pad FORMAT a10 TRUNCATE

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t;

CREATE TABLE t AS
SELECT rownum AS id, rpad('*',1000,'*') AS pad
FROM dual
CONNECT BY level <= 1000;

EXECUTE dbms_stats.gather_table_stats(user, 't')

CREATE OR REPLACE FUNCTION myfct(p_n IN NUMBER) RETURN NUMBER AS
BEGIN
  RETURN p_n;
END;
/

CREATE INDEX i ON t (myfct(id));

CREATE OR REPLACE FUNCTION myfct(p_n IN NUMBER) RETURN NUMBER DETERMINISTIC AS
BEGIN
  RETURN p_n;
END;
/

CREATE INDEX i ON t (myfct(id));

ALTER SESSION SET statistics_level = all;

SELECT * FROM t WHERE myfct(id) = 1;

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats rows'));

CREATE OR REPLACE FUNCTION myfct(p_n IN NUMBER) RETURN NUMBER DETERMINISTIC AS
BEGIN
  RETURN -p_n;
END;
/

SELECT status, funcidx_status FROM user_indexes WHERE index_name = 'I';

SELECT * FROM t WHERE myfct(id) = 1;

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats rows'));

ALTER INDEX i REBUILD;

SELECT * FROM t WHERE myfct(id) = 1;

SELECT * FROM table(dbms_xplan.display_cursor(NULL,NULL,'iostats rows'));

REM
REM Cleanup
REM

DROP TABLE t;
PURGE TABLE t;
DROP FUNCTION myfct;
