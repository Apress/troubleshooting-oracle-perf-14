SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: system_stats_restore.sql
REM Author......: Christian Antognini
REM Date........: January 2013
REM Description.: This script shows how the restore_system_stats procedure
REM               works.
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

@../connect.sql

VARIABLE now VARCHAR2(14)

COLUMN pvalue FORMAT A30

SET ECHO ON

REM
REM Start with a fresh set of noworkload statistics
REM

BEGIN
  dbms_stats.delete_system_stats();
  dbms_stats.gather_system_stats('noworkload');
END;
/

PAUSE

SELECT pname, nvl(to_char(pval1),pval2) AS pvalue
FROM sys.aux_stats$;

PAUSE

REM
REM Record the current date and time
REM

BEGIN
  SELECT to_char(sysdate,'YYYYMMDDHH24MISS')
  INTO :now
  FROM dual;
END;
/

PAUSE

REM
REM Manually set noworkload statistics _and_ workload statistics  
REM

BEGIN
  dbms_stats.delete_system_stats();
  -- no workload
  dbms_stats.set_system_stats(pname => 'CPUSPEEDNW', pvalue => 772);
  dbms_stats.set_system_stats(pname => 'IOSEEKTIM', pvalue => 4);
  dbms_stats.set_system_stats(pname => 'IOTFRSPEED', pvalue => 50000);
  -- workload
  dbms_stats.set_system_stats(pname => 'CPUSPEED', pvalue => 772);
  dbms_stats.set_system_stats(pname => 'SREADTIM', pvalue => 5.5);
  dbms_stats.set_system_stats(pname => 'MREADTIM', pvalue => 19.4);
  dbms_stats.set_system_stats(pname => 'MBRC',      pvalue => 53);
  dbms_stats.set_system_stats(pname => 'MAXTHR',   pvalue => 1136136192);
  dbms_stats.set_system_stats(pname => 'SLAVETHR', pvalue => 16870400);
END;
/

PAUSE

SELECT pname, nvl(to_char(pval1),pval2) AS pvalue
FROM sys.aux_stats$;

PAUSE

REM
REM Restore to a previous point in time (notice that a delete is necessary!)
REM

BEGIN
  dbms_stats.restore_system_stats(to_date(:now,'YYYYMMDDHH24MISS'));
END;
/

PAUSE

SELECT pname, nvl(to_char(pval1),pval2) AS pvalue
FROM sys.aux_stats$;

PAUSE

BEGIN
  dbms_stats.delete_system_stats();
  dbms_stats.restore_system_stats(to_date(:now,'YYYYMMDDHH24MISS'));
END;
/

PAUSE

SELECT pname, nvl(to_char(pval1),pval2) AS pvalue
FROM sys.aux_stats$;

