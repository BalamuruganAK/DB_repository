-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Select_BillDtl]
(@BillHdrID_new int out,
@CashCount int out)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec [Select_BillDtl] null
*/
	DECLARE @maxDateTime datetime

		SELECT @BillHdrID_new = isnull(MAX(BillHdrID),0)+1
		FROM [tbl_BillHdr]
	
		SELECT @maxDateTime = MAX(c.CashDateTime)
		FROM tbl_Cash c
		
		SELECT @CashCount = (Select convert(int,q.QuickCode) from tbl_QuickCode q where q.QuickCodeType = 'CASHCOUNT') - COUNT(1)
		FROM tbl_BillHdr h
		WHERE h.BillDateTime > @maxDateTime
	
		Select
				d.Cfloat  Rate
			   ,d.Cchar  Item
			   ,d.Cfloat  Quantity 
			   ,d.Cfloat  Discount
			   ,d.Cchar  Offer
			   ,d.Cfloat  Amount
		 From tbl_Dummy d
		/* union 
		 Select
				 d.Cint +2 AS SNo
			   ,d.Cfloat  Rate
			   ,d.Cchar  Item
			   ,d.Cint  Quantity 
			   ,d.Cfloat  Discount
			   ,d.Cchar  Offer
			   ,d.Cfloat  Amount
		 From tbl_Dummy d*/
		 
END

GO

