-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_ItemType]
(@Rate float, @ItemType varchar(50) out)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
declare @ItemType varchar(50)
exec [get_ItemType] 40.80, @ItemType out
select @ItemType
*/

	if exists(SELECT 1 
			FROM [tbl_Stock] 
			WHERE Rate = @Rate)
		begin
			SELECT @ItemType = ItemType 
			FROM [tbl_Stock] 
			WHERE Rate = @Rate 
		end
		else
		begin
			SELECT @ItemType = 'InValid' 
		end
	--SELECT  ItemType AS ItemTypeA FROM [tbl_Stock] WHERE Rate = @Rate
		 
END

GO

