SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[Production].[vProductModelInstructions]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [Production].[vProductModelInstructions] 
AS 
SELECT 
    [ProductModelID] 
    ,[Name] 
,CAST(" " as varchar(MAX)) AS [Instructions] 
,CAST(" " as varchar(MAX)) AS [LocationID] 
,CAST(" " as varchar(MAX)) AS [SetupHours] 
,CAST(" " as varchar(MAX)) AS [MachineHours] 
,CAST(" " as varchar(MAX)) AS [LaborHours] 
,CAST(" " as varchar(MAX)) AS [LotSize] 
,CAST(" " as varchar(MAX)) AS [Step] 
    ,[rowguid] 
    ,[ModifiedDate]
FROM [Production].[ProductModel] 
' 
GO
