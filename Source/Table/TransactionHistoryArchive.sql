SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Production].[TransactionHistoryArchive]') AND type in (N'U'))
BEGIN
CREATE TABLE [Production].[TransactionHistoryArchive](
	[TransactionID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[ReferenceOrderID] [int] NOT NULL,
	[ReferenceOrderLineID] [int] NOT NULL,
	[TransactionDate] [datetime] NOT NULL,
	[TransactionType] [nchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Quantity] [int] NOT NULL,
	[ActualCost] [money] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_TransactionHistoryArchive_TransactionID] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Production].[TransactionHistoryArchive]') AND name = N'IX_TransactionHistoryArchive_ProductID')
CREATE NONCLUSTERED INDEX [IX_TransactionHistoryArchive_ProductID] ON [Production].[TransactionHistoryArchive]
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Production].[TransactionHistoryArchive]') AND name = N'IX_TransactionHistoryArchive_ReferenceOrderID_ReferenceOrderLineID')
CREATE NONCLUSTERED INDEX [IX_TransactionHistoryArchive_ReferenceOrderID_ReferenceOrderLineID] ON [Production].[TransactionHistoryArchive]
(
	[ReferenceOrderID] ASC,
	[ReferenceOrderLineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Production].[DF_TransactionHistoryArchive_ReferenceOrderLineID]') AND type = 'D')
BEGIN
ALTER TABLE [Production].[TransactionHistoryArchive] ADD  CONSTRAINT [DF_TransactionHistoryArchive_ReferenceOrderLineID]  DEFAULT ((0)) FOR [ReferenceOrderLineID]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Production].[DF_TransactionHistoryArchive_TransactionDate]') AND type = 'D')
BEGIN
ALTER TABLE [Production].[TransactionHistoryArchive] ADD  CONSTRAINT [DF_TransactionHistoryArchive_TransactionDate]  DEFAULT (getdate()) FOR [TransactionDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Production].[DF_TransactionHistoryArchive_ModifiedDate]') AND type = 'D')
BEGIN
ALTER TABLE [Production].[TransactionHistoryArchive] ADD  CONSTRAINT [DF_TransactionHistoryArchive_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_TransactionHistoryArchive_TransactionType]') AND parent_object_id = OBJECT_ID(N'[Production].[TransactionHistoryArchive]'))
ALTER TABLE [Production].[TransactionHistoryArchive]  WITH CHECK ADD  CONSTRAINT [CK_TransactionHistoryArchive_TransactionType] CHECK  ((upper([TransactionType])='P' OR upper([TransactionType])='S' OR upper([TransactionType])='W'))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_TransactionHistoryArchive_TransactionType]') AND parent_object_id = OBJECT_ID(N'[Production].[TransactionHistoryArchive]'))
ALTER TABLE [Production].[TransactionHistoryArchive] CHECK CONSTRAINT [CK_TransactionHistoryArchive_TransactionType]
GO
