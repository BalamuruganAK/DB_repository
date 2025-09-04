-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Insert_BillDtl]
			(@BillHdrID	int,
			@Item	float,
			@Quantity	float,
			@Discount	float,
			@Offer	varchar(20),
			@Amount	float) 
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	/*
	select * from [tbl_BillDtl]
	*/
	SET NOCOUNT ON;
	
	Declare @BillDtlID_new int 
	Declare @Bag int
	Declare @Bag_Stock int
	Declare @Loose float
	Declare @Loose_Stock float
	Declare @UnitSize int
		
	SELECT @Loose_Stock = s.Loose,
			@Bag_Stock = s.Bag,
			@UnitSize = s.UnitSize 
	FROM tbl_Stock s
    WHERE s.Rate = @Item
	
	SELECT @Bag = convert(int,(@Quantity /@UnitSize))
	SELECT @Loose = (@Quantity - (@Bag * @UnitSize))
	
	if @Loose_Stock < @Loose
	begin
		SELECT @Bag_Stock = @Bag_Stock - 1, 
			@Loose_Stock = @Loose_Stock + @UnitSize
	end
	
	SELECT @Bag_Stock = @Bag_Stock - @Bag, 
			@Loose_Stock = @Loose_Stock - @Loose
	
	UPDATE s
    SET s.Bag = @Bag_Stock,
		s.Loose = @Loose_Stock
    FROM tbl_Stock s
    WHERE s.Rate = @Item
    	
	SELECT @BillDtlID_new = isnull(MAX(BillDtlID),0)+1
	FROM [tbl_BillDtl]
	
	INSERT INTO [tbl_BillDtl]
		(BillDtlID	,
		BillHdrID	,
		Item	,
		Quantity	,
		Discount	,
		Offer	,
		Amount	)
	VALUES
       (@BillDtlID_new,	
		@BillHdrID	,
		@Item	,
		@Quantity	,
		@Discount	,
		@Offer	,
		@Amount	)

		  Declare @BillHdrID_n	int,
				@Item_n	float,
				@Quantity_n	float,
				@Discount_n	float,
				@Offer_n	varchar(20),
				@Amount_n	float
				
		if @Quantity < 0
		begin
			select @Quantity_n	= -1
		end
		else
		begin
			select @Quantity_n	= 1
		end
		
		   SELECT @BillHdrID_n =	@BillHdrID,
				--@Item_n	= @Item_n,
				--@Quantity_n	= 1,
				--@Discount_n	= @Item_n,
				@Offer_n	= null,
				@Amount_n	= 0
		
	  SELECT @Offer = upper(@Offer )
	  		     
      if @Offer = 'ASO'
      begin
			SELECT @Item_n = s.Rate  
			FROM tbl_Stock s
			WHERE s.ItemType = 'Atta'
			
			EXEC Insert_BillDtl
			@BillHdrID_n,
			@Item_n,
			@Quantity_n,
			@Item_n,
			@Offer_n,
			@Amount_n 
			
			SELECT @Item_n = s.Rate  
			FROM tbl_Stock s
			WHERE s.ItemType = 'Sugar'
			
			EXEC Insert_BillDtl
			@BillHdrID_n,
			@Item_n,
			@Quantity_n,
			@Item_n,
			@Offer_n,
			@Amount_n 
			
			SELECT @Item_n = s.Rate  
			FROM tbl_Stock s
			WHERE s.ItemType = 'SF_Oil'
			
			EXEC Insert_BillDtl
			@BillHdrID_n,
			@Item_n,
			@Quantity_n,
			@Item_n,
			@Offer_n,
			@Amount_n 
		end
		
      if @Offer = 'ASG'
      begin	
			SELECT @Item_n = s.Rate  
			FROM tbl_Stock s
			WHERE s.ItemType = 'Atta'
			
			EXEC Insert_BillDtl
			@BillHdrID_n,
			@Item_n,
			@Quantity_n,
			@Item_n,
			@Offer_n,
			@Amount_n 
			
			SELECT @Item_n = s.Rate  
			FROM tbl_Stock s
			WHERE s.ItemType = 'Sugar'
			
			EXEC Insert_BillDtl
			@BillHdrID_n,
			@Item_n,
			@Quantity_n,
			@Item_n,
			@Offer_n,
			@Amount_n 
			
			SELECT @Item_n = s.Rate  
			FROM tbl_Stock s
			WHERE s.ItemType = 'RG_Oil'
			
			EXEC Insert_BillDtl
			@BillHdrID_n,
			@Item_n,
			@Quantity_n,
			@Item_n,
			@Offer_n,
			@Amount_n 
		end
		
	  if @Offer = 'ASS'
      begin	
			SELECT @Item_n = s.Rate  
			FROM tbl_Stock s
			WHERE s.ItemType = 'Atta'
			
			EXEC Insert_BillDtl
			@BillHdrID_n,
			@Item_n,
			@Quantity_n,
			@Item_n,
			@Offer_n,
			@Amount_n 
			
			SELECT @Item_n = s.Rate  
			FROM tbl_Stock s
			WHERE s.ItemType = 'Sugar'
			
			EXEC Insert_BillDtl
			@BillHdrID_n,
			@Item_n,
			@Quantity_n,
			@Item_n,
			@Offer_n,
			@Amount_n 
			
			SELECT @Item_n = s.Rate  
			FROM tbl_Stock s
			WHERE s.ItemType = 'Sugar'
			
			EXEC Insert_BillDtl
			@BillHdrID_n,
			@Item_n,
			@Quantity_n,
			@Item_n,
			@Offer_n,
			@Amount_n 
		end

      if @Offer = 'OO'
      begin
			SELECT @Item_n = s.Rate  
			FROM tbl_Stock s
			WHERE s.ItemType = 'SF_Oil'
			
			EXEC Insert_BillDtl
			@BillHdrID_n,
			@Item_n,
			@Quantity_n,
			@Item_n,
			@Offer_n,
			@Amount_n 
			
			SELECT @Item_n = s.Rate  
			FROM tbl_Stock s
			WHERE s.ItemType = 'SF_Oil'
			
			EXEC Insert_BillDtl
			@BillHdrID_n,
			@Item_n,
			@Quantity_n,
			@Item_n,
			@Offer_n,
			@Amount_n 
		end
		-- s.ItemType in( 'Atta','SF_Oil','RG_Oil','Sugar')
		
END

GO

