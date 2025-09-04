-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_ParentItem]
(@Name varchar(200), @PName varchar(200) out)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
declare @Stock varchar(500)
exec [get_ParentItem] 'Jeera100g {0.1 [ 30 ] 7.Masala}<169.Pepper>', @Stock out
select @Stock
*/

SELECT 
		@PName =	p.iname + ' {'+convert(varchar(10),p.qty)+' , '+ convert(varchar(10),p.price)+' , '+ convert(varchar(50),c.category)+'}' 
		FROM item i		
		INNER JOIN item p
		ON p.iid = i.piid AND i.iid <> i.piid
		INNER JOIN category c
		ON p.cid = c.cid 
		WHERE i.iname = substring(@Name,1, CHARINDEX('{',@Name)-1)
		AND p.iid = i.piid
		 
END

GO

