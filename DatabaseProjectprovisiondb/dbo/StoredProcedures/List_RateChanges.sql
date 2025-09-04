-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[List_RateChanges]
(@FromDate DateTime, @ToDate DateTime)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec List_RateChanges 
*/
	
		
		SELECT 
			RateChangeID,
			RateChangeDateTime,
			CurrentRate,
			CurrentBag,
			CurrentLoose,
			NewRate,
			NewBag,
			NewLoose,
			ChangeBag,
			ChangeLoose
		FROM [tbl_RateChange] h 
		WHERE h.RateChangeDateTime between @FromDate and @ToDate
		Order by h.RateChangeID desc 
END

GO

