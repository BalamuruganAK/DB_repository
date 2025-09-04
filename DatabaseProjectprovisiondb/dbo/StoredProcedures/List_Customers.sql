-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[List_Customers]
(@FromDate DateTime, @ToDate DateTime)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec List_Customers 
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
		WHERE h.CustomerDateTime between @FromDate and @ToDate
		Order by h.CustomerID desc 
END

GO

