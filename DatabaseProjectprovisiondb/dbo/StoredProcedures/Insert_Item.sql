-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Insert_Item]
(@Name varchar(100), @Qty float,  @Price float, @Discount float, @Parent varchar(100), @Category varchar(100)) 
	AS
BEGIN
	SET NOCOUNT ON;
	
	Declare @iid_new int
	SELECT @iid_new = isnull(MAX(iid),0)+1 	FROM [Item]

	Declare @piid int
	if LEN(@Parent)>0
	begin
		SELECT @piid = iid FROM item i WHERE i.iname = substring(@Parent,1, CHARINDEX('{',@Parent)-1)
	end

	Declare @cid int
	if isnull(@piid, 0) <> 0 
	begin
		SELECT @cid = cid FROM item i WHERE i.iid = @piid
	end
	else
	begin
		SELECT @cid = substring(@Category,1, CHARINDEX('.',@Category)-1)
	end

	If Exists (Select 1 from item where iname  = @Name)
	begin
		if isnull(@piid, 0) <> 0 
		begin
			UPDATE  [Item]
			Set qty = @Qty, price = @Price, discount = @Discount, piid = @piid, cid = @cid
			WHERE iname  = @Name
		end
		else
		begin
			UPDATE  [Item]
			Set qty = @Qty, price = @Price, discount = @Discount, piid = iid, cid = @cid
			WHERE iname  = @Name
		end
	end
	else
	begin
		if isnull(@piid, 0) <> 0  
		begin
			INSERT INTO [Item] ([iid] ,iname ,qty ,price ,discount ,piid ,cid)
			VALUES (@iid_new ,@Name, @Qty, @Price, @Discount, @piid, @cid)
		end
		else
			begin
			INSERT INTO [Item] ([iid] ,iname ,qty ,price ,discount ,piid ,cid)
			VALUES (@iid_new ,@Name, @Qty, @Price, @Discount, @iid_new, @cid)
		end
			INSERT INTO Stock ([iid] ,qty ,cost) VALUES (@iid_new ,0, 0)
    end       
    
END

GO

