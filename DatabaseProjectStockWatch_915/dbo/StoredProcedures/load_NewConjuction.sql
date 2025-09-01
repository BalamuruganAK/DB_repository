CREATE proc [dbo].[load_NewConjuction]
as
begin
	Declare @count int
	Select @count = 1
	
	create table #datem(PDate smalldatetime)
	
	insert into #datem 
	Select distinct PDate from tbl_Work
		Where PDate not in (Select PDate from tbl_NewConjuction Where KeyPlanet = 4)
		and KeyPlanet = 4
		
	Insert into tbl_NewConjuction (PDate,KeyPlanet) 
	Select PDate, 4 as KeyPlanet from #datem

	Insert into tbl_NewConjuction (PDate,KeyPlanet) 
	Select PDate, 3 as KeyPlanet from #datem

	Insert into tbl_NewConjuction (PDate,KeyPlanet) 
	Select PDate, 7 as KeyPlanet from #datem

	While @count <= 5
	begin
			Update J
			set J.KPlanet = COALESCE(J.KPlanet + '/', '') + PD.PlanetShortDesc,
			J.KPosition = COALESCE(J.KPosition + '/', '') + PD.PlanetShortDesc +
				convert(varchar(2),convert(numeric(2),case when kp.Degree >= C.Degree then
						((kp.Degree - C.Degree) / 108000) + 1
					else
						((1296000 + kp.Degree - C.Degree) / 108000) + 1
					end))
					
		--	Select J.KPlanet , PD.PlanetShortDesc
			From tbl_NewConjuction J
			inner join tbl_Work w
			on w.PDate = J.PDate
			and w.KeyPlanet = J.KeyPlanet
		--	and J.KeyPlanet = 4
			inner join tbl_Planet kp
			on kp.PDate = w.PDate
			and kp.Planet = w.KeyPlanet
			inner join tbl_Planet C
			on C.PDate = kp.PDate
			and C.Planet <> kp.Planet
			and C.Planet not in (10,11,12)
			and (
			C.Degree - kp.Degree between -12000 and 12000
			or ( C.Degree - kp.Degree between -48000 and 48000 and C.Star = kp.Star )
			)
			inner join tbl_PlanetDesc PD
			on PD.Planet = C.Planet
			and isnull(J.KPlanet,'') not like '%'+ PD.PlanetShortDesc +'%'
			--Where w.PDate in (Select PDate from #datem)

		----Begin X Y 
			Update J
			set J.XPlanet = COALESCE(J.XPlanet + '/', '') + PD.PlanetShortDesc,
			J.XPosition = COALESCE(J.XPosition + '/', '') + PD.PlanetShortDesc +
				convert(varchar(2),convert(numeric(2),case when kp.Degree >= C.Degree then
						((kp.Degree - C.Degree) / 108000) + 1
					else
						((1296000 + kp.Degree - C.Degree) / 108000) + 1
					end))
			From tbl_NewConjuction J
			inner join tbl_Work w
			on w.PDate = J.PDate
			and w.KeyPlanet = J.KeyPlanet
		--	and J.KeyPlanet = 4
			inner join tbl_Planet P
			on P.PDate = w.PDate
			and P.Planet = w.XPlanet
			inner join tbl_Planet kp
			on kp.PDate = w.PDate
			and kp.Planet = w.KeyPlanet
			inner join tbl_Planet C
			on C.PDate = P.PDate
			and C.Planet <> P.Planet
			and C.Planet not in (10,11,12)
			and (
			C.Degree - P.Degree between -12000 and 12000
			or ( C.Degree - P.Degree between -48000 and 48000 and C.Star = P.Star )
			)
			inner join tbl_PlanetDesc PD
			on PD.Planet = C.Planet
			and isnull(J.XPlanet,'') not like '%'+ PD.PlanetShortDesc +'%'
			--Where w.PDate in (Select PDate from #datem)

			Update J
			set J.YPlanet = COALESCE(J.YPlanet + '/', '') + PD.PlanetShortDesc,
			J.YPosition = COALESCE(J.YPosition + '/', '') + PD.PlanetShortDesc +
				convert(varchar(2),convert(numeric(2),case when kp.Degree >= C.Degree then
						((kp.Degree - C.Degree) / 108000) + 1
					else
						((1296000 + kp.Degree - C.Degree) / 108000) + 1
					end))
			From tbl_NewConjuction J
			inner join tbl_Work w
			on w.PDate = J.PDate
			and w.KeyPlanet = J.KeyPlanet
		--	and J.KeyPlanet = 4
			inner join tbl_Planet P
			on P.PDate = w.PDate
			and P.Planet = w.YPlanet
			inner join tbl_Planet kp
			on kp.PDate = w.PDate
			and kp.Planet = w.KeyPlanet
			inner join tbl_Planet C
			on C.PDate = P.PDate
			and C.Planet <> P.Planet
			and C.Planet not in (10,11,12)
			and (
			C.Degree - P.Degree between -12000 and 12000
			or ( C.Degree - P.Degree between -48000 and 48000 and C.Star = P.Star )
			)
			inner join tbl_PlanetDesc PD
			on PD.Planet = C.Planet
			and isnull(J.YPlanet,'') not like '%'+ PD.PlanetShortDesc +'%'
			--Where w.PDate in (Select PDate from #datem)
		----End X Y 
		Select @count = @count + 1
	end
end

GO

