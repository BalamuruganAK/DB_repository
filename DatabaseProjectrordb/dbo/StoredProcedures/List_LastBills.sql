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
	Declare @cashDateTime datetime
	
		SELECT @cashDateTime = MAX(c.CashDateTime)
		FROM tbl_Cash c
		
		SELECT top (Select convert(int,q.QuickCode) from tbl_QuickCode q where q.QuickCodeType = 'CASHCOUNT')
			h.BillHdrID, 'Detail' Detail, 'Cancel' Cancel, h.BillDateTime, h.ExecutiveId, h.Phone, 
			h.TotalAmount, h.Cash, h.SwipeCard, h.Adjustment,h.OnDelivery,
			isnull(c.Name,'') Name, isnull(c.CustomerAddress,'') Address, isnull(c.CustomerType,'') Type
		FROM [tbl_BillHdr] h left outer join tbl_Customer c
			ON h.Phone = c.Phone 
		WHERE isnull(h.Cancel,0) <> 1
		AND h.BillDateTime > @cashDateTime
		AND	NOT EXISTS (
			Select 1 From tbl_Delivery d Where d.BillHdrID = h.BillHdrID And d.Status ='Done' )	
		Order by h.BillHdrID desc 
END

GO

