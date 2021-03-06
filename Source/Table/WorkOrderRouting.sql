SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Production].[WorkOrderRouting]') AND type in (N'U'))
BEGIN
CREATE TABLE [Production].[WorkOrderRouting](
	[WorkOrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[OperationSequence] [smallint] NOT NULL,
	[LocationID] [smallint] NOT NULL,
	[ScheduledStartDate] [datetime] NOT NULL,
	[ScheduledEndDate] [datetime] NOT NULL,
	[ActualStartDate] [datetime] NULL,
	[ActualEndDate] [datetime] NULL,
	[ActualResourceHrs] [decimal](9, 4) NULL,
	[PlannedCost] [money] NOT NULL,
	[ActualCost] [money] NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence] PRIMARY KEY CLUSTERED 
(
	[WorkOrderID] ASC,
	[ProductID] ASC,
	[OperationSequence] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Production].[WorkOrderRouting]') AND name = N'IX_WorkOrderRouting_ProductID')
CREATE NONCLUSTERED INDEX [IX_WorkOrderRouting_ProductID] ON [Production].[WorkOrderRouting]
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Production].[DF_WorkOrderRouting_ModifiedDate]') AND type = 'D')
BEGIN
ALTER TABLE [Production].[WorkOrderRouting] ADD  CONSTRAINT [DF_WorkOrderRouting_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Production].[FK_WorkOrderRouting_Location_LocationID]') AND parent_object_id = OBJECT_ID(N'[Production].[WorkOrderRouting]'))
ALTER TABLE [Production].[WorkOrderRouting]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrderRouting_Location_LocationID] FOREIGN KEY([LocationID])
REFERENCES [Production].[Location] ([LocationID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Production].[FK_WorkOrderRouting_Location_LocationID]') AND parent_object_id = OBJECT_ID(N'[Production].[WorkOrderRouting]'))
ALTER TABLE [Production].[WorkOrderRouting] CHECK CONSTRAINT [FK_WorkOrderRouting_Location_LocationID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Production].[FK_WorkOrderRouting_WorkOrder_WorkOrderID]') AND parent_object_id = OBJECT_ID(N'[Production].[WorkOrderRouting]'))
ALTER TABLE [Production].[WorkOrderRouting]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrderRouting_WorkOrder_WorkOrderID] FOREIGN KEY([WorkOrderID])
REFERENCES [Production].[WorkOrder] ([WorkOrderID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Production].[FK_WorkOrderRouting_WorkOrder_WorkOrderID]') AND parent_object_id = OBJECT_ID(N'[Production].[WorkOrderRouting]'))
ALTER TABLE [Production].[WorkOrderRouting] CHECK CONSTRAINT [FK_WorkOrderRouting_WorkOrder_WorkOrderID]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_WorkOrderRouting_ActualCost]') AND parent_object_id = OBJECT_ID(N'[Production].[WorkOrderRouting]'))
ALTER TABLE [Production].[WorkOrderRouting]  WITH CHECK ADD  CONSTRAINT [CK_WorkOrderRouting_ActualCost] CHECK  (([ActualCost]>(0.00)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_WorkOrderRouting_ActualCost]') AND parent_object_id = OBJECT_ID(N'[Production].[WorkOrderRouting]'))
ALTER TABLE [Production].[WorkOrderRouting] CHECK CONSTRAINT [CK_WorkOrderRouting_ActualCost]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_WorkOrderRouting_ActualEndDate]') AND parent_object_id = OBJECT_ID(N'[Production].[WorkOrderRouting]'))
ALTER TABLE [Production].[WorkOrderRouting]  WITH CHECK ADD  CONSTRAINT [CK_WorkOrderRouting_ActualEndDate] CHECK  (([ActualEndDate]>=[ActualStartDate] OR [ActualEndDate] IS NULL OR [ActualStartDate] IS NULL))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_WorkOrderRouting_ActualEndDate]') AND parent_object_id = OBJECT_ID(N'[Production].[WorkOrderRouting]'))
ALTER TABLE [Production].[WorkOrderRouting] CHECK CONSTRAINT [CK_WorkOrderRouting_ActualEndDate]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_WorkOrderRouting_ActualResourceHrs]') AND parent_object_id = OBJECT_ID(N'[Production].[WorkOrderRouting]'))
ALTER TABLE [Production].[WorkOrderRouting]  WITH CHECK ADD  CONSTRAINT [CK_WorkOrderRouting_ActualResourceHrs] CHECK  (([ActualResourceHrs]>=(0.0000)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_WorkOrderRouting_ActualResourceHrs]') AND parent_object_id = OBJECT_ID(N'[Production].[WorkOrderRouting]'))
ALTER TABLE [Production].[WorkOrderRouting] CHECK CONSTRAINT [CK_WorkOrderRouting_ActualResourceHrs]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_WorkOrderRouting_PlannedCost]') AND parent_object_id = OBJECT_ID(N'[Production].[WorkOrderRouting]'))
ALTER TABLE [Production].[WorkOrderRouting]  WITH CHECK ADD  CONSTRAINT [CK_WorkOrderRouting_PlannedCost] CHECK  (([PlannedCost]>(0.00)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_WorkOrderRouting_PlannedCost]') AND parent_object_id = OBJECT_ID(N'[Production].[WorkOrderRouting]'))
ALTER TABLE [Production].[WorkOrderRouting] CHECK CONSTRAINT [CK_WorkOrderRouting_PlannedCost]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_WorkOrderRouting_ScheduledEndDate]') AND parent_object_id = OBJECT_ID(N'[Production].[WorkOrderRouting]'))
ALTER TABLE [Production].[WorkOrderRouting]  WITH CHECK ADD  CONSTRAINT [CK_WorkOrderRouting_ScheduledEndDate] CHECK  (([ScheduledEndDate]>=[ScheduledStartDate]))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Production].[CK_WorkOrderRouting_ScheduledEndDate]') AND parent_object_id = OBJECT_ID(N'[Production].[WorkOrderRouting]'))
ALTER TABLE [Production].[WorkOrderRouting] CHECK CONSTRAINT [CK_WorkOrderRouting_ScheduledEndDate]
GO
