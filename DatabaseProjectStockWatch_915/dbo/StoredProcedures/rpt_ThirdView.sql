CREATE proc [dbo].[rpt_ThirdView]
as
begin
	Select convert(varchar(5),W.PDate,104) as Date,
		pdx.PlanetShortDesc + convert(varchar(2),w.XPosition) as MX, 
		pdy.PlanetShortDesc + convert(varchar(2),w.YPosition) as MY,
		case when pdx.PlanetShortDesc = 'Ket' then 'K'
			when pdx.PlanetShortDesc = 'Rah' then 'R' 
			else '' end +
		case 
			when w.XPosition in (1,3,6,10,11) then '+'
			when w.XPosition in (5,8,12) then '-'
			when w.XPosition in (2,9) then '^'
			when w.XPosition in (4,7) then '='
		end + tv.MX as M3X,
		case when pdy.PlanetShortDesc = 'Ket' then 'K'
			when pdy.PlanetShortDesc = 'Rah' then 'R'  
			else '' end +
		case 
			when w.YPosition in (1,3,6,10,11) then '+'
			when w.YPosition in (5,8,12) then '-'
			when w.YPosition in (2,9) then '^'
			when w.YPosition in (4,7) then '='
		end + tv.MY as M3Y
	from tbl_Work w	
	inner join tbl_ThirdView tv
	on tv.PDate = W.PDate
	and tv.Planet = 4
	and w.KeyPlanet = 4
	inner join tbl_PlanetDesc pdx
	on pdx.Planet = w.XPlanet 
	inner join tbl_PlanetDesc pdy
	on pdy.Planet = w.YPlanet 
	where year(W.PDate) = 2018 and month(W.PDate) >= 7
	order by W.PDate
	
		Select convert(varchar(10),W.PDate,102) as Date,
		pdx.PlanetShortDesc + convert(varchar(2),w.XPosition) as MX, 
		pdy.PlanetShortDesc + convert(varchar(2),w.YPosition) as MY,
		case when pdx.PlanetShortDesc = 'Ket' then 'K'
			when pdx.PlanetShortDesc = 'Rah' then 'R' 
			else '' end +
		case 
			when w.XPosition in (1,3,6,10,11) then '+'
			when w.XPosition in (5,8,12) then '-'
			when w.XPosition in (2,9) then '^'
			when w.XPosition in (4,7) then '='
		end + tv.MX as M3X,
		case when pdy.PlanetShortDesc = 'Ket' then 'K'
			when pdy.PlanetShortDesc = 'Rah' then 'R'  
			else '' end +
		case 
			when w.YPosition in (1,3,6,10,11) then '+'
			when w.YPosition in (5,8,12) then '-'
			when w.YPosition in (2,9) then '^'
			when w.YPosition in (4,7) then '='
		end + tv.MY as M3Y
	from tbl_Work w	
	inner join tbl_ThirdView tv
	on tv.PDate = W.PDate
	and tv.Planet = 3
	and w.KeyPlanet = 3
	inner join tbl_PlanetDesc pdx
	on pdx.Planet = w.XPlanet 
	inner join tbl_PlanetDesc pdy
	on pdy.Planet = w.YPlanet 
	where year(W.PDate) = 2018 and month(W.PDate) >= 7
	order by W.PDate
	
	Select convert(varchar(10),W.PDate,102) as Date,
		pdx.PlanetShortDesc + convert(varchar(2),w.XPosition) as MX, 
		pdy.PlanetShortDesc + convert(varchar(2),w.YPosition) as MY,
		case when pdx.PlanetShortDesc = 'Ket' then 'K'
			when pdx.PlanetShortDesc = 'Rah' then 'R' 
			else '' end +
		case 
			when w.XPosition in (1,3,6,10,11) then '+'
			when w.XPosition in (5,8,12) then '-'
			when w.XPosition in (2,9) then '^'
			when w.XPosition in (4,7) then '='
		end + tv.MX as M3X,
		case when pdy.PlanetShortDesc = 'Ket' then 'K'
			when pdy.PlanetShortDesc = 'Rah' then 'R'  
			else '' end +
		case 
			when w.YPosition in (1,3,6,10,11) then '+'
			when w.YPosition in (5,8,12) then '-'
			when w.YPosition in (2,9) then '^'
			when w.YPosition in (4,7) then '='
		end + tv.MY as M3Y
	from tbl_Work w	
	inner join tbl_ThirdView tv
	on tv.PDate = W.PDate
	and tv.Planet = 7
	and w.KeyPlanet = 7
	inner join tbl_PlanetDesc pdx
	on pdx.Planet = w.XPlanet 
	inner join tbl_PlanetDesc pdy
	on pdy.Planet = w.YPlanet 
	where year(W.PDate) = 2018 and month(W.PDate) >= 7
	order by W.PDate
--Select xp.Degree % 48000, xp.* from tbl_Planet xp
end

GO

