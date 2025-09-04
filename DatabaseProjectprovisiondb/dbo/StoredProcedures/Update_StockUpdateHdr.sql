-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Update_StockUpdateHdr]
	AS
BEGIN
	/*
	Select * from [tbl_StockUpdateHdr]
	select * from tbl_stock
	delete  from [tbl_StockUpdateHdr]
	*/
	SET NOCOUNT ON;

	declare @StockUpdateHdrID_new int
	
	
		SELECT @StockUpdateHdrID_new = isnull(MAX(stockupdatehdrid),0)
		FROM stockupdatehdr
			
		UPDATE sh
		Set sh.actualcost =
			(Select sum(case when s.cost > 0 then s.cost else i.price * 0.90 end * d.actual)
			from stock s Inner Join item i On s.iid = i.iid
			inner join stockupdatedetail d on d.iid = i.iid and d.stockupdatehdrid = sh.stockupdatehdrid)
		From stockupdatehdr sh
		WHERE stockupdatehdrid = @StockUpdateHdrID_new

		UPDATE sh
		Set sh.diffcost = sh.actualcost - 
			(Select sum(case when s.cost > 0 then s.cost else i.price * 0.90 end * d.available)
			from stock s Inner Join item i On s.iid = i.iid
			inner join stockupdatedetail d on d.iid = i.iid and d.stockupdatehdrid = sh.stockupdatehdrid)
		From stockupdatehdr sh
		WHERE stockupdatehdrid = @StockUpdateHdrID_new
			
END

GO

