CREATE proc [dbo].[rpt_RetroDates]
as
begin
		Declare @RetroList varchar(2000)
		
		Select  @RetroList = COALESCE(@RetroList + ', ', '') + 
				CONVERT(varchar(10),R.FPDate,102)  + ' / ' +
			CONVERT(varchar(10),R.TPDate,102)  + ' ' +
			PD.PlanetShortDesc 
			From tbl_Retro R
			inner join tbl_PlanetDesc PD
			on PD.Planet = R.Planet
		 order by Year(R.FPDate) Desc, MONTH(Year(R.FPDate))

		Select  @RetroList RetroDates

		 --order by (avg(PHP) / case when avg(PLP) > 0 then avg(PLP) else 0.005 end * -1) desc
	 
end

GO

