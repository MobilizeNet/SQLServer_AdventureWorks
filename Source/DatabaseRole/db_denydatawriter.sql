IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_denydatawriter' AND type = 'R')
CREATE ROLE [db_denydatawriter]
GO
