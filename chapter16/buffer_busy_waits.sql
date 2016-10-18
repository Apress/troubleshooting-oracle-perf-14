SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: buffer_busy_waits.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows an example of processing that causes plenty
REM               of buffer busy waits events.
REM Notes.......: Execute the following SQL statements as SYSDBA before
REM               executing this script: 
REM                 GRANT EXECUTE ON dbms_lock TO &user;
REM                 GRANT ALTER SESSION TO &user;
REM               In addition make sure that the initialization parameter
REM               JOB_QUEUE_PROCESSES is set to cpu_count or a higher value.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 27.11.2013 Made the number of parallel jobs equal to CPU_COUNT +
REM            Added configuration of TRACEFILE_IDENTIFIER + Remove 9i content
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

CREATE TABLE t (
  id NUMBER, 
  n1 NUMBER, 
  n2 NUMBER, 
  n3 NUMBER, 
  n4 NUMBER, 
  n5 NUMBER, 
  n6 NUMBER, 
  n7 NUMBER, 
  n8 NUMBER, 
  n9 NUMBER, 
  n10 NUMBER, 
  d DATE
);

INSERT INTO t
SELECT level, level, level, level, level, level, level, level, level, level, level, sysdate 
FROM dual 
CONNECT BY level <= 8;

ALTER TABLE t ADD CONSTRAINT t_pk PRIMARY KEY (id);

execute dbms_stats.gather_table_stats(tabname=>'t', ownname=>user)

REM Create a procedure performing some operations that stresses the test table

CREATE OR REPLACE PROCEDURE load(p_test IN VARCHAR2, p_session IN NUMBER, p_count IN NUMBER) IS
  l_ret NUMBER;
BEGIN
  l_ret := dbms_lock.request(p_session);
  
  IF (p_session = 1)
  THEN
    EXECUTE IMMEDIATE 'ALTER SESSION SET tracefile_identifier = ' || p_test;
    EXECUTE IMMEDIATE 'ALTER SESSION SET events ''10046 trace name context forever, level 8''';
  END IF;

  FOR i IN 1..p_count
  LOOP
    UPDATE /*+ index(t) */ t SET d = SYSDATE WHERE id = p_session AND n10 = id;
    COMMIT;
  END LOOP;

  IF (p_session = 1)
  THEN
    EXECUTE IMMEDIATE 'ALTER SESSION SET events ''10046 trace name context off''';
  END IF;
  
  l_ret := dbms_lock.release(p_session);
END;
/

SHOW ERRORS

ALTER SESSION SET plsql_warnings = 'disable:all';

PAUSE

REM
REM Run test
REM

SET TIMING ON

DECLARE
  l_job NUMBER;
  l_ret NUMBER;
  l_count NUMBER;
BEGIN
  SELECT value INTO l_count 
  FROM v$parameter 
  WHERE name = 'cpu_count';
  
  FOR i IN 1..l_count LOOP
    dbms_job.submit(l_job, 'load(''test1'','||i||',10000);');
  END LOOP;
  COMMIT;
  
  dbms_lock.sleep(10);
  
  FOR i IN 1..l_count LOOP
    l_ret := dbms_lock.request(i);
  END LOOP;
  
  FOR i IN 1..l_count LOOP
    l_ret := dbms_lock.release(i);
  END LOOP;
END;
/

SET TIMING OFF

PAUSE

REM
REM Rerun test after reorganizing the table and the index
REM

ALTER TABLE t MOVE PCTFREE 99 PCTUSED 1;

ALTER INDEX t_pk REBUILD;

PAUSE

SET TIMING ON

DECLARE
  l_job NUMBER;
  l_ret NUMBER;
  l_count NUMBER;
BEGIN
  SELECT value INTO l_count 
  FROM v$parameter 
  WHERE name = 'cpu_count';
  
  FOR i IN 1..l_count LOOP
    dbms_job.submit(l_job, 'load(''test2'','||i||',10000);');
  END LOOP;
  COMMIT;
  
  dbms_lock.sleep(10);
  
  FOR i IN 1..l_count LOOP
    l_ret := dbms_lock.request(i);
  END LOOP;
  
  FOR i IN 1..l_count LOOP
    l_ret := dbms_lock.release(i);
  END LOOP;
END;
/

SET TIMING OFF

REM
REM Cleanup
REM

DROP PROCEDURE load;

DROP TABLE t PURGE;
