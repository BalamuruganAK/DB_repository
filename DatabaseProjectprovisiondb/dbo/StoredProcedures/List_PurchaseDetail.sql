-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[List_PurchaseDetail]
(@PurchaseHdrID int)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec [List_Purchases] 
*/
		Declare @min_pdid int

		SELECT @min_pdid = min(h.pdid)	- 1		 
		FROM purchasedetail  h 
		Where h.pid = @PurchaseHdrID

		SELECT h.pdid - @min_pdid id, i.iname, h.qty Quantity, h.amt Amount,h.cost UnitCost, i.Price			 
		FROM purchasedetail  h 
		inner join item i on i.iid = h.iid
		Where h.pid = @PurchaseHdrID
		Order by h.pdid 
END

GO

