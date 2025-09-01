-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
create FUNCTION Get_Playmate 
(
	@a varchar(3), @b varchar(3), @c varchar(3), @d varchar(3)
)
RETURNS varchar(2000)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @PlaymateList varchar(2000)
	DECLARE @PL1 varchar(10)
	DECLARE @PL2 varchar(10)
	DECLARE @PL3 varchar(10)
	DECLARE @PL4 varchar(10)
	DECLARE @PL5 varchar(10)
	DECLARE @PL6 varchar(10)
	DECLARE @PL7 varchar(10)
	DECLARE @PL8 varchar(10)
	DECLARE @PL9 varchar(10)
	DECLARE @PL10 varchar(10)
	DECLARE @PL11 varchar(10)
	DECLARE @PL12 varchar(10)

	Select @PL1 = @a+','+@b
	Select @PL2 = @a+','+@c
	Select @PL3 = @a+','+@d
	Select @PL4 = @b+','+@a
	Select @PL5 = @b+','+@c
	Select @PL6 = @b+','+@d
	Select @PL7 = @c+','+@a
	Select @PL8 = @c+','+@b
	Select @PL9 = @c+','+@d
	Select @PL10 = @d+','+@a
	Select @PL11 = @d+','+@c
	Select @PL12 = @d+','+@b
	-- Add the T-SQL statements to compute the return value here
	
--	insert into TPlaymate
	
	SELECT @PlaymateList = COALESCE(@PlaymateList + ', ', '') + s.Playmate
	from tbl_Playmate s where s.Planets in 
	(@a,@b,@c,@d,@PL1,@PL2,@PL3,@PL4,@PL5,@PL6,@PL7,@PL8,@PL9,@PL10,@PL11,@PL12)
	
--	SELECT distinct s.Playmate from tbl_Stock s where s.Planets in 
--	(@a,@b,@c,@d,@PL1,@PL2,@PL3,@PL4,@PL5,@PL6,@PL7,@PL8,@PL9,@PL10,@PL11,@PL12)

	--SELECT @PlaymateList
	
	-- Return the result of the function
	RETURN @PlaymateList
	

END

GO

