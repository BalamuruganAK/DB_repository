-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[List_Purchases]
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec [List_Purchases] 
*/
		SELECT h.pid ID, h.pdate Date, h.amt Amount, h.phistid PurchaseHdrHistID, 
		(Select COUNT(1) from purchasedetail d where  d.pid = h.pid) cnt,
		case when h.phistid is not null then 'History' else 'Edit' end Edit
		FROM purchase  h 
		Order by h.pid desc
END

GO

