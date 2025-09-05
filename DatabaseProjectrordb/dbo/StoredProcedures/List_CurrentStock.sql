-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].List_CurrentStock
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec List_StockDetail 2 
*/
			SELECT s.Rate 
			   ,s.Bag  
			   ,s.Loose 
			   ,0 AvailableBag 
			   ,0 AvailableLoose 
			   ,0 DifferenceBag 
			   ,0 DifferenceLoose
			   ,0 ExecutiveId 
			   ,null StockUpdateDateTime
			   ,null Reason
			   ,0 Taken
			   ,s.UnitSize 
		FROM tbl_Stock s
		
		 
END

GO

