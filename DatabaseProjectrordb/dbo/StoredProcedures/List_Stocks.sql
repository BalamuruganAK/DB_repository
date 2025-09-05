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
		SELECT h.StockUpdateHdrID ID, h.StockUpdateDate Date, h.TotalCount, h.BagCount, h.LooseCount,
			h.BagDiff, h.LooseDiff, h.TakenCount
		FROM tbl_StockUpdateHdr  h 
		Order by h.StockUpdateHdrID desc
END

GO

