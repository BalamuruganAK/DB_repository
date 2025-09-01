CREATE proc [dbo].[Load_ElementDesc]
as
begin
	--truncate table tbl_ElementDesc
	Insert into tbl_ElementDesc Select 1, 'SSumD'
	Insert into tbl_ElementDesc Select 2, 'CSumD'
	Insert into tbl_ElementDesc Select 3, 'KSum'
	Insert into tbl_ElementDesc Select 4, 'SSum'
	Insert into tbl_ElementDesc Select 5, 'CSum'
	Insert into tbl_ElementDesc Select 6, 'SumOr'	
	Insert into tbl_ElementDesc Select 7, 'CSOr'
	Insert into tbl_ElementDesc Select 8, 'CKOr'
	Insert into tbl_ElementDesc Select 9, 'KSumD'
	Insert into tbl_ElementDesc Select 10, 'CSKOr'
end

GO

