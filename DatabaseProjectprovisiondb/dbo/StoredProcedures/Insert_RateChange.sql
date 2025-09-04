-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Insert_RateChange]
(@CRate float, @NRate float, @NBag int, @NLoose float) 
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	/*
	select * from [tbl_PurchaseDtl]
	*/
	SET NOCOUNT ON;
	
	Declare @RateChangeID_new int 
	Declare @MBag int
	Declare @MLoose Float
	
	SELECT @MBag = s.Bag, @MLoose = s.Loose
    FROM tbl_Stock s
    WHERE s.Rate = @CRate 
	
	IF @MBag >= @NBag AND @MLoose >= @NLoose
	Begin
		SELECT @RateChangeID_new = isnull(MAX(RateChangeID),0)+1
		FROM [tbl_RateChange]
		
		INSERT INTO [tbl_RateChange]
			([RateChangeID]
			   ,[RateChangeDateTime]
			   ,[CurrentRate]
			   ,[CurrentBag]
			   ,[CurrentLoose]
			   ,[NewRate]
			   ,[NewBag]
			   ,[NewLoose]
			   ,[ChangeBag]
			   ,[ChangeLoose])
		VALUES
		   (@RateChangeID_new
			   ,GETDATE()
			   ,@CRate
			   ,0
			   ,0.0
			   ,@NRate
			   ,0
			   ,0.0 
			   ,@NBag 
			   ,@NLoose)
	           
		UPDATE r
		SET r.CurrentBag = s.Bag, r.CurrentLoose = s.Loose
		FROM tbl_RateChange r inner join tbl_Stock s
		ON s.Rate = r.CurrentRate
		AND r.RateChangeID = @RateChangeID_new
		
		UPDATE r
		SET r.NewBag = s.Bag, r.NewLoose = s.Loose
		FROM tbl_RateChange r inner join tbl_Stock s
		ON s.Rate = r.NewRate 
		AND r.RateChangeID = @RateChangeID_new
	    
		UPDATE s
		SET s.Bag = s.Bag - @NBag, s.Loose = s.Loose - @NLoose
		FROM tbl_Stock s
		WHERE s.Rate = @CRate
		
		UPDATE s
		SET s.Bag = s.Bag + @NBag, s.Loose = s.Loose + @NLoose
		FROM tbl_Stock s
		WHERE s.Rate = @NRate
    end
    -- Insert statements for procedure here
END

GO

