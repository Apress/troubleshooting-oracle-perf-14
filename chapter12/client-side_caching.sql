SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: client-side_caching.sql
REM Author......: Christian Antognini
REM Date........: June 2010
REM Description.: This file is used to check when a SQL statement executed
REM               through PL/SQL can use client-side statement caching.
REM Notes.......: -
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 12.03.2012 Changed gathering of session-level statistics 
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

UNDEFINE parses_tot
UNDEFINE cache_hits_tot

DEFINE parses_tot = 0
DEFINE cache_hits_tot = 0

COLUMN parses_tot NEW_VALUE parses_tot
COLUMN cache_hits_tot NEW_VALUE cache_hits_tot

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t;

execute dbms_random.seed(0)

CREATE TABLE t
AS
SELECT rownum AS val,
       dbms_random.string('p',100) AS pad
FROM dual
CONNECT BY level <= 10000
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

ALTER SESSION SET session_cached_cursors = &session_cached_cursors;

SELECT sum(decode(name,'parse count (total)',value,0)) AS parses_tot,
       sum(decode(name,'parse count (total)',value,0))-&parses_tot AS parses_diff,
       sum(decode(name,'session cursor cache hits',value,0)) AS cache_hits_tot,
       sum(decode(name,'session cursor cache hits',value,0))-&cache_hits_tot AS cache_hits_diff
FROM v$mystat JOIN v$statname USING (statistic#)
WHERE name IN ('parse count (total)','session cursor cache hits');

PAUSE

REM
REM  S T A T I C   S Q L
REM

REM In 9i server-side statement caching is controlled by the initialization
REM parameter open_cursors. Therefore it is not possible to disable it.

DECLARE
  CURSOR c (p_val NUMBER) IS SELECT pad FROM t WHERE val = p_val;
  l_pad VARCHAR2(4000);
BEGIN
  FOR i IN 1..10000 
  LOOP
    OPEN c(i);
    FETCH c INTO l_pad;
    CLOSE c;
  END LOOP;
END;
/

SELECT sum(decode(name,'parse count (total)',value,0)) AS parses_tot,
       sum(decode(name,'parse count (total)',value,0))-&parses_tot AS parses_diff,
       sum(decode(name,'session cursor cache hits',value,0)) AS cache_hits_tot,
       sum(decode(name,'session cursor cache hits',value,0))-&cache_hits_tot AS cache_hits_diff
FROM v$mystat JOIN v$statname USING (statistic#)
WHERE name IN ('parse count (total)','session cursor cache hits');

PAUSE

DECLARE
  l_pad VARCHAR2(4000);
BEGIN
  FOR i IN 1..10000 
  LOOP
    SELECT pad INTO l_pad 
    FROM t 
    WHERE val = i;
  END LOOP;
END;
/

SELECT sum(decode(name,'parse count (total)',value,0)) AS parses_tot,
       sum(decode(name,'parse count (total)',value,0))-&parses_tot AS parses_diff,
       sum(decode(name,'session cursor cache hits',value,0)) AS cache_hits_tot,
       sum(decode(name,'session cursor cache hits',value,0))-&cache_hits_tot AS cache_hits_diff
FROM v$mystat JOIN v$statname USING (statistic#)
WHERE name IN ('parse count (total)','session cursor cache hits');

PAUSE

REM the following code is a bit different than the others because it fetches all rows

DECLARE
  TYPE t_pad IS TABLE OF VARCHAR2(4000);
  l_pad t_pad;
BEGIN
  FOR i IN 1..10000 
  LOOP
    BEGIN
      SELECT pad BULK COLLECT INTO l_pad FROM t WHERE val = i;
    EXCEPTION
      WHEN no_data_found THEN NULL;
    END;
  END LOOP;
END;
/

SELECT sum(decode(name,'parse count (total)',value,0)) AS parses_tot,
       sum(decode(name,'parse count (total)',value,0))-&parses_tot AS parses_diff,
       sum(decode(name,'session cursor cache hits',value,0)) AS cache_hits_tot,
       sum(decode(name,'session cursor cache hits',value,0))-&cache_hits_tot AS cache_hits_diff
FROM v$mystat JOIN v$statname USING (statistic#)
WHERE name IN ('parse count (total)','session cursor cache hits');

PAUSE

REM
REM  N A T I V E   D Y N A M I C   S Q L
REM

DECLARE
  TYPE t_cursor IS REF CURSOR;
  l_cursor t_cursor;
  l_pad VARCHAR2(4000);
BEGIN
  FOR i IN 1..10000 
  LOOP
    OPEN l_cursor FOR 'SELECT pad FROM t WHERE val = :1' USING i;
    FETCH l_cursor INTO l_pad;
    CLOSE l_cursor;
  END LOOP;
END;
/

SELECT sum(decode(name,'parse count (total)',value,0)) AS parses_tot,
       sum(decode(name,'parse count (total)',value,0))-&parses_tot AS parses_diff,
       sum(decode(name,'session cursor cache hits',value,0)) AS cache_hits_tot,
       sum(decode(name,'session cursor cache hits',value,0))-&cache_hits_tot AS cache_hits_diff
FROM v$mystat JOIN v$statname USING (statistic#)
WHERE name IN ('parse count (total)','session cursor cache hits');

PAUSE

DECLARE
  l_pad VARCHAR2(4000);
BEGIN
  FOR i IN 1..10000 
  LOOP
    EXECUTE IMMEDIATE 'SELECT pad FROM t WHERE val = :1' INTO l_pad USING i;
  END LOOP;
END;
/

SELECT sum(decode(name,'parse count (total)',value,0)) AS parses_tot,
       sum(decode(name,'parse count (total)',value,0))-&parses_tot AS parses_diff,
       sum(decode(name,'session cursor cache hits',value,0)) AS cache_hits_tot,
       sum(decode(name,'session cursor cache hits',value,0))-&cache_hits_tot AS cache_hits_diff
FROM v$mystat JOIN v$statname USING (statistic#)
WHERE name IN ('parse count (total)','session cursor cache hits');

PAUSE

REM the following code is a bit different than the others because it fetches all rows

DECLARE
  TYPE t_pad IS TABLE OF VARCHAR2(4000);
  l_pad t_pad;
BEGIN
  FOR i IN 1..10000 
  LOOP
    BEGIN
      EXECUTE IMMEDIATE 'SELECT pad FROM t WHERE val = :1' 
      BULK COLLECT INTO l_pad USING i;
    EXCEPTION
      WHEN no_data_found THEN NULL;
    END;
  END LOOP;
END;
/

SELECT sum(decode(name,'parse count (total)',value,0)) AS parses_tot,
       sum(decode(name,'parse count (total)',value,0))-&parses_tot AS parses_diff,
       sum(decode(name,'session cursor cache hits',value,0)) AS cache_hits_tot,
       sum(decode(name,'session cursor cache hits',value,0))-&cache_hits_tot AS cache_hits_diff
FROM v$mystat JOIN v$statname USING (statistic#)
WHERE name IN ('parse count (total)','session cursor cache hits');

PAUSE

REM
REM  P A C K A G E   D B M S _ S Q L
REM

DECLARE
  l_cursor INTEGER;
  l_pad VARCHAR2(4000);
  l_retval INTEGER;
BEGIN
  FOR i IN 1..10000
  LOOP
    l_cursor := dbms_sql.open_cursor;
    dbms_sql.parse(l_cursor, 'SELECT pad FROM t WHERE val = :1', 1);
    dbms_sql.define_column(l_cursor, 1, l_pad, 10);
    dbms_sql.bind_variable(l_cursor, ':1', i);
    l_retval := dbms_sql.execute(l_cursor);
    IF dbms_sql.fetch_rows(l_cursor) > 0 
    THEN  
      NULL;
    END IF;
    dbms_sql.close_cursor(l_cursor);
  END LOOP;
END;
/

SELECT sum(decode(name,'parse count (total)',value,0)) AS parses_tot,
       sum(decode(name,'parse count (total)',value,0))-&parses_tot AS parses_diff,
       sum(decode(name,'session cursor cache hits',value,0)) AS cache_hits_tot,
       sum(decode(name,'session cursor cache hits',value,0))-&cache_hits_tot AS cache_hits_diff
FROM v$mystat JOIN v$statname USING (statistic#)
WHERE name IN ('parse count (total)','session cursor cache hits');

PAUSE

REM
REM Cleanup
REM

DROP TABLE t;
PURGE TABLE t;

UNDEFINE parses_tot
UNDEFINE cache_hits_tot
