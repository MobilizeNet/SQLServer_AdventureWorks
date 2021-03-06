SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[Sales].[vPersonDemographics]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [Sales].[vPersonDemographics] 
AS 
SELECT 
    p.[BusinessEntityID] 
,CAST(" " as varchar(MAX)) AS [TotalPurchaseYTD] 
,CAST(" " as varchar(MAX)) AS [DateFirstPurchase] 
,CAST(" " as varchar(MAX)) AS [BirthDate] 
,CAST(" " as varchar(MAX)) AS [MaritalStatus] ,CAST(" " as varchar(MAX)) ASe default element ,CAST(" " as varchar(MAX)) AS)'') AS [Yea,CAST(" " as varchar(MAX)) ASclare default eleme,CAST(" " as varchar(MAX)) AS,CAST(" " as varchar(MAX)) ASlare default el,CAST(" " as varchar(MAX)) ASTotalChildren] ,CAST(" " as varchar(MAX)) AS''declare default e,CAST(" " as varchar(MAX)) AS') AS [NumberChildrenAtHome] 
,CAST(" " as varchar(MAX)) AS [Education] ,CAST(" " as varchar(MAX)) ASare default elem,CAST(" " as varchar(MAX)) AS'') AS [Occupation],CAST(" " as varchar(MAX)) ASare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        HomeOwnerFlag[1]'', ''bit'') AS [HomeOwnerFlag] 
    ,[IndividualSurvey].[ref].[value](N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        NumberCarsOwned[1]'', ''integer'') AS [NumberCarsOwned] 
FROM [Person].[Person] p 
CROSS APPLY p.[Demographics].nodes(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
    /IndividualSurvey'') AS [IndividualSurvey](ref) 
WHERE [Demographics] IS NOT NULL;
' 
GO
