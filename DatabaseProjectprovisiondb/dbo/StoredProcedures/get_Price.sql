-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_Price]
(@Name varchar(100), @price float out, @discount float out, @rate float out)
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

			SELECT @price = i.price,
				@discount = i.discount,
				@rate = i.price - i.discount
			FROM item i
			WHERE i.iname = substring(@Name,1, CHARINDEX('{',@Name)-1)
				
	--SELECT  Stock AS StockA FROM [tbl_Stock] WHERE Rate = @Rate
		 
END

GO

