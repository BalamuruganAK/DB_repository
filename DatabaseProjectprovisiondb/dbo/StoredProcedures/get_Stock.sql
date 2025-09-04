-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_Stock]
(@item varchar(50), @Stock varchar(20) out, @price float out)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
declare @Stock varchar(50)
exec [get_Stock] 'Sugar', @Stock out
select @Stock
*/

	if exists(SELECT 1 
			FROM [stock] s
			inner join item i
			on i.iid = s.iid
			WHERE i.iname = substring(@item,1, CHARINDEX('{',@item)-1))
		begin
			SELECT @Stock = convert(varchar(10),s.qty)+'   /   '+convert(varchar(10),s.cost ),
				@price = i.price
			FROM [stock] s
			inner join item i
			on i.iid = s.iid
			WHERE i.iname = substring(@item,1, CHARINDEX('{',@item)-1)
		end
		else
		begin
			SELECT @Stock = '0' , @price = 0
		end
	--SELECT  Stock AS StockA FROM [tbl_Stock] WHERE Rate = @Rate
		 
END

GO

