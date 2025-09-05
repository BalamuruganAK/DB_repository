-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Insert_Expense]
		   (@ExpenseID int,
           @ExecutiveId int,
           @ExpenseType varchar(50),
           @Advance float,
           @Expense float,
           @Balance float,
           @Details varchar(200)) 
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	/*
	Select * from [tbl_Expense]
	select * from tbl_stock
	delete  from [tbl_Expense]
	*/
	SET NOCOUNT ON;

	INSERT INTO [rordb].[dbo].[tbl_Expense]
           ([ExpenseID]
           ,[ExpenseDateTime]
           ,[ExecutiveId]
           ,[ExpenseType]
           ,[Advance]
           ,[Expense]
           ,[Balance]
           ,[Details])
	VALUES
		   (@ExpenseID	,
			GETDATE(),
			@ExecutiveId	,
			@ExpenseType	,
			@Advance	,
			@Expense 	,
			@Balance 	,
			@Details )
           
    -- Insert statements for procedure here
END

GO

