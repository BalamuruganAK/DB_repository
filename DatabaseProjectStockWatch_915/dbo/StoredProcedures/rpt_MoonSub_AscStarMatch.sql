 CREATE proc rpt_MoonSub_AscStarMatch
 as
 begin
		SELECT pd.PlanetShortDesc
				,pm.PDate
			  ,pm.Planet
			  ,pm.Degree
			  ,pm.FDegree
			  ,pm.Star
			  ,pm.Sub
			  ,pa.Planet
			  ,pa.Degree
			  ,pa.FDegree
			  ,pa.Star
			  ,pa.Sub
			  ,case when px.Degree >= pm.Degree then
				((px.Degree - pm.Degree) / 108000) + 1
			else
				((1296000 + px.Degree - pm.Degree) / 108000) + 1
			end 
		  FROM tbl_Planet pm
		  inner join tbl_Planet pa
		  on pm.PDate = pa.PDate
		  and pm.Planet = 4
		  and pa.Planet = 12
		  and pa.Star = pm.Sub
		  and Datepart(Weekday, pm.PDate) between 2 and 6
		  inner join tbl_PlanetDesc pd
		  on pd.Planet = pm.Sub 
		    inner join tbl_Planet px
			on px.Planet = pm.Sub
			and px.PDate = pm.PDate
		  
		 
 end

GO

