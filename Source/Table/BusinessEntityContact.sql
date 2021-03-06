SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Person].[BusinessEntityContact]') AND type in (N'U'))
BEGIN
CREATE TABLE [Person].[BusinessEntityContact](
	[BusinessEntityID] [int] NOT NULL,
	[PersonID] [int] NOT NULL,
	[ContactTypeID] [int] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeID] PRIMARY KEY CLUSTERED 
(
	[BusinessEntityID] ASC,
	[PersonID] ASC,
	[ContactTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Person].[BusinessEntityContact]') AND name = N'AK_BusinessEntityContact_rowguid')
CREATE UNIQUE NONCLUSTERED INDEX [AK_BusinessEntityContact_rowguid] ON [Person].[BusinessEntityContact]
(
	[rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Person].[BusinessEntityContact]') AND name = N'IX_BusinessEntityContact_ContactTypeID')
CREATE NONCLUSTERED INDEX [IX_BusinessEntityContact_ContactTypeID] ON [Person].[BusinessEntityContact]
(
	[ContactTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Person].[BusinessEntityContact]') AND name = N'IX_BusinessEntityContact_PersonID')
CREATE NONCLUSTERED INDEX [IX_BusinessEntityContact_PersonID] ON [Person].[BusinessEntityContact]
(
	[PersonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Person].[DF_BusinessEntityContact_rowguid]') AND type = 'D')
BEGIN
ALTER TABLE [Person].[BusinessEntityContact] ADD  CONSTRAINT [DF_BusinessEntityContact_rowguid]  DEFAULT (newid()) FOR [rowguid]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Person].[DF_BusinessEntityContact_ModifiedDate]') AND type = 'D')
BEGIN
ALTER TABLE [Person].[BusinessEntityContact] ADD  CONSTRAINT [DF_BusinessEntityContact_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Person].[FK_BusinessEntityContact_BusinessEntity_BusinessEntityID]') AND parent_object_id = OBJECT_ID(N'[Person].[BusinessEntityContact]'))
ALTER TABLE [Person].[BusinessEntityContact]  WITH CHECK ADD  CONSTRAINT [FK_BusinessEntityContact_BusinessEntity_BusinessEntityID] FOREIGN KEY([BusinessEntityID])
REFERENCES [Person].[BusinessEntity] ([BusinessEntityID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Person].[FK_BusinessEntityContact_BusinessEntity_BusinessEntityID]') AND parent_object_id = OBJECT_ID(N'[Person].[BusinessEntityContact]'))
ALTER TABLE [Person].[BusinessEntityContact] CHECK CONSTRAINT [FK_BusinessEntityContact_BusinessEntity_BusinessEntityID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Person].[FK_BusinessEntityContact_ContactType_ContactTypeID]') AND parent_object_id = OBJECT_ID(N'[Person].[BusinessEntityContact]'))
ALTER TABLE [Person].[BusinessEntityContact]  WITH CHECK ADD  CONSTRAINT [FK_BusinessEntityContact_ContactType_ContactTypeID] FOREIGN KEY([ContactTypeID])
REFERENCES [Person].[ContactType] ([ContactTypeID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Person].[FK_BusinessEntityContact_ContactType_ContactTypeID]') AND parent_object_id = OBJECT_ID(N'[Person].[BusinessEntityContact]'))
ALTER TABLE [Person].[BusinessEntityContact] CHECK CONSTRAINT [FK_BusinessEntityContact_ContactType_ContactTypeID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Person].[FK_BusinessEntityContact_Person_PersonID]') AND parent_object_id = OBJECT_ID(N'[Person].[BusinessEntityContact]'))
ALTER TABLE [Person].[BusinessEntityContact]  WITH CHECK ADD  CONSTRAINT [FK_BusinessEntityContact_Person_PersonID] FOREIGN KEY([PersonID])
REFERENCES [Person].[Person] ([BusinessEntityID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Person].[FK_BusinessEntityContact_Person_PersonID]') AND parent_object_id = OBJECT_ID(N'[Person].[BusinessEntityContact]'))
ALTER TABLE [Person].[BusinessEntityContact] CHECK CONSTRAINT [FK_BusinessEntityContact_Person_PersonID]
GO
