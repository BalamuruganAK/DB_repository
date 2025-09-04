-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[List_StockDetail]
(@StockHrdID int)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec List_StockDetail 2 
*/
		declare @StockUpdateDate date
		
		select @StockUpdateDate = StockUpdateDate
			from tbl_StockUpdateHdr where StockUpdateHdrID= @StockHrdID	

			Select i.iid as Iid, i.iname as Iname,  d.stockupdatedate As SDate, i.price as Price, 
		d.actual as Actual,d.available as Available, d.diff as Diff, d.reason As [Reasion]
	from item i inner Join stockupdatedetail d On i.iid = d.iid and d.stockupdatehdrid = @StockHrdID
		 
END

GO

