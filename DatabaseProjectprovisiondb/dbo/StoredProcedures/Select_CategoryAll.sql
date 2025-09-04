-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Select_CategoryAll]
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec [Select_Category] null
*/		
		
		SELECT 'All'  as category	
		Union All
		SELECT c.category as category
		FROM [Category] c
		Order by category
END

GO

