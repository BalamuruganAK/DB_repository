-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FilterCustomers]
(@Phone varchar(12))
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec [FilterCustomers] '12' 
*/
	
	Select @Phone = '%'+ replace(@Phone,' ','%') + '%'

		
		SELECT 
			convert(varchar(10),i.Phone) + ' {'+i.Name+' , '+ i.CustomerAddress+'}' as 'Name'
		FROM tbl_Customer i
		WHERE convert(varchar(10),i.Phone) like @Phone
		Order by i.Phone 
	
END

GO

