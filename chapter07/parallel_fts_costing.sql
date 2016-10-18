SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: parallel_fts_costing.sql
REM Author......: Christian Antognini
REM Date........: October 2013
REM Description.: This script shows how the costs of parallel executions are
REM               computed.
REM Notes.......: The script changes the system statistics.
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
SET LINESIZE 100
SET PAGESIZE 100
SET ECHO ON

@../connect.sql

REM
REM Setup test environment
REM

VARIABLE cpuspeed NUMBER
VARIABLE sreadtim NUMBER
VARIABLE mreadtim NUMBER
VARIABLE mbrc NUMBER
VARIABLE maxthr NUMBER
VARIABLE slavethr NUMBER

VARIABLE max_dop NUMBER
VARIABLE serial_io_cost NUMBER
VARIABLE mreadthr NUMBER
VARIABLE fudge_factor NUMBER
VARIABLE version_fix NUMBER

DROP TABLE t CASCADE CONSTRAINTS PURGE;

CREATE TABLE t PCTFREE 90 PCTUSED 10 AS SELECT rownum AS id, rpad('*',1000,'*') AS pad FROM dual CONNECT BY level <= 10000;
INSERT /*+ append */ INTO t SELECT * FROM t;
COMMIT;
INSERT /*+ append */ INTO t SELECT * FROM t;
COMMIT;
INSERT /*+ append */ INTO t SELECT * FROM t;
COMMIT;
INSERT /*+ append */ INTO t SELECT * FROM t;
COMMIT;
INSERT /*+ append */ INTO t SELECT * FROM t;
COMMIT;

execute dbms_stats.gather_table_stats(user,'t')

DECLARE
  l_version       VARCHAR2(10);
  l_compatibility VARCHAR2(10);
BEGIN
  -- system statistics
  :cpuspeed := 2000;
  :sreadtim := 5;
  :mreadtim := 10;
  :mbrc := 42;
  -- maximum DOP used for the tests
  :max_dop := 42;
  -- serial I/O cost
  SELECT ceil(blocks/:mbrc*:mreadtim/:sreadtim+1) INTO :serial_io_cost
  FROM user_tables
  WHERE table_name = 'T';
  -- throughput of a single server process
  SELECT :mbrc*value/:mreadtim*1000 INTO :mreadthr
  FROM v$parameter
  WHERE name = 'db_block_size';
  -- fundge factor
  :fudge_factor := 0.9;
  -- database version
  dbms_utility.db_version(l_version, l_compatibility);
  IF replace(l_version,'.','') < 112040
  THEN
    :version_fix := 1000;
  ELSE
    :version_fix := 1;
  END IF;
END;
/

PAUSE

REM
REM Test 1: no MAXTHR, no SLAVETHR
REM

BEGIN
  :maxthr := NULL;
  :slavethr := NULL;
  dbms_stats.delete_system_stats();
  dbms_stats.set_system_stats(pname => 'CPUSPEED', pvalue => :cpuspeed);
  dbms_stats.set_system_stats(pname => 'SREADTIM', pvalue => :sreadtim);
  dbms_stats.set_system_stats(pname => 'MREADTIM', pvalue => :mreadtim);
  dbms_stats.set_system_stats(pname => 'MBRC',     pvalue => :mbrc);
  dbms_stats.set_system_stats(pname => 'MAXTHR',   pvalue => :maxthr);
  dbms_stats.set_system_stats(pname => 'SLAVETHR', pvalue => :slavethr);
END;
/

PAUSE

BEGIN
  DELETE plan_table;
  FOR i IN 1..:max_dop
  LOOP
    EXECUTE IMMEDIATE 'EXPLAIN PLAN SET STATEMENT_ID = ''' || i || ''' FOR SELECT /*+ parallel(t,' || i || ') */ * FROM t';
  END LOOP;
END;
/

PAUSE

SELECT dop, io_cost, my_io_cost, io_cost-my_io_cost AS diff
FROM (
  SELECT dop,
         io_cost,
         round(
           greatest(
             :serial_io_cost/(dop*:fudge_factor),                                          -- slavethr and maxthr unset
             :serial_io_cost/(dop*nvl((:slavethr*:version_fix)/:mreadthr,:fudge_factor)),  -- slavethr set
             :serial_io_cost*nvl(:mreadthr/(:maxthr*:version_fix),0)                       -- maxthr set
           )
         ) AS my_io_cost
  FROM (
    SELECT to_number(statement_id) AS dop, io_cost
    FROM plan_table
    WHERE id = 2
  )
)
ORDER BY dop;

PAUSE

REM
REM Test 2: no MAXTHR, SLAVETHR = 50% of the expected throughput of a single server process
REM         (50% has been arbitrarily chosen)
REM

BEGIN
  :maxthr := NULL;
  :slavethr := :mreadthr*0.5;
  dbms_stats.delete_system_stats();
  dbms_stats.set_system_stats(pname => 'CPUSPEED', pvalue => :cpuspeed);
  dbms_stats.set_system_stats(pname => 'SREADTIM', pvalue => :sreadtim);
  dbms_stats.set_system_stats(pname => 'MREADTIM', pvalue => :mreadtim);
  dbms_stats.set_system_stats(pname => 'MBRC',     pvalue => :mbrc);
  dbms_stats.set_system_stats(pname => 'MAXTHR',   pvalue => :maxthr);
  dbms_stats.set_system_stats(pname => 'SLAVETHR', pvalue => :slavethr);
END;
/

PAUSE

BEGIN
  DELETE plan_table;
  FOR i IN 1..:max_dop
  LOOP
    EXECUTE IMMEDIATE 'EXPLAIN PLAN SET STATEMENT_ID = ''' || i || ''' FOR SELECT /*+ parallel(t,' || i || ') */ * FROM t';
  END LOOP;
END;
/

PAUSE

SELECT dop, io_cost, my_io_cost, io_cost-my_io_cost AS diff
FROM (
  SELECT dop,
         io_cost,
         round(
           greatest(
             :serial_io_cost/(dop*:fudge_factor),                                          -- slavethr and maxthr unset
             :serial_io_cost/(dop*nvl((:slavethr*:version_fix)/:mreadthr,:fudge_factor)),  -- slavethr set
             :serial_io_cost*nvl(:mreadthr/(:maxthr*:version_fix),0)                       -- maxthr set
           )
         ) AS my_io_cost
  FROM (
    SELECT to_number(statement_id) AS dop, io_cost
    FROM plan_table
    WHERE id = 2
  )
)
ORDER BY dop;

PAUSE

REM
REM Test 3: MAXTHR = 25% of the expected throughput with dop=:max_dop, no SLAVETHR
REM         (25% has been arbitrarily chosen)
REM

BEGIN
  :maxthr := :mreadthr*:max_dop*0.25;
  :slavethr := NULL;
  dbms_stats.delete_system_stats();
  dbms_stats.set_system_stats(pname => 'CPUSPEED', pvalue => :cpuspeed);
  dbms_stats.set_system_stats(pname => 'SREADTIM', pvalue => :sreadtim);
  dbms_stats.set_system_stats(pname => 'MREADTIM', pvalue => :mreadtim);
  dbms_stats.set_system_stats(pname => 'MBRC',     pvalue => :mbrc);
  dbms_stats.set_system_stats(pname => 'MAXTHR',   pvalue => :maxthr);
  dbms_stats.set_system_stats(pname => 'SLAVETHR', pvalue => :slavethr);
END;
/

PAUSE

BEGIN
  DELETE plan_table;
  FOR i IN 1..:max_dop
  LOOP
    EXECUTE IMMEDIATE 'EXPLAIN PLAN SET STATEMENT_ID = ''' || i || ''' FOR SELECT /*+ parallel(t,' || i || ') */ * FROM t';
  END LOOP;
END;
/

PAUSE

SELECT dop, io_cost, my_io_cost, io_cost-my_io_cost AS diff
FROM (
  SELECT dop,
         io_cost,
         round(
           greatest(
             :serial_io_cost/(dop*:fudge_factor),                                          -- slavethr and maxthr unset
             :serial_io_cost/(dop*nvl((:slavethr*:version_fix)/:mreadthr,:fudge_factor)),  -- slavethr set
             :serial_io_cost*nvl(:mreadthr/(:maxthr*:version_fix),0)                       -- maxthr set
           )
         ) AS my_io_cost
  FROM (
    SELECT to_number(statement_id) AS dop, io_cost
    FROM plan_table
    WHERE id = 2
  )
)
ORDER BY dop;

PAUSE

REM
REM Test 4: MAXTHR = 25% of the expected throughput with dop=:max_dop
REM         SLAVETHR = 50% of the expected throughput of a single server process
REM         (25% and 50% has been arbitrarily chosen)
REM

BEGIN
  :maxthr := :mreadthr*:max_dop*0.25;
  :slavethr := :mreadthr*0.50;
  dbms_stats.delete_system_stats();
  dbms_stats.set_system_stats(pname => 'CPUSPEED', pvalue => :cpuspeed);
  dbms_stats.set_system_stats(pname => 'SREADTIM', pvalue => :sreadtim);
  dbms_stats.set_system_stats(pname => 'MREADTIM', pvalue => :mreadtim);
  dbms_stats.set_system_stats(pname => 'MBRC',     pvalue => :mbrc);
  dbms_stats.set_system_stats(pname => 'MAXTHR',   pvalue => :maxthr);
  dbms_stats.set_system_stats(pname => 'SLAVETHR', pvalue => :slavethr);
END;
/

PAUSE

BEGIN
  DELETE plan_table;
  FOR i IN 1..:max_dop
  LOOP
    EXECUTE IMMEDIATE 'EXPLAIN PLAN SET STATEMENT_ID = ''' || i || ''' FOR SELECT /*+ parallel(t,' || i || ') */ * FROM t';
  END LOOP;
END;
/

PAUSE

SELECT dop, io_cost, my_io_cost, io_cost-my_io_cost AS diff
FROM (
  SELECT dop,
         io_cost,
         round(
           greatest(
             :serial_io_cost/(dop*:fudge_factor),                                          -- slavethr and maxthr unset
             :serial_io_cost/(dop*nvl((:slavethr*:version_fix)/:mreadthr,:fudge_factor)),  -- slavethr set
             :serial_io_cost*nvl(:mreadthr/(:maxthr*:version_fix),0)                       -- maxthr set
           )
         ) AS my_io_cost
  FROM (
    SELECT to_number(statement_id) AS dop, io_cost
    FROM plan_table
    WHERE id = 2
  )
)
ORDER BY dop;

PAUSE

REM
REM Cleanup
REM

DROP TABLE t CASCADE CONSTRAINTS PURGE;
