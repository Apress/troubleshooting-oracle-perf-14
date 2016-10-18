SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: ParsingTest.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script creates the object used by test case 1, 2 and 3.
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

SET ECHO ON

DROP TABLE t;

execute dbms_random.seed(0)

CREATE TABLE t
AS
SELECT round(5678+dbms_random.normal*1234) AS val,
       dbms_random.string('p',100) AS pad
FROM dual
CONNECT BY level <= 5000
ORDER BY dbms_random.value;

CREATE INDEX t_val_i ON t (val);

BEGIN
  dbms_stats.gather_table_stats(
    ownname          => user,
    tabname          => 'T',
    estimate_percent => 100,
    method_opt       => 'for all columns size skewonly',
    cascade          => TRUE
  );
END;
/

SELECT num_rows, blocks, empty_blocks, avg_space, chain_cnt, avg_row_len
FROM user_tab_statistics
WHERE table_name = 'T';

COLUMN name FORMAT A4
COLUMN #dst FORMAT 99999
COLUMN low_value FORMAT A14
COLUMN high_value FORMAT A14
COLUMN dens FORMAT .99999
COLUMN #null FORMAT 9999
COLUMN avglen FORMAT 9999
COLUMN histogram FORMAT A15
COLUMN #bkt FORMAT 9999

SELECT column_name AS "NAME", 
       num_distinct AS "#DST", 
       low_value, 
       high_value, 
       density AS "DENS", 
       num_nulls AS "#NULL", 
       avg_col_len AS "AVGLEN", 
       histogram, 
       num_buckets AS "#BKT"
FROM user_tab_col_statistics
WHERE table_name = 'T';

SELECT min(val), max(val)
FROM t;
