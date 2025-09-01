CREATE proc [dbo].[rpt_ElementDesc]
as
begin
	Select e.ElementDesc
	from tbl_ElementDesc e
	--where e.ID < 10
end

GO

