-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Select_Delivery]
(@BillHdrID int, @OnDelivery float out, @CustInfo varchar(100) out)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
declare @OnDelivery float , @CustInfo varchar(100) 
exec [Select_Delivery] 29,@OnDelivery  out, @CustInfo  out
select @OnDelivery  , @CustInfo
*/
declare @Received float 

		Select @Received = isnull(sum(isnull(d.Received,0)),0)
		from tbl_Delivery d
		Where d.BillHdrID = @BillHdrID
		
		Select @OnDelivery = isnull(h.OnDelivery,0) - isnull(@Received,0), @CustInfo = convert(varchar(10),h.Phone)  
		From tbl_BillHdr h
		Where h.BillHdrID = @BillHdrID 
	
		Select	d.QuickCode
		From tbl_QuickCode  d
		Where d.QuickCodeType = 'DELIVERY'		
		 
END

GO

