-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[List_Bills]
(@FromDate DateTime, @ToDate DateTime)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec List_Bills 
*/		
		SELECT 
			h.sid, 'Detail' Detail, h.Cancel Canceled, h.sdate BillDateTime, h.eid 'S_Ex_ID', 
			h.Phone, h.amt TotalAmount, h.Cash, h.cards SwipeCard, h.gpay,h.discount,
			isnull(c.Name,'') Name, isnull(c.CustomerAddress,'') Address, isnull(c.CustomerType,'') Type,
			case when h.Cancel = 0 then 'Edit' else 'Canceled' end Edit
		FROM sales h 
			left outer join tbl_Customer c
			ON h.Phone = c.Phone 			
		WHERE h.sdate between @FromDate and @ToDate
		Order by h.sid desc 
END

GO

