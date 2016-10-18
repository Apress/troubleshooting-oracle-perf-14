SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: selectivity.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This scripts provides the examples shown in the section
REM                "Defining Selectivity."
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
SET FEEDBACK ON
SET VERIFY OFF
SET SCAN ON

@../connect.sql

COLUMN pad FORMAT a20 TRUNCATE

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t;

execute dbms_random.seed(0)

CREATE TABLE t
AS
SELECT rownum AS id,
       round(5678+dbms_random.normal*1234) AS n1,
       mod(255+trunc(dbms_random.normal*1000),255) AS n2,
       dbms_random.string('p',255) AS pad
FROM dual
CONNECT BY level <= 10000
ORDER BY dbms_random.value;

ALTER TABLE t ADD CONSTRAINT t_pk PRIMARY KEY (id);
CREATE INDEX t_n2_i ON t (n2);

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
REM
REM

SELECT * FROM t

PAUSE

/

REM selectivity = 10000/10000 = 1

PAUSE

SELECT * FROM t WHERE n1 BETWEEN 6000 AND 7000

PAUSE

/

REM selectivity = 2601/10000 = 0.2601

PAUSE

SELECT * FROM t WHERE n1 = 19;

REM selectivity = 0/10000 = 0

PAUSE

SELECT sum(n2) FROM t WHERE n1 BETWEEN 6000 AND 7000;

REM selectivity <> 1/10000
REM selectivity = 2601/10000 = 0.2601

PAUSE

SELECT count(*) FROM t WHERE n1 BETWEEN 6000 AND 7000;

PAUSE

REM
REM Cleanup
REM

UNDEFINE sql_id

DROP TABLE t;
PURGE TABLE t;
