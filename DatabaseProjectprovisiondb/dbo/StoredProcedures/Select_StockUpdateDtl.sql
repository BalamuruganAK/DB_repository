-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Select_StockUpdateDtl]
(@StockDate as date, @Iname as Varchar(100), @category as Varchar(100))
	AS
BEGIN
	SET NOCOUNT ON;
/*
Declare @StockDate as date
Select @StockDate = getdate()+11
exec [Select_StockUpdateDtl] @StockDate
*/	
	Declare @cid as int

	Select @Iname = '%'+TRIM(@Iname)+'%'
	
	if @category = 'All' or LEN(@category) = 0
	begin
		Select s.iid as Iid, i.iname as Iname,  max(d.stockupdatedate) As SDate, i.price as Price, 
			s.qty as Actual,s.qty as Available, s.qty as Diff, i.iname As [Reasion], 
			(s.iid) as [Taken], case when s.cost > 0 then s.cost else i.price * 0.90 end as Cost 
		from stock s Inner Join item i On s.iid = i.iid and i.iname like @Iname
		Left Outer Join stockupdatedetail d On s.iid = d.iid and d.stockupdatedate >= @StockDate
		Group by s.iid, i.iname, i.price, s.qty, s.cost
	end
	else
	begin
		Select  @cid = c.cid From category c Where c.category = @category
		Select s.iid as Iid, i.iname as Iname,  max(d.stockupdatedate) As SDate, i.price as Price, 
			s.qty as Actual,s.qty as Available, s.qty as Diff, i.iname As [Reasion], 
			(s.iid) as [Taken], case when s.cost > 0 then s.cost else i.price * 0.90 end as Cost 
		from stock s Inner Join item i On s.iid = i.iid and i.iname like @Iname and i.cid = @cid
		Left Outer Join stockupdatedetail d On s.iid = d.iid and d.stockupdatedate >= @StockDate
		Group by s.iid, i.iname, i.price, s.qty, s.cost
	end	
END

GO

