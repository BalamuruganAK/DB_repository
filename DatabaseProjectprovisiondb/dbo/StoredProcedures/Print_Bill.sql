-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Print_Bill]
(@BillHdrID int)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
-- To allow advanced options to be changed.
EXEC sp_configure 'show advanced options', 1;
GO
-- To update the currently configured value for advanced options.
RECONFIGURE;
GO
-- To enable the feature.
EXEC sp_configure 'xp_cmdshell', 1;
GO
-- To update the currently configured value for this feature.
RECONFIGURE;
GO


exec Print_Bill 26
*/
declare @Hdr varchar(1000)
declare @Hdr1 varchar(100)
declare @Hdr11 varchar(100)
declare @Hdr12 varchar(100)
declare @Hdr2 varchar(100)
declare @Dtl  varchar(100)
declare @Footer varchar(100)
declare @Footer1 varchar(100)
declare @Footer2 varchar(100)
declare @Footer3 varchar(100)
declare @Footer4 varchar(100)
declare @Line varchar(100)
declare @Space varchar(100)
declare @Count int
declare @I int
declare @MinBillDtlNo int
declare @OnDelivery float

		SELECT @Space = '-       '
		SELECT @Space = '@echo ' + @Space + ' >> c:\ror\print_test.txt'

		SELECT @Line = '--------------------------------------------'
		SELECT @Line = '@echo ' + @Line + ' >> c:\ror\print_test.txt'		

		SELECT @Hdr1 = '               RICE OM RICE   ',
			@Hdr11 = '       SGR Dental Collage Rd, Marathali',
			@Hdr12 = 'CC:9742466727                   shop:9742810696',
			@Hdr2 = 'Bill No:'+right(convert(varchar(8),h.BillHdrID+10000000),7)+'   DateTime:'+convert(varchar(20),h.BillDateTime,120),
			--@Footer = 'Cust Phone: '+CONVERT(varchar(10),h.Phone)+ 
			@Footer = 'Cust Phone: '+stuff(CONVERT(varchar(10),h.Phone ),1 ,0 ,replicate(' ',10-LEN(convert(varchar(10),h.Phone))))+
			'     Total Amt: '+ CONVERT(varchar(10),h.TotalAmount),
			@OnDelivery = isnull(h.OnDelivery,0)
		FROM [tbl_BillHdr] h
		WHERE BillHdrID = @BillHdrID 
		
		SELECT @Hdr1 = '@echo ' + @Hdr1 + ' > c:\ror\print_test.txt'
		SELECT @Hdr11 = '@echo ' + @Hdr11 + ' >> c:\ror\print_test.txt'
		SELECT @Hdr12 = '@echo ' + @Hdr12 + ' >> c:\ror\print_test.txt'
		SELECT @Hdr2 = '@echo ' + @Hdr2 + ' >> c:\ror\print_test.txt'
		SELECT @Footer = '@echo ' + @Footer + ' >> c:\ror\print_test.txt'
		exec xp_cmdshell @Hdr1
		exec xp_cmdshell @Hdr11
		exec xp_cmdshell @Hdr12
		exec xp_cmdshell @Space
		exec xp_cmdshell @Hdr2
		exec xp_cmdshell @Line
		SELECT @Dtl = 'SNo  Rate     Item  Qty Discount Offer Amount'
		SELECT @Dtl = '@echo ' + @Dtl + ' >> c:\ror\print_test.txt'		
		exec xp_cmdshell @Dtl
		exec xp_cmdshell @Line
		
		
		SELECT @Count =COUNT(1), @MinBillDtlNo = MIN(d.BillDtlID), @I = 0
		FROM tbl_BillDtl d
		WHERE BillHdrID = @BillHdrID
		
		WHILE @I < @Count
		begin
			SELECT @I = @I + 1 
			
			SELECT @Dtl= right(convert(varchar(3),@I +100),2) + ' ' 
			+ stuff(CONVERT(varchar(10),d.Item),1 ,0 ,replicate(' ',6-LEN(convert(varchar(10),d.Item))))
			+ stuff(CONVERT(varchar(10),s.ItemType),1 ,0 ,replicate(' ',10-LEN(convert(varchar(10),s.ItemType ))))
			+ stuff(CONVERT(varchar(10),d.Quantity),1 ,0 ,replicate(' ',4-LEN(convert(varchar(10),d.Quantity))))
			+ stuff(CONVERT(varchar(10),d.Discount ),1 ,0 ,replicate(' ',6-LEN(convert(varchar(10),d.Discount))))
			+ stuff(isnull(d.Offer,'-'),1 ,0 ,replicate(' ',5-LEN(isnull(d.Offer,'-'))))
			+ stuff(CONVERT(varchar(10),d.Amount ),1 ,0 ,replicate(' ',8-LEN(convert(varchar(10),d.Amount))))
			FROM tbl_BillDtl d, tbl_Stock s
			WHERE d.Item = s.Rate 
			AND d.BillDtlID = @MinBillDtlNo	
			
			SELECT @Dtl = '@echo ' + @Dtl + ' >> c:\ror\print_test.txt'		
			exec xp_cmdshell @Dtl
			SELECT @MinBillDtlNo = @MinBillDtlNo + 1	
		end		
		
		exec xp_cmdshell @Line
		exec xp_cmdshell @Footer
				
		if @OnDelivery <> 0
		begin
			SELECT @Footer = '@echo '+ '  On Delivery Amt: '+ CONVERT(varchar(10),@OnDelivery) +' >> c:\ror\print_test.txt'		
			exec xp_cmdshell @Footer
		end
		exec xp_cmdshell @Space
		SELECT @Footer = '@echo     *No Cash Refund - Exchange within 2days* >> c:\ror\print_test.txt'		
		exec xp_cmdshell @Footer
		SELECT @Footer = '@echo     *** HAPPY SHOPPING WITH RICR OM RICE *** >> c:\ror\print_test.txt'		
		exec xp_cmdshell @Footer			
		exec xp_cmdshell @Space
		exec xp_cmdshell @Space	
		exec xp_cmdshell @Space
		exec xp_cmdshell @Space
		exec xp_cmdshell @Space
		exec xp_cmdshell @Space
		exec xp_cmdshell @Space
		exec xp_cmdshell @Space
		exec xp_cmdshell @Space
									
		SELECT @Hdr = 'PRINT /D:\\LOENOVO-PC\EPSON c:\ror\print_test.txt'
		exec xp_cmdshell @Hdr
							 
END

GO

