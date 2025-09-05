-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[List_Expenses]
(@FromDate DateTime, @ToDate DateTime)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec List_LastExpenses 
*/
	Declare @cashDateTime datetime
	
		SELECT @cashDateTime = MAX(c.CashDateTime)
		FROM tbl_Cash c
	
		SELECT h.ExpenseID, h.ExpenseDateTime, h.ExecutiveId, h.Expense, 
			h.ExpenseType, h.Details, h.Advance, h.Balance 
		FROM tbl_Expense h 
		WHERE isnull(h.Cancel,0) <> 1
		AND h.ExpenseDateTime between @FromDate and @ToDate
		Order by h.ExpenseID desc 
END

GO

