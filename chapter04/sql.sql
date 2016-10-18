SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: sql.sql
REM Author......: Christian Antognini
REM Date........: January 2014
REM Description.: This script shows detailed information about a cursor.
REM Notes.......: The data is based on the v$sql dynamic performance view
REM Parameters..: &1: SQL id of the parent cursor
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 30.06.2014 Added header to the output
REM ***************************************************************************

SET TERMOUT OFF SERVEROUT ON LONG 1000000 LONGCHUNKSIZE 1000000 LINESIZE 90 VERIFY OFF FEEDBACK OFF HEADING OFF

COLUMN "Text" FORMAT A90 WRAP
COLUMN global_name NEW_VALUE global_name
COLUMN day NEW_VALUE day

SELECT global_name, to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') AS day
FROM global_name;

TTITLE CENTER '&global_name / &day' SKIP 2

SET TERMOUT ON
SELECT sql_fulltext AS "Text"
FROM v$sqlarea
WHERE sql_id = '&1';

DECLARE
  c_line CONSTANT INTEGER := 90;
  c_col1 CONSTANT INTEGER := 36;
  c_col2 CONSTANT INTEGER := 54;

  s v$sql%ROWTYPE;
  p VARCHAR2(100);

  PROCEDURE o(p_name IN VARCHAR2, p_value IN VARCHAR2) AS
  BEGIN
    dbms_output.put_line(rpad(p_name, c_col1) || lpad(p_value, c_col2));
  END;

  PROCEDURE o(p_name IN VARCHAR2, p_value1 IN VARCHAR2, p_value2 IN VARCHAR2, p_value3 IN VARCHAR2) AS
  BEGIN
    dbms_output.put_line(rpad(p_name, c_col1) || lpad(p_value1, c_col2/3) || lpad(p_value2, c_col2/3) || lpad(p_value3, c_col2/3));
  END;

  PROCEDURE o(p_text IN VARCHAR2) AS
  BEGIN
    o(p_text, cast(NULL AS VARCHAR2));
  END;

  PROCEDURE o(p_linesize IN INTEGER DEFAULT c_line) AS
  BEGIN
    dbms_output.put_line(rpad('-', p_linesize, '-'));
  END;

  PROCEDURE o(p_name IN VARCHAR2, p_value IN NUMBER, p_integer IN BOOLEAN DEFAULT TRUE) AS
  BEGIN
    IF p_integer
    THEN
      o(p_name, to_char(round(p_value, 0), '9,999,999,999,999'));
    ELSE
      o(p_name, to_char(round(p_value, 2), '9,999,999,990.999'));
    END IF;
  END;

  PROCEDURE o(p_name IN VARCHAR2, p_value IN NUMBER, p_executions IN NUMBER, p_rows IN NUMBER, p_integer IN BOOLEAN DEFAULT TRUE) AS
  BEGIN
    IF p_integer
    THEN
      o(p_name, 
        to_char(round(p_value, 0), '9,999,999,999,999'), 
        to_char(round(p_value/nullif(p_executions, 0), 0), '9,999,999,999,999'), 
        to_char(round(p_value/nullif(p_rows, 0), 0), '9,999,999,999,999'));
    ELSE
      o(p_name, 
        to_char(round(p_value, 0), '9,999,999,990.999'), 
        to_char(round(p_value/nullif(p_executions, 0), 0), '9,999,999,990.999'), 
        to_char(round(p_value/nullif(p_rows, 0), 0), '9,999,999,990.999'));
    END IF;
  END;

BEGIN
  FOR c IN (SELECT sql_id, child_number
            FROM v$sql
            WHERE sql_id = '&1')
  LOOP
    SELECT * INTO s
    FROM v$sql
    WHERE sql_id = c.sql_id
    AND child_number = c.child_number;

    o();
    o('Identification');
    o();
    $IF dbms_db_version.version >= 12
    $THEN
      o('Container Id', s.con_id);
    $END
    o('SQL Id', c.sql_id);
    o('Child number', c.child_number);
    o('Execution Plan Hash Value', to_char(s.plan_hash_value));

    o();
    o('General');
    o();
    o('Module', s.module);
    o('Action', s.action);
    $IF NOT (dbms_db_version.version = 10 AND dbms_db_version.release = 1)
    $THEN
      o('Parsing Schema', s.parsing_schema_name);
    $ELSE
      DECLARE
        l_username dba_users.username%TYPE;
      BEGIN
      	SELECT username INTO l_username
        FROM dba_users
        WHERE user_id = s.parsing_schema_id;
        o('Parsing Schema', l_username);
      EXCEPTION
        WHEN no_data_found THEN
          o('Parsing Schema ID', s.parsing_schema_id);
      END;
    $END
    BEGIN
      IF s.program_id IS NOT NULL AND s.program_id <> 0
      THEN
        SELECT owner || '.' || object_name INTO p
        FROM dba_objects
        WHERE object_id = s.program_id;
      END IF;
    EXCEPTION
      WHEN no_data_found THEN
        p := to_char(s.program_id);
    END;
    o('PL/SQL Program', p);
    o('PL/SQL Line Number', nullif(s.program_line#,1));
    o('SQL Profile', s.sql_profile);
    o('Stored Outline Category', s.outline_category);
    $IF dbms_db_version.version >= 11
    $THEN
       o('SQL Plan Baseline', s.sql_plan_baseline);
    $END

    o();
    o('Shared Cursors Statistics');
    o();
    o('Total Parses', s.parse_calls);
    o('Loads / Hard Parses', s.loads);
    o('Invalidations', s.invalidations);
    o('Cursor Size / Shared (bytes)', s.sharable_mem);
    o('Cursor Size / Persistent (bytes)', s.persistent_mem);
    o('Cursor Size / Runtime (bytes)', s.runtime_mem);
    o('First Load Time', s.first_load_time);
    o('Last Load Time', s.last_load_time);

    o();
    o('Activity by Time');
    o();
    o('Elapsed Time (seconds)', s.elapsed_time / 1E6, FALSE);
    o('CPU Time (seconds)', s.cpu_time / 1E6, FALSE);
    o('Wait Time (seconds)', (s.elapsed_time - s.cpu_time) / 1E6, FALSE);

    o();
    o('Activity by Waits');
    o();
    o('Application Waits (%)', s.application_wait_time / nullif(s.elapsed_time, 0) * 100, FALSE);   
    o('Concurrency Waits (%)', s.concurrency_wait_time / nullif(s.elapsed_time, 0) * 100, FALSE);   
    o('Cluster Waits (%)', s.cluster_wait_time / nullif(s.elapsed_time, 0) * 100, FALSE);
    o('User I/O Waits (%)', s.user_io_wait_time / nullif(s.elapsed_time, 0) * 100, FALSE);
    o('Remaining Waits (%)', (s.elapsed_time - s.cpu_time - s.application_wait_time - s.concurrency_wait_time - s.cluster_wait_time - s.user_io_wait_time) / nullif(s.elapsed_time, 0) * 100, FALSE);   
    o('CPU (%)', s.cpu_time / nullif(s.elapsed_time, 0) * 100, FALSE);

    o();
    o('Elapsed Time Breakdown');
    o();
    o('SQL Time (seconds)', (s.elapsed_time - s.plsql_exec_time - s.java_exec_time) / 1E6, FALSE);  
    o('PL/SQL Time (seconds)', s.plsql_exec_time / 1E6, FALSE);
    o('Java Time (seconds)', s.java_exec_time / 1E6, FALSE);

    o();
    o('Execution Statistics', '             Total     Per Execution           Per Row');
    o();
    o('Elapsed Time (seconds)', s.elapsed_time / 1E6, s.executions, s.rows_processed, FALSE);
    o('CPU Time (seconds)', s.cpu_time / 1E6, s.executions, s.rows_processed, FALSE);
    o('Executions', s.executions, s.executions, s.rows_processed);
    o('Buffer Gets', s.buffer_gets, s.executions, s.rows_processed);
    o('Disk Reads', s.disk_reads, s.executions, s.rows_processed);
    o('Direct Writes', s.direct_writes, s.executions, s.rows_processed);
    o('Rows', s.rows_processed, s.executions, s.rows_processed);
    o('Fetches', s.fetches, s.executions, s.rows_processed);
    o('Average Fetch Size', nullif(s.rows_processed, 0) / nullif(s.executions, 0), NULL, NULL);

    o();
    o('Other Statistics');
    o();
    o('Executions that Fetched All Rows (%)', floor(s.end_of_fetch_count / nullif(s.executions, 0) * 100));
    o('Serializable Aborts', s.serializable_aborts);
    o('Remote', s.remote);
    o('Obsolete', s.is_obsolete);
    $IF dbms_db_version.version >= 11
    $THEN
      o('Shareable', s.is_shareable);
      o('Bind Sensitive', s.is_bind_sensitive);
      o('Bind Aware', s.is_bind_aware);
    $END
    o();

  END LOOP;
END;
/

TTITLE OFF

CLEAR COLUMNS
