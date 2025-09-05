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
			h.BillHdrID, 'Detail' Detail, h.Cancel Canceled, h.BillDateTime, h.ExecutiveId 'S_Ex_ID', 
			h.Phone, h.TotalAmount, h.Cash, h.SwipeCard, h.Adjustment,h.OnDelivery,
			isnull(c.Name,'') Name, isnull(c.CustomerAddress,'') Address, isnull(c.CustomerType,'') Type,
			d.Status 'Delivered', d.Received 'Received', d.ExecutiveId 'D_Ex_ID'
		FROM [tbl_BillHdr] h 
			left outer join tbl_Customer c
			ON h.Phone = c.Phone 
			left outer join tbl_Delivery d
			on d.BillHdrID = h.BillHdrID
		WHERE h.BillDateTime between @FromDate and @ToDate
		Order by h.BillHdrID desc 
END

GO

