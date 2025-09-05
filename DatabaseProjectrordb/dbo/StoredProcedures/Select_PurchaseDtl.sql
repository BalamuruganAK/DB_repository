-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Select_PurchaseDtl]
(@PurchaseHdrID int) 
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec [Select_PurchaseDtl] null
*/


	if exists (
		Select 1
		From tbl_PurchaseHdr
		Where PurchaseHdrID = @PurchaseHdrID)
	begin
	
		Select
				p.Rate
			   ,p.Brand
			   ,convert(varchar(10),s.Bag)+'   /   '+convert(varchar(10),s.Loose ) Stock
			   ,p.Quantity Qty
			   ,p.UnitSize
			   ,p.Price
			   ,p.Amount
		 From tbl_PurchaseDtl p, tbl_Stock s
		 Where [PurchaseHdrID] = @PurchaseHdrID
		 And p.Rate = s.Rate And p.UnitSize = s.UnitSize
		 union 
		 Select
				s.Rate Rate
			   ,d.Cchar as Brand
			   ,convert(varchar(10),s.Bag)+'   /   '+convert(varchar(10),s.Loose ) Stock
			   ,d.Cint Qty
			   ,s.UnitSize UnitSize
			   ,d.Cint Price
			   ,d.Cint Amount
		 From tbl_Stock s, tbl_Dummy d
		 where not exists( select 1 from  [tbl_PurchaseDtl] d1
						where s.Rate = d1.Rate and s.UnitSize = d1.UnitSize
						and d1.PurchaseHdrID = @PurchaseHdrID)
		 Order by [Rate]
		 
 	end
 	else
 	begin
 	
		  Select
				s.Rate Rate
			   ,d.Cchar as Brand
			   ,convert(varchar(10),s.Bag)+'   /   '+convert(varchar(10),s.Loose ) Stock
			   ,d.Cint Qty
			   ,s.UnitSize UnitSize
			   ,d.Cint Price
			   ,d.Cint Amount
		 From tbl_Stock s, tbl_Dummy d
		 Order by [Rate]
		  
 	end
    -- Insert statements for procedure here
END

GO

