SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Sales].[SalesPersonQuotaHistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [Sales].[SalesPersonQuotaHistory](
	[BusinessEntityID] [int] NOT NULL,
	[QuotaDate] [datetime] NOT NULL,
	[SalesQuota] [money] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate] PRIMARY KEY CLUSTERED 
(
	[BusinessEntityID] ASC,
	[QuotaDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Sales].[SalesPersonQuotaHistory]') AND name = N'AK_SalesPersonQuotaHistory_rowguid')
CREATE UNIQUE NONCLUSTERED INDEX [AK_SalesPersonQuotaHistory_rowguid] ON [Sales].[SalesPersonQuotaHistory]
(
	[rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Sales].[DF_SalesPersonQuotaHistory_rowguid]') AND type = 'D')
BEGIN
ALTER TABLE [Sales].[SalesPersonQuotaHistory] ADD  CONSTRAINT [DF_SalesPersonQuotaHistory_rowguid]  DEFAULT (newid()) FOR [rowguid]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Sales].[DF_SalesPersonQuotaHistory_ModifiedDate]') AND type = 'D')
BEGIN
ALTER TABLE [Sales].[SalesPersonQuotaHistory] ADD  CONSTRAINT [DF_SalesPersonQuotaHistory_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Sales].[FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID]') AND parent_object_id = OBJECT_ID(N'[Sales].[SalesPersonQuotaHistory]'))
ALTER TABLE [Sales].[SalesPersonQuotaHistory]  WITH CHECK ADD  CONSTRAINT [FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID] FOREIGN KEY([BusinessEntityID])
REFERENCES [Sales].[SalesPerson] ([BusinessEntityID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Sales].[FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID]') AND parent_object_id = OBJECT_ID(N'[Sales].[SalesPersonQuotaHistory]'))
ALTER TABLE [Sales].[SalesPersonQuotaHistory] CHECK CONSTRAINT [FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Sales].[CK_SalesPersonQuotaHistory_SalesQuota]') AND parent_object_id = OBJECT_ID(N'[Sales].[SalesPersonQuotaHistory]'))
ALTER TABLE [Sales].[SalesPersonQuotaHistory]  WITH CHECK ADD  CONSTRAINT [CK_SalesPersonQuotaHistory_SalesQuota] CHECK  (([SalesQuota]>(0.00)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Sales].[CK_SalesPersonQuotaHistory_SalesQuota]') AND parent_object_id = OBJECT_ID(N'[Sales].[SalesPersonQuotaHistory]'))
ALTER TABLE [Sales].[SalesPersonQuotaHistory] CHECK CONSTRAINT [CK_SalesPersonQuotaHistory_SalesQuota]
GO
