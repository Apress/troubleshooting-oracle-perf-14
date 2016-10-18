SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: object_statistics.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script provides an overview of all object statistics.
REM Notes.......: Since also extended statistics are shown, the scripts only
REM               works in Oracle Database 11g.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 09.02.2011 Improved part about histograms to easily reproduce the examples 
REM            provided in the book
REM 14.05.2013 Improvements for 12c
REM 26.02.2014 Added example of column group containing an expression
REM 06.05.2014 Added examples related to estimations for values not represented
REM            in histograms
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

@../connect.sql

SET SERVEROUTPUT ON

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t PURGE;

execute dbms_random.seed(0)

CREATE TABLE t
AS
SELECT rownum AS id,
       50+round(dbms_random.normal*4) AS val1,
       100+round(ln(rownum/3.25+2)) AS val2,
       100+round(ln(rownum/3.25+2)) AS val3,
       dbms_random.string('p',250) AS pad
FROM dual
CONNECT BY level <= 1000
ORDER BY dbms_random.value;

UPDATE t SET val1 = NULL WHERE val1 < 0;

ALTER TABLE t ADD CONSTRAINT t_pk PRIMARY KEY (id);

CREATE INDEX t_val1_i ON t (val1);

CREATE INDEX t_val2_i ON t (val2);

BEGIN
  dbms_stats.gather_table_stats(ownname          => user,
                                tabname          => 'T',
                                estimate_percent => dbms_stats.auto_sample_size,
                                method_opt       => 'for columns size skewonly id, val1 size 15, val2, val3 size 5, pad',
                                cascade          => TRUE);
END;
/

REM
REM Table statistics
REM

SELECT num_rows, blocks, empty_blocks, avg_space, chain_cnt, avg_row_len
FROM user_tab_statistics
WHERE table_name = 'T';

PAUSE

REM
REM Column statistics
REM

COLUMN name FORMAT A4
COLUMN #dst FORMAT 9999
COLUMN low_value FORMAT A19
COLUMN high_value FORMAT A19
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

PAUSE

COLUMN low_value FORMAT 9999
COLUMN high_value FORMAT 9999

SELECT utl_raw.cast_to_number(low_value) AS low_value,
       utl_raw.cast_to_number(high_value) AS high_value
FROM user_tab_col_statistics
WHERE table_name = 'T'
AND column_name = 'VAL1';

PAUSE

REM This query works as of 12.1 only

SET SQLTERMINATOR OFF

WITH
  FUNCTION convert_raw_value(p_value IN RAW) RETURN NUMBER IS
    l_ret NUMBER;
  BEGIN
   dbms_stats.convert_raw_value(p_value, l_ret);
   RETURN l_ret;
  END;
SELECT convert_raw_value(low_value) AS low_value,
       convert_raw_value(high_value) AS high_value
FROM user_tab_col_statistics
WHERE table_name = 'T'
AND column_name = 'VAL1'
/

COLUMN low_value FORMAT A30
COLUMN high_value FORMAT A30

WITH
  FUNCTION convert_raw_value(p_value IN RAW, p_datatype IN VARCHAR2) RETURN VARCHAR2 IS
    l_ret VARCHAR2(64);
    l_date DATE;
    l_number NUMBER;
    l_binary_float BINARY_FLOAT;
    l_binary_double BINARY_DOUBLE;
    l_nvarchar2 NVARCHAR2(64);
    l_rowid ROWID;
  BEGIN
    IF p_datatype = 'VARCHAR2' OR p_datatype = 'CHAR'
    THEN
      dbms_stats.convert_raw_value(p_value, l_ret);
    ELSIF p_datatype = 'DATE'
    THEN
      dbms_stats.convert_raw_value(p_value, l_date);
      l_ret := to_char(l_date, 'YYYY-MM-DD HH24:MI:SS');
    ELSIF p_datatype LIKE 'TIMESTAMP%'
    THEN
      dbms_stats.convert_raw_value(p_value, l_date);
      l_ret := to_char(l_date, 'YYYY-MM-DD HH24:MI:SS');
    ELSIF p_datatype = 'NUMBER'
    THEN
      dbms_stats.convert_raw_value(p_value, l_number);
      l_ret := to_char(l_number);
    ELSIF p_datatype = 'BINARY_FLOAT'
    THEN
      dbms_stats.convert_raw_value(p_value, l_binary_float);
      l_ret := to_char(l_binary_float);
    ELSIF p_datatype = 'BINARY_DOUBLE'
    THEN
      dbms_stats.convert_raw_value(p_value, l_binary_double);
      l_ret := to_char(l_binary_double);
    ELSIF p_datatype = 'NVARCHAR2'
    THEN
      dbms_stats.convert_raw_value(p_value, l_nvarchar2);
      l_ret := to_char(l_nvarchar2);
    ELSIF p_datatype = 'ROWID'
    THEN
      dbms_stats.convert_raw_value(p_value, l_nvarchar2);
      l_ret := to_char(l_nvarchar2);
    ELSE
      l_ret := 'UNSUPPORTED DATATYPE';
    END IF;
    RETURN l_ret;
  END;
SELECT column_name,
       convert_raw_value(low_value, data_type) AS low_value,
       convert_raw_value(high_value, data_type) AS high_value
FROM user_tab_columns
WHERE table_name = 'T'
ORDER BY column_id
/

SET SQLTERMINATOR ON

PAUSE

REM
REM Frequency Histograms
REM

SELECT val2, count(*)
FROM t
GROUP BY val2
ORDER BY val2;

PAUSE

COLUMN endpoint_value FORMAT 9999
COLUMN endpoint_number FORMAT 999999
COLUMN frequency FORMAT 999999

SELECT endpoint_value, endpoint_number,
       endpoint_number - lag(endpoint_number,1,0) 
                         OVER (ORDER BY endpoint_number) AS frequency
FROM user_tab_histograms
WHERE table_name = 'T'
AND column_name = 'VAL2'
ORDER BY endpoint_number;

PAUSE

DELETE plan_table;
EXPLAIN PLAN SET STATEMENT_ID '101' FOR SELECT * FROM t WHERE val2 = 101;
EXPLAIN PLAN SET STATEMENT_ID '102' FOR SELECT * FROM t WHERE val2 = 102;
EXPLAIN PLAN SET STATEMENT_ID '103' FOR SELECT * FROM t WHERE val2 = 103;
EXPLAIN PLAN SET STATEMENT_ID '104' FOR SELECT * FROM t WHERE val2 = 104;
EXPLAIN PLAN SET STATEMENT_ID '105' FOR SELECT * FROM t WHERE val2 = 105;
EXPLAIN PLAN SET STATEMENT_ID '106' FOR SELECT * FROM t WHERE val2 = 106;

COLUMN statement_id FORMAT A12

SELECT statement_id, cardinality
FROM plan_table
WHERE id = 0
ORDER BY statement_id;

PAUSE

DELETE plan_table;
EXPLAIN PLAN SET STATEMENT_ID '096' FOR SELECT * FROM t WHERE val2 = 96;
EXPLAIN PLAN SET STATEMENT_ID '098' FOR SELECT * FROM t WHERE val2 = 98;
EXPLAIN PLAN SET STATEMENT_ID '100' FOR SELECT * FROM t WHERE val2 = 100;
EXPLAIN PLAN SET STATEMENT_ID '103.5' FOR SELECT * FROM t WHERE val2 = 103.5;
EXPLAIN PLAN SET STATEMENT_ID '107' FOR SELECT * FROM t WHERE val2 = 107;
EXPLAIN PLAN SET STATEMENT_ID '109' FOR SELECT * FROM t WHERE val2 = 109;
EXPLAIN PLAN SET STATEMENT_ID '111' FOR SELECT * FROM t WHERE val2 = 111;

COLUMN statement_id FORMAT A12

SELECT statement_id, cardinality
FROM plan_table
WHERE id = 0
ORDER BY statement_id;

PAUSE

REM
REM Height-Balanced Histograms
REM

SELECT count(*), max(val2) AS endpoint_value, endpoint_number
FROM (
  SELECT val2, ntile(5) OVER (ORDER BY val2) AS endpoint_number
  FROM t
)
GROUP BY endpoint_number
ORDER BY endpoint_number;

PAUSE

BEGIN
  dbms_stats.gather_table_stats(
    ownname          => user,
    tabname          => 'T',
    estimate_percent => 100,
    method_opt       => 'for columns val2 size 5',
    cascade          => TRUE
  );
END;
/

PAUSE

SELECT endpoint_value, endpoint_number
FROM user_tab_histograms
WHERE table_name = 'T'
AND column_name = 'VAL2'
ORDER BY endpoint_number;

PAUSE

DELETE plan_table;
EXPLAIN PLAN SET STATEMENT_ID '101' FOR SELECT * FROM t WHERE val2 = 101;
EXPLAIN PLAN SET STATEMENT_ID '102' FOR SELECT * FROM t WHERE val2 = 102;
EXPLAIN PLAN SET STATEMENT_ID '103' FOR SELECT * FROM t WHERE val2 = 103;
EXPLAIN PLAN SET STATEMENT_ID '104' FOR SELECT * FROM t WHERE val2 = 104;
EXPLAIN PLAN SET STATEMENT_ID '105' FOR SELECT * FROM t WHERE val2 = 105;
EXPLAIN PLAN SET STATEMENT_ID '106' FOR SELECT * FROM t WHERE val2 = 106;

COLUMN statement_id FORMAT A12

SELECT statement_id, cardinality
FROM plan_table
WHERE id = 0
ORDER BY statement_id;

PAUSE

DELETE plan_table;
EXPLAIN PLAN SET STATEMENT_ID '096' FOR SELECT * FROM t WHERE val2 = 96;
EXPLAIN PLAN SET STATEMENT_ID '098' FOR SELECT * FROM t WHERE val2 = 98;
EXPLAIN PLAN SET STATEMENT_ID '100' FOR SELECT * FROM t WHERE val2 = 100;
EXPLAIN PLAN SET STATEMENT_ID '103.5' FOR SELECT * FROM t WHERE val2 = 103.5;
EXPLAIN PLAN SET STATEMENT_ID '107' FOR SELECT * FROM t WHERE val2 = 107;
EXPLAIN PLAN SET STATEMENT_ID '109' FOR SELECT * FROM t WHERE val2 = 109;
EXPLAIN PLAN SET STATEMENT_ID '111' FOR SELECT * FROM t WHERE val2 = 111;

COLUMN statement_id FORMAT A12

SELECT statement_id, cardinality
FROM plan_table
WHERE id = 0
ORDER BY statement_id;

PAUSE

UPDATE t SET val2 = 105 WHERE val2 = 106 AND rownum <= 20;

PAUSE

BEGIN
  dbms_stats.gather_table_stats(
    ownname          => user,
    tabname          => 'T',
    estimate_percent => 100,
    method_opt       => 'for columns val2 size 5',
    cascade          => TRUE
  );
END;
/

PAUSE

SELECT endpoint_value, endpoint_number
FROM user_tab_histograms
WHERE table_name = 'T'
AND column_name = 'VAL2'
ORDER BY endpoint_number;

PAUSE

DELETE plan_table;
EXPLAIN PLAN SET STATEMENT_ID '101' FOR SELECT * FROM t WHERE val2 = 101;
EXPLAIN PLAN SET STATEMENT_ID '102' FOR SELECT * FROM t WHERE val2 = 102;
EXPLAIN PLAN SET STATEMENT_ID '103' FOR SELECT * FROM t WHERE val2 = 103;
EXPLAIN PLAN SET STATEMENT_ID '104' FOR SELECT * FROM t WHERE val2 = 104;
EXPLAIN PLAN SET STATEMENT_ID '105' FOR SELECT * FROM t WHERE val2 = 105;
EXPLAIN PLAN SET STATEMENT_ID '106' FOR SELECT * FROM t WHERE val2 = 106;

COLUMN statement_id FORMAT A12

SELECT statement_id, cardinality
FROM plan_table
WHERE id = 0
ORDER BY statement_id;

PAUSE

SELECT endpoint_value, endpoint_number
FROM user_tab_histograms
WHERE table_name = 'T'
AND column_name = 'ID'
ORDER BY endpoint_number;

PAUSE

REM
REM Top Frequency Histograms
REM

COLUMN percent FORMAT 90.9

SELECT val3, count(*) AS frequency, ratio_to_report(count(*)) OVER ()*100 AS percent
FROM t
GROUP BY val3
ORDER BY val3;

PAUSE

SELECT endpoint_value, endpoint_number,
       endpoint_number - lag(endpoint_number,1,0) 
                         OVER (ORDER BY endpoint_number) AS frequency
FROM user_tab_histograms
WHERE table_name = 'T'
AND column_name = 'VAL3'
ORDER BY endpoint_number;

PAUSE

DELETE plan_table;
EXPLAIN PLAN SET STATEMENT_ID '101' FOR SELECT * FROM t WHERE val3 = 101;
EXPLAIN PLAN SET STATEMENT_ID '102' FOR SELECT * FROM t WHERE val3 = 102;
EXPLAIN PLAN SET STATEMENT_ID '103' FOR SELECT * FROM t WHERE val3 = 103;
EXPLAIN PLAN SET STATEMENT_ID '104' FOR SELECT * FROM t WHERE val3 = 104;
EXPLAIN PLAN SET STATEMENT_ID '105' FOR SELECT * FROM t WHERE val3 = 105;
EXPLAIN PLAN SET STATEMENT_ID '106' FOR SELECT * FROM t WHERE val3 = 106;

COLUMN statement_id FORMAT A12

SELECT statement_id, cardinality
FROM plan_table
WHERE id = 0
ORDER BY statement_id;

PAUSE

DELETE plan_table;
EXPLAIN PLAN SET STATEMENT_ID '096' FOR SELECT * FROM t WHERE val3 = 96;
EXPLAIN PLAN SET STATEMENT_ID '098' FOR SELECT * FROM t WHERE val3 = 98;
EXPLAIN PLAN SET STATEMENT_ID '100' FOR SELECT * FROM t WHERE val3 = 100;
EXPLAIN PLAN SET STATEMENT_ID '103.5' FOR SELECT * FROM t WHERE val3 = 103.5;
EXPLAIN PLAN SET STATEMENT_ID '107' FOR SELECT * FROM t WHERE val3 = 107;
EXPLAIN PLAN SET STATEMENT_ID '109' FOR SELECT * FROM t WHERE val3 = 109;
EXPLAIN PLAN SET STATEMENT_ID '111' FOR SELECT * FROM t WHERE val3 = 111;

COLUMN statement_id FORMAT A12

SELECT statement_id, cardinality
FROM plan_table
WHERE id = 0
ORDER BY statement_id;

PAUSE

REM
REM Hybrid Histograms
REM

COLUMN percent FORMAT 90.9

SELECT val1, count(*), ratio_to_report(count(*)) OVER ()*100 AS percent
FROM t
GROUP BY val1
ORDER BY val1;

PAUSE

SELECT endpoint_value, endpoint_number,
       endpoint_number - lag(endpoint_number,1,0)
                         OVER (ORDER BY endpoint_number) AS count,
       endpoint_repeat_count
FROM user_tab_histograms
WHERE table_name = 'T'
AND column_name = 'VAL1'
ORDER BY endpoint_number;

PAUSE

DELETE plan_table;
EXPLAIN PLAN SET STATEMENT_ID '44' FOR SELECT * FROM t WHERE val1 = 44;
EXPLAIN PLAN SET STATEMENT_ID '50' FOR SELECT * FROM t WHERE val1 = 50;
EXPLAIN PLAN SET STATEMENT_ID '56' FOR SELECT * FROM t WHERE val1 = 56;

COLUMN statement_id FORMAT A12

SELECT statement_id, cardinality
FROM plan_table
WHERE id = 0
ORDER BY statement_id;

PAUSE

BEGIN
  DELETE plan_table;
  FOR i IN 30..70
  LOOP
    EXECUTE IMMEDIATE 'EXPLAIN PLAN SET STATEMENT_ID ''' || i || ''' FOR SELECT * FROM t WHERE val1 = ' || i;
  END LOOP;
END;
/

COLUMN statement_id FORMAT A12

SELECT statement_id, cardinality
FROM plan_table
WHERE id = 0
ORDER BY statement_id;


PAUSE

REM
REM Extended statistics
REM

SELECT dbms_stats.create_extended_stats(ownname   => user,
                                        tabname   => 'T',
                                        extension => '(upper(pad))') AS ext1,
       dbms_stats.create_extended_stats(ownname   => user,
                                        tabname   => 'T',
                                        extension => '(val2,val3)') AS ext2
FROM dual;

PAUSE

REM A column group cannot contain expressions

SELECT dbms_stats.create_extended_stats(ownname   => user,
                                        tabname   => 'T',
                                        extension => '(val2,round(val3,0))') AS ext3
FROM dual;

PAUSE

REM A column group cannot contain virtual columns

ALTER TABLE t ADD dummy GENERATED ALWAYS AS (val1+val2);

SELECT dbms_stats.create_extended_stats(ownname   => user,
                                        tabname   => 'T',
                                        extension => '(dummy,val3)') AS ext4
FROM dual;

ALTER TABLE t DROP COLUMN dummy;

PAUSE

COLUMN extension_name FORMAT A30
COLUMN extension FORMAT A15

SELECT extension_name, extension
FROM user_stat_extensions
WHERE table_name = 'T';

PAUSE

COLUMN column_name FORMAT A30
COLUMN data_type FORMAT A9
COLUMN hidden_column FORMAT A6

SELECT column_name, data_type, hidden_column, data_default
FROM user_tab_cols
WHERE table_name = 'T'
ORDER BY column_id;

PAUSE

BEGIN
  dbms_stats.drop_extended_stats(ownname   => user,
                                 tabname   => 'T',
                                 extension => '(upper(pad))');
  dbms_stats.drop_extended_stats(ownname   => user,
                                 tabname   => 'T',
                                 extension => '(val2,val3)');
END;
/

PAUSE

COLUMN name FORMAT A10
COLUMN name FORMAT A10

DROP TABLE persons PURGE;

CREATE TABLE persons (
  name VARCHAR2(100),
  name_upper AS (upper(name))
);

INSERT INTO persons (name) VALUES ('Michelle');

SELECT name 
FROM persons
WHERE name_upper = 'MICHELLE';

PAUSE

REM
REM Index statistics
REM

COLUMN name FORMAT A10
COLUMN blevel FORMAT 9
COLUMN leaf_blks FORMAT 99999
COLUMN dst_keys FORMAT 99999
COLUMN num_rows FORMAT 99999
COLUMN clust_fact FORMAT 99999
COLUMN leaf_per_key FORMAT 99999
COLUMN data_per_key FORMAT 99999

SELECT index_name AS name, 
       blevel, 
       leaf_blocks AS leaf_blks, 
       distinct_keys AS dst_keys, 
       num_rows, 
       clustering_factor AS clust_fact,
       avg_leaf_blocks_per_key AS leaf_per_key, 
       avg_data_blocks_per_key AS data_per_key
FROM user_ind_statistics
WHERE table_name = 'T';

REM
REM Cleanup
REM

BEGIN
  dbms_stats.drop_extended_stats(ownname   => user, 
                                 tabname   => 'T', 
                                 extension => '(upper(pad))');
  dbms_stats.drop_extended_stats(ownname   => user, 
                                 tabname   => 'T', 
                                 extension => '(val2,val3)');
END;
/

DROP TABLE t PURGE;

DROP TABLE persons PURGE;
