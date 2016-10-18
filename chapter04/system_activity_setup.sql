SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: system_activity_setup.sql
REM Author......: Christian Antognini
REM Date........: October 2011
REM Description.: This script installs the objects required by the  
REM               system_activity.sql script. It has to be executed as SYS.
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

@@system_activity_teardown.sql

CREATE TYPE t_system_wait_class AS OBJECT (
  wait_class# NUMBER,
	wait_class VARCHAR2(64), 
	time_waited NUMBER
);
/

CREATE TYPE t_system_wait_class_tab IS TABLE OF t_system_wait_class;
/

CREATE TYPE t_system_activity AS OBJECT (
	tstamp DATE, 
	aas NUMBER, 
	time_waited_other NUMBER, 
	time_waited_queueing NUMBER,
	time_waited_network NUMBER,
	time_waited_administrative NUMBER,
	time_waited_configuration NUMBER, 
	time_waited_commit NUMBER,
	time_waited_application NUMBER, 
	time_waited_concurrency NUMBER,
	time_waited_cluster NUMBER,
	time_waited_system_io NUMBER,
	time_waited_user_io NUMBER,
	time_waited_scheduler NUMBER,
	time_cpu NUMBER
);
/

CREATE TYPE t_system_activity_tab IS TABLE OF t_system_activity;
/

CREATE FUNCTION system_activity(p_interval IN NUMBER DEFAULT 15, -- wait 15s between two snapshots
                                p_count IN NUMBER DEFAULT 1)     -- take 1 snapshot
  RETURN t_system_activity_tab
  PIPELINED
AS
  l_snap1 t_system_wait_class_tab;
  l_snap2 t_system_wait_class_tab;
  l_cpu1 NUMBER;
  l_cpu2 NUMBER;
  l_tstamp DATE;
  l_other NUMBER;
	l_queueing NUMBER;
	l_network NUMBER;
	l_administrative NUMBER;
	l_configuration NUMBER;
	l_commit NUMBER;
	l_application NUMBER;
	l_concurrency NUMBER;
	l_cluster NUMBER;
	l_system_io NUMBER;
	l_user_io NUMBER;
	l_scheduler NUMBER;
	l_total NUMBER;
BEGIN
  SELECT t_system_wait_class(wait_class#, wait_class, time_waited/1E2) 
  BULK COLLECT INTO l_snap1
  FROM v$system_wait_class
  WHERE wait_class <> 'Idle';
  
  SELECT sum(value)/1E6
  INTO l_cpu1
  FROM v$sys_time_model
  WHERE stat_name IN ('DB CPU','background cpu time');
	  
  FOR i IN 1..p_count
  LOOP  
    dbms_lock.sleep(p_interval);

	  SELECT t_system_wait_class(wait_class#, wait_class, time_waited/1E2) 
	  BULK COLLECT INTO l_snap2
	  FROM v$system_wait_class
	  WHERE wait_class <> 'Idle';

	  SELECT sum(value)/1E6, sysdate
	  INTO l_cpu2, l_tstamp
	  FROM v$sys_time_model
	  WHERE stat_name IN ('DB CPU','background cpu time');

	  l_other := 0;
		l_queueing := 0;
		l_network := 0;
		l_administrative := 0;
		l_configuration := 0;
		l_commit := 0;
		l_application := 0;
		l_concurrency := 0;
		l_cluster := 0;
		l_system_io := 0;
		l_user_io := 0;
		l_scheduler := 0;
		l_total := 0;
	  
    FOR r IN (SELECT snap1.wait_class,
                     snap2.time_waited-snap1.time_waited AS time_waited
              FROM table(l_snap1) snap1,
                   table(l_snap2) snap2
              WHERE snap1.wait_class# = snap2.wait_class#)
    LOOP
      CASE r.wait_class
				WHEN 'Other' THEN l_other := r.time_waited;
				WHEN 'Queueing' THEN l_queueing := r.time_waited;
				WHEN 'Network' THEN l_network := r.time_waited;
				WHEN 'Administrative' THEN l_administrative := r.time_waited;
				WHEN 'Configuration' THEN l_configuration := r.time_waited;
				WHEN 'Commit' THEN l_commit := r.time_waited;
				WHEN 'Application' THEN l_application := r.time_waited;
				WHEN 'Concurrency' THEN l_concurrency := r.time_waited;
				WHEN 'Cluster' THEN l_cluster := r.time_waited;
				WHEN 'System I/O' THEN l_system_io := r.time_waited;
				WHEN 'User I/O' THEN l_user_io := r.time_waited;
				WHEN 'Scheduler' THEN l_scheduler := r.time_waited;
			END CASE;
			l_total := l_total + r.time_waited;
    END LOOP;
    l_total := l_total + (l_cpu2 - l_cpu1);
    l_total := nullif(l_total,0); -- avoid ORA-01476: divisor is equal to zero
    PIPE ROW(t_system_activity(l_tstamp,
                               l_total/nullif(p_interval,0),
                               l_other/l_total*100,
                               l_queueing/l_total*100,
                               l_network/l_total*100,
                               l_administrative/l_total*100,
                               l_configuration/l_total*100,
                               l_commit/l_total*100,
                               l_application/l_total*100,
                               l_concurrency/l_total*100,
                               l_cluster/l_total*100,
                               l_system_io/l_total*100,
                               l_user_io/l_total*100,
                               l_scheduler/l_total*100,
                               (l_cpu2 - l_cpu1)/l_total*100));
    l_snap1 := l_snap2;    
    l_cpu1 := l_cpu2;
  END LOOP;
  RETURN;
END system_activity;
/

SHOW ERROR

CREATE PUBLIC SYNONYM system_activity FOR system_activity;

GRANT EXECUTE ON system_activity TO PUBLIC;
