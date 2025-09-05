-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Insert_Customer]
		   (@CustomerID int,
           @ExecutiveId int,
           @CustomerType varchar(50),
           @Phone bigint,
           @Name varchar(50),
           @Address varchar(200)) 
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
/*	declare @Phone bigint
	select @Phone = 9742466727
	exec dbo.Insert_Customer 3, 1,'Shop', @Phone,'Rice OM Rice','52, SGR Deltal Collage Road,
Marathali.'

	Select * from [tbl_Customer]
	select * from tbl_stock
	delete  from [tbl_Customer]
	*/
	SET NOCOUNT ON;

	IF not Exists (Select 1 from [tbl_Customer] c where c.Phone= @Phone)
	begin
		INSERT INTO [dbo].[tbl_Customer]
			   ([CustomerID]
			   ,[CustomerDateTime]
			   ,[ExecutiveId]
			   ,[Phone]
			   ,[CustomerType]
			   ,[Name]
			   ,[CustomerAddress])
		VALUES
			   (@CustomerID	,
				GETDATE(),
				@ExecutiveId	,
				@Phone ,
				@CustomerType	,
				@Name 	,
				@Address  )
    end
    else
    begin
		INSERT INTO [tbl_CustomerHist]
			   ([CustomerID]
			   ,[CustomerDateTime]
			   ,[ExecutiveId]
			   ,[Phone]
			   ,[CustomerType]
			   ,[Name]
			   ,[CustomerAddress])
			SELECT [CustomerID]
			   ,[CustomerDateTime]
			   ,[ExecutiveId]
			   ,[Phone]
			   ,[CustomerType]
			   ,[Name]
			   ,[CustomerAddress]
		FROM [tbl_Customer] c 
		WHERE c.Phone = @Phone
		
		update c
		Set [CustomerDateTime] = GETDATE()
			   ,[ExecutiveId] = @ExecutiveId
			   ,[CustomerType] = @CustomerType
			   ,[Name] = @Name
			   ,[CustomerAddress]=@Address
		FROM tbl_Customer c
		WHERE c.Phone = @Phone
					 
    end
    -- Insert statements for procedure here
END

GO

