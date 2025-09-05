-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[List_PendingDelivery]
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec List_PendingDelivery 
*/

		SELECT h.BillHdrID, 'Detail' Detail, 'Edit' Edit, h.BillDateTime, h.ExecutiveId, h.Phone, 
			h.TotalAmount, h.Cash, h.SwipeCard, h.Adjustment,h.OnDelivery,
			isnull(c.Name,'') Name, isnull(c.CustomerAddress,'') Address, isnull(c.CustomerType,'') Type
		FROM [tbl_BillHdr] h left outer join tbl_Customer c
			ON h.Phone = c.Phone 
		WHERE h.DeliveryRequired = 1
		AND isnull(h.Cancel,0) <> 1
		AND	NOT EXISTS (
			Select 1 From tbl_Delivery d Where d.BillHdrID = h.BillHdrID And d.Status ='Done' )		 
END

GO

