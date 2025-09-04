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
           @Card float,
           @GPay float,
           @Cash float,
           @Salesbalance float,
           @Locker float,
           @Closing float,
           @CashBoxAmount float,
           @CashByAccount float,
           @Received float,
		   @MonthExpense float) 
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
	Declare @openbalance Float = 0,
		@cashfromsales Float = 0,
		@Purchase Float = 0,
		@expensesnonm Float = 0 ,
		@closebalance Float = 0 ,
		@PreCashBalanceDate Datetime,
		@cbid int

	INSERT INTO [dbo].[tbl_Cash]
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
			,[Card]
			,[GPay]
			,[Cash]
			,[Salesbalance]
			,[Locker]
			,[Closing]
			,[CashBoxAmount]
			,[CashByAccount]
			,[CashStatus]
			,Received
			,MonthExpense)
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
           @Card ,
           @GPay ,
           @Cash ,
           @Salesbalance ,
           @Locker ,
           @Closing ,
           @CashBoxAmount ,
           @CashByAccount ,
           'Match',
           @Received,
		   @MonthExpense)
           
		 
		SELECT @PreCashBalanceDate = max(c.cbdate) 
		FROM cashbalance c
		WHERE convert(varchar(12),c.cbdate,112) <= convert(varchar(12),GETDATE()-1,112)
		
		SELECT @openbalance = isnull(c.closebalance,0)
		FROM cashbalance c
		WHERE c.cbdate = @PreCashBalanceDate
		
		SELECT @openbalance = ISNULL(@openbalance,0)

		SELECT @cashfromsales = isnull(h.Locker,0) + isnull(h.Card,0) + isnull(h.GPay,0)
		FROM tbl_Cash h
		WHERE h.CashID = ( Select Max(c.CashID)
			From tbl_Cash c Where convert(varchar(12),c.CashDateTime,112) > convert(varchar(12),@PreCashBalanceDate,112)
			Group by convert(varchar(12),c.CashDateTime,112))

		SELECT @cashfromsales = isnull(@cashfromsales,0)

		SELECT @Purchase = isnull(sum(isnull(h.amt,0)),0)
		FROM purchase h
		WHERE h.pdate > @PreCashBalanceDate
		AND isnull(h.phistid,0) = 0

		   SELECT @expensesnonm = isnull(sum(isnull(h.Expense,0)),0)
		FROM tbl_Expense  h
		WHERE h.ExpenseDateTime > @PreCashBalanceDate
		AND h.ExpenseType Not like 'Maintenance%'
		AND isnull(h.Cancel,0) <> 1

		SELECT @closebalance = (@openbalance + @cashfromsales) - (@Purchase + @expensesnonm)

		If exists(	SELECT 1 FROM cashbalance c
			WHERE convert(varchar(12),c.cbdate,112) = convert(varchar(12),GETDATE(),112))
			begin
				SELECT @cbid = isnull(MAX(cbid),0) FROM cashbalance
				Update cashbalance
					set openbalance = @openbalance, cashfromsales = @cashfromsales, Purchase =@Purchase,
					expensesnonm = @expensesnonm, closebalance = @closebalance, cbdate = GETDATE()
				Where cbid = @cbid
			end
			else
			begin
				SELECT @cbid = isnull(MAX(cbid),0)+1 FROM cashbalance
				Insert into cashbalance values (@cbid, GETDATE(), @openbalance, 
					@cashfromsales, @Purchase, @expensesnonm, @closebalance)
			end


    -- Insert statements for procedure here
END

GO

