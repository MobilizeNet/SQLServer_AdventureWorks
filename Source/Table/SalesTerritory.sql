SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Sales].[SalesTerritory]') AND type in (N'U'))
BEGIN
CREATE TABLE [Sales].[SalesTerritory](
	[TerritoryID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[CountryRegionCode] [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Group] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[SalesYTD] [money] NOT NULL,
	[SalesLastYear] [money] NOT NULL,
	[CostYTD] [money] NOT NULL,
	[CostLastYear] [money] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SalesTerritory_TerritoryID] PRIMARY KEY CLUSTERED 
(
	[TerritoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Sales].[SalesTerritory]') AND name = N'AK_SalesTerritory_Name')
CREATE UNIQUE NONCLUSTERED INDEX [AK_SalesTerritory_Name] ON [Sales].[SalesTerritory]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Sales].[SalesTerritory]') AND name = N'AK_SalesTerritory_rowguid')
CREATE UNIQUE NONCLUSTERED INDEX [AK_SalesTerritory_rowguid] ON [Sales].[SalesTerritory]
(
	[rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Sales].[DF_SalesTerritory_SalesYTD]') AND type = 'D')
BEGIN
ALTER TABLE [Sales].[SalesTerritory] ADD  CONSTRAINT [DF_SalesTerritory_SalesYTD]  DEFAULT ((0.00)) FOR [SalesYTD]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Sales].[DF_SalesTerritory_SalesLastYear]') AND type = 'D')
BEGIN
ALTER TABLE [Sales].[SalesTerritory] ADD  CONSTRAINT [DF_SalesTerritory_SalesLastYear]  DEFAULT ((0.00)) FOR [SalesLastYear]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Sales].[DF_SalesTerritory_CostYTD]') AND type = 'D')
BEGIN
ALTER TABLE [Sales].[SalesTerritory] ADD  CONSTRAINT [DF_SalesTerritory_CostYTD]  DEFAULT ((0.00)) FOR [CostYTD]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Sales].[DF_SalesTerritory_CostLastYear]') AND type = 'D')
BEGIN
ALTER TABLE [Sales].[SalesTerritory] ADD  CONSTRAINT [DF_SalesTerritory_CostLastYear]  DEFAULT ((0.00)) FOR [CostLastYear]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Sales].[DF_SalesTerritory_rowguid]') AND type = 'D')
BEGIN
ALTER TABLE [Sales].[SalesTerritory] ADD  CONSTRAINT [DF_SalesTerritory_rowguid]  DEFAULT (newid()) FOR [rowguid]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Sales].[DF_SalesTerritory_ModifiedDate]') AND type = 'D')
BEGIN
ALTER TABLE [Sales].[SalesTerritory] ADD  CONSTRAINT [DF_SalesTerritory_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Sales].[FK_SalesTerritory_CountryRegion_CountryRegionCode]') AND parent_object_id = OBJECT_ID(N'[Sales].[SalesTerritory]'))
ALTER TABLE [Sales].[SalesTerritory]  WITH CHECK ADD  CONSTRAINT [FK_SalesTerritory_CountryRegion_CountryRegionCode] FOREIGN KEY([CountryRegionCode])
REFERENCES [Person].[CountryRegion] ([CountryRegionCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Sales].[FK_SalesTerritory_CountryRegion_CountryRegionCode]') AND parent_object_id = OBJECT_ID(N'[Sales].[SalesTerritory]'))
ALTER TABLE [Sales].[SalesTerritory] CHECK CONSTRAINT [FK_SalesTerritory_CountryRegion_CountryRegionCode]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Sales].[CK_SalesTerritory_CostLastYear]') AND parent_object_id = OBJECT_ID(N'[Sales].[SalesTerritory]'))
ALTER TABLE [Sales].[SalesTerritory]  WITH CHECK ADD  CONSTRAINT [CK_SalesTerritory_CostLastYear] CHECK  (([CostLastYear]>=(0.00)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Sales].[CK_SalesTerritory_CostLastYear]') AND parent_object_id = OBJECT_ID(N'[Sales].[SalesTerritory]'))
ALTER TABLE [Sales].[SalesTerritory] CHECK CONSTRAINT [CK_SalesTerritory_CostLastYear]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Sales].[CK_SalesTerritory_CostYTD]') AND parent_object_id = OBJECT_ID(N'[Sales].[SalesTerritory]'))
ALTER TABLE [Sales].[SalesTerritory]  WITH CHECK ADD  CONSTRAINT [CK_SalesTerritory_CostYTD] CHECK  (([CostYTD]>=(0.00)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Sales].[CK_SalesTerritory_CostYTD]') AND parent_object_id = OBJECT_ID(N'[Sales].[SalesTerritory]'))
ALTER TABLE [Sales].[SalesTerritory] CHECK CONSTRAINT [CK_SalesTerritory_CostYTD]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Sales].[CK_SalesTerritory_SalesLastYear]') AND parent_object_id = OBJECT_ID(N'[Sales].[SalesTerritory]'))
ALTER TABLE [Sales].[SalesTerritory]  WITH CHECK ADD  CONSTRAINT [CK_SalesTerritory_SalesLastYear] CHECK  (([SalesLastYear]>=(0.00)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Sales].[CK_SalesTerritory_SalesLastYear]') AND parent_object_id = OBJECT_ID(N'[Sales].[SalesTerritory]'))
ALTER TABLE [Sales].[SalesTerritory] CHECK CONSTRAINT [CK_SalesTerritory_SalesLastYear]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Sales].[CK_SalesTerritory_SalesYTD]') AND parent_object_id = OBJECT_ID(N'[Sales].[SalesTerritory]'))
ALTER TABLE [Sales].[SalesTerritory]  WITH CHECK ADD  CONSTRAINT [CK_SalesTerritory_SalesYTD] CHECK  (([SalesYTD]>=(0.00)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Sales].[CK_SalesTerritory_SalesYTD]') AND parent_object_id = OBJECT_ID(N'[Sales].[SalesTerritory]'))
ALTER TABLE [Sales].[SalesTerritory] CHECK CONSTRAINT [CK_SalesTerritory_SalesYTD]
GO
