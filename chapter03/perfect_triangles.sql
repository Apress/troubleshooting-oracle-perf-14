SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM File name...: perfect_triangles.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: You can use this script to create the PL/SQL procedure
REM               perfect_triangles used as an example in the "Gathering the
REM               Profiling Data" section.
REM Notes.......: The code of this procedure is distributed by Oracle in the
REM               following file: $ORACLE_HOME/plsql/demo/ncmpdemo.sql.
REM Parameters..: -
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 23.03.2014 Added a package and a type that call the procedure
REM ***************************************************************************
SET ECHO ON

@../connect.sql

CREATE OR REPLACE PROCEDURE perfect_triangles(p_max IN INTEGER) IS
  hyp NUMBER; 
  ihyp INTEGER;
  TYPE side_r IS RECORD(short INTEGER, long INTEGER);
  TYPE sides_t IS TABLE OF side_r INDEX BY BINARY_INTEGER;
  unique_sides sides_t; 
  dup_sides sides_t;    
  n integer :=0;
  m integer :=0;
  
  PROCEDURE store_dup_sides(p_long IN INTEGER, p_short IN INTEGER) IS
    mult INTEGER := 2; 
    long_mult INTEGER := p_long*2; 
    short_mult INTEGER := p_short*2;
  BEGIN
    WHILE long_mult < p_max OR short_mult < p_max
    LOOP
      n := n+1;
      dup_sides(n).long := long_mult; 
      dup_sides(n).short := short_mult;
      mult := mult+1; 
      long_mult := p_long*mult; 
      short_mult := p_short*mult;
    END LOOP;
  END store_dup_sides;

  FUNCTION sides_are_unique(p_long IN INTEGER, p_short IN INTEGER) RETURN BOOLEAN IS
  BEGIN
    FOR j IN 1..n
    LOOP
      IF p_long = dup_sides(j).long  
         AND 
         p_short = dup_sides(j).short
      THEN 
        RETURN FALSE; 
      END IF;
    END LOOP;
    RETURN TRUE;
  END sides_are_unique;

BEGIN
  FOR long IN 1..p_max
  LOOP
    FOR short IN 1..long
    LOOP
      hyp := sqrt(long*long + short*short); 
      ihyp := floor(hyp);
      IF hyp-ihyp < 0.01
      THEN
        IF ihyp*ihyp = long*long + short*short
        THEN
          IF sides_are_unique(long, short)
          THEN
            m := m+1;
            unique_sides(m).long := long;
            unique_sides(m).short := short;
            store_dup_sides(long, short);
          END IF;
        END IF;
      END IF;
    END LOOP;
  END LOOP;
  FOR j IN 1..m
  LOOP
    dbms_output.put_line('.' ||
                         lpad(unique_sides(j).long, 4,' ')||
                         lpad(unique_sides(j).short,4,' '));
  END LOOP;
END perfect_triangles;
/

CREATE OR REPLACE PACKAGE perfect_triangles_pck IS
  PROCEDURE run(p_max IN INTEGER);
END perfect_triangles_pck;
/

CREATE OR REPLACE PACKAGE BODY perfect_triangles_pck IS
  PROCEDURE run(p_max IN INTEGER) IS
  BEGIN
    perfect_triangles(p_max);
  END run;
END perfect_triangles_pck;
/

CREATE OR REPLACE TYPE perfect_triangles_typ AS OBJECT (
  dummy NUMBER,
  STATIC PROCEDURE run(p_max IN INTEGER)
);
/

CREATE OR REPLACE TYPE BODY perfect_triangles_typ IS
  STATIC PROCEDURE run(p_max IN INTEGER) IS
  BEGIN
    perfect_triangles(p_max);
  END run;
END;
/


