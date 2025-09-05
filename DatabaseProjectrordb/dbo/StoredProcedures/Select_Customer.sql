-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[Select_Customer]
(@CustomerID_new int out)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec [Select_Customer] null
*/

		SELECT @CustomerID_new = isnull(MAX(CustomerID),0)+1
		FROM [tbl_Customer]
	
		Select	d.QuickCode
		From tbl_QuickCode  d
		Where d.QuickCodeType = 'CUSTOMER'
		
		 
END

GO

