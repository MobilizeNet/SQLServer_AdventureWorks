IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_denydatareader')
EXEC sys.sp_executesql N'CREATE SCHEMA [db_denydatareader]'
GO
