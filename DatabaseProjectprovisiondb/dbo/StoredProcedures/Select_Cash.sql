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
		@GPay Float = 0 out,
		@Cash Float = 0 out,
		@Salesbalance Float = 0 out,
		@Received Float = 0 out,
		@Net Float = 0 out,
		@CashByAccount Float = 0 out,
		@MonthExpense Float = 0 out,
		@Locker Float = 0 out,
		@Closing Float = 0 out	)
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
		DECLARE @PreCashDate Datetime
		DECLARE @lockertemp float

		SELECT @CashID_new = isnull(MAX(CashID),0)+1
		FROM [tbl_Cash]
	
		SELECT @Sales = isnull(sum(isnull(h.amt,0)),0), 
			@Card = isnull(sum(isnull(h.cards,0)),0), 
			@GPay = isnull(sum( isnull(h.gpay,0)),0),
			@Cash = isnull(sum( isnull(h.cash,0)),0),			
			@Salesbalance = isnull(sum(isnull(h.salesbalance,0)),0)
		FROM sales h
		WHERE convert(varchar(12),h.sdate,112) = convert(varchar(12),GETDATE(),112)
		AND isnull(h.Cancel,0) <> 1
		
		SELECT @Received = isnull(SUM(isnull(h.salesbalance,0)),0) * -1
		FROM sales h
		WHERE convert(varchar(12),h.sdate,112) = convert(varchar(12),GETDATE(),112)
		AND isnull(h.Cancel,0) <> 1 and h.salesbalance < 0

		SELECT @Salesbalance = isnull(SUM(isnull(h.salesbalance,0)),0) 
		FROM sales h
		WHERE convert(varchar(12),h.sdate,112) = convert(varchar(12),GETDATE(),112)
		AND isnull(h.Cancel,0) <> 1 and h.salesbalance > 0
		 
		SELECT @Expense = isnull(sum(isnull(h.Expense,0)),0)
		FROM tbl_Expense  h
		WHERE convert(varchar(12),h.ExpenseDateTime,112) = convert(varchar(12),GETDATE(),112)
		AND h.ExpenseType like 'Maintenance%'
		AND isnull(h.Cancel,0) <> 1
		
		SELECT @PreCashDate = max(c.CashDateTime) 
		FROM tbl_Cash c
		WHERE convert(varchar(12),c.CashDateTime,112) < convert(varchar(12),GETDATE(),112)
		
		SELECT @Opening = isnull(c.Closing,0)
		FROM tbl_Cash c
		WHERE c.CashDateTime = @PreCashDate
		
		SELECT @Opening = ISNULL(@Opening,0)
		SELECT @Net = @Opening+ @Received + @Sales - @Expense - @Salesbalance
		SELECT @CashByAccount = @Net - @Card - @GPay
		SELECT @MonthExpense = convert(int,(@Net * 0.12) / 10) * 10

		SELECT @lockertemp = convert(int,(@CashByAccount - @MonthExpense)/1000)*1000

		if (@CashByAccount - @MonthExpense - @lockertemp) < 500 
		begin
			SELECT @locker = @lockertemp
		end
		else
		begin
			SELECT @locker = @lockertemp + 500
		end

		SELECT @Closing  = @CashByAccount - @MonthExpense - @locker	

END

GO

