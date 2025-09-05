-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Insert_Stock]
(@Rate float, @UnitSize int) 
	AS
BEGIN
/*
begin tran
exec [Insert_Stock] 25.80, 25
exec [Insert_Stock] 28.80, 25
exec [Insert_Stock] 32.80, 25
exec [Insert_Stock] 35.80, 25
exec [Insert_Stock] 36.80, 25
exec [Insert_Stock] 38.80, 25
exec [Insert_Stock] 39.80, 25
exec [Insert_Stock] 40.80, 25
exec [Insert_Stock] 41.80, 25
exec [Insert_Stock] 42.80, 25
exec [Insert_Stock] 44.80, 25
exec [Insert_Stock] 45.80, 25
exec [Insert_Stock] 46.80, 25
exec [Insert_Stock] 48.80, 25
exec [Insert_Stock] 49.80, 25
exec [Insert_Stock] 50.80, 25
exec [Insert_Stock] 52.80, 25
exec [Insert_Stock] 54.80, 25
exec [Insert_Stock] 55.80, 25
exec [Insert_Stock] 58.80, 25
exec [Insert_Stock] 60.80, 25
exec [Insert_Stock] 64.80, 25
exec [Insert_Stock] 70.80, 25
exec [Insert_Stock] 74.80, 25
exec [Insert_Stock] 78.80, 25
exec [Insert_Stock] 80.80, 25
exec [Insert_Stock] 85.80, 25
exec [Insert_Stock] 110.80, 20

exec [Insert_Stock] 70.00, 10
exec [Insert_Stock] 75.00, 10

exec [Insert_Stock] 26.00, 50
exec [Insert_Stock] 40.00, 50


  update [tbl_Stock]
  set ItemType = 'Rice'
  where UnitSize in( 25, 20)
  
  update [tbl_Stock]
  set ItemType = 'Atta'
  where Rate  = 26
  
  update [tbl_Stock]
  set ItemType = 'Sugar'
  where Rate  = 40
    
  update [tbl_Stock]
  set ItemType = 'RG_Oil'
  where Rate  = 70
  
  update [tbl_Stock]
  set ItemType = 'SF_Oil'
  where Rate  = 75
  
select * from tbl_Stock
commit tran
rollback tran
go*/
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @StockID_new int
	SELECT @StockID_new = isnull(MAX(StockID),0)+1
	FROM [tbl_Stock]
	
	If Not Exists 
		(Select 1 from tbl_Stock 
		where Rate = @Rate 
		and UnitSize = @UnitSize)
	begin
		INSERT INTO [tbl_Stock]
		   ([StockID]
		   ,Rate
		   ,Bag
		   ,Loose
		   ,UnitSize)
		VALUES
		   (@StockID_new ,
		   @Rate,
		   0,
		   0.0,
		   @UnitSize)
    end       
	
    -- Insert statements for procedure here
END

GO

