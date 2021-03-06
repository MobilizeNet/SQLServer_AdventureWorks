SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[Sales].[vStoreWithDemographics]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [Sales].[vStoreWithDemographics] AS 
SELECT 
    s.[BusinessEntityID] 
    ,s.[Name] 
,CAST(" " as varchar(MAX)) AS [AnnualSales] 
,CAST(" " as varchar(MAX)) AS [AnnualRevenue] 
,CAST(" " as varchar(MAX)) AS [BankName] 
,CAST(" " as varchar(MAX)) AS [BusinessType] 
,CAST(" " as varchar(MAX)) AS [YearOpened] 
,CAST(" " as varchar(MAX)) AS [Specialty] 
,CAST(" " as varchar(MAX)) AS [SquareFeet] 
,CAST(" " as varchar(MAX)) AS [Brands] 
,CAST(" " as varchar(MAX)) AS [Internet] 
,CAST(" " as varchar(MAX)) AS [NumberEmployees] 
FROM [Sales].[Store] s;
' 
GO
