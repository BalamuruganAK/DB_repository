-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Insert_StockUpdateDtl]
			(@Iid int 
           ,@Actual float
           ,@Available float
           ,@Diff float
           ,@Reason varchar(100)) 
	AS
BEGIN
	/*
	select * from [tbl_StockUpdateHdr]
	select * from [tbl_StockUpdateDtl]
	select * from [tbl_Stock]
	*/
	SET NOCOUNT ON;
	
	Declare @StockUpdateDtlID_new int 
	Declare @StockUpdateHdrID int
	Declare @StockUpdateDate date
	
	SELECT @StockUpdateDate = GETDATE()
	SELECT @StockUpdateDtlID_new = isnull(MAX(stockupdatedtlid),0)+1
	FROM stockupdatedetail
	
	SELECT @StockUpdateHdrID = isnull(MAX(stockupdatehdrid),0)
	FROM stockupdatehdr
		
		INSERT INTO stockupdatedetail
			(stockupdatehdrid
           ,stockupdatedtlid
           ,stockupdatedate
           ,iid
           ,actual
           ,available
		   ,diff
           ,reason)
		VALUES
		(@StockUpdateHdrID
           ,@StockUpdateDtlID_new
           ,@StockUpdateDate
           ,@Iid
           ,@Actual
           ,@Available
           ,@Diff
           ,@Reason)
           
    UPDATE s
    SET s.qty = @Available
    FROM stock s
    WHERE s.iid = @Iid
	
    -- Insert statements for procedure here
END

GO

