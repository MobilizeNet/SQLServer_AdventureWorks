SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Production].[ProductListPriceHistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [Production].[ProductListPriceHistory](
	[ProductID] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL,
	[ListPrice] [money] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ProductListPriceHistory_ProductID_StartDate] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[StartDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Production].[DF_ProductListPriceHistory_ModifiedDate]') AND type = 'D')
BEGIN
ALTER TABLE [Production].[ProductListPriceHistory] ADD  CONSTRAINT [DF_ProductListPriceHistory_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Production].[FK_ProductListPriceHistory_Product_ProductID]') AND parent_object_id = OBJECT_ID(N'[Production].[ProductListPriceHistory]'))
ALTER TABLE [Production].[ProductListPriceHistory]  WITH CHECK ADD  CONSTRAINT [FK_ProductListPriceHistory_Product_ProductID] FOREIGN KEY([ProductID])
REFERENCES [Production].[Product] ([ProductID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Production].[FK_ProductListPriceHistory_Product_ProductID]') AND parent_object_id = OBJECT_ID(N'[Production].[ProductListPriceHistory]'))
ALTER TABLE [Production].[ProductListPriceHistory] CHECK CONSTRAINT [FK_ProductListPriceHistory_Product_ProductID]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_ProductListPriceHistory_EndDate]') AND parent_object_id = OBJECT_ID(N'[Production].[ProductListPriceHistory]'))
ALTER TABLE [Production].[ProductListPriceHistory]  WITH CHECK ADD  CONSTRAINT [CK_ProductListPriceHistory_EndDate] CHECK  (([EndDate]>=[StartDate] OR [EndDate] IS NULL))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_ProductListPriceHistory_EndDate]') AND parent_object_id = OBJECT_ID(N'[Production].[ProductListPriceHistory]'))
ALTER TABLE [Production].[ProductListPriceHistory] CHECK CONSTRAINT [CK_ProductListPriceHistory_EndDate]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_ProductListPriceHistory_ListPrice]') AND parent_object_id = OBJECT_ID(N'[Production].[ProductListPriceHistory]'))
ALTER TABLE [Production].[ProductListPriceHistory]  WITH CHECK ADD  CONSTRAINT [CK_ProductListPriceHistory_ListPrice] CHECK  (([ListPrice]>(0.00)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_ProductListPriceHistory_ListPrice]') AND parent_object_id = OBJECT_ID(N'[Production].[ProductListPriceHistory]'))
ALTER TABLE [Production].[ProductListPriceHistory] CHECK CONSTRAINT [CK_ProductListPriceHistory_ListPrice]
GO
