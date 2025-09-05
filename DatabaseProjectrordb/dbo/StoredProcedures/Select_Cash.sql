-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Select_Cash]
		(@CashID_new int out,
		@Opening Float = 0 out,
		@Sales Float = 0 out,
		@Expense Float = 0 out,
		@Card Float = 0 out,
		@Due Float = 0 out,
		@Delivery Float = 0 out,
		@Adjustment Float = 0 out,
		@PreDelivery Float = 0 out,
		@PreReceived Float = 0 out)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
declare @CashID_new int 
declare @Opening Float 
declare @Sales Float 
declare @Expense Float 
declare @Card Float 
declare @Due Float 
declare @Delivery Float 
declare @Adjustment Float 
exec [Select_Cash]
		@CashID_new  out,
		@Opening  out,
		@Sales  out,
		@Expense  out,
		@Card  out,
		@Due  out,
		@Delivery  out,
		@Adjustment  out
		
		Select @CashID_new  ,
		@Opening  ,
		@Sales  ,
		@Expense  ,
		@Card  ,
		@Due  ,
		@Delivery  ,
		@Adjustment  
*/
		DECLARE @Received Float
		DECLARE @PreCashDate Datetime

		SELECT @CashID_new = isnull(MAX(CashID),0)+1
		FROM [tbl_Cash]
	
		SELECT @Sales = isnull(sum(isnull(h.TotalAmount,0)),0), 
			@Card = isnull(sum(isnull(h.SwipeCard,0)),0), 
			@Due = isnull(sum(case when h.Due = 1 then isnull(h.TotalAmount,0) end),0),
			@Delivery = isnull(sum(case when h.DeliveryRequired = 1 then isnull(h.OnDelivery,0) end),0), 
			@Adjustment = isnull(sum(isnull(h.Adjustment,0)),0)
		FROM tbl_BillHdr h
		WHERE convert(varchar(12),h.BillDateTime,112) = convert(varchar(12),GETDATE(),112)
		AND isnull(h.Cancel,0) <> 1
		
		SELECT @PreDelivery = isnull(sum(isnull(h.OnDelivery,0)),0)
		FROM tbl_BillHdr h
		WHERE isnull(h.Cancel,0) <> 1
		AND h.DeliveryRequired = 1
		AND convert(varchar(12),h.BillDateTime,112) < convert(varchar(12),GETDATE(),112)
		AND	NOT EXISTS (
			Select 1 From tbl_Delivery d Where d.BillHdrID = h.BillHdrID And d.Status ='Done' )	
		
		SELECT @Received = isnull(SUM(isnull(d.Received,0)),0)
		FROM tbl_BillHdr h, tbl_Delivery d
		WHERE convert(varchar(12),h.BillDateTime,112) = convert(varchar(12),GETDATE(),112)
		AND isnull(h.Cancel,0) <> 1 AND h.BillHdrID = d.BillHdrID AND d.Status = 'Done'
		
		SELECT @PreReceived = isnull(SUM(isnull(d.Received,0)),0)
		FROM tbl_BillHdr h, tbl_Delivery d
		WHERE convert(varchar(12),h.BillDateTime,112) < convert(varchar(12),GETDATE(),112)
		AND convert(varchar(12),d.DeliveryDateTime,112) = convert(varchar(12),GETDATE(),112)
		AND isnull(h.Cancel,0) <> 1 AND h.BillHdrID = d.BillHdrID AND d.Status in( 'Done' , 'Partial')
		
		SELECT @Delivery = @Delivery - @Received 
		 
		SELECT @Expense = isnull(sum(isnull(h.Expense,0)),0)
		FROM tbl_Expense  h
		WHERE convert(varchar(12),h.ExpenseDateTime,112) = convert(varchar(12),GETDATE(),112)
		AND isnull(h.Cancel,0) <> 1
		
		SELECT @PreCashDate = max(c.CashDateTime) 
		FROM tbl_Cash c
		WHERE convert(varchar(12),c.CashDateTime,112) < convert(varchar(12),GETDATE(),112)
		
		SELECT @Opening = isnull(c.Closing,0)
		FROM tbl_Cash c
		WHERE c.CashDateTime = @PreCashDate
		
		SELECT @Opening = ISNULL(@Opening,0)
END

GO

