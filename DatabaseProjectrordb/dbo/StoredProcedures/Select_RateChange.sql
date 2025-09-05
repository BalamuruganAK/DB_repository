-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Select_RateChange]
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec [RateChange] 
*/

		  Select
				s.Rate CRate
			   ,s.Bag CBag
			   ,s.Loose CLoose
			   ,d.Cfloat NRate
			   ,d.Cint  NBag
			   ,d.Cfloat NLoose
		 From tbl_Stock s, tbl_Dummy d
		 Order by [CRate]
	
    -- Insert statements for procedure here
END

GO

