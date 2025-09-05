-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[List_Cashs]
(@FromDate DateTime, @ToDate DateTime)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec List_Cashs 
*/
	
		
		SELECT 
			[CashID]
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
		  ,[PreDelivery]
		  ,[PreReceived]
		  ,[CashDateTime]
		FROM [tbl_Cash] h 
		WHERE h.CashDateTime between @FromDate and @ToDate
		Order by h.CashID desc 
END

GO

