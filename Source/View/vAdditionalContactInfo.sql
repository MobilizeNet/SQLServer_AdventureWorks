SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[Person].[vAdditionalContactInfo]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [Person].[vAdditionalContactInfo] 
AS 
SELECT 
    [BusinessEntityID] 
    ,[FirstName]
    ,[MiddleName]
    ,[LastName]
,CAST(" " as varchar(MAX)) AS [TelephoneNumber] 
,CAST(" " as varchar(MAX)) AS [TelephoneSpecialInstructions] 
,CAST(" " as varchar(MAX)) AS [Street] 
,CAST(" " as varchar(MAX)) AS [City] 
,CAST(" " as varchar(MAX)) AS [StateProvince] 
,CAST(" " as varchar(MAX)) AS [PostalCode] 
,CAST(" " as varchar(MAX)) AS [CountryRegion] 
,CAST(" " as varchar(MAX)) AS [HomeAddressSpecialInstructions] 
,CAST(" " as varchar(MAX)) AS [EMailAddress] 
,CAST(" " as varchar(MAX)) AS [EMailSpecialInstructions] 
,CAST(" " as varchar(MAX)) AS [EMailTelephoneNumber] 
    ,[rowguid] 
    ,[ModifiedDate]
FROM [Person].[Person]
OUTER APPLY [AdditionalContactInfo].nodes(
    ''declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
    /ci:AdditionalContactInfo'') AS ContactInfo(ref) 
WHERE [AdditionalContactInfo] IS NOT NULL;
' 
GO
