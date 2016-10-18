SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: dpi.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script shows the behavior of direct-path inserts related 
REM               to the utilization of the buffer cache, the generation of 
REM               redo and undo, and the support of triggers and foreign keys.
REM Notes.......: -
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 23.12.2013 Added example based on a primarky key with a non-unique index
REM ***************************************************************************

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

@../connect.sql

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t2;
DROP TABLE t1;

CREATE TABLE t2 (id NUMBER, pad VARCHAR2(1000));

PAUSE

REM
REM A conventional insert uses the buffer cache and produce undo
REM

ALTER SYSTEM SET EVENTS 'IMMEDIATE TRACE NAME FLUSH_CACHE';

SELECT count(*)
FROM v$bh b, user_objects o
WHERE b.objd = o.data_object_id
AND o.object_name = 'T2'
AND b.class# = 1 /* data block */
AND b.status != 'free';

INSERT INTO t2
SELECT rownum AS id, rpad('*',1000,'*') AS pad
FROM dual
CONNECT BY level <= 100000;

SELECT count(*)
FROM v$bh b, user_objects o
WHERE b.objd = o.data_object_id
AND o.object_name = 'T2'
AND b.class# = 1 /* data block */
AND b.status != 'free';

SELECT t.used_ublk, t.used_urec
FROM v$transaction t, v$session s
WHERE t.addr = s.taddr
AND s.audsid = userenv('sessionid');

PAUSE

REM
REM A direct path insert do not use the buffer cache and produce minimal undo
REM

TRUNCATE TABLE t2;

ALTER SYSTEM SET EVENTS 'IMMEDIATE TRACE NAME FLUSH_CACHE';

SELECT count(*)
FROM v$bh b, user_objects o
WHERE b.objd = o.data_object_id
AND o.object_name = 'T2'
AND b.class# = 1 /* data block */
AND b.status != 'free';

INSERT /*+ append */ INTO t2
SELECT rownum AS id, rpad('*',1000,'*') AS pad
FROM dual
CONNECT BY level <= 100000;

SELECT count(*)
FROM v$bh b, user_objects o
WHERE b.objd = o.data_object_id
AND o.object_name = 'T2'
AND b.class# = 1 /* data block */
AND b.status != 'free';

SELECT t.used_ublk, t.used_urec
FROM v$transaction t, v$session s
WHERE t.addr = s.taddr
AND s.audsid = userenv('sessionid');

PAUSE

REM
REM The segment cannot be accessed if the transaction is open 
REM

SELECT count(*) FROM t2;

ROLLBACK;

SELECT count(*) FROM t2;

PAUSE

REM
REM Multi-table inserts also support direct inserts
REM

CREATE TABLE t1 (id NUMBER, pad VARCHAR2(1000));

INSERT /*+ append */ ALL INTO t1 INTO t2
SELECT rownum AS id, rpad('*',100,'*') AS pad
FROM dual
CONNECT BY level <= 100000;

SELECT count(*) FROM t1;

SELECT count(*) FROM t2;

ROLLBACK;

PAUSE

REM
REM A trigger BEFORE INSERT leads to a conventional insert
REM

CREATE OR REPLACE TRIGGER t2
BEFORE INSERT ON t2
--BEFORE INSERT ON t2 FOR EACH ROW
--AFTER INSERT ON t2
--AFTER INSERT ON t2 FOR EACH ROW
BEGIN
  NULL;
END;
/

INSERT /*+ append */ INTO t2
SELECT rownum AS id, rpad('*',100,'*') AS pad
FROM dual
CONNECT BY level <= 100000;

SELECT count(*) FROM t2;

ROLLBACK;

PAUSE

ALTER TRIGGER t2 DISABLE;

INSERT /*+ append */ INTO t2
SELECT rownum AS id, rpad('*',100,'*') AS pad
FROM dual
CONNECT BY level <= 100000;

SELECT count(*) FROM t2;

ROLLBACK;

PAUSE

REM
REM A trigger BEFORE DELETE OR UPDATE is not a problem
REM

CREATE OR REPLACE TRIGGER t2 
BEFORE DELETE OR UPDATE ON t2
--BEFORE DELETE OR UPDATE ON t2 FOR EACH ROW
--AFTER DELETE OR UPDATE ON t2
--AFTER DELETE OR UPDATE ON t2 FOR EACH ROW
BEGIN
  NULL;
END;
/

INSERT /*+ append */ INTO t2
SELECT rownum AS id, rpad('*',100,'*') AS pad
FROM dual
CONNECT BY level <= 100000;

SELECT count(*) FROM t2;

ROLLBACK;

DROP TRIGGER t2;

PAUSE

REM
REM With a primary/unique key based on a non-unique index only as of 11.1
REM a direct insert is possible
REM

ALTER TABLE t1 ADD CONSTRAINT t1_pk PRIMARY KEY (id) 
USING INDEX (CREATE UNIQUE INDEX t1_pk ON t1 (id));

INSERT /*+ append */ INTO t1
SELECT rownum AS id, rpad('*',100,'*') AS pad
FROM dual
CONNECT BY level <= 100000;

SELECT count(*) FROM t1;

ROLLBACK;

PAUSE

ALTER TABLE t1 DROP CONSTRAINT t1_pk;

ALTER TABLE t1 ADD CONSTRAINT t1_pk PRIMARY KEY (id) 
USING INDEX (CREATE INDEX t1_pk ON t1 (id));

INSERT /*+ append */ INTO t1
SELECT rownum AS id, rpad('*',100,'*') AS pad
FROM dual
CONNECT BY level <= 100000;

SELECT count(*) FROM t1;

ROLLBACK;

PAUSE

REM
REM With a foreign key in place, no direct insert is possible on the parent table
REM

INSERT /*+ append */ INTO t1
SELECT rownum AS id, rpad('*',100,'*') AS pad
FROM dual
CONNECT BY level <= 100000;

ALTER TABLE t1 ADD CONSTRAINT t1_pk PRIMARY KEY (id);

ALTER TABLE t2 ADD CONSTRAINT t2_t1_fk FOREIGN KEY (id) REFERENCES t1 (id);

INSERT /*+ append */ INTO t2
SELECT rownum AS id, rpad('*',100,'*') AS pad
FROM dual
CONNECT BY level <= 100000;

SELECT count(*) FROM t2;

ROLLBACK;

PAUSE

INSERT /*+ append */ INTO t1
SELECT -rownum AS id, rpad('*',100,'*') AS pad
FROM dual
CONNECT BY level <= 100000;

SELECT count(*) FROM t1;

ROLLBACK;

PAUSE

REM
REM Support of LOBs
REM

DROP TABLE t3;

CREATE TABLE t3 (id NUMBER, pad CLOB);

PAUSE

REM @../connect

INSERT /*+ append */ INTO t3
SELECT rownum AS id, rpad('*',100,'*') AS pad
FROM dual
CONNECT BY level <= 100000;

SELECT count(*) FROM t3;

ROLLBACK;

PAUSE

REM
REM Cleanup
REM

DROP TABLE t3;
PURGE TABLE t3;
DROP TABLE t2;
PURGE TABLE t2;
DROP TABLE t1;
PURGE TABLE t1;
