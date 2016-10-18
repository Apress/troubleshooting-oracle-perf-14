SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: px_calibrate_io.sql
REM Author......: Christian Antognini
REM Date........: December 2013
REM Description.: Run I/O calibration and show gathered statistics.
REM Notes.......: Oracle Database 11g or newer is required.
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
SET SCAN ON
SET VERIFY OFF

COLUMN calibration_time FORMAT A25
COLUMN start_time FORMAT A28
COLUMN end_time FORMAT A28
COLUMN duration FORMAT A26

@../connect.sql

SET SERVEROUTPUT ON
SET ECHO ON

REM
REM Show status before running calibration
REM

SELECT * 
FROM v$io_calibration_status;

SELECT start_time, end_time, end_time-start_time AS duration
FROM dba_rsrc_io_calibrate;

SELECT max_iops, max_mbps, max_pmbps, latency, num_physical_disks
FROM dba_rsrc_io_calibrate;

PAUSE

REM
REM Run calibration
REM

DECLARE
  l_max_iops PLS_INTEGER;
  l_max_mbps PLS_INTEGER;
  l_actual_latency PLS_INTEGER;
BEGIN
  dbms_resource_manager.calibrate_io(
    num_physical_disks => &num_physical_disks, 
    max_latency        => 20, -- default value
    max_iops           => l_max_iops,
    max_mbps           => l_max_mbps,
    actual_latency     => l_actual_latency
  );
  dbms_output.put_line('max_iops = ' || l_max_iops);
  dbms_output.put_line('max_mbps = ' || l_max_mbps);
  dbms_output.put_line('actual_latency = ' || l_actual_latency);
END;
/

PAUSE

REM
REM Show status after running calibration
REM

SELECT * 
FROM v$io_calibration_status;

SELECT start_time, end_time, end_time-start_time AS duration
FROM dba_rsrc_io_calibrate;

SELECT max_iops, max_mbps, max_pmbps, latency, num_physical_disks
FROM dba_rsrc_io_calibrate;
