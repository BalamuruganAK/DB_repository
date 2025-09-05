-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[List_StockDetail]
(@StockHrdID int)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec List_StockDetail 2 
*/
		declare @StockUpdateDate date
		
		select @StockUpdateDate = StockUpdateDate
			from tbl_StockUpdateHdr where StockUpdateHdrID= @StockHrdID	

		SELECT d.Rate 
			   ,d.Bag  
			   ,d.Loose 
			   ,d.AvailableBag 
			   ,d.AvailableLoose 
			   ,d.DifferenceBag 
			   ,d.DifferenceLoose
			   ,d.ExecutiveId 
			   ,d.StockUpdateDateTime
			   ,d.Reason
			   ,1 Taken
			   ,s.UnitSize 
		FROM tbl_StockUpdateDtl d inner join tbl_Stock s
		on s.Rate = d.Rate
		WHERE d.StockUpdateHdrID in
			( select StockUpdateHdrID
			from tbl_StockUpdateHdr where StockUpdateDate= @StockUpdateDate)
		union all
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
		FROM tbl_StockUpdateDtl d right outer join tbl_StockHist s
		on s.Rate = d.Rate and d.StockUpdateDate = s.StockDate
		and d.StockUpdateHdrID in
			( select StockUpdateHdrID
			from tbl_StockUpdateHdr where StockUpdateDate= @StockUpdateDate)	
		Where s.StockDate = @StockUpdateDate
		and d.StockUpdateHdrID is null
		 
END

GO

