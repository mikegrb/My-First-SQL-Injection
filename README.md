My-First-SQL-Injection
======================

Two overly verbose Mojolicious::Lite apps, one vulnerable to SQL injection, one not.

Definately not DRY compliant to simplify understanding the code.

DB Content
----------
```sql
CREATE TABLE [Users] ([id] INT PRIMARY KEY NOT NULL, [name] VARCHAR, [username] VARCHAR, [password] VARCHAR, [is_admin] BOOLEAN DEFAULT(0));
INSERT INTO "Users" VALUES(1,'Hunter','hunterg','letmein',1);
INSERT INTO "Users" VALUES(2,'Trent','tj','plz',0);
INSERT INTO "Users" VALUES(3,'Daddy','mikegrb','doit',0);
```
