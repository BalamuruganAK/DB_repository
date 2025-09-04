-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Select_Expense]
(@ExpenseID_new int out)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec [Select_Expense] null
*/

		SELECT @ExpenseID_new = isnull(MAX(expenseID),0)+1
		FROM [tbl_Expense]
	
		Select	d.QuickCode
		From tbl_QuickCode  d
		Where d.QuickCodeType = 'EXPENSE'
		Order By d.QuickCode
		
		 
END

GO

