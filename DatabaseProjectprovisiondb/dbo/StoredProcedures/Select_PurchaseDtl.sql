-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Select_PurchaseDtl]
(@pid int) 
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec [Select_PurchaseDtl] 29
*/


	if exists (
		Select 1
		From purchase
		Where pid = @pid)
	begin
	
		Select
				i.iname + ' {'+convert(varchar(10),i.qty)+' , '+ convert(varchar(10),i.price)+'}' as 'Name'
			   ,convert(varchar(10),s.qty)+'   /   '+convert(varchar(10),i.price ) Stock
			   ,p.qty Qty
			   ,p.amt Amount
			   ,p.cost Cost
			   ,i.price NewPrice
			   ,p.pdid  pdid
		 From purchasedetail p, stock s, item i
		 Where [pid] = @pid
		 And p.iid = s.iid 
		 And i.iid = p.iid 
		 union 
		 Select
				convert(varchar(100),d.cchar) as 'Name'
			   ,convert(varchar(100),d.cint) Stock
			   ,d.cfloat Qty
			   ,d.cfloat Amount
			   ,d.cfloat Cost
			   ,d.cfloat NewPrice
			   ,d.cint pdid
		 From stock s, dummy d
		 where not exists( select 1 from  [purchasedetail] d1
						where s.iid = d1.iid 
						and d1.pid = @pid)
		 Order by pdid
		 
 	end
 	else
 	begin
 	
		 Select
				d.cchar as 'Name'
			   ,convert(varchar(100),d.cint) Stock
			   ,d.cfloat Qty
			   ,d.cfloat Amount
			   ,d.cfloat Cost
			   ,d.cfloat NewPrice
		 From stock s, dummy d
		 where not exists( select 1 from  [purchasedetail] d1
						where s.iid = d1.iid 
						and d1.pid = @pid)  
 	end
    -- Insert statements for procedure here
END

GO

