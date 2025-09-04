-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cancel_Bill]
			(@Sid	int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	/*
	select * from [tbl_stock]
	*/
	SET NOCOUNT ON;
	
	if not exists(SELECT 1 FROM sales 
			WHERE cancel = 1
			AND sid = @Sid)
	BEGIN
		UPDATE sales 
		SET cancel = 1
		WHERE sid = @Sid
		
		UPDATE account 
		SET cancel = 1
		WHERE sid = @Sid

		UPDATE s
		SET s.qty = s.qty + d.qty_s
		FROM stock s, 
			(Select i.piid, SUM(sd.qty*i.qty) as qty_s 
			from salesdetail sd 
			inner join item i on i.iid = sd.iid
			where sd.sid = @Sid group by i.piid ) d
		WHERE s.iid = d.piid
		
    END
END

GO

