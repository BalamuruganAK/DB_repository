-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Delete_NoStockItem]
(@Iid as int)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec [List_Stocks] 
*/
		Delete FROM stock  
		Where iid = @Iid

		Delete FROM item  
		Where iid = @Iid

END

GO

