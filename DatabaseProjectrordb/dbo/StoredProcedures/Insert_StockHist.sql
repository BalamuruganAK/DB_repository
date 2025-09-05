-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[Insert_StockHist]
	AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
		INSERT INTO [tbl_StockHist]
		   (StockDate
		   ,[StockID]
		   ,Rate
		   ,Bag
		   ,Loose
		   ,UnitSize)
		Select 
		GETDATE()
			,StockID
		   ,Rate
		   ,Bag
		   ,Loose
		   ,UnitSize
		From tbl_Stock 
          
	
    -- Insert statements for procedure here
END

GO

