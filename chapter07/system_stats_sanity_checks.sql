SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: system_stats_sanity_checks.sql
REM Author......: Christian Antognini
REM Date........: January 2013
REM Description.: This script shows the corrections performed by the query
REM               optimizer when the workload system statistics are not
REM               considered consistent.
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

VARIABLE cpuspeed NUMBER
VARIABLE ioseektim NUMBER
VARIABLE def_ioseektim NUMBER
VARIABLE iotfrspeed NUMBER
VARIABLE def_iotfrspeed NUMBER
VARIABLE sreadtim NUMBER
VARIABLE mreadtim NUMBER
VARIABLE mbrc NUMBER
VARIABLE dfmbrc NUMBER

BEGIN
  :cpuspeed := 2000;
  :ioseektim := 3;
  :def_ioseektim := 10;
  :iotfrspeed := 100000;
  :def_iotfrspeed := 4096;
  :sreadtim := 4;
  :mreadtim := 12;
  :mbrc := 16;
  :dfmbrc := 128;
END;
/

VARIABLE block_size NUMBER
VARIABLE def_block_size NUMBER

SET ECHO ON

REM
REM Setup test environment
REM

DROP TABLE t;

CREATE TABLE t (
	n1 number,n2 number,n3 number,n4 number,n5 number,n6 number,n7 number,n8 number,n9 number,
	n10 number,n11 number,n12 number,n13 number,n14 number,n15 number,n16 number,n17 number,n18 number,n19 number,
	n20 number,n21 number,n22 number,n23 number,n24 number,n25 number,n26 number,n27 number,n28 number,n29 number,
	n30 number,n31 number,n32 number,n33 number,n34 number,n35 number,n36 number,n37 number,n38 number,n39 number,
	n40 number,n41 number,n42 number,n43 number,n44 number,n45 number,n46 number,n47 number,n48 number,n49 number,
	n50 number,n51 number,n52 number,n53 number,n54 number,n55 number,n56 number,n57 number,n58 number,n59 number,
	n60 number,n61 number,n62 number,n63 number,n64 number,n65 number,n66 number,n67 number,n68 number,n69 number,
	n70 number,n71 number,n72 number,n73 number,n74 number,n75 number,n76 number,n77 number,n78 number,n79 number,
	n80 number,n81 number,n82 number,n83 number,n84 number,n85 number,n86 number,n87 number,n88 number,n89 number,
	n90 number,n91 number,n92 number,n93 number,n94 number,n95 number,n96 number,n97 number,n98 number,n99 number,
	n100 number,n101 number,n102 number,n103 number,n104 number,n105 number,n106 number,n107 number,n108 number,n109 number,
	n110 number,n111 number,n112 number,n113 number,n114 number,n115 number,n116 number,n117 number,n118 number,n119 number,
	n120 number,n121 number,n122 number,n123 number,n124 number,n125 number,n126 number,n127 number,n128 number,n129 number,
	n130 number,n131 number,n132 number,n133 number,n134 number,n135 number,n136 number,n137 number,n138 number,n139 number,
	n140 number,n141 number,n142 number,n143 number,n144 number,n145 number,n146 number,n147 number,n148 number,n149 number,
	n150 number,n151 number,n152 number,n153 number,n154 number,n155 number,n156 number,n157 number,n158 number,n159 number,
	n160 number,n161 number,n162 number,n163 number,n164 number,n165 number,n166 number,n167 number,n168 number,n169 number,
	n170 number,n171 number,n172 number,n173 number,n174 number,n175 number,n176 number,n177 number,n178 number,n179 number,
	n180 number,n181 number,n182 number,n183 number,n184 number,n185 number,n186 number,n187 number,n188 number,n189 number,
	n190 number,n191 number,n192 number,n193 number,n194 number,n195 number,n196 number,n197 number,n198 number,n199 number,
	n200 number,n201 number,n202 number,n203 number,n204 number,n205 number,n206 number,n207 number,n208 number,n209 number,
	n210 number,n211 number,n212 number,n213 number,n214 number,n215 number,n216 number,n217 number,n218 number,n219 number,
	n220 number,n221 number,n222 number,n223 number,n224 number,n225 number,n226 number,n227 number,n228 number,n229 number,
	n230 number,n231 number,n232 number,n233 number,n234 number,n235 number,n236 number,n237 number,n238 number,n239 number,
	n240 number,n241 number,n242 number,n243 number,n244 number,n245 number,n246 number,n247 number,n248 number,n249 number,
	n250 number
);

INSERT INTO t SELECT 
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0
FROM dual
CONNECT BY level <= 10000;

COMMIT;

BEGIN
  SELECT value
  INTO :def_block_size
  FROM v$parameter
  WHERE name = 'db_block_size';

  SELECT block_size
  INTO :block_size
  FROM user_tablespaces
  WHERE tablespace_name = (SELECT tablespace_name
                           FROM user_segments
                           WHERE segment_name = 'T'
                           AND segment_type = 'TABLE');

  dbms_stats.gather_table_stats(user,'t');

  EXECUTE IMMEDIATE 'ALTER SESSION SET db_file_multiblock_read_count = '||:dfmbrc;
END;
/

DELETE plan_table;

ALTER SESSION SET optimizer_mode = all_rows;

PAUSE

REM
REM Noworkload system statistics (default)
REM

BEGIN
  dbms_stats.delete_system_stats;
  dbms_stats.set_system_stats(pname=>'CPUSPEEDNW', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'IOSEEKTIM', pvalue=>:def_ioseektim);
  dbms_stats.set_system_stats(pname=>'IOTFRSPEED', pvalue=>:def_iotfrspeed);
END;
/

EXPLAIN PLAN SET STATEMENT_ID 'def nw / workload missing' FOR SELECT * FROM t;

PAUSE

REM
REM Noworkload system statistics (not default)
REM

BEGIN
  dbms_stats.delete_system_stats;
  dbms_stats.set_system_stats(pname=>'CPUSPEEDNW', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'IOSEEKTIM', pvalue=>:def_ioseektim);
  dbms_stats.set_system_stats(pname=>'IOTFRSPEED', pvalue=>:def_iotfrspeed);
  dbms_stats.set_system_stats(pname=>'CPUSPEEDNW', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'IOSEEKTIM', pvalue=>:ioseektim);
  dbms_stats.set_system_stats(pname=>'IOTFRSPEED', pvalue=>:iotfrspeed);
END;
/

EXPLAIN PLAN SET STATEMENT_ID 'usr nw / workload missing' FOR SELECT * FROM t;

PAUSE

REM
REM Workload system statistics
REM

BEGIN
  dbms_stats.delete_system_stats;
  dbms_stats.set_system_stats(pname=>'CPUSPEEDNW', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'IOSEEKTIM', pvalue=>:def_ioseektim);
  dbms_stats.set_system_stats(pname=>'IOTFRSPEED', pvalue=>:def_iotfrspeed);
  dbms_stats.set_system_stats(pname=>'CPUSPEED', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'SREADTIM', pvalue=>:sreadtim);
  dbms_stats.set_system_stats(pname=>'MREADTIM', pvalue=>:mreadtim);
  dbms_stats.set_system_stats(pname=>'MBRC', pvalue=>:mbrc);
END;
/

EXPLAIN PLAN SET STATEMENT_ID 'def nw / workload' FOR SELECT * FROM t;

BEGIN
  dbms_stats.delete_system_stats;
  dbms_stats.set_system_stats(pname=>'CPUSPEEDNW', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'IOSEEKTIM', pvalue=>:ioseektim);
  dbms_stats.set_system_stats(pname=>'IOTFRSPEED', pvalue=>:iotfrspeed);
  dbms_stats.set_system_stats(pname=>'CPUSPEED', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'SREADTIM', pvalue=>:sreadtim);
  dbms_stats.set_system_stats(pname=>'MREADTIM', pvalue=>:mreadtim);
  dbms_stats.set_system_stats(pname=>'MBRC', pvalue=>:mbrc);
END;
/

EXPLAIN PLAN SET STATEMENT_ID 'usr nw / workload' FOR SELECT * FROM t;

PAUSE

REM
REM Workload system statistics (sreadtim IS NULL)
REM

BEGIN
  dbms_stats.delete_system_stats;
  dbms_stats.set_system_stats(pname=>'CPUSPEEDNW', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'IOSEEKTIM', pvalue=>:def_ioseektim);
  dbms_stats.set_system_stats(pname=>'IOTFRSPEED', pvalue=>:def_iotfrspeed);
  dbms_stats.set_system_stats(pname=>'CPUSPEED', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'MREADTIM', pvalue=>:mreadtim);
  dbms_stats.set_system_stats(pname=>'MBRC', pvalue=>:mbrc);
END;
/

EXPLAIN PLAN SET STATEMENT_ID 'def nw / workload: no sread' FOR SELECT * FROM t;

BEGIN
  dbms_stats.delete_system_stats;
  dbms_stats.set_system_stats(pname=>'CPUSPEEDNW', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'IOSEEKTIM', pvalue=>:ioseektim);
  dbms_stats.set_system_stats(pname=>'IOTFRSPEED', pvalue=>:iotfrspeed);
  dbms_stats.set_system_stats(pname=>'CPUSPEED', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'MREADTIM', pvalue=>:mreadtim);
  dbms_stats.set_system_stats(pname=>'MBRC', pvalue=>:mbrc);
END;
/

EXPLAIN PLAN SET STATEMENT_ID 'usr nw / workload: no sread' FOR SELECT * FROM t;

PAUSE

REM
REM Workload system statistics (mreadtim IS NULL)
REM

BEGIN
  dbms_stats.delete_system_stats;
  dbms_stats.set_system_stats(pname=>'CPUSPEEDNW', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'IOSEEKTIM', pvalue=>:def_ioseektim);
  dbms_stats.set_system_stats(pname=>'IOTFRSPEED', pvalue=>:def_iotfrspeed);
  dbms_stats.set_system_stats(pname=>'CPUSPEED', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'SREADTIM', pvalue=>:sreadtim);
  dbms_stats.set_system_stats(pname=>'MBRC', pvalue=>:mbrc);
END;
/

EXPLAIN PLAN SET STATEMENT_ID 'def nw / workload: no mread' FOR SELECT * FROM t;

BEGIN
  dbms_stats.delete_system_stats;
  dbms_stats.set_system_stats(pname=>'CPUSPEEDNW', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'IOSEEKTIM', pvalue=>:ioseektim);
  dbms_stats.set_system_stats(pname=>'IOTFRSPEED', pvalue=>:iotfrspeed);
  dbms_stats.set_system_stats(pname=>'CPUSPEED', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'SREADTIM', pvalue=>:sreadtim);
  dbms_stats.set_system_stats(pname=>'MBRC', pvalue=>:mbrc);
END;
/

EXPLAIN PLAN SET STATEMENT_ID 'usr nw / workload: no mread' FOR SELECT * FROM t;

PAUSE

REM
REM Workload system statistics (workload stats: sreadtim = 0)
REM

BEGIN
  dbms_stats.delete_system_stats;
  dbms_stats.set_system_stats(pname=>'CPUSPEEDNW', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'IOSEEKTIM', pvalue=>:def_ioseektim);
  dbms_stats.set_system_stats(pname=>'IOTFRSPEED', pvalue=>:def_iotfrspeed);
  dbms_stats.set_system_stats(pname=>'CPUSPEED', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'SREADTIM', pvalue=>0);
  dbms_stats.set_system_stats(pname=>'MREADTIM', pvalue=>:mreadtim);
  dbms_stats.set_system_stats(pname=>'MBRC', pvalue=>:mbrc);
END;
/

EXPLAIN PLAN SET STATEMENT_ID 'def nw / workload: sread=0' FOR SELECT * FROM t;

BEGIN
  dbms_stats.delete_system_stats;
  dbms_stats.set_system_stats(pname=>'CPUSPEEDNW', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'IOSEEKTIM', pvalue=>:ioseektim);
  dbms_stats.set_system_stats(pname=>'IOTFRSPEED', pvalue=>:iotfrspeed);
  dbms_stats.set_system_stats(pname=>'CPUSPEED', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'SREADTIM', pvalue=>0);
  dbms_stats.set_system_stats(pname=>'MREADTIM', pvalue=>:mreadtim);
  dbms_stats.set_system_stats(pname=>'MBRC', pvalue=>:mbrc);
END;
/

EXPLAIN PLAN SET STATEMENT_ID 'usr nw / workload: sread=0' FOR SELECT * FROM t;

PAUSE

REM
REM Workload system statistics (workload stats: sreadtim = mreadtim)
REM

BEGIN
  dbms_stats.delete_system_stats;
  dbms_stats.set_system_stats(pname=>'CPUSPEEDNW', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'IOSEEKTIM', pvalue=>:def_ioseektim);
  dbms_stats.set_system_stats(pname=>'IOTFRSPEED', pvalue=>:def_iotfrspeed);
  dbms_stats.set_system_stats(pname=>'CPUSPEED', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'SREADTIM', pvalue=>:mreadtim);
  dbms_stats.set_system_stats(pname=>'MREADTIM', pvalue=>:mreadtim);
  dbms_stats.set_system_stats(pname=>'MBRC', pvalue=>:mbrc);
END;
/

EXPLAIN PLAN SET STATEMENT_ID 'def nw / workload: sread=mread' FOR SELECT * FROM t;

BEGIN
  dbms_stats.delete_system_stats;
  dbms_stats.set_system_stats(pname=>'CPUSPEEDNW', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'IOSEEKTIM', pvalue=>:ioseektim);
  dbms_stats.set_system_stats(pname=>'IOTFRSPEED', pvalue=>:iotfrspeed);
  dbms_stats.set_system_stats(pname=>'CPUSPEED', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'SREADTIM', pvalue=>:mreadtim);
  dbms_stats.set_system_stats(pname=>'MREADTIM', pvalue=>:mreadtim);
  dbms_stats.set_system_stats(pname=>'MBRC', pvalue=>:mbrc);
END;
/

EXPLAIN PLAN SET STATEMENT_ID 'usr nw / workload: sread=mread' FOR SELECT * FROM t;

PAUSE

REM
REM Workload system statistics (workload stats: sreadtim = mreadtim)
REM

BEGIN
  dbms_stats.delete_system_stats;
  dbms_stats.set_system_stats(pname=>'CPUSPEEDNW', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'IOSEEKTIM', pvalue=>:def_ioseektim);
  dbms_stats.set_system_stats(pname=>'IOTFRSPEED', pvalue=>:def_iotfrspeed);
  dbms_stats.set_system_stats(pname=>'CPUSPEED', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'SREADTIM', pvalue=>:mreadtim+1E-9);
  dbms_stats.set_system_stats(pname=>'MREADTIM', pvalue=>:mreadtim);
  dbms_stats.set_system_stats(pname=>'MBRC', pvalue=>:mbrc);
END;
/

EXPLAIN PLAN SET STATEMENT_ID 'def nw / workload: sread>mread' FOR SELECT * FROM t;

BEGIN
  dbms_stats.delete_system_stats;
  dbms_stats.set_system_stats(pname=>'CPUSPEEDNW', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'IOSEEKTIM', pvalue=>:ioseektim);
  dbms_stats.set_system_stats(pname=>'IOTFRSPEED', pvalue=>:iotfrspeed);
  dbms_stats.set_system_stats(pname=>'CPUSPEED', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'SREADTIM', pvalue=>:mreadtim+1E-9);
  dbms_stats.set_system_stats(pname=>'MREADTIM', pvalue=>:mreadtim);
  dbms_stats.set_system_stats(pname=>'MBRC', pvalue=>:mbrc);
END;
/

EXPLAIN PLAN SET STATEMENT_ID 'usr nw / workload: sread>mread' FOR SELECT * FROM t;

PAUSE

REM
REM Workload system statistics (workload stats: mbrc = 0)
REM

BEGIN
  dbms_stats.delete_system_stats;
  dbms_stats.set_system_stats(pname=>'CPUSPEEDNW', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'IOSEEKTIM', pvalue=>:def_ioseektim);
  dbms_stats.set_system_stats(pname=>'IOTFRSPEED', pvalue=>:def_iotfrspeed);
  dbms_stats.set_system_stats(pname=>'CPUSPEED', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'SREADTIM', pvalue=>:sreadtim);
  dbms_stats.set_system_stats(pname=>'MREADTIM', pvalue=>:mreadtim);
  dbms_stats.set_system_stats(pname=>'MBRC', pvalue=>0);
END;
/

EXPLAIN PLAN SET STATEMENT_ID 'def nw / workload: mbrc=0' FOR SELECT * FROM t;

BEGIN
  dbms_stats.delete_system_stats;
  dbms_stats.set_system_stats(pname=>'CPUSPEEDNW', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'IOSEEKTIM', pvalue=>:ioseektim);
  dbms_stats.set_system_stats(pname=>'IOTFRSPEED', pvalue=>:iotfrspeed);
  dbms_stats.set_system_stats(pname=>'CPUSPEED', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'SREADTIM', pvalue=>:sreadtim);
  dbms_stats.set_system_stats(pname=>'MREADTIM', pvalue=>:mreadtim);
  dbms_stats.set_system_stats(pname=>'MBRC', pvalue=>0);
END;
/

EXPLAIN PLAN SET STATEMENT_ID 'usr nw / workload: mbrc=0' FOR SELECT * FROM t;

PAUSE

REM
REM Workload system statistics (workload stats: mbrc = 0)
REM

BEGIN
  dbms_stats.delete_system_stats;
  dbms_stats.set_system_stats(pname=>'CPUSPEEDNW', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'IOSEEKTIM', pvalue=>:def_ioseektim);
  dbms_stats.set_system_stats(pname=>'IOTFRSPEED', pvalue=>:def_iotfrspeed);
  dbms_stats.set_system_stats(pname=>'CPUSPEED', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'SREADTIM', pvalue=>:sreadtim);
  dbms_stats.set_system_stats(pname=>'MREADTIM', pvalue=>:mreadtim);
END;
/

EXPLAIN PLAN SET STATEMENT_ID 'def nw / workload: no mbrc' FOR SELECT * FROM t;

BEGIN
  dbms_stats.delete_system_stats;
  dbms_stats.set_system_stats(pname=>'CPUSPEEDNW', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'IOSEEKTIM', pvalue=>:ioseektim);
  dbms_stats.set_system_stats(pname=>'IOTFRSPEED', pvalue=>:iotfrspeed);
  dbms_stats.set_system_stats(pname=>'CPUSPEED', pvalue=>:cpuspeed);
  dbms_stats.set_system_stats(pname=>'SREADTIM', pvalue=>:sreadtim);
  dbms_stats.set_system_stats(pname=>'MREADTIM', pvalue=>:mreadtim);
END;
/

EXPLAIN PLAN SET STATEMENT_ID 'usr nw / workload: no mbrc' FOR SELECT * FROM t;

PAUSE

REM
REM Compare the estimations with the different sets of system statistics
REM

SELECT statement_id, cost, io_cost, cost-io_cost, cpu_cost
FROM plan_table
WHERE id = 0
ORDER BY statement_id;

SELECT 'DEFAULT' AS NW_TYPE,
       ceil(blocks/:mbrc * :mreadtim/:sreadtim + 1) AS io_cost_workload_stats, 
       ceil(blocks/:mbrc * (:def_ioseektim+:mbrc*:def_block_size/:def_iotfrspeed)/(:def_ioseektim+:def_block_size/:def_iotfrspeed)+1) AS io_cost_bad_workload_stats,
       ceil(blocks/(:dfmbrc*:def_block_size/:block_size) * (:def_ioseektim+(:dfmbrc*:def_block_size/:block_size)*:def_block_size/:def_iotfrspeed)/(:def_ioseektim+:def_block_size/:def_iotfrspeed)+1) AS io_cost_noworkload_stats
FROM user_tables
WHERE table_name = 'T'
UNION ALL
SELECT 'NOT DEFAULT' AS NW_TYPE,
       ceil(blocks/:mbrc * :mreadtim/:sreadtim + 1) AS io_cost_workload_stats, 
       ceil(blocks/:mbrc * (:ioseektim+:mbrc*:def_block_size/:iotfrspeed)/(:ioseektim+:def_block_size/:iotfrspeed)+1) AS io_cost_bad_workload_stats,
       ceil(blocks/(:dfmbrc*:def_block_size/:block_size) * (:ioseektim+(:dfmbrc*:def_block_size/:block_size)*:def_block_size/:iotfrspeed)/(:ioseektim+:def_block_size/:iotfrspeed)+1) AS io_cost_noworkload_stats
FROM user_tables
WHERE table_name = 'T';

PAUSE

REM
REM Cleanup
REM

execute dbms_stats.delete_system_stats

DROP TABLE t;
PURGE TABLE t;
