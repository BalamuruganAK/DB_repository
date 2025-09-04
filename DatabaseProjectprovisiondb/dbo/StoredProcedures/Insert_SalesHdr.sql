
CREATE proc [dbo].[Insert_SalesHdr]
			(@sid int,
           @total float,
           @discount float,
           @amt float,
           @cash float,
           @gpay float,
           @cards float,
		   @salesbalance float,
           @phone bigint,
           @eid int)
AS
Begin
	Declare @cid int
	Declare @accbalance float
	Declare @transaction varchar(10)
	Declare @sid_new int
		
	if exists(SELECT 1 FROM sales 
			WHERE cancel = 0
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
		
		SELECT @sid_new = isnull(MAX(sid),0)+1
		FROM sales

		INSERT INTO [dbo].[sales]
				   ([sid]
				   ,[sdate]
				   ,[total]
				   ,[discount]
				   ,[amt]
				   ,[cash]
				   ,[gpay]
				   ,[cards]
				   ,salesbalance
				   ,[phone]
				   ,[cancel]
				   ,[eid])
			 VALUES
				   (@sid_new, 
				   GETDATE(),
				   @total, 
				   @discount, 
				   @amt, 
				   @cash, 
				   @gpay, 
				   @cards, 
				   @salesbalance,
				   @phone, 
				   0, 
				   @eid )

			SELECT @cid = c.CustomerID from tbl_customer c where c.Phone = @phone

			if @salesbalance > 0 
			begin
				SELECT @transaction = 'buy'
			end
			if @salesbalance < 0 
			begin
				SELECT @transaction = 'pay'
			end

			if @salesbalance > 0 or @salesbalance < 0 
			begin
				SELECT @accbalance = isnull(a1.accbalance,0) from account a1 where a1.cid = @cid
					and a1.adate = (SELECT max(a2.adate) from account a2 where a2.cid = @cid and a2.cancel = 0 )

				SELECT @accbalance = isnull(@accbalance,0) + @salesbalance

				INSERT INTO dbo.account
					(cid,adate,[transaction], [sid], amt, accbalance, eid, cancel)
				VALUES
					(@cid, GETDATE(),@transaction,@sid_new,@salesbalance,@accbalance, @eid, 0)
			end
    END
	ELSE
	BEGIN
		INSERT INTO [dbo].[sales]
				   ([sid]
				   ,[sdate]
				   ,[total]
				   ,[discount]
				   ,[amt]
				   ,[cash]
				   ,[gpay]
				   ,[cards]
				   ,salesbalance
				   ,[phone]
				   ,[cancel]
				   ,[eid])
			 VALUES
				   (@sid, 
				   GETDATE(),
				   @total, 
				   @discount, 
				   @amt, 
				   @cash, 
				   @gpay, 
				   @cards, 
				   @salesbalance,
				   @phone, 
				   0, 
				   @eid )

			SELECT @cid = c.CustomerID from tbl_customer c where c.Phone = @phone

			if @salesbalance > 0 
			begin
				SELECT @transaction = 'buy'
			end
			if @salesbalance < 0 
			begin
				SELECT @transaction = 'pay'
			end

			if @salesbalance > 0 or @salesbalance < 0 
			begin
				SELECT @accbalance = isnull(a1.accbalance,0) from account a1 where a1.cid = @cid
					and a1.adate = (SELECT max(a2.adate) from account a2 where a2.cid = @cid and a2.cancel = 0 )

				SELECT @accbalance = isnull(@accbalance,0) + @salesbalance

				INSERT INTO dbo.account
					(cid,adate,[transaction], [sid], amt, accbalance, eid, cancel)
				VALUES
					(@cid, GETDATE(),@transaction,@sid,@salesbalance,@accbalance, @eid, 0)
			end
		END
END

GO

