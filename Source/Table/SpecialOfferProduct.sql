SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Sales].[SpecialOfferProduct]') AND type in (N'U'))
BEGIN
CREATE TABLE [Sales].[SpecialOfferProduct](
	[SpecialOfferID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SpecialOfferProduct_SpecialOfferID_ProductID] PRIMARY KEY CLUSTERED 
(
	[SpecialOfferID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Sales].[SpecialOfferProduct]') AND name = N'AK_SpecialOfferProduct_rowguid')
CREATE UNIQUE NONCLUSTERED INDEX [AK_SpecialOfferProduct_rowguid] ON [Sales].[SpecialOfferProduct]
(
	[rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Sales].[SpecialOfferProduct]') AND name = N'IX_SpecialOfferProduct_ProductID')
CREATE NONCLUSTERED INDEX [IX_SpecialOfferProduct_ProductID] ON [Sales].[SpecialOfferProduct]
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Sales].[DF_SpecialOfferProduct_rowguid]') AND type = 'D')
BEGIN
ALTER TABLE [Sales].[SpecialOfferProduct] ADD  CONSTRAINT [DF_SpecialOfferProduct_rowguid]  DEFAULT (newid()) FOR [rowguid]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Sales].[DF_SpecialOfferProduct_ModifiedDate]') AND type = 'D')
BEGIN
ALTER TABLE [Sales].[SpecialOfferProduct] ADD  CONSTRAINT [DF_SpecialOfferProduct_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Sales].[FK_SpecialOfferProduct_Product_ProductID]') AND parent_object_id = OBJECT_ID(N'[Sales].[SpecialOfferProduct]'))
ALTER TABLE [Sales].[SpecialOfferProduct]  WITH CHECK ADD  CONSTRAINT [FK_SpecialOfferProduct_Product_ProductID] FOREIGN KEY([ProductID])
REFERENCES [Production].[Product] ([ProductID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Sales].[FK_SpecialOfferProduct_Product_ProductID]') AND parent_object_id = OBJECT_ID(N'[Sales].[SpecialOfferProduct]'))
ALTER TABLE [Sales].[SpecialOfferProduct] CHECK CONSTRAINT [FK_SpecialOfferProduct_Product_ProductID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Sales].[FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID]') AND parent_object_id = OBJECT_ID(N'[Sales].[SpecialOfferProduct]'))
ALTER TABLE [Sales].[SpecialOfferProduct]  WITH CHECK ADD  CONSTRAINT [FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID] FOREIGN KEY([SpecialOfferID])
REFERENCES [Sales].[SpecialOffer] ([SpecialOfferID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Sales].[FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID]') AND parent_object_id = OBJECT_ID(N'[Sales].[SpecialOfferProduct]'))
ALTER TABLE [Sales].[SpecialOfferProduct] CHECK CONSTRAINT [FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID]
GO
