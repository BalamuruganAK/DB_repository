CREATE proc [dbo].[rpt_Stock]
as
begin
	Select s.Stock
	from tbl_Stock s
	union all
	Select 'ALL' 
	union all
	Select 'ALLS' 
	union all
	Select 'ALLP' 
	union all
	Select 'ALLPS' 
	union all
	Select 'PLANETS' 
	order by 1	
end

GO

