
CREATE proc [dbo].[rpt_ZPlanet]
as
begin 

	Select convert(varchar(10),z.PDate,102), d.PlanetShortDesc + convert(varchar(2),z.ZPosition) as Z, 
		dy.PlanetShortDesc + convert(varchar(2),z.YPosition) as Y, z.ZConjuction  
	from tbl_ZPlanet z
	inner join tbl_PlanetDesc d
	on d.Planet = z.ZPlanet 
	inner join tbl_PlanetDesc dy
	on dy.Planet = z.YPlanet 
	where month(z.PDate) >= MONTH(getdate()) and YEAR(z.pdate) = YEAR(getdate())
	-- > '2018-07-03 09:15:00'
end

GO

