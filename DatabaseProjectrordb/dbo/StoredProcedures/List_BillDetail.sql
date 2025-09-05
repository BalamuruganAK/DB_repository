-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[List_BillDetail]
(@BillHrdID int)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec List_BillDetail 2 
*/
		Declare @MIN_BillDtlID int

		SELECT @MIN_BillDtlID = MIN( h.BillDtlID)
		FROM [tbl_BillDtl] h 
		WHERE h.BillHdrID = @BillHrdID	
		
		SELECT h.BillHdrID, h.BillDtlID - @MIN_BillDtlID + 1 BillDtlID, h.Item, h.Quantity, h.Discount, h.Offer, h.Amount
		FROM [tbl_BillDtl] h 
		WHERE h.BillHdrID = @BillHrdID	 
END

GO

