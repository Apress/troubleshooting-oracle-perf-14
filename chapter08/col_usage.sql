SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: col_usage.sql
REM Author......: Christian Antognini
REM Date........: March 2009
REM Description.: This script shows how to retrieve information about the
REM               column usage history from the data dictionary.
REM Notes.......: -
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 07.05.2014 Added "dbms_random.seed(0)" in the setup part + removed
REM            to sys.user$ + added reset_col_usage and report_col_usage
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON
SET NUMWIDTH 6
SET LONG 100000

COLUMN name FORMAT A13
COLUMN timestamp FORMAT A9

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t;

execute dbms_random.seed(0)

CREATE TABLE t
AS
SELECT rownum AS id,
       round(dbms_random.normal*1000) AS val1,
       100+round(ln(rownum/3.25+2)) AS val2,
       100+round(ln(rownum/3.25+2)) AS val3,
       dbms_random.string('p',250) AS pad
FROM dual
CONNECT BY level <= 1000
ORDER BY dbms_random.value;

execute dbms_stats.gather_table_stats(user, 'T')

PAUSE

REM
REM Run some queries with different kind of predicates
REM

SELECT count(*) FROM t WHERE id = 1;
SELECT count(*) FROM t t1, t t2 WHERE t1.id = t2.id;
SELECT count(*) FROM t WHERE val1 = 1;
SELECT count(*) FROM t WHERE val3 = 1;
SELECT count(*) FROM t WHERE val1 = 1 AND val3 = 3;
SELECT count(*) FROM t t1, t t2 WHERE t1.val3 = t2.val3;
SELECT count(*) FROM t WHERE pad BETWEEN 'A' AND 'B';

PAUSE

REM
REM Flush column usage information
REM

execute dbms_stats.flush_database_monitoring_info

PAUSE

REM
REM Show column usage information for table T
REM

COLUMN name FORMAT A4
COLUMN timestamp FORMAT A9
COLUMN equality FORMAT 9999
COLUMN equijoin FORMAT 9999
COLUMN noneequijoin FORMAT 9999
COLUMN range FORMAT 9999
COLUMN "LIKE" FORMAT 9999
COLUMN "NULL" FORMAT 9999

SELECT c.name, cu.timestamp,
       cu.equality_preds AS equality, cu.equijoin_preds AS equijoin,
       cu.nonequijoin_preds AS noneequijoin, cu.range_preds AS range,
       cu.like_preds AS "LIKE", cu.null_preds AS "NULL"
FROM sys.col$ c, sys.col_usage$ cu, sys.obj$ o, dba_users u
WHERE c.obj# = cu.obj# (+)
AND c.intcol# = cu.intcol# (+)
AND c.obj# = o.obj#
AND o.owner# = u.user_id
AND o.name = 'T'
AND u.username = user
ORDER BY c.col#;

PAUSE

REM This query works as of 11.2.0.2 only

SELECT dbms_stats.report_col_usage(ownname => user, tabname => 't')
FROM dual;

PAUSE

REM
REM Reset column usage information for table T
REM

execute dbms_stats.reset_col_usage(ownname => user, tabname => 't')

PAUSE

SELECT dbms_stats.report_col_usage(ownname => user, tabname => 't')
FROM dual;

PAUSE

REM
REM Cleanup
REM

DROP TABLE t;
PURGE TABLE t;
