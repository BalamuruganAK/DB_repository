-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cancel_Bill]
			(@BillHdrID	int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	/*
	select * from [tbl_stock]
	*/
	SET NOCOUNT ON;
	
	if not exists(SELECT 1 FROM tbl_BillHdr 
			WHERE Cancel = 1
			AND BillHdrID = @BillHdrID)
	BEGIN
		UPDATE tbl_BillHdr 
		SET Cancel = 1
		WHERE BillHdrID = @BillHdrID
		
		
		UPDATE s
		SET s.Bag = Bag + Convert(int,(d.Quantity_s/s.UnitSize)),
			s.Loose = s.Loose + (d.Quantity_s - (Convert(int,(d.Quantity_s/s.UnitSize))*s.UnitSize))
		FROM tbl_Stock s, (Select Item as Item_s, SUM(Quantity) as Quantity_s from tbl_BillDtl where BillHdrID = @BillHdrID group by Item ) d
		WHERE s.Rate = d.Item_s
		
    END
END

GO

