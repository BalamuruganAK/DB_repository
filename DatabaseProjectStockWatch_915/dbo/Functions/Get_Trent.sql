-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
create FUNCTION [dbo].[Get_Trent] 
(
	@Position tinyint
)
RETURNS varchar(10)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @SectorList varchar(2000)

	
	SELECT @SectorList = s.Direction
	from tbl_Trent s where s.Position = @Position
	
	RETURN @SectorList
	

END

GO

