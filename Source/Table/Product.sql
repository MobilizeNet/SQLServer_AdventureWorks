SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Production].[Product]') AND type in (N'U'))
BEGIN
CREATE TABLE [Production].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[ProductNumber] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[MakeFlag] [dbo].[Flag] NOT NULL,
	[FinishedGoodsFlag] [dbo].[Flag] NOT NULL,
	[Color] [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SafetyStockLevel] [smallint] NOT NULL,
	[ReorderPoint] [smallint] NOT NULL,
	[StandardCost] [money] NOT NULL,
	[ListPrice] [money] NOT NULL,
	[Size] [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SizeUnitMeasureCode] [nchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[WeightUnitMeasureCode] [nchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Weight] [decimal](8, 2) NULL,
	[DaysToManufacture] [int] NOT NULL,
	[ProductLine] [nchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Class] [nchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Style] [nchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProductSubcategoryID] [int] NULL,
	[ProductModelID] [int] NULL,
	[SellStartDate] [datetime] NOT NULL,
	[SellEndDate] [datetime] NULL,
	[DiscontinuedDate] [datetime] NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Product_ProductID] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Production].[Product]') AND name = N'AK_Product_Name')
CREATE UNIQUE NONCLUSTERED INDEX [AK_Product_Name] ON [Production].[Product]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Production].[Product]') AND name = N'AK_Product_ProductNumber')
CREATE UNIQUE NONCLUSTERED INDEX [AK_Product_ProductNumber] ON [Production].[Product]
(
	[ProductNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Production].[Product]') AND name = N'AK_Product_rowguid')
CREATE UNIQUE NONCLUSTERED INDEX [AK_Product_rowguid] ON [Production].[Product]
(
	[rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Production].[DF_Product_MakeFlag]') AND type = 'D')
BEGIN
ALTER TABLE [Production].[Product] ADD  CONSTRAINT [DF_Product_MakeFlag]  DEFAULT ((1)) FOR [MakeFlag]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Production].[DF_Product_FinishedGoodsFlag]') AND type = 'D')
BEGIN
ALTER TABLE [Production].[Product] ADD  CONSTRAINT [DF_Product_FinishedGoodsFlag]  DEFAULT ((1)) FOR [FinishedGoodsFlag]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Production].[DF_Product_rowguid]') AND type = 'D')
BEGIN
ALTER TABLE [Production].[Product] ADD  CONSTRAINT [DF_Product_rowguid]  DEFAULT (newid()) FOR [rowguid]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Production].[DF_Product_ModifiedDate]') AND type = 'D')
BEGIN
ALTER TABLE [Production].[Product] ADD  CONSTRAINT [DF_Product_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Production].[FK_Product_ProductModel_ProductModelID]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductModel_ProductModelID] FOREIGN KEY([ProductModelID])
REFERENCES [Production].[ProductModel] ([ProductModelID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Production].[FK_Product_ProductModel_ProductModelID]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [FK_Product_ProductModel_ProductModelID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Production].[FK_Product_ProductSubcategory_ProductSubcategoryID]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductSubcategory_ProductSubcategoryID] FOREIGN KEY([ProductSubcategoryID])
REFERENCES [Production].[ProductSubcategory] ([ProductSubcategoryID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Production].[FK_Product_ProductSubcategory_ProductSubcategoryID]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [FK_Product_ProductSubcategory_ProductSubcategoryID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Production].[FK_Product_UnitMeasure_SizeUnitMeasureCode]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_UnitMeasure_SizeUnitMeasureCode] FOREIGN KEY([SizeUnitMeasureCode])
REFERENCES [Production].[UnitMeasure] ([UnitMeasureCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Production].[FK_Product_UnitMeasure_SizeUnitMeasureCode]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [FK_Product_UnitMeasure_SizeUnitMeasureCode]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Production].[FK_Product_UnitMeasure_WeightUnitMeasureCode]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_UnitMeasure_WeightUnitMeasureCode] FOREIGN KEY([WeightUnitMeasureCode])
REFERENCES [Production].[UnitMeasure] ([UnitMeasureCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Production].[FK_Product_UnitMeasure_WeightUnitMeasureCode]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [FK_Product_UnitMeasure_WeightUnitMeasureCode]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_Product_Class]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [CK_Product_Class] CHECK  ((upper([Class])='H' OR upper([Class])='M' OR upper([Class])='L' OR [Class] IS NULL))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_Product_Class]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [CK_Product_Class]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_Product_DaysToManufacture]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [CK_Product_DaysToManufacture] CHECK  (([DaysToManufacture]>=(0)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_Product_DaysToManufacture]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [CK_Product_DaysToManufacture]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_Product_ListPrice]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [CK_Product_ListPrice] CHECK  (([ListPrice]>=(0.00)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_Product_ListPrice]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [CK_Product_ListPrice]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_Product_ProductLine]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [CK_Product_ProductLine] CHECK  ((upper([ProductLine])='R' OR upper([ProductLine])='M' OR upper([ProductLine])='T' OR upper([ProductLine])='S' OR [ProductLine] IS NULL))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_Product_ProductLine]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [CK_Product_ProductLine]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_Product_ReorderPoint]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [CK_Product_ReorderPoint] CHECK  (([ReorderPoint]>(0)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_Product_ReorderPoint]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [CK_Product_ReorderPoint]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_Product_SafetyStockLevel]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [CK_Product_SafetyStockLevel] CHECK  (([SafetyStockLevel]>(0)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_Product_SafetyStockLevel]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [CK_Product_SafetyStockLevel]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_Product_SellEndDate]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [CK_Product_SellEndDate] CHECK  (([SellEndDate]>=[SellStartDate] OR [SellEndDate] IS NULL))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_Product_SellEndDate]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [CK_Product_SellEndDate]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_Product_StandardCost]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [CK_Product_StandardCost] CHECK  (([StandardCost]>=(0.00)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_Product_StandardCost]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [CK_Product_StandardCost]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_Product_Style]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [CK_Product_Style] CHECK  ((upper([Style])='U' OR upper([Style])='M' OR upper([Style])='W' OR [Style] IS NULL))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_Product_Style]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [CK_Product_Style]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_Product_Weight]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [CK_Product_Weight] CHECK  (([Weight]>(0.00)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_Product_Weight]') AND parent_object_id = OBJECT_ID(N'[Production].[Product]'))
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [CK_Product_Weight]
GO
