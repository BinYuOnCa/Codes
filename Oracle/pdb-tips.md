# PDB related commands


## Check PDB 

```sql
COLUMN name FORMAT A30
COLUMN pdb FORMAT A30

SELECT name, pdb 
  FROM v$services
ORDER BY name;


```

## Switch between PDBs

```sql

ALTER SESSION SET CONTAINER=xxx;



```
