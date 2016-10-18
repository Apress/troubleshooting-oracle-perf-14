SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: delete_histogram.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows how to delete a single histogram, without
REM               modifying the other statistics.
REM Notes.......: This script works in Oracle Database 11g only.
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

COLUMN name FORMAT A4
COLUMN #dst FORMAT 9999
COLUMN low_value FORMAT A14
COLUMN high_value FORMAT A14
COLUMN dens FORMAT .99999
COLUMN #null FORMAT 9999
COLUMN avglen FORMAT 9999
COLUMN histogram FORMAT A15
COLUMN #bkt FORMAT 9999

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t;

CREATE TABLE t
AS
SELECT 10+round(ln(rownum/2+2)) AS val
FROM dual
CONNECT BY level <= 1000;

PAUSE

REM
REM Gather statistics with histograms and display them
REM

BEGIN
  dbms_stats.gather_table_stats(
    ownname          => user,
    tabname          => 'T',
    estimate_percent => 100,
    method_opt       => 'for all columns size skewonly'
  );
END;
/

PAUSE

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

PAUSE

REM
REM Delete histogram and display new statistics at column level
REM

BEGIN
  dbms_stats.delete_column_stats(ownname       => user,
                                 tabname       => 'T',
                                 colname       => 'VAL',
                                 col_stat_type => 'HISTOGRAM');
END;
/

PAUSE

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

PAUSE

REM
REM Gather statistics without histograms and display them
REM

BEGIN
  dbms_stats.gather_table_stats(
    ownname          => user,
    tabname          => 'T',
    estimate_percent => 100,
    method_opt       => 'for all columns size 1'
  );
END;
/

PAUSE

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

PAUSE

REM
REM Cleanup
REM

DROP TABLE t;
PURGE TABLE t;
