SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[Production].[vProductModelCatalogDescription]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [Production].[vProductModelCatalogDescription] 
AS 
SELECT 
    [ProductModelID] 
    ,[Name] 
,CAST(" " as varchar(MAX)) AS [Summary] 
,CAST(" " as varchar(MAX)) AS [Manufacturer] ,CAST(" " as varchar(MAX)) ASlserver/2004/07,CAST(" " as varchar(MAX)) ASCopyright] 
,CAST(" " as varchar(MAX)) AS [ProductURL] 
,CAST(" " as varchar(MAX)) AS [WarrantyPeriod] 
,CAST(" " as varchar(MAX)) AS [WarrantyDescription] 
,CAST(" " as varchar(MAX)) AS [NoOfYears] 
,CAST(" " as varchar(MAX)) AS [MaintenanceDescription] 
,CAST(" " as varchar(MAX)) AS [Wheel] 
,CAST(" " as varchar(MAX)) AS [Saddle] 
,CAST(" " as varchar(MAX)) AS [Pedal] 
,CAST(" " as varchar(MAX)) AS [BikeFrame] 
,CAST(" " as varchar(MAX)) AS [Crankset] 
,CAST(" " as varchar(MAX)) AS [PictureAngle] 
,CAST(" " as varchar(MAX)) AS [PictureSize] 
,CAST(" " as varchar(MAX)) AS [ProductPhotoID] 
,CAST(" " as varchar(MAX)) AS [Material] 
,CAST(" " as varchar(MAX)) AS [Color] 
,CAST(" " as varchar(MAX)) AS [ProductLine] 
,CAST(" " as varchar(MAX)) AS [Style] 
,CAST(" " as varchar(MAX)) AS [RiderExperience] 
,[rowguid] 
,[ModifiedDate]
FROM [Production].[ProductModel] 
WHERE [CatalogDescription] IS NOT NULL;
' 
GO
