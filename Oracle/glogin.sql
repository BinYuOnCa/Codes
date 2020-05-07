


--


-- Copyright (c) 1988, 2005, Oracle. All Rights Reserved.


--


-- NAME


-- glogin.sql


--


-- DESCRIPTION


-- SQL*Plus global login "site profile" file


--


-- Add any SQL*Plus commands here that are to be executed when a


-- user starts SQL*Plus, or uses the SQL*Plus CONNECT command.


--


-- USAGE


-- This script is automatically run


--


set echo off


set termout off

 

set sqlprompt "_USER'@'_CONNECT_IDENTIFIER _PRIVILEGE>"


set sqlprompt "&_user@&_CONNECT_IDENTIFIER>"

 

set serveroutput on size 1000000


set trimspool on


set lines 160


set pagesize 9999


set arraysize 5000

 

set sqlblanklines on


set sqlterminator ';'


set verify off

 

column plan_plus_exp format a90


column table_name format a31


column column_name format a31


column data_type format a15

 

/*


alter session set workarea_size_policy = manual;


alter session set hash_area_size=1073741824;


alter session set sort_area_size=1073741824;


alter session enable parallel dml;


--alter session set "_push_join_union_view"=FALSE;


alter session set nls_date_format='yyyy/mm/dd';


*/


--ALTER SESSION SET PLSQL_CCFLAGS = 'DEBUG_BEN:TRUE';

 

column log_file new_value log_file


select 'P:\!Works\DailyLogs\DLY_'||USER||'.'


    ||REGEXP_SUBSTR( SYS_CONTEXT('USERENV','SERVICE_NAME'),'[A-Za-z0-9]+')


    ||'_'||to_char(sysdate,'yyyy.mm.dd_hh24.mi.ss')||'.log' log_file from dual;

 

spool &log_file

 

--define _editor = "vim"

 

select 'C:\!works\DLOG\sqlplus_' || USER ||'_&_CONNECT_IDENTIFIER'-- || sys_context('userenv', 'con_name')


||'_'||to_char(sysdate, 'yyyy_mm_dd_hh24_mi_ss')||'.log' log_file_name from dual;

 

spool &_log_file_name

 

column owner format a30


column table_name format a30


column object_type format a20


column count(1) format '999,999,999'

 

column product format a45


column version format a20


column status format a20

 

alter session set nls_date_format='yyyy/mm/dd hh24:mi:ss';

 

select * from product_component_version;

 

set verify on


set termout on


set time off


set timing on


set echo on





 
