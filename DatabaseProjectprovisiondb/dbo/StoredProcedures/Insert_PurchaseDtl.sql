-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Insert_PurchaseDtl]
(@pid int, @Name varchar(100), 
@qty float, @amt float, @cost float, @price float) 
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	/*
	select * from [tbl_PurchaseDtl]
	*/
	SET NOCOUNT ON;
	
	Declare @pdid_new int, @iid int
	
	SELECT @pdid_new = isnull(MAX(pdid),0)+1
	FROM purchasedetail

	SELECT @iid = iid FROM item i WHERE i.iname = substring(@Name,1, CHARINDEX('{',@Name)-1)
	
	INSERT INTO purchasedetail
		(pdid
           ,pid
           ,iid
           ,qty
           ,amt
		   ,cost)
	VALUES
       (@pdid_new
           ,@pid
           ,@iid
           ,@qty
           ,@amt
           ,@cost)
    if exists (Select 1 FROM stock s WHERE s.iid = @iid)    
	begin
		UPDATE s
		SET s.qty = s.qty + @qty, s.cost = @cost
		FROM stock s
		WHERE s.iid = @iid
	end
	else
	begin
		Insert into stock values (@iid,@qty,@cost)
	end

	if exists (select 1 from item where iid = @iid and price <> @price)
	begin
		INSERT INTO itemhistory Select iid, GETDATE() as idate, iname, qty, price, discount, piid, cid from item where iid = @iid 

		UPDATE i
		SET i.price =  @price
		FROM item i
		WHERE i.iid = @iid
		and i.price <> @price
	end
		-- Insert statements for procedure here
END

GO

