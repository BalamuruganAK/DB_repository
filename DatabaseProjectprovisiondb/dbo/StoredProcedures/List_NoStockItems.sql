-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[List_NoStockItems]
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec [List_Stocks] 
*/
		SELECT i.iid as Iid, i.iname + '{'+ CONVERT(varchar(10), i.price) + '}' as Detail,
			c.category as Category, 'Delete' as [Delete]
		FROM item  i
		Inner join category c on c.cid = i.cid
		Where i.iid not in (Select s.iid from stock s Where s.qty > 0)
END

GO

