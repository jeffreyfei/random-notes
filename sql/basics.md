## Insert
- Insert into specific colums, order does not matter
- id can be omitted as it is the primary key

```sql
INSERT INTO my_table(id, col_name1, col_name2)
VALUES(2, 'some word', 'some word');
```
- Insert into entire row
  - column names can be omitted, but values must be in order
  
```sql
INSERT INTO my_table
VALUES(2, 'some word', 'some word')
```

## Update
- Change one column

```sql
UPDATE my_table
SET col_1 = 'new value'
WHERE id = 5;
```
- Change multiple columns

```sql
UPDATE my_table
SET col_1 = 'new value', col_2 = 'new value'
WHERE id = 5;
```

## Delete
```sql
DELETE from my_table
WHERE id = 3 OR id = 4
```
- Usually used with a where statement
  - If used without the where statement it will delete every row in the table