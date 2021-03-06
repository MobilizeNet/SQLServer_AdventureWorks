SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Purchasing].[PurchaseOrderHeader]') AND type in (N'U'))
BEGIN
CREATE TABLE [Purchasing].[PurchaseOrderHeader](
	[PurchaseOrderID] [int] IDENTITY(1,1) NOT NULL,
	[RevisionNumber] [tinyint] NOT NULL,
	[Status] [tinyint] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[VendorID] [int] NOT NULL,
	[ShipMethodID] [int] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[ShipDate] [datetime] NULL,
	[SubTotal] [money] NOT NULL,
	[TaxAmt] [money] NOT NULL,
	[Freight] [money] NOT NULL,
	[TotalDue]  AS (isnull(([SubTotal]+[TaxAmt])+[Freight],(0))) PERSISTED NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PurchaseOrderHeader_PurchaseOrderID] PRIMARY KEY CLUSTERED 
(
	[PurchaseOrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Purchasing].[PurchaseOrderHeader]') AND name = N'IX_PurchaseOrderHeader_EmployeeID')
CREATE NONCLUSTERED INDEX [IX_PurchaseOrderHeader_EmployeeID] ON [Purchasing].[PurchaseOrderHeader]
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Purchasing].[PurchaseOrderHeader]') AND name = N'IX_PurchaseOrderHeader_VendorID')
CREATE NONCLUSTERED INDEX [IX_PurchaseOrderHeader_VendorID] ON [Purchasing].[PurchaseOrderHeader]
(
	[VendorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Purchasing].[DF_PurchaseOrderHeader_RevisionNumber]') AND type = 'D')
BEGIN
ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD  CONSTRAINT [DF_PurchaseOrderHeader_RevisionNumber]  DEFAULT ((0)) FOR [RevisionNumber]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Purchasing].[DF_PurchaseOrderHeader_Status]') AND type = 'D')
BEGIN
ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD  CONSTRAINT [DF_PurchaseOrderHeader_Status]  DEFAULT ((1)) FOR [Status]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Purchasing].[DF_PurchaseOrderHeader_OrderDate]') AND type = 'D')
BEGIN
ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD  CONSTRAINT [DF_PurchaseOrderHeader_OrderDate]  DEFAULT (getdate()) FOR [OrderDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Purchasing].[DF_PurchaseOrderHeader_SubTotal]') AND type = 'D')
BEGIN
ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD  CONSTRAINT [DF_PurchaseOrderHeader_SubTotal]  DEFAULT ((0.00)) FOR [SubTotal]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Purchasing].[DF_PurchaseOrderHeader_TaxAmt]') AND type = 'D')
BEGIN
ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD  CONSTRAINT [DF_PurchaseOrderHeader_TaxAmt]  DEFAULT ((0.00)) FOR [TaxAmt]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Purchasing].[DF_PurchaseOrderHeader_Freight]') AND type = 'D')
BEGIN
ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD  CONSTRAINT [DF_PurchaseOrderHeader_Freight]  DEFAULT ((0.00)) FOR [Freight]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Purchasing].[DF_PurchaseOrderHeader_ModifiedDate]') AND type = 'D')
BEGIN
ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD  CONSTRAINT [DF_PurchaseOrderHeader_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Purchasing].[FK_PurchaseOrderHeader_Employee_EmployeeID]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[PurchaseOrderHeader]'))
ALTER TABLE [Purchasing].[PurchaseOrderHeader]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseOrderHeader_Employee_EmployeeID] FOREIGN KEY([EmployeeID])
REFERENCES [HumanResources].[Employee] ([BusinessEntityID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Purchasing].[FK_PurchaseOrderHeader_Employee_EmployeeID]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[PurchaseOrderHeader]'))
ALTER TABLE [Purchasing].[PurchaseOrderHeader] CHECK CONSTRAINT [FK_PurchaseOrderHeader_Employee_EmployeeID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Purchasing].[FK_PurchaseOrderHeader_ShipMethod_ShipMethodID]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[PurchaseOrderHeader]'))
ALTER TABLE [Purchasing].[PurchaseOrderHeader]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseOrderHeader_ShipMethod_ShipMethodID] FOREIGN KEY([ShipMethodID])
REFERENCES [Purchasing].[ShipMethod] ([ShipMethodID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Purchasing].[FK_PurchaseOrderHeader_ShipMethod_ShipMethodID]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[PurchaseOrderHeader]'))
ALTER TABLE [Purchasing].[PurchaseOrderHeader] CHECK CONSTRAINT [FK_PurchaseOrderHeader_ShipMethod_ShipMethodID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Purchasing].[FK_PurchaseOrderHeader_Vendor_VendorID]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[PurchaseOrderHeader]'))
ALTER TABLE [Purchasing].[PurchaseOrderHeader]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseOrderHeader_Vendor_VendorID] FOREIGN KEY([VendorID])
REFERENCES [Purchasing].[Vendor] ([BusinessEntityID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Purchasing].[FK_PurchaseOrderHeader_Vendor_VendorID]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[PurchaseOrderHeader]'))
ALTER TABLE [Purchasing].[PurchaseOrderHeader] CHECK CONSTRAINT [FK_PurchaseOrderHeader_Vendor_VendorID]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Purchasing].[CK_PurchaseOrderHeader_Freight]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[PurchaseOrderHeader]'))
ALTER TABLE [Purchasing].[PurchaseOrderHeader]  WITH CHECK ADD  CONSTRAINT [CK_PurchaseOrderHeader_Freight] CHECK  (([Freight]>=(0.00)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Purchasing].[CK_PurchaseOrderHeader_Freight]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[PurchaseOrderHeader]'))
ALTER TABLE [Purchasing].[PurchaseOrderHeader] CHECK CONSTRAINT [CK_PurchaseOrderHeader_Freight]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Purchasing].[CK_PurchaseOrderHeader_ShipDate]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[PurchaseOrderHeader]'))
ALTER TABLE [Purchasing].[PurchaseOrderHeader]  WITH CHECK ADD  CONSTRAINT [CK_PurchaseOrderHeader_ShipDate] CHECK  (([ShipDate]>=[OrderDate] OR [ShipDate] IS NULL))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Purchasing].[CK_PurchaseOrderHeader_ShipDate]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[PurchaseOrderHeader]'))
ALTER TABLE [Purchasing].[PurchaseOrderHeader] CHECK CONSTRAINT [CK_PurchaseOrderHeader_ShipDate]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Purchasing].[CK_PurchaseOrderHeader_Status]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[PurchaseOrderHeader]'))
ALTER TABLE [Purchasing].[PurchaseOrderHeader]  WITH CHECK ADD  CONSTRAINT [CK_PurchaseOrderHeader_Status] CHECK  (([Status]>=(1) AND [Status]<=(4)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Purchasing].[CK_PurchaseOrderHeader_Status]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[PurchaseOrderHeader]'))
ALTER TABLE [Purchasing].[PurchaseOrderHeader] CHECK CONSTRAINT [CK_PurchaseOrderHeader_Status]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Purchasing].[CK_PurchaseOrderHeader_SubTotal]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[PurchaseOrderHeader]'))
ALTER TABLE [Purchasing].[PurchaseOrderHeader]  WITH CHECK ADD  CONSTRAINT [CK_PurchaseOrderHeader_SubTotal] CHECK  (([SubTotal]>=(0.00)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Purchasing].[CK_PurchaseOrderHeader_SubTotal]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[PurchaseOrderHeader]'))
ALTER TABLE [Purchasing].[PurchaseOrderHeader] CHECK CONSTRAINT [CK_PurchaseOrderHeader_SubTotal]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Purchasing].[CK_PurchaseOrderHeader_TaxAmt]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[PurchaseOrderHeader]'))
ALTER TABLE [Purchasing].[PurchaseOrderHeader]  WITH CHECK ADD  CONSTRAINT [CK_PurchaseOrderHeader_TaxAmt] CHECK  (([TaxAmt]>=(0.00)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[Purchasing].[CK_PurchaseOrderHeader_TaxAmt]') AND parent_object_id = OBJECT_ID(N'[Purchasing].[PurchaseOrderHeader]'))
ALTER TABLE [Purchasing].[PurchaseOrderHeader] CHECK CONSTRAINT [CK_PurchaseOrderHeader_TaxAmt]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[Purchasing].[uPurchaseOrderHeader]'))
EXEC dbo.sp_executesql @statement = N'
CREATE TRIGGER [Purchasing].[uPurchaseOrderHeader] ON [Purchasing].[PurchaseOrderHeader] 
AFTER UPDATE AS 
BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    BEGIN TRY
        -- Update RevisionNumber for modification of any field EXCEPT the Status.
        IF NOT UPDATE([Status])
        BEGIN
            UPDATE [Purchasing].[PurchaseOrderHeader]
            SET [Purchasing].[PurchaseOrderHeader].[RevisionNumber] = 
                [Purchasing].[PurchaseOrderHeader].[RevisionNumber] + 1
            WHERE [Purchasing].[PurchaseOrderHeader].[PurchaseOrderID] IN 
                (SELECT inserted.[PurchaseOrderID] FROM inserted);
        END;
    END TRY
    BEGIN CATCH
        EXECUTE [dbo].[uspPrintError];

        -- Rollback any active or uncommittable transactions before
        -- inserting information in the ErrorLog
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END

        EXECUTE [dbo].[uspLogError];
    END CATCH;
END;
' 
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader] ENABLE TRIGGER [uPurchaseOrderHeader]
GO
