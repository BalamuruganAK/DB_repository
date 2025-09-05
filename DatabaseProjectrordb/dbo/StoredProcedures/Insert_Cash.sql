-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Insert_Cash]
		   (@CashID int,
           @ExecutiveId int,
           @Thousand int,
           @FiveHundrad int,
           @Hundrad int,
           @Fifty int,
           @Twenty int,
           @Ten int,
           @Five int,
           @Two int,
           @One int,
           @Opening float,
           @Sales float,
           @Expense float,
           @Net float,
           @SwipeCard float,
           @Due float,
           @Delivery float,
           @Adjustment float,
           @Locker float,
           @Closing float,
           @CashBoxAmount float,
           @CashByAccount float,
           @PreDelivery float,
           @PreReceived float) 
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	/*
	Select * from [tbl_Cash]
	select * from tbl_stock
	delete  from [tbl_Cash]
	*/
	SET NOCOUNT ON;

	INSERT INTO [rordb].[dbo].[tbl_Cash]
           ([CashID]
			,[CashDateTime]
			,[ExecutiveId]
			,[Thousand]
			,[FiveHundrad]
			,[Hundrad]
			,[Fifty]
			,[Twenty]
			,[Ten]
			,[Five]
			,[Two]
			,[One]
			,[Opening]
			,[Sales]
			,[Expense]
			,[Net]
			,[SwipeCard]
			,[Due]
			,[Delivery]
			,[Adjustment]
			,[Locker]
			,[Closing]
			,[CashBoxAmount]
			,[CashByAccount]
			,[CashStatus]
			,PreDelivery
			,PreReceived)
	VALUES
		   (@CashID	,
			GETDATE(),
			@ExecutiveId	,
			 @Thousand ,
           @FiveHundrad ,
           @Hundrad ,
           @Fifty ,
           @Twenty ,
           @Ten ,
           @Five ,
           @Two ,
           @One ,
           @Opening ,
           @Sales ,
           @Expense ,
           @Net ,
           @SwipeCard ,
           @Due ,
           @Delivery ,
           @Adjustment ,
           @Locker ,
           @Closing ,
           @CashBoxAmount ,
           @CashByAccount ,
           'Match',
           @PreDelivery,
           @PreReceived)
           
    -- Insert statements for procedure here
END

GO

