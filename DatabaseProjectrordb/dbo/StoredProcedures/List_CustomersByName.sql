-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[List_CustomersByName]
(@Name varchar(50), @CustomerAddress varchar(200))
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec [List_CustomersByName] '' ,''
*/
	
		
		SELECT 
			CustomerID,
			CustomerDateTime,
			ExecutiveId,
			Phone,
			CustomerType,
			Name,
			CustomerAddress
		FROM [tbl_Customer] h 
		WHERE h.Name like '%'+@Name+'%'
		and h.CustomerAddress like '%'+@CustomerAddress+'%'
		Order by h.CustomerID desc 
END

GO

