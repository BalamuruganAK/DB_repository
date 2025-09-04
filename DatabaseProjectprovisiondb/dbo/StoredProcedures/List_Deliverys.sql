-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[List_Deliverys]
(@FromDate DateTime, @ToDate DateTime)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec List_PendingDelivery 
*/

		SELECT h.BillHdrID, 'Detail' Detail, h.Cancel Cancel, h.BillDateTime, h.ExecutiveId, h.Phone, 
			h.TotalAmount, h.Cash, h.SwipeCard, h.Adjustment,h.OnDelivery,
			isnull(c.Name,'') Name, isnull(c.CustomerAddress,'') Address, isnull(c.CustomerType,'') Type,
			d.Status, d.Received, d.DeliveryDateTime, d.ExecutiveId DExId
		FROM [tbl_BillHdr] h left outer join tbl_Customer c
			ON h.Phone = c.Phone 
			left outer join tbl_Delivery d on d.BillHdrID = h.BillHdrID
		WHERE h.DeliveryRequired = 1
		AND h.BillDateTime between @FromDate and @ToDate	 
END

GO

