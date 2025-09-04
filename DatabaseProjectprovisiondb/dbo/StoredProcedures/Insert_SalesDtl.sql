
CREATE proc [dbo].[Insert_SalesDtl]
		(@sid int,
           @Name varchar(100),
           @price float,
           @disc float,
		   @rate float,
           @qty float,
           @amt float)
AS
BEGIN
	Declare @sdid_new int
	Declare @iid int	
	Declare @piid int
	Declare @iqty float
	Declare @sid_new int
		
	if exists(SELECT 1 FROM sales 
			WHERE cancel = 1
			AND sid = @Sid)
	BEGIN				
		SELECT @sid_new = isnull(MAX(sid),0)
		FROM sales
		SELECT @sid = @sid_new
	END

	SELECT @iid = iid, @piid = piid, @iqty = qty FROM item i WHERE i.iname = substring(@Name,1, CHARINDEX('{',@Name)-1)
	
	SELECT @sdid_new = isnull(MAX(sdid),0)+1
	FROM salesdetail

	INSERT INTO [dbo].[salesdetail]
			   ([sid]
			   ,[sdid]
			   ,[iid]
			   ,[price]
			   ,[discount]
			   ,[rate]
			   ,[qty]
			   ,[amt])
		 VALUES
			   (@sid ,
			   @sdid_new ,
			   @iid ,
			   @price ,
			   @disc ,
			   @rate ,
			   @qty ,
			   @amt )

		UPDATE s
		SET s.qty = s.qty - (@qty * @iqty)
		FROM stock s
		WHERE s.iid = @piid
END

GO

