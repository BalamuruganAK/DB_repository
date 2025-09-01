CREATE proc [dbo].[Clear_All]
as
begin
	Truncate table tbl_PlanetPosition 
	Truncate table tbl_Planet 
	Truncate table tbl_Work
	Truncate table tbl_FinalTrent
	Truncate table tbl_Conjuction
    Truncate table tbl_NewConjuction
    Truncate table tbl_DayPosition
    Truncate table tbl_Element
end

GO

