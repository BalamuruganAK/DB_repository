-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Insert_PurchaseHdr]
(@PurchaseHdrID int, @PurchaseDate date, @StockInDate date,
	@Bag int, @Oil int, @AttaSugar int, @Amount float, @PurchaseHdrID_new int out) 
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	/*
	Select * from [tbl_PurchaseHdr]
	select * from tbl_stock
	delete  from [tbl_PurchaseHdr]
	*/
	SET NOCOUNT ON;

	SELECT @PurchaseHdrID_new = isnull(MAX(PurchaseHdrID),0)+1
	FROM [tbl_PurchaseHdr]
	
	INSERT INTO [tbl_PurchaseHdr]
       ([PurchaseHdrID]
       ,[PurchaseDate]
       ,StockInDate
       ,Bag 
       ,Oil 
       ,AttaSugar
       ,Amount)
	VALUES
       (@PurchaseHdrID_new 
       ,@PurchaseDate
       ,@StockInDate 
       ,@Bag 
       ,@Oil 
       ,@AttaSugar
       ,@Amount)
           
	if (@PurchaseHdrID is not null and @PurchaseHdrID > 0)
	begin 
	    UPDATE [tbl_PurchaseHdr]
	    SET PurchaseHdrHistID = @PurchaseHdrID_new
	    WHERE PurchaseHdrID = @PurchaseHdrID
	    
	    UPDATE s
	    SET s.Bag = s.Bag - p.Quantity
	    FROM tbl_Stock s
	    INNER JOIN tbl_PurchaseDtl p
	    ON s.Rate = p.Rate
	    AND p.PurchaseHdrID = @PurchaseHdrID
	end
    -- Insert statements for procedure here
END

GO

