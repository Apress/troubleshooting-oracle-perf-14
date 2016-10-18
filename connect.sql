SET ECHO OFF
REM ***************************************************************************
REM ******************* Troubleshooting Oracle Performance ********************
REM ************************* http://top.antognini.ch *************************
REM ***************************************************************************
REM
REM Script......: connect.sql
REM Author......: Christian Antognini
REM Date........: August 2008
REM Description.: This script is called by all other scripts to open a
REM               connection.
REM Notes.......: The user connecting the database must be a DBA.
REM
REM You can send feedbacks or questions about this script to top@antognini.ch.
REM
REM Changes:
REM DD.MM.YYYY Description
REM ---------------------------------------------------------------------------
REM 07.03.2009 Added DBM11107 and DBA11107
REM 24.06.2010 Added DBM10205, DBA10205, DBM11201 and DBA11201
REM 12.01.2012 Added DBM11202, DBA11202, DBM11203, DBA11203 + user and password
REM 29.06.2014 Added DBM11204, DBA11204, DBM12101, DBA12101, DBM12102, DBA12102
REM ***************************************************************************
SET ECHO ON

REM CONNECT chris/ian@dbm9204.antognini.ch
REM CONNECT chris/ian@dba9204.antognini.ch
REM CONNECT chris/ian@dbm9206.antognini.ch
REM CONNECT chris/ian@dba9206.antognini.ch
REM CONNECT chris/ian@dbm9207.antognini.ch
REM CONNECT chris/ian@dba9207.antognini.ch
REM CONNECT chris/ian@dbm9208.antognini.ch
REM CONNECT chris/ian@dba9208.antognini.ch
REM CONNECT chris/ian@dbm10103.antognini.ch
REM CONNECT chris/ian@dba10103.antognini.ch
REM CONNECT chris/ian@dbm10104.antognini.ch
REM CONNECT chris/ian@dba10104.antognini.ch
REM CONNECT chris/ian@dbm10105.antognini.ch
REM CONNECT chris/ian@dba10105.antognini.ch
REM CONNECT chris/ian@dbm10201.antognini.ch
REM CONNECT chris/ian@dba10201.antognini.ch
REM CONNECT chris/ian@dbm10202.antognini.ch
REM CONNECT chris/ian@dba10202.antognini.ch
REM CONNECT chris/ian@dbm10203.antognini.ch
REM CONNECT chris/ian@dba10203.antognini.ch
REM CONNECT chris/ian@dbm10204.antognini.ch
REM CONNECT chris/ian@dba10204.antognini.ch
REM CONNECT chris/ian@dbm10205.antognini.ch
REM CONNECT chris/ian@dba10205.antognini.ch
REM CONNECT chris/ian@dbm11106.antognini.ch
REM CONNECT chris/ian@dba11106.antognini.ch
REM CONNECT chris/ian@dbm11107.antognini.ch
REM CONNECT chris/ian@dba11107.antognini.ch
REM CONNECT chris/ian@dba11201.antognini.ch
REM CONNECT chris/ian@dbm11202.antognini.ch
REM CONNECT chris/ian@dba11202.antognini.ch
REM CONNECT chris/ian@dbm11203.antognini.ch
REM CONNECT chris/ian@dba11203.antognini.ch
REM CONNECT chris/ian@dbm11204.antognini.ch
REM CONNECT chris/ian@dba11204.antognini.ch
REM CONNECT chris/ian@dbm12101.antognini.ch
REM CONNECT chris/ian@dba12101.antognini.ch
REM CONNECT chris/ian@dbm12102.antognini.ch
REM CONNECT chris/ian@dba12102.antognini.ch
CONNECT &user/&password@&service
REM CONNECT chris/ian

REM
REM Display working environment
REM

SELECT user, instance_name, host_name
FROM v$instance;

SELECT *
FROM v$version
WHERE rownum = 1;
