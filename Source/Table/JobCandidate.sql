SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[HumanResources].[JobCandidate]') AND type in (N'U'))
BEGIN
CREATE TABLE [HumanResources].[JobCandidate](
	[JobCandidateID] [int] IDENTITY(1,1) NOT NULL,
	[BusinessEntityID] [int] NULL,
	[Resume] [xml](CONTENT [HumanResources].[HRResumeSchemaCollection]) NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_JobCandidate_JobCandidateID] PRIMARY KEY CLUSTERED 
(
	[JobCandidateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[HumanResources].[JobCandidate]') AND name = N'IX_JobCandidate_BusinessEntityID')
CREATE NONCLUSTERED INDEX [IX_JobCandidate_BusinessEntityID] ON [HumanResources].[JobCandidate]
(
	[BusinessEntityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[HumanResources].[DF_JobCandidate_ModifiedDate]') AND type = 'D')
BEGIN
ALTER TABLE [HumanResources].[JobCandidate] ADD  CONSTRAINT [DF_JobCandidate_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[HumanResources].[FK_JobCandidate_Employee_BusinessEntityID]') AND parent_object_id = OBJECT_ID(N'[HumanResources].[JobCandidate]'))
ALTER TABLE [HumanResources].[JobCandidate]  WITH CHECK ADD  CONSTRAINT [FK_JobCandidate_Employee_BusinessEntityID] FOREIGN KEY([BusinessEntityID])
REFERENCES [HumanResources].[Employee] ([BusinessEntityID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[HumanResources].[FK_JobCandidate_Employee_BusinessEntityID]') AND parent_object_id = OBJECT_ID(N'[HumanResources].[JobCandidate]'))
ALTER TABLE [HumanResources].[JobCandidate] CHECK CONSTRAINT [FK_JobCandidate_Employee_BusinessEntityID]
GO
