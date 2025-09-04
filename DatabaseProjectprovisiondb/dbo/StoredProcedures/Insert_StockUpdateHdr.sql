-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Insert_StockUpdateHdr]
(@TotalCount int, @TakenCount int, @Actual float, @Available float,  @Diff float) 
	AS
BEGIN
	/*
	Select * from [tbl_StockUpdateHdr]
	select * from tbl_stock
	delete  from [tbl_StockUpdateHdr]
	*/
	SET NOCOUNT ON;

	declare @StockUpdateHdrID_new int
	declare @StockUpdateDate date
	
	select @StockUpdateDate = GETDATE()
	
		SELECT @StockUpdateHdrID_new = isnull(MAX(stockupdatehdrid),0)+1
		FROM stockupdatehdr
			
		INSERT INTO stockupdatehdr
			(stockupdatehdrid
			,stockupdatedate
			,totalcount
			,takencount
			,actual
			,available
			,diff)
		VALUES
			(@StockUpdateHdrID_new 
			,@StockUpdateDate
			,@TotalCount  
			,@TakenCount  
			,@Actual
			,@Available
			,@Diff )
END

GO

