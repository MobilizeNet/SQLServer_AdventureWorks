SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[HumanResources].[vJobCandidateEmployment]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [HumanResources].[vJobCandidateEmployment] 
AS 
SELECT 
    jc.[JobCandidateID] 
,CAST(" " as varchar(MAX)) AS [Emp.StartDate] 
,CAST(" " as varchar(MAX)) AS [Emp.EndDate] 
,CAST(" " as varchar(MAX)) AS [Emp.OrgName]
,CAST(" " as varchar(MAX)) AS [Emp.JobTitle]
,CAST(" " as varchar(MAX)) AS [Emp.Responsibility]
,CAST(" " as varchar(MAX)) AS [Emp.FunctionCategory]
,CAST(" " as varchar(MAX)) AS [Emp.IndustryCategory]
,CAST(" " as varchar(MAX)) AS [Emp.Loc.CountryRegion]
,CAST(" " as varchar(MAX)) AS [Emp.Loc.State]
,CAST(" " as varchar(MAX)) AS [Emp.Loc.City]
FROM [HumanResources].[JobCandidate] jc 
' 
GO
