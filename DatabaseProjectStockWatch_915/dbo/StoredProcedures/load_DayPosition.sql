CREATE proc [dbo].[load_DayPosition]
as
begin

	Declare @count int
	Select @count = 1
	
	create table #datem(PDate smalldatetime)
	CREATE TABLE #Planet(
	[PDate] [smalldatetime] NOT NULL,
	[Planet] [tinyint] NOT NULL,
	[Degree] [int] NULL,
	[Retro] [tinyint] NULL)

	CREATE TABLE #Planet30(
	[PDate] [smalldatetime] NOT NULL,
	[Planet] [tinyint] NOT NULL,
	[Degree] [int] NULL,
	[Retro] [tinyint] NULL)
	
	insert into #Planet
	Select p.PDate, p.Planet, p.Degree, p.Retro from tbl_Planet p
	order by 1,3,2
	
	insert into #Planet30
	Select p.PDate, p.Planet, p.Degree, p.Retro from tbl_Planet p
	order by 1,P.Degree  % 108000
	
	insert into tbl_DayPosition(PDate) 
	Select distinct PDate from tbl_Planet
		Where PDate not in (Select PDate from tbl_DayPosition)
	
	While @count <= 10
	begin	
		Update d
		set  d.SPlanet = COALESCE(d.SPlanet + ',  ', '') + 
		 PD.PlanetShortDesc + case when P.Retro = 1 then '(R)' else '' end,
		 d.SPosition = COALESCE(d.SPosition + ',  ', '') + 
		 PD.PlanetShortDesc   + 
			case when P.Retro = 1 then '(R)' else '' end + ' ('+
			convert(varchar(2),convert(numeric(2),(P.Degree  / 108000)+1)) + ') '+
			convert(varchar(2),convert(numeric(2),(P.Degree  % 108000)/3600)) + '.'+
			convert(varchar(2),convert(numeric(2),
			(((P.Degree  % 108000)/3600.0)- ((P.Degree  % 108000)/3600))* 60))
		From tbl_DayPosition d
		inner join #Planet P
		on d.PDate = P.PDate
		inner join tbl_PlanetDesc PD
		on PD.Planet = P.Planet
		and isnull(d.SPlanet,'') not like '%'+ PD.PlanetShortDesc +'%'
		

		Update d
		set  d.S30Planet = COALESCE(d.S30Planet + ',  ', '') + 
		 PD.PlanetShortDesc + case when P.Retro = 1 then '(R)' else '' end,
		 d.S30Position = COALESCE(d.S30Position + ',  ', '') + 
		 PD.PlanetShortDesc   +  
			case when P.Retro = 1 then '(R)' else '' end + ' '+
			convert(varchar(2),convert(numeric(2),(P.Degree  % 108000)/3600)) + '.'+
			convert(varchar(2),convert(numeric(2),
			(((P.Degree  % 108000)/3600.0)- ((P.Degree  % 108000)/3600))* 60))
		From tbl_DayPosition d
		inner join #Planet30 P
		on d.PDate = P.PDate
		inner join tbl_PlanetDesc PD
		on PD.Planet = P.Planet
		and isnull(d.S30Planet,'') not like '%'+ PD.PlanetShortDesc +'%'
			
		Update d
		set  d.StarPlanet = COALESCE(d.StarPlanet + ',  ', '') + 
		 PD.PlanetShortDesc + '/' + CD.PlanetShortDesc ,
		 d.StarPosition = COALESCE(d.StarPosition + ',  ', '') + 
		 PD.PlanetShortDesc + case when P.Retro = 1 then '(R)' else '' end + '/' +
		 CD.PlanetShortDesc + case when C.Retro = 1 then '(R)' else '' end +
			convert(varchar(2),case when P.Degree >= C.Degree then
						((P.Degree - C.Degree) / 108000) + 1
					else
						((1296000 + P.Degree - C.Degree) / 108000) + 1
					end) 
		From tbl_DayPosition d
		inner join tbl_Planet P
		on d.PDate = P.PDate
		inner join tbl_Planet C
		on C.PDate = P.PDate
	--	and C.Planet <> P.Planet
		and C.Planet not in (10,11,12)
		and C.Star = P.Planet 
		inner join tbl_PlanetDesc PD
		on PD.Planet = P.Planet
		inner join tbl_PlanetDesc CD
		on CD.Planet = C.Planet
		and isnull(d.StarPlanet,'') not like 
			('%'+ PD.PlanetShortDesc + '/' + CD.PlanetShortDesc+'%')
		
		Update d
		set  d.CPlanet = COALESCE(d.CPlanet + ',  ', '') +
			PD.PlanetShortDesc + '/' + CD.PlanetShortDesc,
			d.CPosition = COALESCE(d.CPosition + ',  ', '') +
			 PD.PlanetShortDesc + case when P.Retro = 1 then '(R)' else '' end + '/' +
			CD.PlanetShortDesc + case when C.Retro = 1 then '(R)' else '' end + 
				convert(varchar(2),case when C.Degree >= P.Degree then
						((C.Degree - P.Degree) / 108000) + 1
					else
						((1296000 + C.Degree - P.Degree) / 108000) + 1
					end) 
			From tbl_DayPosition d
			inner join tbl_Planet P
			on d.PDate = P.PDate
			inner join tbl_Planet C
			on C.PDate = P.PDate
			and C.Planet <> P.Planet
			and C.Planet not in (10,11,12)
			and (
			C.Degree - P.Degree between -12000 and 12000
			or ( C.Degree - P.Degree between -48000 and 48000 and C.Star = P.Star )
			)
			inner join tbl_PlanetDesc PD
			on PD.Planet = P.Planet
			inner join tbl_PlanetDesc CD
			on CD.Planet = C.Planet
			and isnull(d.CPlanet,'') not like 
				('%'+ PD.PlanetShortDesc + '/' + CD.PlanetShortDesc+'%')
			and isnull(d.CPlanet,'') not like '%'+ CD.PlanetShortDesc + '/' + PD.PlanetShortDesc+'%'
		
			Update d
			set  d.RPlanet = COALESCE(d.RPlanet + ',  ', '') + PD.PlanetShortDesc
			From tbl_DayPosition d
			inner join tbl_Planet P
			on d.PDate = P.PDate
				inner join tbl_PlanetDesc PD
				on PD.Planet = P.Planet
			Where P.Retro = 1
			and isnull(d.RPlanet,'') not like '%'+ PD.PlanetShortDesc +'%'
			
			Update d
			set  TS = convert(varchar(1), convert(numeric(1), case when mp.Degree % 48000 > 36000 
				then 1 end)) ,
				TSTime = convert(varchar(6), convert(numeric(5,2), case when mp.Degree % 48000 > 36000 
					then ((48000-(mp.Degree % 48000.0))*1.65/3600)+9.25 end)) ,
				MSPosition = convert(varchar(2),(mp.Degree / 48000) + 1) ,
				SMPosition = convert(varchar(2),((1296000 +  mp.Degree - sp.Degree) % 1296000 / 43200) +1) 
			From tbl_DayPosition d
			inner join tbl_Planet mP
			on d.PDate = mP.PDate
			and mP.Planet = 4
			inner join tbl_Planet sP
			on d.PDate = sP.PDate
			and sP.Planet = 3
			
			Select @count = @count + 1
		end			
end

GO

