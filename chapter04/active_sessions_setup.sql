SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: active_sessions_setup.sql
REM Author......: Christian Antognini
REM Date........: October 2011
REM Description.: This script installs the objects required by the  
REM               active_sessions.sql script. It has to be executed as SYS.
REM Notes.......: -
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 29.06.2014 To provide 10g compatibility replaced REGEXP_SUBSTR with SUBSTR
REM ***************************************************************************

SET ECHO ON

@@active_sessions_teardown.sql

CREATE TYPE t_sess_time_model AS OBJECT (sid NUMBER, value NUMBER);
/

CREATE TYPE t_sess_time_model_tab IS TABLE OF t_sess_time_model;
/

CREATE TYPE t_active_session AS OBJECT (tstamp DATE, sessions NUMBER, logins NUMBER, sid VARCHAR2(30), username VARCHAR2(30), program VARCHAR2(48), activity NUMBER);
/

CREATE TYPE t_active_session_tab IS TABLE OF t_active_session;
/

CREATE FUNCTION active_sessions(p_interval IN NUMBER DEFAULT 15, -- wait 15s between two snapshots
                                p_count IN NUMBER DEFAULT 1,     -- take 1 snapshot
                                p_top IN NUMBER DEFAULT 10)      -- show top-10 sessions only
  RETURN t_active_session_tab
  PIPELINED
AS
  l_snap1 t_sess_time_model_tab;
  l_snap2 t_sess_time_model_tab;
  l_tstamp DATE;
  l_tot_db_time1 NUMBER;
  l_tot_db_time2 NUMBER;
  l_tot_db_time NUMBER;
  l_logons_cum1 NUMBER;
  l_logons_cum2 NUMBER;
  l_logons_cur NUMBER;
BEGIN
  SELECT value 
  INTO l_logons_cum1
  FROM v$sysstat 
  WHERE name = 'logons cumulative';

  SELECT t_sess_time_model(sid, sum(value)*1E-6) 
  BULK COLLECT INTO l_snap1
  FROM v$sess_time_model
  WHERE stat_name IN ('DB time','background elapsed time')
  GROUP BY sid;
  
  SELECT sum(value)*1E-6
  INTO l_tot_db_time1
  FROM v$sys_time_model
  WHERE stat_name IN ('DB time','background elapsed time');
  
  FOR i IN 1..p_count
  LOOP  
    dbms_lock.sleep(p_interval);

    SELECT value 
    INTO l_logons_cur
    FROM v$sysstat 
    WHERE name = 'logons current';
    
    SELECT value 
    INTO l_logons_cum2
    FROM v$sysstat 
    WHERE name = 'logons cumulative';
    
    SELECT t_sess_time_model(sid, sum(value)*1E-6) 
    BULK COLLECT INTO l_snap2
    FROM v$sess_time_model
    WHERE stat_name IN ('DB time','background elapsed time')
    GROUP BY sid;
  
    SELECT sum(value)*1E-6, sysdate
    INTO l_tot_db_time2, l_tstamp
    FROM v$sys_time_model
    WHERE stat_name IN ('DB time','background elapsed time');

    l_tot_db_time := l_tot_db_time2-l_tot_db_time1;
    FOR r IN (SELECT stm.sid AS sid,
                     s.username AS username,
                     decode(s.type,'BACKGROUND',substr(program,instr(program,'(')+1,4),program) AS program,
                     sum(stm.db_time) AS db_time,
                     sum(stm.activity) AS activity
              FROM (SELECT sid,
                           db_time,
                           db_time/nullif(l_tot_db_time,0)*100 AS activity
                    FROM (WITH 
                            active_sessions AS (
                              SELECT snap2.sid,
                                     snap2.value-nvl(snap1.value,0) AS db_time
                              FROM table(l_snap1) snap1 
                                   RIGHT OUTER JOIN table(l_snap2) snap2 ON snap1.sid = snap2.sid
                            )
                          /* active sessions */
                          SELECT to_char(sid) AS sid,
                                 db_time
                          FROM active_sessions
                          UNION ALL
                          /* closed sessions */
                          SELECT 'Unknown' AS sid,
                                 l_tot_db_time-sum(db_time) AS db_time
                          FROM active_sessions)
                    ORDER BY db_time DESC) stm
                    LEFT OUTER JOIN v$session s ON to_char(s.sid) = stm.sid
              WHERE rownum <= p_top
              GROUP BY rollup((stm.sid, s.type, s.program, s.username))
              ORDER BY grouping(sid),
                       db_time DESC)
    LOOP
      PIPE ROW(t_active_session(l_tstamp, 
                                l_logons_cur,
                                l_logons_cum2-l_logons_cum1,
                                nvl(r.sid,'Top-'||p_top||' Total'),
                                r.username,
                                r.program,
                                r.activity));
    END LOOP;
    l_logons_cum1 := l_logons_cum2;
    l_snap1 := l_snap2;    
    l_tot_db_time1 := l_tot_db_time2;
  END LOOP;
  RETURN;
END active_sessions;
/

SHOW ERROR

CREATE PUBLIC SYNONYM active_sessions FOR active_sessions;

GRANT EXECUTE ON active_sessions TO PUBLIC;
