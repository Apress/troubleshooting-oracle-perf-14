SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: host_load_setup.sql
REM Author......: Christian Antognini
REM Date........: May 2014
REM Description.: This script installs the HOST_LOAD function as well as some
REM               related objects used by the host_load.sql script. The script
REM               has to be executed as SYS.
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

@@host_load_teardown.sql

CREATE TYPE t_host_load AS OBJECT (
	begin_time DATE, 
	duration NUMBER, 
	db_fg_cpu NUMBER,
	db_bg_cpu NUMBER,
	non_db_cpu NUMBER,
	os_load NUMBER,
	num_cpu NUMBER
);
/

CREATE TYPE t_host_load_tab IS TABLE OF t_host_load;
/

CREATE OR REPLACE FUNCTION host_load(p_count IN NUMBER DEFAULT 1) -- number of samples (1 sample per minute)
  RETURN t_host_load_tab                                          -- set p_count to 0 to loop forever
  PIPELINED
AS
	l_begin_time DATE;
	l_duration NUMBER; 
	l_db_fg_cpu NUMBER;
	l_db_bg_cpu NUMBER;
	l_non_db_cpu NUMBER;
	l_os_load NUMBER;
	l_num_cpu NUMBER;
	l_samples INTEGER := 0;
	l_previous_time DATE := sysdate-1; 
BEGIN
  BEGIN
    SELECT value INTO l_num_cpu
    FROM v$osstat 
    WHERE stat_name = 'NUM_CPU_CORES';
  EXCEPTION
    WHEN no_data_found THEN
      SELECT value INTO l_num_cpu
      FROM v$osstat 
      WHERE stat_name = 'NUM_CPUS';
  END;
  LOOP  
    SELECT begin_time, 
           duration, 
           db_fg, 
           db_bg, 
           host - db_fg - db_bg AS non_db, 
           os_load
        INTO l_begin_time,
             l_duration,
             l_db_fg_cpu,
             l_db_bg_cpu,
             l_non_db_cpu,
             l_os_load
    FROM (
      SELECT begin_time, 
             intsize_csec/100 AS duration,
             sum(case when metric_name = 'Host CPU Usage Per Sec' then value/100 else 0 end) AS host, 
             sum(case when metric_name = 'CPU Usage Per Sec' then value/100 else 0 end) AS db_fg, 
             sum(case when metric_name = 'Background CPU Usage Per Sec' then value/100 else 0 end) AS db_bg,
             sum(case when metric_name = 'Current OS Load' then value else 0 end) AS os_load
      FROM v$metric
      WHERE group_id = (SELECT group_id FROM v$metricgroup WHERE name = 'System Metrics Long Duration')
      AND metric_name IN ('CPU Usage Per Sec', 
                          'Background CPU Usage Per Sec',
                          'Host CPU Usage Per Sec', 
                          'Current OS Load')
      GROUP BY begin_time, intsize_csec
    )
    ORDER BY begin_time;
    IF l_previous_time < l_begin_time
    THEN
      PIPE ROW(t_host_load(l_begin_time,
                           l_duration,
                           l_db_fg_cpu,
                           l_db_bg_cpu,
                           l_non_db_cpu,
                           l_os_load,
                           l_num_cpu));
      l_samples := l_samples + 1;
    END IF;
    EXIT WHEN l_samples = p_count;
    l_previous_time := l_begin_time;
    dbms_lock.sleep(5);
  END LOOP;
  RETURN;
END host_load;
/

SHOW ERROR

CREATE PUBLIC SYNONYM host_load FOR host_load;

GRANT EXECUTE ON host_load TO PUBLIC;
