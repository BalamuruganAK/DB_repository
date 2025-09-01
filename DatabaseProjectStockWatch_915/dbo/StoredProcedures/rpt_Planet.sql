create proc [dbo].[rpt_Planet]
as
begin
	Select s.PlanetShortDesc
	from tbl_PlanetDesc s
	union all
	Select 'ALL' 
	order by 1	
end

GO

