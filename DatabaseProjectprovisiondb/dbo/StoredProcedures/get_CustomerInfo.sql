-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_CustomerInfo]
(@Phone bigint, @CustomerInfo varchar(500) out)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
declare @CustomerInfo varchar(50)
exec [get_CustomerInfo] 40.80, @CustomerInfo out
select @CustomerInfo
*/
	Declare @cid as int
	Declare @accbalance float

	if exists(SELECT 1 
			FROM [tbl_Customer]  
			WHERE Phone  = @Phone AND Phone <> 0)
		begin

			SELECT @cid = c.CustomerID from tbl_customer c where c.Phone = @phone

			SELECT @accbalance = isnull(a1.accbalance,0) from account a1 where a1.cid = @cid
					and a1.adate = (SELECT max(a2.adate) from account a2 where a2.cid = @cid and a2.cancel = 0)
				SELECT @accbalance = isnull(@accbalance,0) 

			SELECT @CustomerInfo = c.Name +'    '+ c.CustomerType +  '     '+  c.CustomerAddress + '    '
				+ 'Balance:Rs' + convert(varchar(10),@accbalance)
			FROM tbl_Customer c
			WHERE c.Phone = @Phone 
		end
		else
		begin
			SELECT @CustomerInfo = 'Info Not Available' 
		end
		
		SELECT h.[sid] AS BillNo, h.sdate AS DateTime, h.amt as Amount, h.salesbalance as BillBalance
		FROM sales h 
		WHERE h.Phone = @Phone
		AND isnull(h.Phone,0) <> 0 
		AND isnull(h.Cancel,0) <> 1
		order by h.[sid] desc
	--SELECT  CustomerInfo AS CustomerInfoA FROM [tbl_Stock] WHERE Rate = @Rate
		 
END

GO

