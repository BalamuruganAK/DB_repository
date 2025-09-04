-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FilterItems]
(@ItemStr varchar(100), @SourceForm varchar(10))
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
exec List_Bills 
*/
	
	Select @ItemStr = '%'+ replace(@ItemStr,' ','%') + '%'

		IF (@SourceForm = 'IT') 
	BEGIN
		SELECT 
			i.iname + ' {'+convert(varchar(10),i.qty)+' [ '+ convert(varchar(10),i.price)+' / '+ convert(varchar(10),i.discount)+' ] '+ convert(varchar(10),c.cid)+'.'+convert(varchar(50),c.category)+'}' as 'Name'
		FROM item i
		INNER JOIN category c
		ON i.cid = c.cid AND i.iid = i.piid
		WHERE i.iname like @ItemStr
		UNION ALL
		SELECT 
			i.iname + ' {'+convert(varchar(10),i.qty)+' [ '+ convert(varchar(10),i.price)+' / '+ convert(varchar(10),i.discount)+' ] '+ convert(varchar(10),c.cid)+'.'+convert(varchar(50),c.category)+'}<' + convert(varchar(10),p.iid)+'.'+convert(varchar(50),p.iname)+'>' as 'Name'
		FROM item i
		INNER JOIN category c
		ON i.cid = c.cid AND i.iid <> i.piid
		INNER JOIN item p
		ON p.iid = i.piid
		WHERE i.iname like @ItemStr
		Order by [Name] 
	END
	IF (@SourceForm = 'I') 
	BEGIN
		SELECT 
			i.iname + ' {'+convert(varchar(10),i.qty)+' , '+ convert(varchar(10),i.price)+' , '+ convert(varchar(50),c.category)+'}' as 'Name'
		FROM item i
		INNER JOIN category c
		ON i.cid = c.cid
		WHERE i.iname like @ItemStr
		AND i.iid = i.piid
		Order by i.iname 
	END
	IF (@SourceForm = 'P') 
	BEGIN
		SELECT 
			i.iname + ' {'+convert(varchar(10),i.qty)+' , '+ convert(varchar(10),i.price)+' / '+ convert(varchar(10),i.discount)+'}' as 'Name'
		FROM item i
		WHERE i.iname like @ItemStr
		AND i.iid = i.piid
		Order by i.iname 
	END
	IF (@SourceForm = 'S') 
	BEGIN	
		SELECT 
			i.iname + ' {'+convert(varchar(10),i.qty)+' , '+ convert(varchar(10),i.price)+' / '+ convert(varchar(10),i.discount)+'}' as 'Name'
		FROM item i
		WHERE i.iname like @ItemStr
		Order by i.iname 
	END
END

GO

