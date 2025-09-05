-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[List_LastExpenses]
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
	
		SELECT top (Select convert(int,q.QuickCode) from tbl_QuickCode q where q.QuickCodeType = 'CASHCOUNT')
		 h.ExpenseID,  'Cancel' Cancel, h.ExpenseDateTime, h.ExecutiveId, h.Expense, 
			h.ExpenseType, h.Details, h.Advance, h.Balance 
		FROM tbl_Expense h 
		WHERE isnull(h.Cancel,0) <> 1
		AND h.ExpenseDateTime > @cashDateTime
		Order by h.ExpenseID desc 
END

GO

