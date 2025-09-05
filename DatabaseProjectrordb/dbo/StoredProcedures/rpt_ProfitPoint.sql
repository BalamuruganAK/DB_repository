CREATE PROC [dbo].[rpt_ProfitPoint]
as
begin
	
	Declare @minPurchaseDtlID int
	Declare @maxPurchaseDtlID int
	Declare @PurchaseDate Date
	Declare @Rate float
	Declare @Price float
	Declare @DQuantity float
	Declare @PAmount float
	Declare @PQuantity float
	
	Declare @SDate Date	
	Declare @MinSDate Date	
	Declare @MaxSDate Date	
	Declare @SQuantity float
	Declare @SAmount float
	
	Declare @ProfitStartDay int
	Declare @ProfitEndDay int
	Declare @ProfitPercentage float
	Declare @CurrentDay int
	Declare @SoldPercentage float
	
	Declare @SaleStartDay int
	Declare @PSQuantity float
	--Declare @PSAmount float
	
	create table #ttbl_PurchaseDtl(PurchaseDtlID int, PurchaseDate Date, Rate float , UnitSize int, 
		Quantity int, Price float, Amount float, DQuantity float)
	create table #ttbl_BillDtl( Item float, BillDateTime date, Quantity float, Discount float, Amount float )
	create table #ttbl_Profit( Item float, PurchaseDate date, PSQuantity float, Quantity float, Price float, Amount float ,
		CurrentDay int, SoldPercentage float, SaleStartDay int, ProfitStartDay int , ProfitEndDay int , ProfitPercentage float)
	
	Insert into #ttbl_PurchaseDtl
	SELECT d.PurchaseDtlID, h.PurchaseDate, d.Rate, d.UnitSize, 
		d.Quantity, d.Price, d.Amount, (d.UnitSize * d.Quantity) as DQuantity
	FROM tbl_PurchaseDtl d 
		inner join tbl_PurchaseHdr h
		on h.PurchaseHdrID = d.PurchaseHdrID
	
	
	Insert into #ttbl_BillDtl
	SELECT d.Item, convert(varchar(12),h.BillDateTime,102 ) as BillDateTime, 
		sum(d.Quantity) as Quantity, sum(d.Discount) as Discount, 
		sum(case when d.Discount = -80.00 then d.Amount -100 else d.Amount end) as Amount
	FROM tbl_BillDtl d 
		inner join tbl_BillHdr h
		on h.BillHdrID = d.BillHdrID
	WHERE isnull(h.Cancel,0) <> 1
	GROUP BY d.Item, convert(varchar(12),h.BillDateTime,102 )
	ORDER BY d.Item, convert(varchar(12),h.BillDateTime,102 )
	
	Select @minPurchaseDtlID = MIN( d.PurchaseDtlID) , @maxPurchaseDtlID = MAX(d.PurchaseDtlID) 
	from #ttbl_PurchaseDtl d
	
	While @maxPurchaseDtlID >= @minPurchaseDtlID 
	begin

		Select @PurchaseDate = d.PurchaseDate, @Rate = d.Rate, @Price = d.Price,
			@DQuantity = d.DQuantity, @PAmount = d.Amount, @PQuantity = d.Quantity
		from #ttbl_PurchaseDtl d
		where d.PurchaseDtlID = @minPurchaseDtlID

		Select @MinSDate = MIN(d.BillDateTime), @MaxSDate = MAX(d.BillDateTime)
		from #ttbl_BillDtl d where d.BillDateTime >= @PurchaseDate and d.Item = @Rate 
		
--------------------------------------------PSQuantity start
		Select @SQuantity = 0.0, @SAmount = 0.0, @ProfitStartDay = 0, @ProfitEndDay = 0,
			@ProfitPercentage = 0, @CurrentDay = DATEDIFF(dd,@PurchaseDate,GETDATE()), @SoldPercentage = 0.0,
			@SaleStartDay = 0
			
		Select @PSQuantity = (su.AvailableBag * s.UnitSize) + su.AvailableLoose 
		from tbl_StockUpdateDtl su 
			inner join tbl_Stock s
			on s.Rate = su.Rate
		where su.Rate = @Rate
		and su.StockUpdateDate = 
			(Select MAX(su.StockUpdateDate) from tbl_StockUpdateDtl su 
		where su.Rate = @Rate
		and su.StockUpdateDate < @PurchaseDate)
		
		Select @SQuantity = 0.0
	
		While @MinSDate <= @MaxSDate
		begin 
			Select @SQuantity = @SQuantity + isnull(d.Quantity,0),
				@SAmount = @SAmount + isnull(d.Amount,0) 
			from #ttbl_BillDtl d
			where d.Item = @Rate 
			and d.BillDateTime = @MinSDate
			
			if @SQuantity >= @PSQuantity
			begin				
				Break
			end
			
			if @MinSDate = @MaxSDate			
			begin
				insert into #ttbl_Profit values( @Rate , @PurchaseDate , @PSQuantity, @PQuantity , @Price , @PAmount ,
					@CurrentDay, @SoldPercentage, @SaleStartDay, @ProfitStartDay , @ProfitEndDay , @ProfitPercentage)
				Break
			end
			
			Select @MinSDate = MIN(d.BillDateTime)
			from #ttbl_BillDtl d 
			where d.BillDateTime > @MinSDate and d.Item = @Rate 
		end
--------------------------------------------PSQuantity end

		Select @SQuantity = @SQuantity - @PSQuantity, @SAmount = 0.0, @ProfitStartDay = 0, @ProfitEndDay = 0,
			@ProfitPercentage = 0, @CurrentDay = DATEDIFF(dd,@PurchaseDate,GETDATE())
			
		Select @SAmount = @SQuantity * @Rate, @SaleStartDay = DATEDIFF(dd,@PurchaseDate,@MinSDate)
			
		Select @MinSDate = MIN(d.BillDateTime)
			from #ttbl_BillDtl d 
			where d.BillDateTime > @MinSDate and d.Item = @Rate 		
				
		While @MinSDate <= @MaxSDate
		begin 
			Select @SQuantity = @SQuantity + isnull(d.Quantity,0), 
				@SAmount = @SAmount + isnull(d.Amount,0) 
			from #ttbl_BillDtl d
			where d.Item = @Rate 
			and d.BillDateTime = @MinSDate
			
			if @SAmount >= @PAmount and @ProfitStartDay = 0
			begin
				Select @ProfitStartDay = DATEDIFF(dd,@PurchaseDate,@MinSDate)
			end
			
			Select @SoldPercentage = 100 * @SQuantity / @DQuantity
			
			if @SQuantity >= @DQuantity and @ProfitEndDay = 0
			begin
				Select @ProfitEndDay = DATEDIFF(dd,@PurchaseDate,@MinSDate)					
				Select @ProfitPercentage = 10000 * ((@SAmount - @PAmount)/ @SAmount) /@SoldPercentage
				
				insert into #ttbl_Profit values( @Rate , @PurchaseDate , @PSQuantity, @PQuantity , @Price , @PAmount ,
					@CurrentDay, @SoldPercentage, @SaleStartDay, @ProfitStartDay , @ProfitEndDay , @ProfitPercentage)
				
				Break
			end
			
			if @MinSDate = @MaxSDate			
			begin
				insert into #ttbl_Profit values( @Rate , @PurchaseDate , @PSQuantity, @PQuantity , @Price , @PAmount ,
					@CurrentDay, @SoldPercentage, @SaleStartDay, @ProfitStartDay , @ProfitEndDay , @ProfitPercentage)
				Break
			end
			
			Select @MinSDate = MIN(d.BillDateTime)
			from #ttbl_BillDtl d 
			where d.BillDateTime > @MinSDate and d.Item = @Rate 
		end
		
		Select @minPurchaseDtlID = @minPurchaseDtlID + 1
	end
	
	Select * from #ttbl_PurchaseDtl
	Select * from #ttbl_Profit p order by p.Item, p.PurchaseDate
	
end

GO

