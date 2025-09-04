-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cancel_Expense]
			(@ExpenseID	int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	/*
	select * from [tbl_stock]
	*/
	SET NOCOUNT ON;
	
	if not exists(SELECT 1 FROM tbl_Expense 
			WHERE Cancel = 1
			AND ExpenseID = @ExpenseID)
	BEGIN
		UPDATE tbl_Expense 
		SET Cancel = 1
		WHERE ExpenseID = @ExpenseID
		
    END
END

GO

