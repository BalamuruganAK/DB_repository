/****** Script for SelectTopNRows command from SSMS  ******/

CREATE proc get_StoreDaseboard
as
begin
	Declare @Investment float, @AssetValue float, @currentAssetValue float, @stockValue float

	Select @Investment = sum(i.amt)
	From Investors i

	SELECT @AssetValue = sum([amount]) 
      ,@currentAssetValue = sum([currentvalue]) 
   FROM asset

	Select @stockValue = sum(case when s.cost = 0 then i.price * 0.8 else s.cost end * s.qty) 
		From Stock s  inner join item i on i.iid = s.iid

	Select @Investment as Investment, @AssetValue as AssetValue, 
		@currentAssetValue as currentAssetValue, @stockValue as stockValue,
		( @AssetValue + @stockValue) - @Investment as AcBalance

	SELECT a.[name], a.amount , a.[currentvalue]
   FROM asset a

   Select 
			i.iname
			,i.price
			,s.qty
		    ,s.cost
			,case when s.cost = 0 then i.price * 0.8 else s.cost end fcost
			,case when s.cost = 0 then i.price * 0.8 else s.cost end * s.qty as amt
		From Stock s
		inner join item i
		on i.iid = s.iid
		order by 6 desc

end

GO

