SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: index_only_scan_list_part.sql
REM Author......: Christian Antognini
REM Date........: November 2013
REM Description.: This script shows that for getting an index-only scan with a 
REM               list partition table it may be necessary to add the partition 
REM               key to an index.
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
SET SCAN OFF

COLUMN pad FORMAT A10 TRUNCATE

@../connect.sql

DROP TABLE t PURGE;

SET ECHO ON

REM
REM Setup test environment
REM

CREATE TABLE t (
  id NUMBER,
  d1 DATE,
  n1 NUMBER,
  n2 NUMBER,
  n3 NUMBER,
  pad VARCHAR2(4000),
  CONSTRAINT t_pk PRIMARY KEY (id)
)
PARTITION BY LIST (n1) (
  PARTITION t_1 VALUES (1),
  PARTITION t_2 VALUES (2),
  PARTITION t_3 VALUES (3),
  PARTITION t_4 VALUES (4),
  PARTITION t_null VALUES (NULL)
);

PAUSE

execute dbms_random.seed(0)

INSERT INTO t 
SELECT rownum AS id,
       trunc(to_date('2013-01-01','YYYY-MM-DD')+rownum/27.4) AS d1,
       1+mod(rownum,4) AS n1,
       255+mod(trunc(dbms_random.normal*1000),255) AS n2,
       round(4515+dbms_random.normal*1234) AS n3,
       rpad('*',1000,'*') AS pad
FROM dual
CONNECT BY level <= 10000
ORDER BY dbms_random.value;

PAUSE

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

PAUSE

REM
REM Index without partition key (n1)
REM

CREATE INDEX i ON t (n2, n3) LOCAL;

PAUSE

REM Equality: index-only scan takes place (except in 10.2.0.1)

SELECT n3 FROM t WHERE n1 = 1 AND n2 = 2;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'basic'));

PAUSE

REM IN condition: index-only scan does not take place

SELECT n3 FROM t WHERE n1 IN (1, 2) AND n2 = 2;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'basic'));

PAUSE

DROP INDEX i;

REM
REM Index with partition key (n1)
REM

CREATE INDEX i ON t (n2, n3, n1) LOCAL;

PAUSE

REM Equality: index-only scan takes place

SELECT n3 FROM t WHERE n1 = 1 AND n2 = 2;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'basic'));

PAUSE

REM IN condition: index-only scan takes place

SELECT n3 FROM t WHERE n1 IN (1, 2) AND n2 = 2;

PAUSE

SELECT * FROM table(dbms_xplan.display_cursor(NULL, NULL, 'basic'));

PAUSE

REM
REM Cleanup
REM

DROP TABLE t PURGE;
