SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: incremental_stats.sql
REM Author......: Christian Antognini
REM Date........: May 2014
REM Description.: This script shows how to enable incremental statistics.
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
SET LINESIZE 100
SET PAGESIZE 1000

COLUMN partition_name FORMAT A14
COLUMN subpartition_name FORMAT A17
COLUMN num_rows FORMAT 999999
COLUMN blocks FORMAT 999999
COLUMN avg_row_len FORMAT 999999
COLUMN global_stats FORMAT A12
COLUMN last_analyzed FORMAT A13
COLUMN object FORMAT A19

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t PURGE;

CREATE TABLE t (id NUMBER, p DATE, sp NUMBER, pad VARCHAR2(1000))
PARTITION BY RANGE (p)
SUBPARTITION BY HASH (sp) SUBPARTITION TEMPLATE
(
  SUBPARTITION sp1,
  SUBPARTITION sp2
)
(
  PARTITION q1 VALUES LESS THAN (to_date('2013-04-01','YYYY-MM-DD')),
  PARTITION q2 VALUES LESS THAN (to_date('2013-07-01','YYYY-MM-DD')),
  PARTITION q3 VALUES LESS THAN (to_date('2013-10-01','YYYY-MM-DD')),
  PARTITION q4 VALUES LESS THAN (to_date('2014-01-01','YYYY-MM-DD'))
);

INSERT INTO t
SELECT rownum, to_date('2013-01-01','YYYY-MM-DD')+mod(rownum,365), mod(rownum,100)+1, rpad('*',100,'*')
FROM dual
CONNECT BY level <= 16000;

COMMIT;

PAUSE

REM
REM Enable and gather incremental statistics at the table level
REM

BEGIN
  dbms_stats.set_table_prefs(ownname => user,
                             tabname => 't',
                             pname   => 'incremental',
                             pvalue  => 'TRUE');
END;
/

PAUSE

BEGIN
  dbms_stats.gather_table_stats(ownname     => user,
                                tabname     => 't', 
                                granularity => 'all');
END;
/

PAUSE

SELECT object_type || ' ' || nvl(subpartition_name, partition_name) AS object, 
       object_type, num_rows, blocks, avg_row_len, 
       to_char(last_analyzed, 'HH24:MI:SS') AS last_analyzed
FROM user_tab_statistics
WHERE table_name = 'T'
ORDER BY partition_name, subpartition_name;

PAUSE

REM
REM Insert data into a single subpartition 
REM

INSERT INTO t SELECT * FROM t SUBPARTITION (q1_sp1);

COMMIT;

PAUSE

REM
REM Wait a couple of seconds (just to make sure that the last_analyzed column shows 
REM a different value) and re-gather statistics
REM

BEGIN
  dbms_lock.sleep(2);
  dbms_stats.gather_table_stats(ownname     => user,
                                tabname     => 't', 
                                granularity => 'all');
END;
/

PAUSE

SELECT object_type || ' ' || nvl(subpartition_name, partition_name) AS object, 
       object_type, num_rows, blocks, avg_row_len, 
       to_char(last_analyzed, 'HH24:MI:SS') AS last_analyzed
FROM user_tab_statistics
WHERE table_name = 'T'
ORDER BY partition_name, subpartition_name;

PAUSE

REM
REM As of 12c, with the incremental_staleness preference, it is possible
REM to control when statistics are considered stale
REM

REM incremental_staleness=NULL (default): any change makes the statistics stale (as in 11g)

BEGIN
  dbms_stats.set_table_prefs(ownname => user,
                             tabname => 't',
                             pname   => 'incremental_staleness',
                             pvalue  => '');
END;
/

PAUSE

INSERT INTO t SELECT * FROM t SUBPARTITION (q1_sp1) WHERE rownum <= 100;

COMMIT;

PAUSE

BEGIN
  dbms_lock.sleep(2);
  dbms_stats.gather_table_stats(ownname     => user,
                                tabname     => 't', 
                                granularity => 'all');
END;
/

PAUSE

REM the statistics were gathered

SELECT object_type || ' ' || nvl(subpartition_name, partition_name) AS object, 
       object_type, num_rows, blocks, avg_row_len, 
       to_char(last_analyzed, 'HH24:MI:SS') AS last_analyzed
FROM user_tab_statistics
WHERE table_name = 'T'
ORDER BY partition_name, subpartition_name;

PAUSE

REM incremental_staleness=use_stale_percent: the value specified with the stale_percent preference is used

BEGIN
  dbms_stats.set_table_prefs(ownname => user,
                             tabname => 't',
                             pname   => 'incremental_staleness',
                             pvalue  => 'use_stale_percent');
END;
/

PAUSE

INSERT INTO t SELECT * FROM t SUBPARTITION (q1_sp1) WHERE rownum <= 100;

COMMIT;

PAUSE

BEGIN
  dbms_lock.sleep(2);
  dbms_stats.gather_table_stats(ownname     => user,
                                tabname     => 't', 
                                granularity => 'all');
END;
/

PAUSE

REM no statistics were gathered (100 < num_rows*stale_percent/100)

SELECT dbms_stats.get_prefs('stale_percent', user, 't') AS stale_percent
FROM dual;

PAUSE

SELECT object_type || ' ' || nvl(subpartition_name, partition_name) AS object, 
       object_type, num_rows, blocks, avg_row_len, 
       to_char(last_analyzed, 'HH24:MI:SS') AS last_analyzed
FROM user_tab_statistics
WHERE table_name = 'T'
ORDER BY partition_name, subpartition_name;

PAUSE

REM In addition, with the value use_locked_stats, you can define that statistics associated
REM to partitions (or subpartitions) with locked statistics are never considered stale

BEGIN
  dbms_stats.set_table_prefs(ownname => user,
                             tabname => 't',
                             pname   => 'incremental_staleness',
                             pvalue  => 'use_stale_percent, use_locked_stats');
END;
/

PAUSE

REM
REM Cleanup
REM

DROP TABLE t PURGE;
