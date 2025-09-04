-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Insert_StockHist]
	AS
BEGIN
 
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @cdate datetime
	Select @cdate = GETDATE()

	If not exists (Select 1 from stockhistory where convert(varchar(12),stockdate,112)  = convert(varchar(12),@cdate,112))
	Begin
		INSERT INTO stockhistory
		   (iid
		   ,stockdate
		   ,qty
		   ,cost)
		Select 
			s.iid
			,@cdate
			,s.qty
		    ,s.cost
		From Stock s
     End
	
    -- Insert statements for procedure here
END

GO

