CREATE proc [dbo].[Load_All]
as
begin

	Exec Load_Planet 
	Exec load_Work
	Exec load_Conjuction
	Exec load_NewConjuction
	Exec load_DayPosition 
	Exec load_FinalTrent  
end

GO

