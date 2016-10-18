SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: long_parse.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script is used to carry out a parse lasting about one
REM               second. It also shows how to create a stored outline to avoid
REM               such a long parse.
REM Notes.......: -
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 15.08.2013 Set tracefile_identifier before enabling SQL trace
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

DROP OUTLINE o;

BEGIN
  FOR i IN 1..20 LOOP
    BEGIN
      EXECUTE IMMEDIATE 'DROP TABLE t' || i;
      EXECUTE IMMEDIATE 'PURGE TABLE t' || i;
    EXCEPTION
      WHEN OTHERS THEN NULL;
    END;
    EXECUTE IMMEDIATE 'CREATE TABLE t' || i || ' AS 
                       SELECT mod(rownum,2)  AS n1,  mod(rownum,3)  AS n2,  mod(rownum,4)  AS n3, 
                              mod(rownum,5)  AS n4,  mod(rownum,6)  AS n5,  mod(rownum,7)  AS n6, 
                              mod(rownum,8)  AS n7,  mod(rownum,9)  AS n8,  mod(rownum,10) AS n9,
                              mod(rownum,11) AS n10, mod(rownum,12) AS n11, mod(rownum,13) AS n12,
                              mod(rownum,14) AS n13, mod(rownum,15) AS n14, mod(rownum,16) AS n15,
                              mod(rownum,17) AS n16, mod(rownum,18) AS n17, mod(rownum,19) AS n18,
                              mod(rownum,20) AS n19, mod(rownum,21) AS n20
                       FROM dual
                       CONNECT BY level <= 10000';
    FOR j IN 1..20 LOOP
      EXECUTE IMMEDIATE 'CREATE INDEX t' || i || '_n' || j || '_i ON t' || i || ' (n' || j || ')';
    END LOOP;
    dbms_stats.gather_table_stats(user, 't' || i, method_opt=>'for all columns size 254');
  END LOOP;
END;
/

ALTER SYSTEM FLUSH SHARED_POOL;

PAUSE

REM
REM Parse without stored outline
REM

@../connect.sql

ALTER SESSION SET tracefile_identifier = 'no_outline';
execute dbms_monitor.session_trace_enable

SELECT  count(*)
FROM t1
WHERE t1.n1 = 1 AND n2 = 2 AND n3 = 3 AND n4 = 4 AND n5 = 5 AND n6 = 6 AND n7 = 7 AND n8 = 8 AND n9 = 9 AND n10 = 10 AND t1.n11 = 11 AND n12 = 12 AND n13 = 13 AND n14 = 14 AND n15 = 15 AND n16 = 16 AND n17 = 17 AND n18 = 18 AND n19 = 19 AND n20 = 20
AND EXISTS (SELECT 1 FROM t2 WHERE t2.n1 = t1.n1 AND t2.n2 = t1.n2 AND t2.n3 = t1.n3 AND t2.n4 = t1.n4 AND t2.n5 = t1.n5 AND t2.n6 = t1.n6 AND t2.n7 = t1.n7 AND t2.n8 = t1.n8 AND t2.n9 = t1.n9 AND t2.n10 = t1.n10 AND t2.n11 = t1.n11 AND t2.n12 = t1.n12 AND t2.n13 = t1.n13 AND t2.n14 = t1.n14 AND t2.n15 = t1.n15 AND t2.n16 = t1.n16 AND t2.n17 = t1.n17 AND t2.n18 = t1.n18 AND t2.n19 = t1.n19 AND t2.n20 = t1.n20)
AND EXISTS (SELECT 1 FROM t3 WHERE t3.n1 = t1.n1 AND t3.n2 = t1.n2 AND t3.n3 = t1.n3 AND t3.n4 = t1.n4 AND t3.n5 = t1.n5 AND t3.n6 = t1.n6 AND t3.n7 = t1.n7 AND t3.n8 = t1.n8 AND t3.n9 = t1.n9 AND t3.n10 = t1.n10 AND t3.n11 = t1.n11 AND t3.n12 = t1.n12 AND t3.n13 = t1.n13 AND t3.n14 = t1.n14 AND t3.n15 = t1.n15 AND t3.n16 = t1.n16 AND t3.n17 = t1.n17 AND t3.n18 = t1.n18 AND t3.n19 = t1.n19 AND t3.n20 = t1.n20)
AND EXISTS (SELECT 1 FROM t4 WHERE t4.n1 = t1.n1 AND t4.n2 = t1.n2 AND t4.n3 = t1.n3 AND t4.n4 = t1.n4 AND t4.n5 = t1.n5 AND t4.n6 = t1.n6 AND t4.n7 = t1.n7 AND t4.n8 = t1.n8 AND t4.n9 = t1.n9 AND t4.n10 = t1.n10 AND t4.n11 = t1.n11 AND t4.n12 = t1.n12 AND t4.n13 = t1.n13 AND t4.n14 = t1.n14 AND t4.n15 = t1.n15 AND t4.n16 = t1.n16 AND t4.n17 = t1.n17 AND t4.n18 = t1.n18 AND t4.n19 = t1.n19 AND t4.n20 = t1.n20)
AND EXISTS (SELECT 1 FROM t5 WHERE t5.n1 = t1.n1 AND t5.n2 = t1.n2 AND t5.n3 = t1.n3 AND t5.n4 = t1.n4 AND t5.n5 = t1.n5 AND t5.n6 = t1.n6 AND t5.n7 = t1.n7 AND t5.n8 = t1.n8 AND t5.n9 = t1.n9 AND t5.n10 = t1.n10 AND t5.n11 = t1.n11 AND t5.n12 = t1.n12 AND t5.n13 = t1.n13 AND t5.n14 = t1.n14 AND t5.n15 = t1.n15 AND t5.n16 = t1.n16 AND t5.n17 = t1.n17 AND t5.n18 = t1.n18 AND t5.n19 = t1.n19 AND t5.n20 = t1.n20)
AND EXISTS (SELECT 1 FROM t6 WHERE t6.n1 = t1.n1 AND t6.n2 = t1.n2 AND t6.n3 = t1.n3 AND t6.n4 = t1.n4 AND t6.n5 = t1.n5 AND t6.n6 = t1.n6 AND t6.n7 = t1.n7 AND t6.n8 = t1.n8 AND t6.n9 = t1.n9 AND t6.n10 = t1.n10 AND t6.n11 = t1.n11 AND t6.n12 = t1.n12 AND t6.n13 = t1.n13 AND t6.n14 = t1.n14 AND t6.n15 = t1.n15 AND t6.n16 = t1.n16 AND t6.n17 = t1.n17 AND t6.n18 = t1.n18 AND t6.n19 = t1.n19 AND t6.n20 = t1.n20)
AND EXISTS (SELECT 1 FROM t7 WHERE t7.n1 = t1.n1 AND t7.n2 = t1.n2 AND t7.n3 = t1.n3 AND t7.n4 = t1.n4 AND t7.n5 = t1.n5 AND t7.n6 = t1.n6 AND t7.n7 = t1.n7 AND t7.n8 = t1.n8 AND t7.n9 = t1.n9 AND t7.n10 = t1.n10 AND t7.n11 = t1.n11 AND t7.n12 = t1.n12 AND t7.n13 = t1.n13 AND t7.n14 = t1.n14 AND t7.n15 = t1.n15 AND t7.n16 = t1.n16 AND t7.n17 = t1.n17 AND t7.n18 = t1.n18 AND t7.n19 = t1.n19 AND t7.n20 = t1.n20)
AND EXISTS (SELECT 1 FROM t8 WHERE t8.n1 = t1.n1 AND t8.n2 = t1.n2 AND t8.n3 = t1.n3 AND t8.n4 = t1.n4 AND t8.n5 = t1.n5 AND t8.n6 = t1.n6 AND t8.n7 = t1.n7 AND t8.n8 = t1.n8 AND t8.n9 = t1.n9 AND t8.n10 = t1.n10 AND t8.n11 = t1.n11 AND t8.n12 = t1.n12 AND t8.n13 = t1.n13 AND t8.n14 = t1.n14 AND t8.n15 = t1.n15 AND t8.n16 = t1.n16 AND t8.n17 = t1.n17 AND t8.n18 = t1.n18 AND t8.n19 = t1.n19 AND t8.n20 = t1.n20)
AND EXISTS (SELECT 1 FROM t9 WHERE t9.n1 = t1.n1 AND t9.n2 = t1.n2 AND t9.n3 = t1.n3 AND t9.n4 = t1.n4 AND t9.n5 = t1.n5 AND t9.n6 = t1.n6 AND t9.n7 = t1.n7 AND t9.n8 = t1.n8 AND t9.n9 = t1.n9 AND t9.n10 = t1.n10 AND t9.n11 = t1.n11 AND t9.n12 = t1.n12 AND t9.n13 = t1.n13 AND t9.n14 = t1.n14 AND t9.n15 = t1.n15 AND t9.n16 = t1.n16 AND t9.n17 = t1.n17 AND t9.n18 = t1.n18 AND t9.n19 = t1.n19 AND t9.n20 = t1.n20)
AND EXISTS (SELECT 1 FROM t10 WHERE t10.n1 = t1.n1 AND t10.n2 = t1.n2 AND t10.n3 = t1.n3 AND t10.n4 = t1.n4 AND t10.n5 = t1.n5 AND t10.n6 = t1.n6 AND t10.n7 = t1.n7 AND t10.n8 = t1.n8 AND t10.n9 = t1.n9 AND t10.n10 = t1.n10 AND t10.n11 = t1.n11 AND t10.n12 = t1.n12 AND t10.n13 = t1.n13 AND t10.n14 = t1.n14 AND t10.n15 = t1.n15 AND t10.n16 = t1.n16 AND t10.n17 = t1.n17 AND t10.n18 = t1.n18 AND t10.n19 = t1.n19 AND t10.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t11 WHERE t11.n1 = t1.n1 AND t11.n2 = t1.n2 AND t11.n3 = t1.n3 AND t11.n4 = t1.n4 AND t11.n5 = t1.n5 AND t11.n6 = t1.n6 AND t11.n7 = t1.n7 AND t11.n8 = t1.n8 AND t11.n9 = t1.n9 AND t11.n10 = t1.n10 AND t11.n11 = t1.n11 AND t11.n12 = t1.n12 AND t11.n13 = t1.n13 AND t11.n14 = t1.n14 AND t11.n15 = t1.n15 AND t11.n16 = t1.n16 AND t11.n17 = t1.n17 AND t11.n18 = t1.n18 AND t11.n19 = t1.n19 AND t11.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t12 WHERE t12.n1 = t1.n1 AND t12.n2 = t1.n2 AND t12.n3 = t1.n3 AND t12.n4 = t1.n4 AND t12.n5 = t1.n5 AND t12.n6 = t1.n6 AND t12.n7 = t1.n7 AND t12.n8 = t1.n8 AND t12.n9 = t1.n9 AND t12.n10 = t1.n10 AND t12.n11 = t1.n11 AND t12.n12 = t1.n12 AND t12.n13 = t1.n13 AND t12.n14 = t1.n14 AND t12.n15 = t1.n15 AND t12.n16 = t1.n16 AND t12.n17 = t1.n17 AND t12.n18 = t1.n18 AND t12.n19 = t1.n19 AND t12.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t13 WHERE t13.n1 = t1.n1 AND t13.n2 = t1.n2 AND t13.n3 = t1.n3 AND t13.n4 = t1.n4 AND t13.n5 = t1.n5 AND t13.n6 = t1.n6 AND t13.n7 = t1.n7 AND t13.n8 = t1.n8 AND t13.n9 = t1.n9 AND t13.n10 = t1.n10 AND t13.n11 = t1.n11 AND t13.n12 = t1.n12 AND t13.n13 = t1.n13 AND t13.n14 = t1.n14 AND t13.n15 = t1.n15 AND t13.n16 = t1.n16 AND t13.n17 = t1.n17 AND t13.n18 = t1.n18 AND t13.n19 = t1.n19 AND t13.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t14 WHERE t14.n1 = t1.n1 AND t14.n2 = t1.n2 AND t14.n3 = t1.n3 AND t14.n4 = t1.n4 AND t14.n5 = t1.n5 AND t14.n6 = t1.n6 AND t14.n7 = t1.n7 AND t14.n8 = t1.n8 AND t14.n9 = t1.n9 AND t14.n10 = t1.n10 AND t14.n11 = t1.n11 AND t14.n12 = t1.n12 AND t14.n13 = t1.n13 AND t14.n14 = t1.n14 AND t14.n15 = t1.n15 AND t14.n16 = t1.n16 AND t14.n17 = t1.n17 AND t14.n18 = t1.n18 AND t14.n19 = t1.n19 AND t14.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t15 WHERE t15.n1 = t1.n1 AND t15.n2 = t1.n2 AND t15.n3 = t1.n3 AND t15.n4 = t1.n4 AND t15.n5 = t1.n5 AND t15.n6 = t1.n6 AND t15.n7 = t1.n7 AND t15.n8 = t1.n8 AND t15.n9 = t1.n9 AND t15.n10 = t1.n10 AND t15.n11 = t1.n11 AND t15.n12 = t1.n12 AND t15.n13 = t1.n13 AND t15.n14 = t1.n14 AND t15.n15 = t1.n15 AND t15.n16 = t1.n16 AND t15.n17 = t1.n17 AND t15.n18 = t1.n18 AND t15.n19 = t1.n19 AND t15.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t16 WHERE t16.n1 = t1.n1 AND t16.n2 = t1.n2 AND t16.n3 = t1.n3 AND t16.n4 = t1.n4 AND t16.n5 = t1.n5 AND t16.n6 = t1.n6 AND t16.n7 = t1.n7 AND t16.n8 = t1.n8 AND t16.n9 = t1.n9 AND t16.n10 = t1.n10 AND t16.n11 = t1.n11 AND t16.n12 = t1.n12 AND t16.n13 = t1.n13 AND t16.n14 = t1.n14 AND t16.n15 = t1.n15 AND t16.n16 = t1.n16 AND t16.n17 = t1.n17 AND t16.n18 = t1.n18 AND t16.n19 = t1.n19 AND t16.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t17 WHERE t17.n1 = t1.n1 AND t17.n2 = t1.n2 AND t17.n3 = t1.n3 AND t17.n4 = t1.n4 AND t17.n5 = t1.n5 AND t17.n6 = t1.n6 AND t17.n7 = t1.n7 AND t17.n8 = t1.n8 AND t17.n9 = t1.n9 AND t17.n10 = t1.n10 AND t17.n11 = t1.n11 AND t17.n12 = t1.n12 AND t17.n13 = t1.n13 AND t17.n14 = t1.n14 AND t17.n15 = t1.n15 AND t17.n16 = t1.n16 AND t17.n17 = t1.n17 AND t17.n18 = t1.n18 AND t17.n19 = t1.n19 AND t17.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t18 WHERE t18.n1 = t1.n1 AND t18.n2 = t1.n2 AND t18.n3 = t1.n3 AND t18.n4 = t1.n4 AND t18.n5 = t1.n5 AND t18.n6 = t1.n6 AND t18.n7 = t1.n7 AND t18.n8 = t1.n8 AND t18.n9 = t1.n9 AND t18.n10 = t1.n10 AND t18.n11 = t1.n11 AND t18.n12 = t1.n12 AND t18.n13 = t1.n13 AND t18.n14 = t1.n14 AND t18.n15 = t1.n15 AND t18.n16 = t1.n16 AND t18.n17 = t1.n17 AND t18.n18 = t1.n18 AND t18.n19 = t1.n19 AND t18.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t19 WHERE t19.n1 = t1.n1 AND t19.n2 = t1.n2 AND t19.n3 = t1.n3 AND t19.n4 = t1.n4 AND t19.n5 = t1.n5 AND t19.n6 = t1.n6 AND t19.n7 = t1.n7 AND t19.n8 = t1.n8 AND t19.n9 = t1.n9 AND t19.n10 = t1.n10 AND t19.n11 = t1.n11 AND t19.n12 = t1.n12 AND t19.n13 = t1.n13 AND t19.n14 = t1.n14 AND t19.n15 = t1.n15 AND t19.n16 = t1.n16 AND t19.n17 = t1.n17 AND t19.n18 = t1.n18 AND t19.n19 = t1.n19 AND t19.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t20 WHERE t20.n1 = t1.n1 AND t20.n2 = t1.n2 AND t20.n3 = t1.n3 AND t20.n4 = t1.n4 AND t20.n5 = t1.n5 AND t20.n6 = t1.n6 AND t20.n7 = t1.n7 AND t20.n8 = t1.n8 AND t20.n9 = t1.n9 AND t20.n10 = t1.n10 AND t20.n11 = t1.n11 AND t20.n12 = t1.n12 AND t20.n13 = t1.n13 AND t20.n14 = t1.n14 AND t20.n15 = t1.n15 AND t20.n16 = t1.n16 AND t20.n17 = t1.n17 AND t20.n18 = t1.n18 AND t20.n19 = t1.n19 AND t20.n20 = t1.n20);

execute dbms_monitor.session_trace_disable

PAUSE

REM
REM Parse with stored outline
REM

@../connect.sql

CREATE OUTLINE o ON
SELECT  count(*)
FROM t1
WHERE t1.n1 = 1 AND n2 = 2 AND n3 = 3 AND n4 = 4 AND n5 = 5 AND n6 = 6 AND n7 = 7 AND n8 = 8 AND n9 = 9 AND n10 = 10 AND t1.n11 = 11 AND n12 = 12 AND n13 = 13 AND n14 = 14 AND n15 = 15 AND n16 = 16 AND n17 = 17 AND n18 = 18 AND n19 = 19 AND n20 = 20
AND EXISTS (SELECT 1 FROM t2 WHERE t2.n1 = t1.n1 AND t2.n2 = t1.n2 AND t2.n3 = t1.n3 AND t2.n4 = t1.n4 AND t2.n5 = t1.n5 AND t2.n6 = t1.n6 AND t2.n7 = t1.n7 AND t2.n8 = t1.n8 AND t2.n9 = t1.n9 AND t2.n10 = t1.n10 AND t2.n11 = t1.n11 AND t2.n12 = t1.n12 AND t2.n13 = t1.n13 AND t2.n14 = t1.n14 AND t2.n15 = t1.n15 AND t2.n16 = t1.n16 AND t2.n17 = t1.n17 AND t2.n18 = t1.n18 AND t2.n19 = t1.n19 AND t2.n20 = t1.n20)
AND EXISTS (SELECT 1 FROM t3 WHERE t3.n1 = t1.n1 AND t3.n2 = t1.n2 AND t3.n3 = t1.n3 AND t3.n4 = t1.n4 AND t3.n5 = t1.n5 AND t3.n6 = t1.n6 AND t3.n7 = t1.n7 AND t3.n8 = t1.n8 AND t3.n9 = t1.n9 AND t3.n10 = t1.n10 AND t3.n11 = t1.n11 AND t3.n12 = t1.n12 AND t3.n13 = t1.n13 AND t3.n14 = t1.n14 AND t3.n15 = t1.n15 AND t3.n16 = t1.n16 AND t3.n17 = t1.n17 AND t3.n18 = t1.n18 AND t3.n19 = t1.n19 AND t3.n20 = t1.n20)
AND EXISTS (SELECT 1 FROM t4 WHERE t4.n1 = t1.n1 AND t4.n2 = t1.n2 AND t4.n3 = t1.n3 AND t4.n4 = t1.n4 AND t4.n5 = t1.n5 AND t4.n6 = t1.n6 AND t4.n7 = t1.n7 AND t4.n8 = t1.n8 AND t4.n9 = t1.n9 AND t4.n10 = t1.n10 AND t4.n11 = t1.n11 AND t4.n12 = t1.n12 AND t4.n13 = t1.n13 AND t4.n14 = t1.n14 AND t4.n15 = t1.n15 AND t4.n16 = t1.n16 AND t4.n17 = t1.n17 AND t4.n18 = t1.n18 AND t4.n19 = t1.n19 AND t4.n20 = t1.n20)
AND EXISTS (SELECT 1 FROM t5 WHERE t5.n1 = t1.n1 AND t5.n2 = t1.n2 AND t5.n3 = t1.n3 AND t5.n4 = t1.n4 AND t5.n5 = t1.n5 AND t5.n6 = t1.n6 AND t5.n7 = t1.n7 AND t5.n8 = t1.n8 AND t5.n9 = t1.n9 AND t5.n10 = t1.n10 AND t5.n11 = t1.n11 AND t5.n12 = t1.n12 AND t5.n13 = t1.n13 AND t5.n14 = t1.n14 AND t5.n15 = t1.n15 AND t5.n16 = t1.n16 AND t5.n17 = t1.n17 AND t5.n18 = t1.n18 AND t5.n19 = t1.n19 AND t5.n20 = t1.n20)
AND EXISTS (SELECT 1 FROM t6 WHERE t6.n1 = t1.n1 AND t6.n2 = t1.n2 AND t6.n3 = t1.n3 AND t6.n4 = t1.n4 AND t6.n5 = t1.n5 AND t6.n6 = t1.n6 AND t6.n7 = t1.n7 AND t6.n8 = t1.n8 AND t6.n9 = t1.n9 AND t6.n10 = t1.n10 AND t6.n11 = t1.n11 AND t6.n12 = t1.n12 AND t6.n13 = t1.n13 AND t6.n14 = t1.n14 AND t6.n15 = t1.n15 AND t6.n16 = t1.n16 AND t6.n17 = t1.n17 AND t6.n18 = t1.n18 AND t6.n19 = t1.n19 AND t6.n20 = t1.n20)
AND EXISTS (SELECT 1 FROM t7 WHERE t7.n1 = t1.n1 AND t7.n2 = t1.n2 AND t7.n3 = t1.n3 AND t7.n4 = t1.n4 AND t7.n5 = t1.n5 AND t7.n6 = t1.n6 AND t7.n7 = t1.n7 AND t7.n8 = t1.n8 AND t7.n9 = t1.n9 AND t7.n10 = t1.n10 AND t7.n11 = t1.n11 AND t7.n12 = t1.n12 AND t7.n13 = t1.n13 AND t7.n14 = t1.n14 AND t7.n15 = t1.n15 AND t7.n16 = t1.n16 AND t7.n17 = t1.n17 AND t7.n18 = t1.n18 AND t7.n19 = t1.n19 AND t7.n20 = t1.n20)
AND EXISTS (SELECT 1 FROM t8 WHERE t8.n1 = t1.n1 AND t8.n2 = t1.n2 AND t8.n3 = t1.n3 AND t8.n4 = t1.n4 AND t8.n5 = t1.n5 AND t8.n6 = t1.n6 AND t8.n7 = t1.n7 AND t8.n8 = t1.n8 AND t8.n9 = t1.n9 AND t8.n10 = t1.n10 AND t8.n11 = t1.n11 AND t8.n12 = t1.n12 AND t8.n13 = t1.n13 AND t8.n14 = t1.n14 AND t8.n15 = t1.n15 AND t8.n16 = t1.n16 AND t8.n17 = t1.n17 AND t8.n18 = t1.n18 AND t8.n19 = t1.n19 AND t8.n20 = t1.n20)
AND EXISTS (SELECT 1 FROM t9 WHERE t9.n1 = t1.n1 AND t9.n2 = t1.n2 AND t9.n3 = t1.n3 AND t9.n4 = t1.n4 AND t9.n5 = t1.n5 AND t9.n6 = t1.n6 AND t9.n7 = t1.n7 AND t9.n8 = t1.n8 AND t9.n9 = t1.n9 AND t9.n10 = t1.n10 AND t9.n11 = t1.n11 AND t9.n12 = t1.n12 AND t9.n13 = t1.n13 AND t9.n14 = t1.n14 AND t9.n15 = t1.n15 AND t9.n16 = t1.n16 AND t9.n17 = t1.n17 AND t9.n18 = t1.n18 AND t9.n19 = t1.n19 AND t9.n20 = t1.n20)
AND EXISTS (SELECT 1 FROM t10 WHERE t10.n1 = t1.n1 AND t10.n2 = t1.n2 AND t10.n3 = t1.n3 AND t10.n4 = t1.n4 AND t10.n5 = t1.n5 AND t10.n6 = t1.n6 AND t10.n7 = t1.n7 AND t10.n8 = t1.n8 AND t10.n9 = t1.n9 AND t10.n10 = t1.n10 AND t10.n11 = t1.n11 AND t10.n12 = t1.n12 AND t10.n13 = t1.n13 AND t10.n14 = t1.n14 AND t10.n15 = t1.n15 AND t10.n16 = t1.n16 AND t10.n17 = t1.n17 AND t10.n18 = t1.n18 AND t10.n19 = t1.n19 AND t10.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t11 WHERE t11.n1 = t1.n1 AND t11.n2 = t1.n2 AND t11.n3 = t1.n3 AND t11.n4 = t1.n4 AND t11.n5 = t1.n5 AND t11.n6 = t1.n6 AND t11.n7 = t1.n7 AND t11.n8 = t1.n8 AND t11.n9 = t1.n9 AND t11.n10 = t1.n10 AND t11.n11 = t1.n11 AND t11.n12 = t1.n12 AND t11.n13 = t1.n13 AND t11.n14 = t1.n14 AND t11.n15 = t1.n15 AND t11.n16 = t1.n16 AND t11.n17 = t1.n17 AND t11.n18 = t1.n18 AND t11.n19 = t1.n19 AND t11.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t12 WHERE t12.n1 = t1.n1 AND t12.n2 = t1.n2 AND t12.n3 = t1.n3 AND t12.n4 = t1.n4 AND t12.n5 = t1.n5 AND t12.n6 = t1.n6 AND t12.n7 = t1.n7 AND t12.n8 = t1.n8 AND t12.n9 = t1.n9 AND t12.n10 = t1.n10 AND t12.n11 = t1.n11 AND t12.n12 = t1.n12 AND t12.n13 = t1.n13 AND t12.n14 = t1.n14 AND t12.n15 = t1.n15 AND t12.n16 = t1.n16 AND t12.n17 = t1.n17 AND t12.n18 = t1.n18 AND t12.n19 = t1.n19 AND t12.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t13 WHERE t13.n1 = t1.n1 AND t13.n2 = t1.n2 AND t13.n3 = t1.n3 AND t13.n4 = t1.n4 AND t13.n5 = t1.n5 AND t13.n6 = t1.n6 AND t13.n7 = t1.n7 AND t13.n8 = t1.n8 AND t13.n9 = t1.n9 AND t13.n10 = t1.n10 AND t13.n11 = t1.n11 AND t13.n12 = t1.n12 AND t13.n13 = t1.n13 AND t13.n14 = t1.n14 AND t13.n15 = t1.n15 AND t13.n16 = t1.n16 AND t13.n17 = t1.n17 AND t13.n18 = t1.n18 AND t13.n19 = t1.n19 AND t13.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t14 WHERE t14.n1 = t1.n1 AND t14.n2 = t1.n2 AND t14.n3 = t1.n3 AND t14.n4 = t1.n4 AND t14.n5 = t1.n5 AND t14.n6 = t1.n6 AND t14.n7 = t1.n7 AND t14.n8 = t1.n8 AND t14.n9 = t1.n9 AND t14.n10 = t1.n10 AND t14.n11 = t1.n11 AND t14.n12 = t1.n12 AND t14.n13 = t1.n13 AND t14.n14 = t1.n14 AND t14.n15 = t1.n15 AND t14.n16 = t1.n16 AND t14.n17 = t1.n17 AND t14.n18 = t1.n18 AND t14.n19 = t1.n19 AND t14.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t15 WHERE t15.n1 = t1.n1 AND t15.n2 = t1.n2 AND t15.n3 = t1.n3 AND t15.n4 = t1.n4 AND t15.n5 = t1.n5 AND t15.n6 = t1.n6 AND t15.n7 = t1.n7 AND t15.n8 = t1.n8 AND t15.n9 = t1.n9 AND t15.n10 = t1.n10 AND t15.n11 = t1.n11 AND t15.n12 = t1.n12 AND t15.n13 = t1.n13 AND t15.n14 = t1.n14 AND t15.n15 = t1.n15 AND t15.n16 = t1.n16 AND t15.n17 = t1.n17 AND t15.n18 = t1.n18 AND t15.n19 = t1.n19 AND t15.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t16 WHERE t16.n1 = t1.n1 AND t16.n2 = t1.n2 AND t16.n3 = t1.n3 AND t16.n4 = t1.n4 AND t16.n5 = t1.n5 AND t16.n6 = t1.n6 AND t16.n7 = t1.n7 AND t16.n8 = t1.n8 AND t16.n9 = t1.n9 AND t16.n10 = t1.n10 AND t16.n11 = t1.n11 AND t16.n12 = t1.n12 AND t16.n13 = t1.n13 AND t16.n14 = t1.n14 AND t16.n15 = t1.n15 AND t16.n16 = t1.n16 AND t16.n17 = t1.n17 AND t16.n18 = t1.n18 AND t16.n19 = t1.n19 AND t16.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t17 WHERE t17.n1 = t1.n1 AND t17.n2 = t1.n2 AND t17.n3 = t1.n3 AND t17.n4 = t1.n4 AND t17.n5 = t1.n5 AND t17.n6 = t1.n6 AND t17.n7 = t1.n7 AND t17.n8 = t1.n8 AND t17.n9 = t1.n9 AND t17.n10 = t1.n10 AND t17.n11 = t1.n11 AND t17.n12 = t1.n12 AND t17.n13 = t1.n13 AND t17.n14 = t1.n14 AND t17.n15 = t1.n15 AND t17.n16 = t1.n16 AND t17.n17 = t1.n17 AND t17.n18 = t1.n18 AND t17.n19 = t1.n19 AND t17.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t18 WHERE t18.n1 = t1.n1 AND t18.n2 = t1.n2 AND t18.n3 = t1.n3 AND t18.n4 = t1.n4 AND t18.n5 = t1.n5 AND t18.n6 = t1.n6 AND t18.n7 = t1.n7 AND t18.n8 = t1.n8 AND t18.n9 = t1.n9 AND t18.n10 = t1.n10 AND t18.n11 = t1.n11 AND t18.n12 = t1.n12 AND t18.n13 = t1.n13 AND t18.n14 = t1.n14 AND t18.n15 = t1.n15 AND t18.n16 = t1.n16 AND t18.n17 = t1.n17 AND t18.n18 = t1.n18 AND t18.n19 = t1.n19 AND t18.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t19 WHERE t19.n1 = t1.n1 AND t19.n2 = t1.n2 AND t19.n3 = t1.n3 AND t19.n4 = t1.n4 AND t19.n5 = t1.n5 AND t19.n6 = t1.n6 AND t19.n7 = t1.n7 AND t19.n8 = t1.n8 AND t19.n9 = t1.n9 AND t19.n10 = t1.n10 AND t19.n11 = t1.n11 AND t19.n12 = t1.n12 AND t19.n13 = t1.n13 AND t19.n14 = t1.n14 AND t19.n15 = t1.n15 AND t19.n16 = t1.n16 AND t19.n17 = t1.n17 AND t19.n18 = t1.n18 AND t19.n19 = t1.n19 AND t19.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t20 WHERE t20.n1 = t1.n1 AND t20.n2 = t1.n2 AND t20.n3 = t1.n3 AND t20.n4 = t1.n4 AND t20.n5 = t1.n5 AND t20.n6 = t1.n6 AND t20.n7 = t1.n7 AND t20.n8 = t1.n8 AND t20.n9 = t1.n9 AND t20.n10 = t1.n10 AND t20.n11 = t1.n11 AND t20.n12 = t1.n12 AND t20.n13 = t1.n13 AND t20.n14 = t1.n14 AND t20.n15 = t1.n15 AND t20.n16 = t1.n16 AND t20.n17 = t1.n17 AND t20.n18 = t1.n18 AND t20.n19 = t1.n19 AND t20.n20 = t1.n20);

PAUSE

ALTER SYSTEM FLUSH SHARED_POOL;

ALTER SESSION SET use_stored_outlines = TRUE;

ALTER SESSION SET tracefile_identifier = 'outline';
execute dbms_monitor.session_trace_enable

SELECT  count(*)
FROM t1
WHERE t1.n1 = 1 AND n2 = 2 AND n3 = 3 AND n4 = 4 AND n5 = 5 AND n6 = 6 AND n7 = 7 AND n8 = 8 AND n9 = 9 AND n10 = 10 AND t1.n11 = 11 AND n12 = 12 AND n13 = 13 AND n14 = 14 AND n15 = 15 AND n16 = 16 AND n17 = 17 AND n18 = 18 AND n19 = 19 AND n20 = 20
AND EXISTS (SELECT 1 FROM t2 WHERE t2.n1 = t1.n1 AND t2.n2 = t1.n2 AND t2.n3 = t1.n3 AND t2.n4 = t1.n4 AND t2.n5 = t1.n5 AND t2.n6 = t1.n6 AND t2.n7 = t1.n7 AND t2.n8 = t1.n8 AND t2.n9 = t1.n9 AND t2.n10 = t1.n10 AND t2.n11 = t1.n11 AND t2.n12 = t1.n12 AND t2.n13 = t1.n13 AND t2.n14 = t1.n14 AND t2.n15 = t1.n15 AND t2.n16 = t1.n16 AND t2.n17 = t1.n17 AND t2.n18 = t1.n18 AND t2.n19 = t1.n19 AND t2.n20 = t1.n20)
AND EXISTS (SELECT 1 FROM t3 WHERE t3.n1 = t1.n1 AND t3.n2 = t1.n2 AND t3.n3 = t1.n3 AND t3.n4 = t1.n4 AND t3.n5 = t1.n5 AND t3.n6 = t1.n6 AND t3.n7 = t1.n7 AND t3.n8 = t1.n8 AND t3.n9 = t1.n9 AND t3.n10 = t1.n10 AND t3.n11 = t1.n11 AND t3.n12 = t1.n12 AND t3.n13 = t1.n13 AND t3.n14 = t1.n14 AND t3.n15 = t1.n15 AND t3.n16 = t1.n16 AND t3.n17 = t1.n17 AND t3.n18 = t1.n18 AND t3.n19 = t1.n19 AND t3.n20 = t1.n20)
AND EXISTS (SELECT 1 FROM t4 WHERE t4.n1 = t1.n1 AND t4.n2 = t1.n2 AND t4.n3 = t1.n3 AND t4.n4 = t1.n4 AND t4.n5 = t1.n5 AND t4.n6 = t1.n6 AND t4.n7 = t1.n7 AND t4.n8 = t1.n8 AND t4.n9 = t1.n9 AND t4.n10 = t1.n10 AND t4.n11 = t1.n11 AND t4.n12 = t1.n12 AND t4.n13 = t1.n13 AND t4.n14 = t1.n14 AND t4.n15 = t1.n15 AND t4.n16 = t1.n16 AND t4.n17 = t1.n17 AND t4.n18 = t1.n18 AND t4.n19 = t1.n19 AND t4.n20 = t1.n20)
AND EXISTS (SELECT 1 FROM t5 WHERE t5.n1 = t1.n1 AND t5.n2 = t1.n2 AND t5.n3 = t1.n3 AND t5.n4 = t1.n4 AND t5.n5 = t1.n5 AND t5.n6 = t1.n6 AND t5.n7 = t1.n7 AND t5.n8 = t1.n8 AND t5.n9 = t1.n9 AND t5.n10 = t1.n10 AND t5.n11 = t1.n11 AND t5.n12 = t1.n12 AND t5.n13 = t1.n13 AND t5.n14 = t1.n14 AND t5.n15 = t1.n15 AND t5.n16 = t1.n16 AND t5.n17 = t1.n17 AND t5.n18 = t1.n18 AND t5.n19 = t1.n19 AND t5.n20 = t1.n20)
AND EXISTS (SELECT 1 FROM t6 WHERE t6.n1 = t1.n1 AND t6.n2 = t1.n2 AND t6.n3 = t1.n3 AND t6.n4 = t1.n4 AND t6.n5 = t1.n5 AND t6.n6 = t1.n6 AND t6.n7 = t1.n7 AND t6.n8 = t1.n8 AND t6.n9 = t1.n9 AND t6.n10 = t1.n10 AND t6.n11 = t1.n11 AND t6.n12 = t1.n12 AND t6.n13 = t1.n13 AND t6.n14 = t1.n14 AND t6.n15 = t1.n15 AND t6.n16 = t1.n16 AND t6.n17 = t1.n17 AND t6.n18 = t1.n18 AND t6.n19 = t1.n19 AND t6.n20 = t1.n20)
AND EXISTS (SELECT 1 FROM t7 WHERE t7.n1 = t1.n1 AND t7.n2 = t1.n2 AND t7.n3 = t1.n3 AND t7.n4 = t1.n4 AND t7.n5 = t1.n5 AND t7.n6 = t1.n6 AND t7.n7 = t1.n7 AND t7.n8 = t1.n8 AND t7.n9 = t1.n9 AND t7.n10 = t1.n10 AND t7.n11 = t1.n11 AND t7.n12 = t1.n12 AND t7.n13 = t1.n13 AND t7.n14 = t1.n14 AND t7.n15 = t1.n15 AND t7.n16 = t1.n16 AND t7.n17 = t1.n17 AND t7.n18 = t1.n18 AND t7.n19 = t1.n19 AND t7.n20 = t1.n20)
AND EXISTS (SELECT 1 FROM t8 WHERE t8.n1 = t1.n1 AND t8.n2 = t1.n2 AND t8.n3 = t1.n3 AND t8.n4 = t1.n4 AND t8.n5 = t1.n5 AND t8.n6 = t1.n6 AND t8.n7 = t1.n7 AND t8.n8 = t1.n8 AND t8.n9 = t1.n9 AND t8.n10 = t1.n10 AND t8.n11 = t1.n11 AND t8.n12 = t1.n12 AND t8.n13 = t1.n13 AND t8.n14 = t1.n14 AND t8.n15 = t1.n15 AND t8.n16 = t1.n16 AND t8.n17 = t1.n17 AND t8.n18 = t1.n18 AND t8.n19 = t1.n19 AND t8.n20 = t1.n20)
AND EXISTS (SELECT 1 FROM t9 WHERE t9.n1 = t1.n1 AND t9.n2 = t1.n2 AND t9.n3 = t1.n3 AND t9.n4 = t1.n4 AND t9.n5 = t1.n5 AND t9.n6 = t1.n6 AND t9.n7 = t1.n7 AND t9.n8 = t1.n8 AND t9.n9 = t1.n9 AND t9.n10 = t1.n10 AND t9.n11 = t1.n11 AND t9.n12 = t1.n12 AND t9.n13 = t1.n13 AND t9.n14 = t1.n14 AND t9.n15 = t1.n15 AND t9.n16 = t1.n16 AND t9.n17 = t1.n17 AND t9.n18 = t1.n18 AND t9.n19 = t1.n19 AND t9.n20 = t1.n20)
AND EXISTS (SELECT 1 FROM t10 WHERE t10.n1 = t1.n1 AND t10.n2 = t1.n2 AND t10.n3 = t1.n3 AND t10.n4 = t1.n4 AND t10.n5 = t1.n5 AND t10.n6 = t1.n6 AND t10.n7 = t1.n7 AND t10.n8 = t1.n8 AND t10.n9 = t1.n9 AND t10.n10 = t1.n10 AND t10.n11 = t1.n11 AND t10.n12 = t1.n12 AND t10.n13 = t1.n13 AND t10.n14 = t1.n14 AND t10.n15 = t1.n15 AND t10.n16 = t1.n16 AND t10.n17 = t1.n17 AND t10.n18 = t1.n18 AND t10.n19 = t1.n19 AND t10.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t11 WHERE t11.n1 = t1.n1 AND t11.n2 = t1.n2 AND t11.n3 = t1.n3 AND t11.n4 = t1.n4 AND t11.n5 = t1.n5 AND t11.n6 = t1.n6 AND t11.n7 = t1.n7 AND t11.n8 = t1.n8 AND t11.n9 = t1.n9 AND t11.n10 = t1.n10 AND t11.n11 = t1.n11 AND t11.n12 = t1.n12 AND t11.n13 = t1.n13 AND t11.n14 = t1.n14 AND t11.n15 = t1.n15 AND t11.n16 = t1.n16 AND t11.n17 = t1.n17 AND t11.n18 = t1.n18 AND t11.n19 = t1.n19 AND t11.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t12 WHERE t12.n1 = t1.n1 AND t12.n2 = t1.n2 AND t12.n3 = t1.n3 AND t12.n4 = t1.n4 AND t12.n5 = t1.n5 AND t12.n6 = t1.n6 AND t12.n7 = t1.n7 AND t12.n8 = t1.n8 AND t12.n9 = t1.n9 AND t12.n10 = t1.n10 AND t12.n11 = t1.n11 AND t12.n12 = t1.n12 AND t12.n13 = t1.n13 AND t12.n14 = t1.n14 AND t12.n15 = t1.n15 AND t12.n16 = t1.n16 AND t12.n17 = t1.n17 AND t12.n18 = t1.n18 AND t12.n19 = t1.n19 AND t12.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t13 WHERE t13.n1 = t1.n1 AND t13.n2 = t1.n2 AND t13.n3 = t1.n3 AND t13.n4 = t1.n4 AND t13.n5 = t1.n5 AND t13.n6 = t1.n6 AND t13.n7 = t1.n7 AND t13.n8 = t1.n8 AND t13.n9 = t1.n9 AND t13.n10 = t1.n10 AND t13.n11 = t1.n11 AND t13.n12 = t1.n12 AND t13.n13 = t1.n13 AND t13.n14 = t1.n14 AND t13.n15 = t1.n15 AND t13.n16 = t1.n16 AND t13.n17 = t1.n17 AND t13.n18 = t1.n18 AND t13.n19 = t1.n19 AND t13.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t14 WHERE t14.n1 = t1.n1 AND t14.n2 = t1.n2 AND t14.n3 = t1.n3 AND t14.n4 = t1.n4 AND t14.n5 = t1.n5 AND t14.n6 = t1.n6 AND t14.n7 = t1.n7 AND t14.n8 = t1.n8 AND t14.n9 = t1.n9 AND t14.n10 = t1.n10 AND t14.n11 = t1.n11 AND t14.n12 = t1.n12 AND t14.n13 = t1.n13 AND t14.n14 = t1.n14 AND t14.n15 = t1.n15 AND t14.n16 = t1.n16 AND t14.n17 = t1.n17 AND t14.n18 = t1.n18 AND t14.n19 = t1.n19 AND t14.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t15 WHERE t15.n1 = t1.n1 AND t15.n2 = t1.n2 AND t15.n3 = t1.n3 AND t15.n4 = t1.n4 AND t15.n5 = t1.n5 AND t15.n6 = t1.n6 AND t15.n7 = t1.n7 AND t15.n8 = t1.n8 AND t15.n9 = t1.n9 AND t15.n10 = t1.n10 AND t15.n11 = t1.n11 AND t15.n12 = t1.n12 AND t15.n13 = t1.n13 AND t15.n14 = t1.n14 AND t15.n15 = t1.n15 AND t15.n16 = t1.n16 AND t15.n17 = t1.n17 AND t15.n18 = t1.n18 AND t15.n19 = t1.n19 AND t15.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t16 WHERE t16.n1 = t1.n1 AND t16.n2 = t1.n2 AND t16.n3 = t1.n3 AND t16.n4 = t1.n4 AND t16.n5 = t1.n5 AND t16.n6 = t1.n6 AND t16.n7 = t1.n7 AND t16.n8 = t1.n8 AND t16.n9 = t1.n9 AND t16.n10 = t1.n10 AND t16.n11 = t1.n11 AND t16.n12 = t1.n12 AND t16.n13 = t1.n13 AND t16.n14 = t1.n14 AND t16.n15 = t1.n15 AND t16.n16 = t1.n16 AND t16.n17 = t1.n17 AND t16.n18 = t1.n18 AND t16.n19 = t1.n19 AND t16.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t17 WHERE t17.n1 = t1.n1 AND t17.n2 = t1.n2 AND t17.n3 = t1.n3 AND t17.n4 = t1.n4 AND t17.n5 = t1.n5 AND t17.n6 = t1.n6 AND t17.n7 = t1.n7 AND t17.n8 = t1.n8 AND t17.n9 = t1.n9 AND t17.n10 = t1.n10 AND t17.n11 = t1.n11 AND t17.n12 = t1.n12 AND t17.n13 = t1.n13 AND t17.n14 = t1.n14 AND t17.n15 = t1.n15 AND t17.n16 = t1.n16 AND t17.n17 = t1.n17 AND t17.n18 = t1.n18 AND t17.n19 = t1.n19 AND t17.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t18 WHERE t18.n1 = t1.n1 AND t18.n2 = t1.n2 AND t18.n3 = t1.n3 AND t18.n4 = t1.n4 AND t18.n5 = t1.n5 AND t18.n6 = t1.n6 AND t18.n7 = t1.n7 AND t18.n8 = t1.n8 AND t18.n9 = t1.n9 AND t18.n10 = t1.n10 AND t18.n11 = t1.n11 AND t18.n12 = t1.n12 AND t18.n13 = t1.n13 AND t18.n14 = t1.n14 AND t18.n15 = t1.n15 AND t18.n16 = t1.n16 AND t18.n17 = t1.n17 AND t18.n18 = t1.n18 AND t18.n19 = t1.n19 AND t18.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t19 WHERE t19.n1 = t1.n1 AND t19.n2 = t1.n2 AND t19.n3 = t1.n3 AND t19.n4 = t1.n4 AND t19.n5 = t1.n5 AND t19.n6 = t1.n6 AND t19.n7 = t1.n7 AND t19.n8 = t1.n8 AND t19.n9 = t1.n9 AND t19.n10 = t1.n10 AND t19.n11 = t1.n11 AND t19.n12 = t1.n12 AND t19.n13 = t1.n13 AND t19.n14 = t1.n14 AND t19.n15 = t1.n15 AND t19.n16 = t1.n16 AND t19.n17 = t1.n17 AND t19.n18 = t1.n18 AND t19.n19 = t1.n19 AND t19.n20 = t1.n20)
AND NOT EXISTS (SELECT 1 FROM t20 WHERE t20.n1 = t1.n1 AND t20.n2 = t1.n2 AND t20.n3 = t1.n3 AND t20.n4 = t1.n4 AND t20.n5 = t1.n5 AND t20.n6 = t1.n6 AND t20.n7 = t1.n7 AND t20.n8 = t1.n8 AND t20.n9 = t1.n9 AND t20.n10 = t1.n10 AND t20.n11 = t1.n11 AND t20.n12 = t1.n12 AND t20.n13 = t1.n13 AND t20.n14 = t1.n14 AND t20.n15 = t1.n15 AND t20.n16 = t1.n16 AND t20.n17 = t1.n17 AND t20.n18 = t1.n18 AND t20.n19 = t1.n19 AND t20.n20 = t1.n20);

execute dbms_monitor.session_trace_disable

PAUSE

REM
REM Cleanup
REM

DROP OUTLINE o;

BEGIN
  FOR i IN 1..20 LOOP
    BEGIN
      EXECUTE IMMEDIATE 'DROP TABLE t' || i;
      EXECUTE IMMEDIATE 'PURGE TABLE t' || i;
    EXCEPTION
      WHEN OTHERS THEN NULL;
    END;
  END LOOP;
END;
/
