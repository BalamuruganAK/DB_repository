-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Insert_StockUpdateHdr]
(@TotalCount int, @TakenCount int,
	@BagCount int, @LooseCount float,@BagDiff int,  @LooseDiff float) 
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	/*
	Select * from [tbl_StockUpdateHdr]
	select * from tbl_stock
	delete  from [tbl_StockUpdateHdr]
	*/
	SET NOCOUNT ON;

	declare @StockUpdateHdrID_new int
	declare @StockUpdateDate date
	
	select @StockUpdateDate = GETDATE()
	
	if not exists(	SELECT 1
		FROM [tbl_StockUpdateHdr]
		WHERE StockUpdateDate = @StockUpdateDate)
		begin		
		
			SELECT @StockUpdateHdrID_new = isnull(MAX(StockUpdateHdrID),0)+1
			FROM [tbl_StockUpdateHdr]
			
			INSERT INTO [tbl_StockUpdateHdr]
			   ([StockUpdateHdrID]
			   ,[StockUpdateDate]
			   ,[TotalCount]
			   ,[TakenCount]
			   ,[BagCount]
			   ,[LooseCount]
			   ,[BagDiff]
			   ,[LooseDiff])
			VALUES
			   (@StockUpdateHdrID_new 
			   ,@StockUpdateDate
			   ,@TotalCount  
			   ,@TakenCount  
			   ,@BagCount  
			   ,@LooseCount 
			   ,@BagDiff 
			   ,@LooseDiff )
          end
          else
          begin
				UPDATE [tbl_StockUpdateHdr]
				SET [TotalCount] = @TotalCount,
					[TakenCount] = @TakenCount,
					[BagCount] = @BagCount,
					[LooseCount] = @LooseCount,
					[BagDiff] = @BagDiff,
					[LooseDiff] = @LooseDiff
				WHERE [StockUpdateDate] = @StockUpdateDate
          end
    -- Insert statements for procedure here
END

GO

