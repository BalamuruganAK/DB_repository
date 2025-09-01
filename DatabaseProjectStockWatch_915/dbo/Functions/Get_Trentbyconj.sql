-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[Get_Trentbyconj] 
(
	@PlanetList varchar(50), @PositionList varchar(50)
)
RETURNS varchar(2000)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @a varchar(3), @b varchar(3), @c varchar(3), @d varchar(3)
	DECLARE @SectorList varchar(2000)
		
	Select @a = right(LEFT(@PlanetList,3),3)
	
	Select @b = case when len(@PlanetList) > 3 then right(LEFT(@PlanetList,7),3) end
	Select @c = case when len(@PlanetList) > 7 then right(LEFT(@PlanetList,11),3) end
	Select @d = case when len(@PlanetList) > 11 then right(LEFT(@PlanetList,15),3) end

Select @SectorList = 
	isnull(dbo.Get_Trent(
		case when isnumeric(substring(@PositionList,charindex(@a,@PositionList)+3,2)) = 1
			then substring(@PositionList,charindex(@a,@PositionList)+3,2)
			else substring(@PositionList,charindex(@a,@PositionList)+3,1)
		end),'') + 
	isnull('/'+ dbo.Get_Trent(
		case when isnumeric(substring(@PositionList,charindex(@b,@PositionList)+3,2)) = 1
			then substring(@PositionList,charindex(@b,@PositionList)+3,2)
			else substring(@PositionList,charindex(@b,@PositionList)+3,1)
		end),'') + 
	isnull('/'+ dbo.Get_Trent(
		case when isnumeric(substring(@PositionList,charindex(@c,@PositionList)+3,2)) = 1
			then substring(@PositionList,charindex(@c,@PositionList)+3,2)
			else substring(@PositionList,charindex(@c,@PositionList)+3,1)
		end),'') + 
	isnull('/'+ dbo.Get_Trent(
		case when isnumeric(substring(@PositionList,charindex(@d,@PositionList)+3,2)) = 1
			then substring(@PositionList,charindex(@d,@PositionList)+3,2)
			else substring(@PositionList,charindex(@d,@PositionList)+3,1)
		end),'') 
--	insert into TSector
	
	
	-- Return the result of the function
	RETURN @SectorList 
	

END

GO

