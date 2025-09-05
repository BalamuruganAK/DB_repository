-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Insert_Delivery]
		   (@BillHdrID int,
           @ExecutiveId int,
           @Status varchar(50),
           @Received float) 
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	/*
	Select * from [tbl_Delivery]
	select * from tbl_stock
	delete  from [tbl_Delivery]
	*/
	SET NOCOUNT ON;

	declare @DeliveryID int

	SELECT @DeliveryID = isnull(MAX(DeliveryID),0)+1
	FROM tbl_Delivery

	INSERT INTO [rordb].[dbo].[tbl_Delivery]
           ([DeliveryID]
           ,[BillHdrID]
           ,[ExecutiveId]
           ,[DeliveryDateTime]
           ,[Received]
           ,[Status])
	VALUES
		   (@DeliveryID	,
		    @BillHdrID,
			@ExecutiveId	,
			GETDATE(),
			@Received	,
			@Status )
			
		UPDATE tbl_BillHdr 
		SET TotalDuePaid = TotalDuePaid + @Received 
		WHERE BillHdrID = @BillHdrID 
		
    IF @Status = 'Cancel'
    begin
		UPDATE tbl_BillHdr 
		SET Cancel = 1
		WHERE BillHdrID = @BillHdrID  
    end
    -- Insert statements for procedure here
END

GO

