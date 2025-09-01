CREATE proc [dbo].[Load_Planet]
as
begin

	Insert into tbl_Planet
	SELECT Dateadd(mi,15,Dateadd(hh,9,PDate)) PDate,
      Planet , Degree, FDegree, Retro, null as Star, null as Sub    		      
	FROM tbl_PlanetPosition PP
	Where Dateadd(mi,15,Dateadd(hh,9,PDate)) 
		not in (Select P.PDate from tbl_Planet P Where P.Planet = PP.Planet)
	
	
	Update tbl_Planet  Set Star = pd.Planet
	from
		(Select p.PDate, p.Planet, p.Degree, h.Star
		From tbl_Planet p
		inner join tbl_Horary h
		on p.Degree > h.FD and p.Degree <= h.TD) as ho
	inner join tbl_PlanetDesc pd
	on pd.PlanetDesc = ho.Star
	inner join tbl_Planet pl
	on ho.PDate = pl.PDate
	and ho.Planet = pl.Planet
	
		Update tbl_Planet  Set Sub = pd.Planet
	from
		(Select p.PDate, p.Planet, p.Degree, h.Sub
		From tbl_Planet p
		inner join tbl_Horary h
		on p.Degree > h.FD and p.Degree <= h.TD) as ho
	inner join tbl_PlanetDesc pd
	on pd.PlanetDesc = ho.Sub
	inner join tbl_Planet pl
	on ho.PDate = pl.PDate
	and ho.Planet = pl.Planet
	
  
end

GO

