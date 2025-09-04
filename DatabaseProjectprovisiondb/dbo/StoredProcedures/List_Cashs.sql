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
		  ,[Card]
		  ,GPay
		  ,Cash
		  ,Salesbalance
		  ,[Locker]
		  ,[Closing]
		  ,[CashBoxAmount]
		  ,[CashByAccount]
		  ,[CashStatus]
		  ,[Received]
		  ,[CashDateTime]
		  ,h.CashStatus
		  ,b.closebalance CashBalance
		FROM [tbl_Cash] h left join cashbalance b
		On convert(varchar(12),h.CashDateTime,112) = convert(varchar(12),b.cbdate,112)
		WHERE h.CashDateTime between @FromDate and @ToDate		
		Order by h.CashID desc 
END

GO

