# tnsnames.ora Samples

Location: $ORACLE_HOME/network/admin


## Check PDB 

```sql

LISTENER = (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.0.215)(PORT = 1521))

pdb_ds =
  (DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.0.215)(PORT = 1521))
    )
    (CONNECT_DATA =
      (SERVICE_NAME = PDB_DS)
    )
  )
```


