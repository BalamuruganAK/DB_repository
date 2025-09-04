-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Insert_PurchaseHdr]
(@pid int, @PurchaseDate date, @Amount float, @pid_new int out) 
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	/*
	Select * from [tbl_PurchaseHdr]
	select * from tbl_stock
	delete  from [tbl_PurchaseHdr]
	*/
	SET NOCOUNT ON;

	SELECT @pid_new = isnull(MAX(pid),0)+1
	FROM Purchase
	
	INSERT INTO Purchase
       (pid
       ,pdate
       ,amt)
	VALUES
       (@pid_new 
       ,GETDATE()
       ,@Amount)
           
	if (@pid is not null and @pid > 0)
	begin 
	    UPDATE Purchase
	    SET phistid = @pid_new
	    WHERE pid = @pid
	    
	    UPDATE s
	    SET s.qty = s.qty - p.qty
	    FROM stock s
	    INNER JOIN purchasedetail p
	    ON s.iid = p.iid
	    AND p.pid = @pid

		 UPDATE i
	    SET i.price = h.price
	    FROM item i
	    INNER JOIN purchasedetail p
	    ON i.iid = p.iid AND p.pid = @pid
		INNER JOIN itemhistory h
		ON h.iid = i.iid and convert(varchar(12),h.idate) = convert(varchar(12),GETDATE())
	end
    -- Insert statements for procedure here
END

GO

