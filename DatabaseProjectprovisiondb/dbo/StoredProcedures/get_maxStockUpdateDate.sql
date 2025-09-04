-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_maxStockUpdateDate]
(@StockDate as date out)
	AS
BEGIN
	SET NOCOUNT ON;
/*
Declare @StockDate as date
exec [get_maxStockUpdateDate] @StockDate out
select @StockDate
*/	
 
	Select @StockDate =  max(d.stockupdatedate) 
	from stockupdatedetail d 	
END

GO

