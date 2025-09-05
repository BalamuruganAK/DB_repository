-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[List_Purchases]
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec [List_Purchases] 
*/
		SELECT h.PurchaseHdrID ID, h.PurchaseDate Date, h.Bag, h.AttaSugar, h.Oil,
			h.Amount, h.StockInDate, h.PurchaseHdrHistID
		FROM tbl_PurchaseHdr  h 
		Order by h.PurchaseHdrID desc
END

GO

