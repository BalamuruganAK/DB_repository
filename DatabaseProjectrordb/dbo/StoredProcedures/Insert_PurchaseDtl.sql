-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Insert_PurchaseDtl]
(@PurchaseHdrID int, @Rate float, @Brand varchar(20), 
@Quantity int, @UnitSize int, @Price float, @Amount float) 
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	/*
	select * from [tbl_PurchaseDtl]
	*/
	SET NOCOUNT ON;
	
	Declare @PurchaseDtlID_new int 
	
	SELECT @PurchaseDtlID_new = isnull(MAX(PurchaseDtlID),0)+1
	FROM [tbl_PurchaseDtl]
	
	INSERT INTO [tbl_PurchaseDtl]
		([PurchaseDtlID]
           ,[PurchaseHdrID]
           ,[Rate]
           ,[Brand]
           ,[Quantity]
           ,[UnitSize]
           ,[Price]
           ,[Amount])
	VALUES
       (@PurchaseDtlID_new
           ,@PurchaseHdrID
           ,@Rate
           ,@Brand
           ,@Quantity
           ,@UnitSize
           ,@Price
           ,@Amount)
           
    UPDATE s
    SET s.Bag = s.Bag + @Quantity
    FROM tbl_Stock s
    WHERE s.Rate = @Rate
    And s.UnitSize = @UnitSize
	
    -- Insert statements for procedure here
END

GO

