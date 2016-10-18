SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: profile_signature.sql
REM Author......: Christian Antognini
REM Date........: May 2009
REM Description.: This script shows the impact of the parameter FORCE_MATCH 
REM               when accepting a SQL profile.
REM Notes.......: This script requires Oracle Database 10g Release 2 or never.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 31.07.2013 Script renamed (the old name was sqltext_to_signature.sql)
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON
SET LONG 1000000
SET PAGESIZE 100
SET LINESIZE 150
SET NUMWIDTH 20

COLUMN sql_text FORMAT A51

@../connect.sql

SET ECHO ON

REM
REM define the SQL statements used during the test
REM

VARIABLE sql1 VARCHAR2(100)
VARIABLE sql2 VARCHAR2(100)
VARIABLE sql3 VARCHAR2(100)
VARIABLE sql4 VARCHAR2(100)
VARIABLE sql5 VARCHAR2(100)
VARIABLE sql6 VARCHAR2(100)

BEGIN
  :sql1 := q'[SELECT * FROM dual WHERE dummy = 'X']';
  :sql2 := q'[select  *  from  dual  where  dummy='X']';
  :sql3 := q'[SELECT * FROM dual WHERE dummy = 'x']';
  :sql4 := q'[SELECT * FROM dual WHERE dummy = 'Y']';
  :sql5 := q'[SELECT * FROM dual WHERE dummy = 'X' OR dummy = :b1]';
  :sql6 := q'[SELECT * FROM dual WHERE dummy = 'Y' OR dummy = :b1]';
END;
/

PAUSE

REM
REM get the signature of the SQL statements with FORCE_MATCHING = FALSE (0)
REM

SELECT :sql1 sql_text, dbms_sqltune.sqltext_to_signature(:sql1,0) signature FROM dual
UNION ALL
SELECT :sql2 sql_text, dbms_sqltune.sqltext_to_signature(:sql2,0) signature FROM dual
UNION ALL
SELECT :sql3 sql_text, dbms_sqltune.sqltext_to_signature(:sql3,0) signature FROM dual
UNION ALL 
SELECT :sql4 sql_text, dbms_sqltune.sqltext_to_signature(:sql4,0) signature FROM dual
UNION ALL
SELECT :sql5 sql_text, dbms_sqltune.sqltext_to_signature(:sql5,0) signature FROM dual
UNION ALL 
SELECT :sql6 sql_text, dbms_sqltune.sqltext_to_signature(:sql6,0) signature FROM dual;

PAUSE

REM
REM get the signature of the SQL statements with FORCE_MATCHING = TRUE (1)
REM

SELECT :sql1 sql_text, dbms_sqltune.sqltext_to_signature(:sql1,1) signature FROM dual
UNION ALL
SELECT :sql2 sql_text, dbms_sqltune.sqltext_to_signature(:sql2,1) signature FROM dual
UNION ALL
SELECT :sql3 sql_text, dbms_sqltune.sqltext_to_signature(:sql3,1) signature FROM dual
UNION ALL 
SELECT :sql4 sql_text, dbms_sqltune.sqltext_to_signature(:sql4,1) signature FROM dual
UNION ALL
SELECT :sql5 sql_text, dbms_sqltune.sqltext_to_signature(:sql5,1) signature FROM dual
UNION ALL 
SELECT :sql6 sql_text, dbms_sqltune.sqltext_to_signature(:sql6,1) signature FROM dual;

PAUSE

REM
REM what about case insensitive searches?
REM

ALTER SESSION SET nls_sort=binary_ci;
ALTER SESSION SET nls_comp=ansi;

PAUSE

SELECT :sql1 sql_text, dbms_sqltune.sqltext_to_signature(:sql1,0) signature FROM dual
UNION ALL
SELECT :sql2 sql_text, dbms_sqltune.sqltext_to_signature(:sql2,0) signature FROM dual
UNION ALL
SELECT :sql3 sql_text, dbms_sqltune.sqltext_to_signature(:sql3,0) signature FROM dual
UNION ALL 
SELECT :sql4 sql_text, dbms_sqltune.sqltext_to_signature(:sql4,0) signature FROM dual
UNION ALL
SELECT :sql5 sql_text, dbms_sqltune.sqltext_to_signature(:sql5,0) signature FROM dual
UNION ALL 
SELECT :sql6 sql_text, dbms_sqltune.sqltext_to_signature(:sql6,0) signature FROM dual;
