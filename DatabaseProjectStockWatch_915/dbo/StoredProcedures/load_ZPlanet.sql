CREATE proc [dbo].[load_ZPlanet]
as
begin
	--truncate table tbl_ZPlanet
	create table #date(PDate smalldatetime)
	
	insert into #date 
	Select distinct PDate from tbl_Planet p
	Where p.Planet = 4
	 and PDate not in (Select PDate from tbl_ZPlanet Where KeyPlanet = 4)
	
	Insert into tbl_ZPlanet (PDate,KeyPlanet) 
	Select PDate, 4 as KeyPlanet
	from #date

	Update z
	set z.ZPlanet = p.Star,
		z.YPlanet = p.Planet,
		z.YPosition = w.YPosition
	From tbl_Work w
	inner join tbl_ZPlanet z
	on z.PDate = w.PDate
	inner join tbl_Planet p
	on p.Planet = w.YPlanet
	and p.PDate = w.PDate
	and w.PDate in (Select PDate from #date)
	and w.KeyPlanet = 4
	
	Update tbl_ZPlanet
	set ZPosition = 
			case when py.Degree >= p.Degree then
				((py.Degree - p.Degree) / 108000) + 1
			else
				((1296000 + py.Degree - p.Degree) / 108000) + 1
			end 
	From tbl_ZPlanet w
	inner join tbl_Planet p
	on p.Planet = w.KeyPlanet
	and p.PDate = w.PDate	
	inner join tbl_Planet py
	on py.Planet = w.ZPlanet
	and py.PDate = w.PDate
	where w.PDate in (Select PDate from #date)
	and w.KeyPlanet = 4

Declare @count int
	Select @count = 1
	
	While @count <= 5
	begin
			Update J
			set J.ZConjuction = COALESCE(J.ZConjuction + '/', '') + PD.PlanetShortDesc +
				convert(varchar(2),convert(numeric(2),case when kp.Degree >= C.Degree then
						((kp.Degree - C.Degree) / 108000) + 1
					else
						((1296000 + kp.Degree - C.Degree) / 108000) + 1
					end))
			From tbl_ZPlanet J
			inner join tbl_Planet P
			on P.PDate = J.PDate
			and P.Planet = J.ZPlanet
			inner join tbl_Planet kp
			on kp.PDate = J.PDate
			and kp.Planet = J.KeyPlanet			
			inner join tbl_Planet C
			on C.PDate = J.PDate
			and C.Planet <> J.ZPlanet
			and C.Planet not in (10,11,12)
			and (
			C.Degree - P.Degree between -12000 and 12000
			or ( C.Degree - P.Degree between -48000 and 48000 and C.Star = P.Star )
			)
			inner join tbl_PlanetDesc PD
			on PD.Planet = C.Planet
			and isnull(J.ZConjuction,'') not like '%'+ PD.PlanetShortDesc +'%'
--			Where J.PDate in (Select PDate from #date)
		Select @count = @count + 1
	end

end

GO

