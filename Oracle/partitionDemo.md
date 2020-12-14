# Demo of Partition

## Prepare a table with partition by range interval

```sql 
DROP TABLE tp;

CREATE SEQUENCE tpid START WITH 1;

CREATE TABLE tp ( 
   id number DEFAULT tpid.nextval, 
   code varchar2(50), 
   create_dt date NOT NULL )
PARTITION BY RANGE (create_dt) 
INTERVAL (numtoyminterval ( 1, 'MONTH')) 
( PARTITION part_01
      VALUES less than ( to_date('2019/01/01', 'yyyy/mm/dd')) 
); 
```

Now we can check only one partition in this table:

```
EXEC DBMS_STATS.gather_table_stats(USER, 'TP');
-- COLUMN table_name FORMAT A20
-- COLUMN partition_name FORMAT A20
-- COLUMN high_value FORMAT A40
 SELECT
    table_name,
    partition_name,
    high_value,
    num_rows
FROM    user_tab_partitions
WHERE    table_name NOT LIKE 'BIN$%'
ORDER BY    table_name,    partition_name;

```

|TABLE_NAME | PARTITION_NAME|HIGH_VALUE    |NUM_ROWS|
|-----------|---------------|-------------------------------------------------------------------------------|----|
|TP|PART_01|TO_DATE(' 2019-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')|0|

## Partition auto creation

Now we added some data with create_dt in 2019:

```
INSERT    INTO
    tp(code, create_dt)
VALUES( 'D2020', sysdate);

SELECT     id, code, create_dt
FROM    tp;
```

|ID|    COD|    CREATE_DT|
|----|-------|-------------|
|3001    |D2020|    14-DEC-20|



Now we can tell that one partition SYS_P268318 was created automatically:

```

EXEC DBMS_STATS.gather_table_stats(USER, 'TP');

 SELECT
    table_name,
    partition_name,
    high_value,
    num_rows
FROM    user_tab_partitions
WHERE    table_name NOT LIKE 'BIN$%'
ORDER BY    table_name,    partition_name;

```

|TABLE_NAME | PARTITION_NAME|HIGH_VALUE    |NUM_ROWS|
|-----------|---------------|-------------------------------------------------------------------------------|----|
|TP|PART_01|TO_DATE(' 2019-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')|0|
|TP|SYS_P268318|TO_DATE(' 2021-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')|1|


Let's add more data into table tp and check the partitions:

```sql
INSERT INTO  tp(code, create_dt)
SELECT  object_name || '-' || to_char(created,'yyyy/mm/dd'),
        trunc(created) + rownum
FROM    all_objects
WHERE   rownum < 1024;

EXEC DBMS_STATS.gather_table_stats(USER, 'TP');

 SELECT
    table_name,
    partition_name,
    high_value,
    num_rows
FROM    user_tab_partitions
WHERE    table_name NOT LIKE 'BIN$%'
ORDER BY    table_name,    partition_name;

```

|TABLE_NAME | PARTITION_NAME|HIGH_VALUE    |NUM_ROWS|
|-----------|---------------|-------------------------------------------------------------------------------|----|
|TP |PART_01     |(' 2019-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')    |318|
|TP |SYS_P268318 |(' 2021-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')    |6|
|TP |SYS_P268319 |(' 2019-02-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')    |31|
|TP |SYS_P268320 |(' 2019-03-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')    |28|
|TP |SYS_P268321 |(' 2019-04-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')    |31|
|TP |SYS_P268322 |(' 2019-05-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')    |30|
|TP |SYS_P268323 |(' 2019-06-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')    |31|
|TP |SYS_P268324 |(' 2019-07-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')    |30|
|TP |SYS_P268325 |(' 2019-08-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')    |31|
|TP |SYS_P268326 |(' 2019-09-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')    |31|
|TP |SYS_P268327 |(' 2019-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')    |30|
|TP |SYS_P268328 |(' 2019-11-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')    |31|
|TP |SYS_P268329 |(' 2019-12-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')    |30|
|TP |SYS_P268330 |(' 2020-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')    |31|
|TP |SYS_P268331 |(' 2020-02-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')    |31|
|TP |SYS_P268332 |(' 2020-03-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')    |29|
|TP |SYS_P268333 |(' 2020-04-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')    |31|
|TP |SYS_P268334 |(' 2020-05-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')    |30|
|TP |SYS_P268335 |(' 2020-06-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')    |31|
|TP |SYS_P268336 |(' 2020-07-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')    |30|
|TP |SYS_P268337 |(' 2020-08-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')    |31|
|TP |SYS_P268338 |(' 2020-09-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')    |31|
|TP |SYS_P268339 |(' 2020-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')    |30|
|TP |SYS_P268340 |(' 2020-11-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')    |31|
|TP |SYS_P268341 |(' 2020-12-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')    |30|

## Partition exchange

Let's see what data range we have before 2019/01/01:

```
SELECT  count(1),
        min(create_dt),
        max(create_dt)
FROM    tp
WHERE   create_dt < date '2019-01-01';
```

|COUNT(1)    | MIN(CREATE_DT)    |MAX(CREATE_DT)|
|----|------|-------|
|318    |17-FEB-18|    31-DEC-18|

We want to archive the data of 2018, the most easiest anc fast way is to exchange partition.

First we create a empty table with same data structure, then apply a partition exchange upon it with partition part_01.

```sql
CREATE TABLE t2018 
AS
  SELECT *
  FROM   tp
  WHERE  NULL IS NOT NULL;

ALTER TABLE tp exchange PARTITION part_01 WITH TABLE t2018 ;

SELECT
    'T2018' tb_name,
    count(1),
    min(create_dt),
    max(create_dt)
FROM    t2018
UNION ALL
SELECT
    'PART_01' ,
    count(1),
    min(create_dt),
    max(create_dt)
FROM    tp
WHERE    create_dt < date '2019-01-01';
```

|TB_NAME|COUNT(1)|MIN(CREATE_DT)|MAX(CREATE_DT)|
|------|-------|-------|-----------|
|T2018|318|17-FEB-18|31-DEC-18|
|PART_01|0| - | - |


If we exchange them one more time, they will back to previous status:

```sql
ALTER TABLE tp exchange PARTITION part_01 WITH TABLE t2018 ;

SELECT
    'T2018' tb_name,
    count(1),
    min(create_dt),
    max(create_dt)
FROM    t2018
UNION ALL
SELECT
    'PART_01' ,
    count(1),
    min(create_dt),
    max(create_dt)
FROM    tp
WHERE    create_dt < date '2019-01-01';
```

|TB_NAME|COUNT(1)|MIN(CREATE_DT)|MAX(CREATE_DT)|
|------|-------|-------|-----------|
|T2018|0| - | - |
|PART_01|318|17-FEB-18|31-DEC-18|

## Index on Partition

Basically we have two different indexes for tables with partition:
- local 
- global

```sql
CREATE INDEX tp_creat_dt ON
tp(create_dt) LOCAL;

CREATE INDEX tp_code ON
tp(code);

SELECT index_name,
       index_type,
       blevel,
       num_rows,
       last_analyzed,
       partitioned,
       global_stats 
FROM   all_indexes
WHERE  table_name = 'TP';

```

INDEX_NAME|INDEX_TYPE|BLEVEL|NUM_ROWS|LAST_ANALYZED|PARTITIONED|GLOBAL_STATS
----|-----|----------|------|--------|-------------|-----------|------------
TP_CREAT_DT|NORMAL|0|1024|14-DEC-20|YES|NO
TP_CODE|NORMAL|1|1024|14-DEC-20|NO|YES


```
EXPLAIN PLAN FOR
SELECT     *
FROM    tp
WHERE    create_dt = date '2019-03-01';

SELECT     plan_table_output
FROM    TABLE(dbms_xplan.display());

 PLAN_TABLE_OUTPUT  
 
Plan hash value: 3843054216
  
| Id  | Operation                                  | Name        | Rows  | Bytes | Cost (%CPU)| Time     | Pstart| Pstop |
--------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                           |             |     1 |    49 |     1   (0)| 00:00:01 |       |       |
|   1 |  PARTITION RANGE SINGLE                    |             |     1 |    49 |     1   (0)| 00:00:01 |     2 |     2 |
|   2 |   TABLE ACCESS BY LOCAL INDEX ROWID BATCHED| TP          |     1 |    49 |     1   (0)| 00:00:01 |     2 |     2 |
|*  3 |    INDEX RANGE SCAN                        | TP_CREAT_DT |     1 |       |     1   (0)| 00:00:01 |     2 |     2 |
--------------------------------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   3 - access("CREATE_DT"=TO_DATE(' 2019-01-01 00:00:00', 'syyyy-mm-dd hh24:mi:ss'))
 
Note
-----
   - dynamic statistics used: dynamic sampling (level=2)
   - 

```
    
When we fetch the table by code, it will get the same row but from global index: 

```sql

EXPLAIN PLAN FOR
SELECT  *
FROM    tp
WHERE   code = 'V$WLM_DB_MODE-2018/02/16';

SELECT  plan_table_output
FROM TABLE(dbms_xplan.display());

 PLAN_TABLE_OUTPUT
Plan hash value: 3264343428
 
----------------------------------------------------------------------------------------------------------------------
| Id  | Operation                                  | Name    | Rows  | Bytes | Cost (%CPU)| Time     | Pstart| Pstop |
----------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                           |         |     1 |    49 |     2   (0)| 00:00:01 |       |       |
|   1 |  TABLE ACCESS BY GLOBAL INDEX ROWID BATCHED| TP      |     1 |    49 |     2   (0)| 00:00:01 | ROWID | ROWID |
|*  2 |   INDEX RANGE SCAN                         | TP_CODE |     1 |       |     1   (0)| 00:00:01 |       |       |
----------------------------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("CODE"='V$WLM_DB_MODE-2018/02/16')
 
Note
-----
   - dynamic statistics used: dynamic sampling (level=2)
   - 
```