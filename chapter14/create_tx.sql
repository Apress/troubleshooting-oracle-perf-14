SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: create_tx.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: Create 4 test tables (t1, t2, t3 and t4).
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

SET TERMOUT ON
SET FEEDBACK OFF
SET VERIFY OFF
SET SCAN ON

@../connect.sql

SET ECHO ON

DROP TABLE t4;
DROP TABLE t3;
DROP TABLE t2;
DROP TABLE t1;

BEGIN
  EXECUTE IMMEDIATE 'PURGE RECYCLEBIN';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE t1 (
  id NUMBER NOT NULL,
  n NUMBER,
  pad VARCHAR2(4000), 
  CONSTRAINT t1_pk PRIMARY KEY(id)
)
PCTFREE 99 PCTUSED 1;

CREATE TABLE t2 (
  id NUMBER NOT NULL, 
  t1_id NUMBER NOT NULL, 
  n NUMBER,
  pad VARCHAR2(4000), 
  CONSTRAINT t2_pk PRIMARY KEY(id),
  CONSTRAINT t2_t1_fk FOREIGN KEY (t1_id) REFERENCES t1
)
PCTFREE 99 PCTUSED 1;

CREATE TABLE t3 (
  id NUMBER NOT NULL, 
  t2_id NUMBER NOT NULL, 
  n NUMBER,
  pad VARCHAR2(4000), 
  CONSTRAINT t3_pk PRIMARY KEY(id),
  CONSTRAINT t3_t2_fk FOREIGN KEY (t2_id) REFERENCES t2
)
PCTFREE 99 PCTUSED 1;

CREATE TABLE t4 (
  id NUMBER NOT NULL, 
  t3_id NUMBER NOT NULL, 
  n NUMBER,
  pad VARCHAR2(4000), 
  CONSTRAINT t4_pk PRIMARY KEY(id),
  CONSTRAINT t4_t3_fk FOREIGN KEY (t3_id) REFERENCES t3
)
PCTFREE 99 PCTUSED 1;

execute dbms_random.seed(0)

INSERT INTO t1 SELECT 10+rownum, 10+rownum, dbms_random.string('p',50) FROM dual CONNECT BY level <= 10 ORDER BY dbms_random.random;
INSERT INTO t2 SELECT 100+rownum, t1.id, 100+rownum, t1.pad FROM t1, t1 dummy ORDER BY dbms_random.random;
INSERT INTO t3 SELECT 1000+rownum, t2.id, 1000+rownum, t2.pad FROM t2, t1 dummy ORDER BY dbms_random.random;
INSERT INTO t4 SELECT 10000+rownum, t3.id, 10000+rownum, t3.pad FROM t3, t1 dummy ORDER BY dbms_random.random;
COMMIT;

CREATE INDEX t2_t1_id ON t2(t1_id);
CREATE INDEX t3_t2_id ON t3(t2_id);
CREATE INDEX t4_t3_id ON t4(t3_id);

BEGIN
  dbms_stats.gather_table_stats(user,'t1');
  dbms_stats.gather_table_stats(user,'t2');
  dbms_stats.gather_table_stats(user,'t3');
  dbms_stats.gather_table_stats(user,'t4');
END;
/

SELECT table_name, num_rows
FROM user_tables
WHERE table_name IN ('T1', 'T2', 'T3', 'T4')
ORDER BY table_name;
