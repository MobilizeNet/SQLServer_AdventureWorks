SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[HumanResources].[vJobCandidate]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [HumanResources].[vJobCandidate] 
AS 
SELECT 
    jc.[JobCandidateID] 
    ,jc.[BusinessEntityID] 
,CAST(" " as varchar(MAX)) AS [Name.Prefix] 
,CAST(" " as varchar(MAX)) AS [Name.First] 
,CAST(" " as varchar(MAX)) AS [Name.Middle] 
,CAST(" " as varchar(MAX)) AS [Name.Last] 
,CAST(" " as varchar(MAX)) AS [Name.Suffix] 
,CAST(" " as varchar(MAX)) AS [Skills] 
,CAST(" " as varchar(MAX)) AS [Addr.Type]
,CAST(" " as varchar(MAX)) AS [Addr.Loc.CountryRegion]
,CAST(" " as varchar(MAX)) AS [Addr.Loc.State]
,CAST(" " as varchar(MAX)) AS [Addr.Loc.City]
,CAST(" " as varchar(MAX)) AS [Addr.PostalCode]
,CAST(" " as varchar(MAX)) AS [EMail] 
,CAST(" " as varchar(MAX)) AS [WebSite] 
    ,jc.[ModifiedDate] 
FROM [HumanResources].[JobCandidate] jc;
' 
GO
