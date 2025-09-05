create proc Delete_tables
as
begin
	delete from tbl_BillDtl 
	delete from tbl_BillHdr
	delete from tbl_Cash
	delete from tbl_Delivery
	delete from tbl_Expense
	delete from tbl_PurchaseDtl 
	delete from tbl_PurchaseHdr
	delete from tbl_RateChange
	delete from tbl_Stock
	delete from tbl_StockHist
	delete from tbl_StockUpdateDtl
	delete from tbl_StockUpdateHdr
end

GO

