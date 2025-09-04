-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Insert_BillHdr]
		   (@BillHdrID int
           ,@ExecutiveId int
           ,@Phone bigint
           ,@TotalAmount float
           ,@Adjustment float
           ,@Cash float
           ,@SwipeCard float
           ,@OnDelivery float
           ,@Due float
           ,@DeliveryRequired int) 
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	/*
	Select * from [tbl_BillHdr]
	select * from tbl_stock
	delete  from [tbl_BillHdr]
	*/
	SET NOCOUNT ON;

	if not exists(
		Select 1 from tbl_BillHdr h 
		where convert(varchar(12),h.BillDateTime,112) = convert(varchar(12),GETDATE(),112))
	begin
		exec Insert_StockHist
	end

	INSERT INTO [tbl_BillHdr]
           ([BillHdrID]
           ,[BillDateTime]
           ,[ExecutiveId]
           ,[Phone]
           ,[TotalAmount]
           ,[Adjustment]
           ,[Cash]
           ,[SwipeCard]
           ,[OnDelivery]
           ,[TotalDuePaid]
           ,[Due]
           ,[DeliveryRequired])
	VALUES
		   (@BillHdrID	,
			GETDATE(),
			@ExecutiveId	,
			@Phone	,
			@TotalAmount	,
			@Adjustment	,
			@Cash	,
			@SwipeCard	,
			@OnDelivery	,
			0.0,
			@Due	,
			@DeliveryRequired)

           
    -- Insert statements for procedure here
END

GO

