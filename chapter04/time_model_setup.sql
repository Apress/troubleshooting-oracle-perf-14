SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: time_model_setup.sql
REM Author......: Christian Antognini
REM Date........: October 2011
REM Description.: This script installs the objects required by the  
REM               time_model.sql script. It has to be executed as SYS.
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

SET ECHO ON

@@time_model_teardown.sql

CREATE TYPE t_sys_time_model AS OBJECT (stat_name VARCHAR2(64), value NUMBER);
/

CREATE TYPE t_sys_time_model_tab IS TABLE OF t_sys_time_model;
/

CREATE TYPE t_time_model AS OBJECT (tstamp DATE, stat_name VARCHAR2(64), aas NUMBER, activity NUMBER);
/

CREATE TYPE t_time_model_tab IS TABLE OF t_time_model;
/

CREATE FUNCTION time_model(p_interval IN NUMBER DEFAULT 15,  -- wait 15s between two snapshots
                           p_count IN NUMBER DEFAULT 1)      -- take 1 snapshot
  RETURN t_time_model_tab
  PIPELINED
AS
  l_snap1 t_sys_time_model_tab;
  l_snap2 t_sys_time_model_tab;
  l_tstamp DATE;
  l_tot_db_time NUMBER;
BEGIN
  SELECT t_sys_time_model(stat_name, value*1E-6) BULK COLLECT 
  INTO l_snap1
  FROM v$sys_time_model;

  FOR i IN 1..p_count
  LOOP  
    dbms_lock.sleep(p_interval);
    
    SELECT t_sys_time_model(stat_name, value*1E-6) BULK COLLECT 
    INTO l_snap2
    FROM v$sys_time_model;
    
    SELECT sum(snap2.value-snap1.value), sysdate
    INTO l_tot_db_time, l_tstamp
    FROM table(l_snap1) snap1
         JOIN table(l_snap2) snap2 ON snap1.stat_name = snap2.stat_name
    WHERE snap1.stat_name IN ('DB time','background elapsed time');
    
    FOR r IN (SELECT rpad('.',level-1,'.')||stat_name AS stat_name,
                     aas,
                     activity
              FROM (SELECT snap1.stat_name AS stat_name,
                           (snap2.value-snap1.value)/nullif(p_interval,0) AS aas,
                           (snap2.value-snap1.value)/nullif(l_tot_db_time,0)*100 AS activity,
                           decode(snap1.stat_name,
                                  'background elapsed time', 101,
                                  'background cpu time', 102,
                                  'RMAN cpu time (backup/restore', 103,
                                  'DB time', 4,
                                  'DB CPU', 5,
                                  'connection management call elapsed time', 6,
                                  'sequence load elapsed time', 7,
                                  'sql execute elapsed time', 8,
                                  'parse time elapsed', 9,
                                  'hard parse elapsed time', 10,
                                  'hard parse (sharing criteria) elapsed time', 11,
                                  'hard parse (bind mismatch) elapsed time', 12,
                                  'failed parse elapsed time', 13,
                                  'failed parse (out of shared memory) elapsed time', 14,
                                  'PL/SQL execution elapsed time', 15,
                                  'inbound PL/SQL rpc elapsed time', 16,
                                  'PL/SQL compilation elapsed time', 17,
                                  'Java execution elapsed time', 18,
                                  'repeated bind elapsed time', 19) AS id,
                           decode(snap1.stat_name,
                                  'background elapsed time', NULL,
                                  'background cpu time', 101,
                                  'RMAN cpu time (backup/restore)', 102,
                                  'DB time', NULL,
                                  'DB CPU', 4,
                                  'connection management call elapsed time', 4,
                                  'sequence load elapsed time', 4,
                                  'sql execute elapsed time', 4,
                                  'parse time elapsed', 4,
                                  'hard parse elapsed time', 9,
                                  'hard parse (sharing criteria) elapsed time', 10,
                                  'hard parse (bind mismatch) elapsed time', 11,
                                  'failed parse elapsed time', 9,
                                  'failed parse (out of shared memory) elapsed time', 13,
                                  'PL/SQL execution elapsed time', 4,
                                  'inbound PL/SQL rpc elapsed time', 4,
                                  'PL/SQL compilation elapsed time', 4,
                                  'Java execution elapsed time', 4,
                                  'repeated bind elapsed time', 4) AS parent_id
                    FROM table(l_snap1) snap1,
                         table(l_snap2) snap2
                    WHERE snap1.stat_name = snap2.stat_name)
              CONNECT BY parent_id = PRIOR id
              START WITH parent_id IS NULL
              ORDER SIBLINGS BY id)
    LOOP
      PIPE ROW(t_time_model(l_tstamp, r.stat_name, r.aas, r.activity));
    END LOOP;
    l_snap1 := l_snap2;
  END LOOP;
END time_model;
/

SHOW ERROR

CREATE PUBLIC SYNONYM time_model FOR time_model;

GRANT EXECUTE ON time_model TO PUBLIC;
