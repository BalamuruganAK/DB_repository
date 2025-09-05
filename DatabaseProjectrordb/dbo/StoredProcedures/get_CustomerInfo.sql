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

	if exists(SELECT 1 
			FROM [tbl_Customer]  
			WHERE Phone  = @Phone AND Phone <> 0)
		begin
			SELECT @CustomerInfo = c.Name +'    '+ c.CustomerType +  '     '+  c.CustomerAddress
			FROM tbl_Customer c
			WHERE c.Phone = @Phone 
		end
		else
		begin
			SELECT @CustomerInfo = 'Info Not Available' 
		end
		
		SELECT d.BillHdrID AS BillNo, h.BillDateTime AS DateTime, d.Item, d.Quantity, d.Discount, d.Offer, d.Amount
		FROM tbl_BillHdr h 
		inner join tbl_BillDtl d
		on h.BillHdrID = d.BillHdrID
		AND h.Phone = @Phone
		AND isnull(h.Phone,0) <> 0 
		AND isnull(h.Cancel,0) <> 1
		order by d.BillHdrID desc, d.BillDtlID asc
	--SELECT  CustomerInfo AS CustomerInfoA FROM [tbl_Stock] WHERE Rate = @Rate
		 
END

GO

