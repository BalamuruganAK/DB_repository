-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[List_LastBills]
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec List_LastBills 
*/
		
		SELECT top 5
			h.sid, 'Detail' Detail, 'Cancel' Cancel, h.sdate BillDateTime, h.eid ExecutiveId, h.Phone, 
			h.amt TotalAmount, h.Cash, h.cards, h.gpay,h.discount,
			isnull(c.Name,'') Name, isnull(c.CustomerAddress,'') Address, isnull(c.CustomerType,'') Type
		FROM sales h left outer join tbl_Customer c
			ON h.Phone = c.Phone 
		WHERE isnull(h.Cancel,0) <> 1	
		Order by h.sid desc 
END

GO

