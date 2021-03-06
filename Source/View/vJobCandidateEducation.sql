SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[HumanResources].[vJobCandidateEducation]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [HumanResources].[vJobCandidateEducation] 
AS 
SELECT 
    jc.[JobCandidateID] 
,CAST(" " as varchar(MAX)) AS [Edu.Level]
,CAST(" " as varchar(MAX)) AS [Edu.StartDate] 
,CAST(" " as varchar(MAX)) AS [Edu.EndDate] 
,CAST(" " as varchar(MAX)) AS [Edu.Degree]
,CAST(" " as varchar(MAX)) AS [Edu.Major]
,CAST(" " as varchar(MAX)) AS [Edu.Minor]
,CAST(" " as varchar(MAX)) AS [Edu.GPA]
,CAST(" " as varchar(MAX)) AS [Edu.GPAScale]
,CAST(" " as varchar(MAX)) AS [Edu.School]
,CAST(" " as varchar(MAX)) AS [Edu.Loc.CountryRegion]
,CAST(" " as varchar(MAX)) AS [Edu.Loc.State]
,CAST(" " as varchar(MAX)) AS [Edu.Loc.City]
FROM [HumanResources].[JobCandidate] jc 
' 
GO
