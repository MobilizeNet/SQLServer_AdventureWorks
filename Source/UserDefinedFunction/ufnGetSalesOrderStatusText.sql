SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufnGetSalesOrderStatusText]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
CREATE FUNCTION [dbo].[ufnGetSalesOrderStatusText](@Status [tinyint])
RETURNS [nvarchar](15) 
AS 
-- Returns the sales order status text representation for the status value.
BEGIN
    DECLARE @ret [nvarchar](15);

    SET @ret = 
        CASE @Status
            WHEN 1 THEN ''In process''
            WHEN 2 THEN ''Approved''
            WHEN 3 THEN ''Backordered''
            WHEN 4 THEN ''Rejected''
            WHEN 5 THEN ''Shipped''
            WHEN 6 THEN ''Cancelled''
            ELSE ''** Invalid **''
        END;
    
    RETURN @ret
END;
' 
END
GO
