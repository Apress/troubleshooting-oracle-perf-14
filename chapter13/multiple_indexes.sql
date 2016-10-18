SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: multiple_indexes.sql
REM Author......: Christian Antognini
REM Date........: November 2013
REM Description.: This script demonstrates that it is possible to create 
REM               multiple indexes on a single column.
REM Notes.......: Requires Oracle Database 12c Release 1
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 
REM ***************************************************************************

SET TERMOUT ON SERVEROUTPUT ON PAGESIZE 100 LINESIZE 100

DROP TABLE t PURGE;

COLUMN index_name FORMAT A11
COLUMN index_type FORMAT A11
COLUMN uniqueness FORMAT A11
COLUMN partitioned FORMAT A11
COLUMN visibility FORMAT A11

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

CREATE TABLE t (n1 NUMBER, n2 NUMBER, n3 NUMBER);

PAUSE

REM
REM Create multiple indexes on the same columns (only one can be visible at a given time)
REM

CREATE INDEX i_i ON t (n1);

PAUSE

CREATE UNIQUE INDEX i_ui ON t (n1);

PAUSE

CREATE UNIQUE INDEX i_ui ON t (n1) INVISIBLE;

PAUSE

CREATE BITMAP INDEX i_bi ON t (n1);

PAUSE

CREATE BITMAP INDEX i_bi ON t (n1) INVISIBLE;

PAUSE

CREATE INDEX i_hpi ON t (n1) INVISIBLE 
GLOBAL PARTITION BY HASH (n1) PARTITIONS 4;

PAUSE

REM this one cannot be created

CREATE INDEX i_rpi ON t (n1) INVISIBLE 
GLOBAL PARTITION BY HASH (n1) PARTITIONS 8;

PAUSE

CREATE INDEX i_rpi ON t (n1) INVISIBLE 
GLOBAL PARTITION BY RANGE (n1) (
  PARTITION VALUES LESS THAN (10),
  PARTITION VALUES LESS THAN (MAXVALUE)
);

PAUSE

REM
REM List available indexes
REM

SELECT index_name, index_type, uniqueness, partitioned, visibility
FROM user_indexes
WHERE table_name = 'T';

PAUSE

REM
REM Change visibility (only one can be visible at a given time)
REM

ALTER INDEX i_ui VISIBLE;

PAUSE

ALTER INDEX i_bi VISIBLE;

PAUSE

ALTER INDEX i_hpi VISIBLE;

PAUSE

ALTER INDEX i_rpi VISIBLE;

PAUSE

ALTER INDEX i_i INVISIBLE;
ALTER INDEX i_ui VISIBLE;

PAUSE

ALTER INDEX i_ui INVISIBLE;
ALTER INDEX i_bi VISIBLE;

PAUSE

ALTER INDEX i_bi INVISIBLE;
ALTER INDEX i_hpi VISIBLE;

PAUSE

ALTER INDEX i_hpi INVISIBLE;
ALTER INDEX i_rpi VISIBLE;

PAUSE

REM
REM Cleanup
REM

DROP TABLE t PURGE;

SET ECHO OFF
