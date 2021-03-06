SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Purchasing].[ProductVendor]') AND type in (N'U'))
BEGIN
CREATE TABLE [Purchasing].[ProductVendor](
	[ProductID] [int] NOT NULL,
	[BusinessEntityID] [int] NOT NULL,
	[AverageLeadTime] [int] NOT NULL,
	[StandardPrice] [money] NOT NULL,
	[LastReceiptCost] [money] NULL,
	[LastReceiptDate] [datetime] NULL,
	[MinOrderQty] [int] NOT NULL,
	[MaxOrderQty] [int] NOT NULL,
	[OnOrderQty] [int] NULL,
	[UnitMeasureCode] [nchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ProductVendor_ProductID_BusinessEntityID] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[BusinessEntityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Purchasing].[ProductVendor]') AND name = N'IX_ProductVendor_BusinessEntityID')
CREATE NONCLUSTERED INDEX [IX_ProductVendor_BusinessEntityID] ON [Purchasing].[ProductVendor]
(
	[BusinessEntityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Purchasing].[ProductVendor]') AND name = N'IX_ProductVendor_UnitMeasureCode')
CREATE NONCLUSTERED INDEX [IX_ProductVendor_UnitMeasureCode] ON [Purchasing].[ProductVendor]
(
	[UnitMeasureCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Purchasing].[DF_ProductVendor_ModifiedDate]') AND type = 'D')
BEGIN
ALTER TABLE [Purchasing].[ProductVendor] ADD  CONSTRAINT [DF_ProductVendor_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Purchasing].[FK_ProductVendor_Product_ProductID]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[ProductVendor]'))
ALTER TABLE [Purchasing].[ProductVendor]  WITH CHECK ADD  CONSTRAINT [FK_ProductVendor_Product_ProductID] FOREIGN KEY([ProductID])
REFERENCES [Production].[Product] ([ProductID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Purchasing].[FK_ProductVendor_Product_ProductID]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[ProductVendor]'))
ALTER TABLE [Purchasing].[ProductVendor] CHECK CONSTRAINT [FK_ProductVendor_Product_ProductID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Purchasing].[FK_ProductVendor_UnitMeasure_UnitMeasureCode]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[ProductVendor]'))
ALTER TABLE [Purchasing].[ProductVendor]  WITH CHECK ADD  CONSTRAINT [FK_ProductVendor_UnitMeasure_UnitMeasureCode] FOREIGN KEY([UnitMeasureCode])
REFERENCES [Production].[UnitMeasure] ([UnitMeasureCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Purchasing].[FK_ProductVendor_UnitMeasure_UnitMeasureCode]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[ProductVendor]'))
ALTER TABLE [Purchasing].[ProductVendor] CHECK CONSTRAINT [FK_ProductVendor_UnitMeasure_UnitMeasureCode]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Purchasing].[FK_ProductVendor_Vendor_BusinessEntityID]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[ProductVendor]'))
ALTER TABLE [Purchasing].[ProductVendor]  WITH CHECK ADD  CONSTRAINT [FK_ProductVendor_Vendor_BusinessEntityID] FOREIGN KEY([BusinessEntityID])
REFERENCES [Purchasing].[Vendor] ([BusinessEntityID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Purchasing].[FK_ProductVendor_Vendor_BusinessEntityID]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[ProductVendor]'))
ALTER TABLE [Purchasing].[ProductVendor] CHECK CONSTRAINT [FK_ProductVendor_Vendor_BusinessEntityID]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Purchasing].[CK_ProductVendor_AverageLeadTime]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[ProductVendor]'))
ALTER TABLE [Purchasing].[ProductVendor]  WITH CHECK ADD  CONSTRAINT [CK_ProductVendor_AverageLeadTime] CHECK  (([AverageLeadTime]>=(1)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Purchasing].[CK_ProductVendor_AverageLeadTime]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[ProductVendor]'))
ALTER TABLE [Purchasing].[ProductVendor] CHECK CONSTRAINT [CK_ProductVendor_AverageLeadTime]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Purchasing].[CK_ProductVendor_LastReceiptCost]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[ProductVendor]'))
ALTER TABLE [Purchasing].[ProductVendor]  WITH CHECK ADD  CONSTRAINT [CK_ProductVendor_LastReceiptCost] CHECK  (([LastReceiptCost]>(0.00)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Purchasing].[CK_ProductVendor_LastReceiptCost]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[ProductVendor]'))
ALTER TABLE [Purchasing].[ProductVendor] CHECK CONSTRAINT [CK_ProductVendor_LastReceiptCost]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Purchasing].[CK_ProductVendor_MaxOrderQty]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[ProductVendor]'))
ALTER TABLE [Purchasing].[ProductVendor]  WITH CHECK ADD  CONSTRAINT [CK_ProductVendor_MaxOrderQty] CHECK  (([MaxOrderQty]>=(1)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Purchasing].[CK_ProductVendor_MaxOrderQty]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[ProductVendor]'))
ALTER TABLE [Purchasing].[ProductVendor] CHECK CONSTRAINT [CK_ProductVendor_MaxOrderQty]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Purchasing].[CK_ProductVendor_MinOrderQty]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[ProductVendor]'))
ALTER TABLE [Purchasing].[ProductVendor]  WITH CHECK ADD  CONSTRAINT [CK_ProductVendor_MinOrderQty] CHECK  (([MinOrderQty]>=(1)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Purchasing].[CK_ProductVendor_MinOrderQty]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[ProductVendor]'))
ALTER TABLE [Purchasing].[ProductVendor] CHECK CONSTRAINT [CK_ProductVendor_MinOrderQty]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Purchasing].[CK_ProductVendor_OnOrderQty]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[ProductVendor]'))
ALTER TABLE [Purchasing].[ProductVendor]  WITH CHECK ADD  CONSTRAINT [CK_ProductVendor_OnOrderQty] CHECK  (([OnOrderQty]>=(0)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Purchasing].[CK_ProductVendor_OnOrderQty]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[ProductVendor]'))
ALTER TABLE [Purchasing].[ProductVendor] CHECK CONSTRAINT [CK_ProductVendor_OnOrderQty]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Purchasing].[CK_ProductVendor_StandardPrice]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[ProductVendor]'))
ALTER TABLE [Purchasing].[ProductVendor]  WITH CHECK ADD  CONSTRAINT [CK_ProductVendor_StandardPrice] CHECK  (([StandardPrice]>(0.00)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Purchasing].[CK_ProductVendor_StandardPrice]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[ProductVendor]'))
ALTER TABLE [Purchasing].[ProductVendor] CHECK CONSTRAINT [CK_ProductVendor_StandardPrice]
GO
