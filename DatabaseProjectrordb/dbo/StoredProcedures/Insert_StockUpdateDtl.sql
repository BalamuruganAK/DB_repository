-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Insert_StockUpdateDtl]
			(@Rate float, 
			@Bag int
           ,@Loose float
           ,@AvailableBag int
           ,@AvailableLoose float
           ,@DifferenceBag int
           ,@DifferenceLoose float
           ,@ExecutiveId int
           ,@Reason varchar(50)) 
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
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
	SELECT @StockUpdateDtlID_new = isnull(MAX(StockUpdateDtlID),0)+1
	FROM [tbl_StockUpdateDtl]
	
	SELECT @StockUpdateHdrID = StockUpdateHdrID 
	FROM [tbl_StockUpdateHdr] 
	WHERE StockUpdateDate = @StockUpdateDate
	
		INSERT INTO [tbl_StockUpdateDtl]
			([StockUpdateDtlID]
           ,[StockUpdateHdrID]
           ,[StockUpdateDate]
           ,[StockUpdateDateTime]
           ,[Rate]
           ,[Bag]
           ,[Loose]
           ,[AvailableBag]
           ,[AvailableLoose]
           ,[DifferenceBag]
           ,[DifferenceLoose]
           ,[ExecutiveId]
           ,[Reason])
		VALUES
		(@StockUpdateDtlID_new
           ,@StockUpdateHdrID
           ,@StockUpdateDate
           ,GETDATE()
           ,@Rate
           ,@Bag
           ,@Loose
           ,@AvailableBag
           ,@AvailableLoose
           ,@DifferenceBag
           ,@DifferenceLoose
           ,@ExecutiveId
           ,@Reason)
           
    UPDATE s
    SET s.Bag = @AvailableBag, s.Loose = @AvailableLoose
    FROM tbl_Stock s
    WHERE s.Rate = @Rate
	
    -- Insert statements for procedure here
END

GO

