-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Select_StockUpdateDtl]

	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec [Select_StockUpdateDtl]
*/
	declare @StockUpdateHdrID int 
	declare @StockUpdateDate date
	
	select @StockUpdateDate = GETDATE()
	
	Select @StockUpdateHdrID = StockUpdateHdrID
		From tbl_StockUpdateHdr
		Where StockUpdateDate  = @StockUpdateDate
		
		
	if exists (
		Select 1
		From tbl_StockUpdateHdr
		Where StockUpdateDate  = @StockUpdateDate)
	begin
	
	Select
				d.Rate 
			   ,d.Bag  
			   ,d.Loose 
			   ,d.AvailableBag 
			   ,d.AvailableLoose 
			   ,d.DifferenceBag 
			   ,d.DifferenceLoose
			   ,d.ExecutiveId 
			   ,d.StockUpdateTime
			   ,d.Reason
			   ,d.Taken
			   ,d.UnitSize 
			   from(
	 		 Select
				s.Rate Rate
			   ,s.Bag Bag 
			   ,s.Loose Loose
			   ,d.Cint AvailableBag 
			   ,d.CFloat AvailableLoose 
			   ,d.Cint DifferenceBag 
			   ,d.CFloat DifferenceLoose
			   ,d.Cint ExecutiveId 
			   ,GETDATE() StockUpdateTime
			   ,d.Cchar Reason
			   ,d.Cint as Taken
			   ,s.UnitSize 
		 From tbl_Stock s, tbl_Dummy d
		 where not exists( select 1 from  [tbl_StockUpdateDtl] d1
						where s.Rate = d1.Rate and d1.StockUpdateHdrID = @StockUpdateHdrID)
	/*	union All
		Select
				p.Rate
			   ,p.Bag 
			   ,p.Loose 
			   ,p.AvailableBag 
			   ,p.AvailableLoose 
			   ,p.DifferenceBag 
			   ,p.DifferenceLoose
			   ,p.ExecutiveId 
			   ,p.StockUpdateDateTime StockUpdateTime
			   ,p.Reason
			   ,d.Cint +1 as Taken
			   ,s.UnitSize 
		 From tbl_StockUpdateDtl p, tbl_Stock s, tbl_Dummy d
		 Where StockUpdateDate  = @StockUpdateDate	
		 AND s.Rate = p.Rate */
		 )	 d
		-- Order by Taken, Rate
		 
 	end
 	else
 	begin
 	Select
				s.Rate Rate
			   ,s.Bag Bag 
			   ,s.Loose Loose
			   ,d.Cint AvailableBag 
			   ,d.CFloat AvailableLoose 
			   ,d.Cint DifferenceBag 
			   ,d.CFloat DifferenceLoose
			   ,d.Cint ExecutiveId 
			   ,GETDATE() StockUpdateTime
			   ,convert(varchar(10),convert(int,(bill.qty / s.UnitSize)) )+'   /   '+convert(varchar(10),bill.qty-convert(int,(bill.qty / s.UnitSize))*s.UnitSize ) Reason
			   ,d.Cint as Taken
			   ,s.UnitSize 
		 From tbl_Stock s
		 left outer join
			(SELECT  ITEM,SUM(Quantity ) qty
			FROM tbl_BillDtl d
			inner join tbl_BillHdr h
			on h.BillHdrID = d.BillHdrID 
			where isnull(h.Cancel,0) <> 1
			and convert(varchar(12),h.BillDateTime,102 ) = convert(varchar(12),GETDATE(),102 )
			GROUP BY Item ) bill
		on s.Rate = bill.Item 
		, tbl_Dummy d
		 Order by Taken, Rate
		 
	
		  
 	end
    -- Insert statements for procedure here
END

GO

