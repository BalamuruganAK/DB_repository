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
		SELECT h.Rate, h.Brand, h.Quantity, h.Price,
			h.UnitSize, h.Amount
		FROM tbl_PurchaseDtl  h 
		Where h.PurchaseHdrID = @PurchaseHdrID
		Order by h.Rate 
END

GO

