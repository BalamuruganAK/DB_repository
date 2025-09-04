
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Select_SalesHdr]
		(@sid int
		, @sid_new int out
		, @sdate date out
		, @total float out
		, @discount float out
		, @amt float out
		, @cash float out
		, @gpay float out
		, @cards float out
		, @salesbalance float out
		, @phone bigint out)
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
exec Select_SalesHdr 30, @sid_new out,  @sdate out,  @total out,  @discount out, 	 @amt out,  @cash out,  @gpay out,  @cards out, @salesbalance out,  @phone out
		Select @sid_new ,  @sdate ,  @total ,  @discount , 	 @amt ,  @cash ,  @gpay ,  @cards , @salesbalance ,  @phone  

*/
	
		SELECT @sid_new = isnull(MAX(sid),0)+1
		FROM sales
		
		SELECT @phone = 0

		SELECT
				@sdate = s.sdate
				,@total = s.total
				,@discount  = s.discount
				,@amt = s.amt
				,@cash = s.cash
				,@gpay = s.gpay
				,@cards = s.cards
				,@salesbalance = s.salesbalance
				,@phone = isnull(s.phone,0)
		 From sales s 
		 Where s.sid = @sid
		 
END

GO

