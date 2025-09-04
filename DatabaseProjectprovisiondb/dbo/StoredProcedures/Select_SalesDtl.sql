
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Select_SalesDtl]
		(@sid int)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
Declare @sid_new int 
		Declare @sdate date 
		Declare @total float 
		Declare @discount float 
		Declare @amt float 
		Declare @cash float 
		Declare @gpay float 
		Declare @cards float 
		Declare @salesbalance float 
		Declare @phone bigint 
exec Select_SalesDtl 30, @sid_new out,  @sdate out,  @total out,  @discount out, 	 @amt out,  @cash out,  @gpay out,  @cards out, @salesbalance out,  @phone out
		Select @sid_new ,  @sdate ,  @total ,  @discount , 	 @amt ,  @cash ,  @gpay ,  @cards , @salesbalance ,  @phone  

*/

		Select
				(SELECT i.iname + ' {'+convert(varchar(10),i.qty)+' , '+ convert(varchar(10),i.price)+' / '+ convert(varchar(10),i.discount)+'}' as 'Name'
				FROM item i WHERE i.iid = d.iid) "Name"
			   ,d.price  Price
			   ,d.discount  Discount
		       ,d.rate  Rate
			   ,d.qty  Qty 
			   ,d.amt  Amt
			 From salesdetail d
		 Where d.sid = @sid		
		 
END

GO

