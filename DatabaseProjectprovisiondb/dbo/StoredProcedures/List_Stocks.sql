-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[List_Stocks]
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec [List_Stocks] 
*/
		SELECT h.StockUpdateHdrID ID, h.StockUpdateDate Date, h.TotalCount, h.takencount, h.actual,
			h.available, h.actualcost, h.diffcost
		FROM stockupdatehdr  h 
		Order by h.StockUpdateHdrID desc
END

GO

