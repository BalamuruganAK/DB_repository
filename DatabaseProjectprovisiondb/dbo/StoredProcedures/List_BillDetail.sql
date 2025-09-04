-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[List_BillDetail]
(@Sid int)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec List_BillDetail 2 
*/
		Declare @MIN_BillDtlID int

		SELECT @MIN_BillDtlID = MIN( h.[sdid])
		FROM salesdetail h 
		WHERE h.[sid] = @Sid	
		
		SELECT h.[sid] as [sid], h.[sdid] - @MIN_BillDtlID + 1 as [sdid], i.iname as Item, 
			h.price as Price,  h.discount as Discount, h.rate as Rate,  h.qty as Quantity, h.amt as Amount
		FROM salesdetail h 
		inner join item i on i.iid = h.iid
		WHERE h.[sid] = @Sid	 
END

GO

