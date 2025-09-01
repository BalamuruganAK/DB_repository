CREATE proc [dbo].[Load_Retro]
as
begin

	Insert into tbl_Retro
	SELECT P1.PDate FPdate, P1.Planet, NULL TPDate   		      
	FROM tbl_Planet P1
	inner join tbl_Planet P2
	on P2.Planet = P1.Planet
	and P2.PDate = DateADD(dd, -1, P1.PDate)
	Where P1.PDate 
		not in (Select R.FPDate from tbl_Retro R 
				Where R.Planet = P1.Planet and R.FPDate = P1.PDate)
	and P1.Retro = 1
	and P2.Retro = 0
	
	Update R
	Set R.TPdate = DateADD(dd, -1,( SELECT min(P1.PDate) 
					FROM tbl_Planet P1
					WHERE R.Planet = P1.Planet
					and P1.PDate > R.FPdate
					and P1.Retro = 0))
	FROM tbl_Retro R
  
end

GO

