CREATE proc [dbo].[load_ThirdView]
as
begin
	declare @cnt int
	set @cnt = 0
	
	insert into tbl_ThirdView(PDate,Planet) 
	Select distinct PDate, Planet from tbl_Planet p
	Where p.Planet in(3, 4, 7)
	 and PDate not in (Select v.PDate from tbl_ThirdView v
		Where p.Planet = v.Planet)

	insert into tbl_ThirdViewSum(PDate) 
	Select distinct PDate from tbl_Planet p
	Where p.Planet in( 4)
	 and PDate not in (Select v.PDate from tbl_ThirdViewSum v)

	while @cnt < 6
	begin			
	Update tbl_ThirdView
	set  KP = isnull(tv.KP,'') + tview.MX1 + ','
	from tbl_ThirdView tv
	inner join(
		Select w.PDate, d.PlanetShortDesc as MX1, w.KeyPlanet as Planet
		from tbl_Work w
		inner join tbl_Planet xp
		on w.PDate = xp.PDate
		and w.KeyPlanet = xp.Planet
		and w.KeyPlanet in(3, 4, 7)
		inner join tbl_Planet x3
		on w.PDate = x3.PDate
		and (xp.Degree / 108000) - (x3.Degree / 108000) in (2,-2)
		inner join tbl_PlanetDesc d
		on d.Planet = x3.Planet) as tview
	on tview.PDate = tv.PDate and CHARINDEX(tview.MX1 ,isnull(tv.KP,'')) = 0
	and  tview.Planet = tv.Planet
	
	Update tbl_ThirdView
	set  MX = isnull(tv.MX,'') + 
		case 
			when Dir = 2 then '>'
			when Dir = -2 then '<'
		end +
		tview.MX1 + ','
	from tbl_ThirdView tv
	inner join(
		Select w.PDate,d.PlanetShortDesc as MX1, w.KeyPlanet as Planet, 
			(xp.Degree / 108000) - (x3.Degree / 108000) as Dir
		from tbl_Work w
		inner join tbl_Planet xp
		on w.PDate = xp.PDate
		and w.XPlanet = xp.Planet
		and w.KeyPlanet in(3, 4, 7)
		inner join tbl_Planet x3
		on w.PDate = x3.PDate
		and (xp.Degree / 108000) - (x3.Degree / 108000) in (2,-2)
		inner join tbl_PlanetDesc d
		on d.Planet = x3.Planet) as tview
	on tview.PDate = tv.PDate and CHARINDEX(tview.MX1 ,isnull(tv.MX,'')) = 0
	and  tview.Planet = tv.Planet
	
	Update tbl_ThirdView
	set  MY = isnull(tv.MY,'') + 
		case 
			when Dir = 2 then '>'
			when Dir = -2 then '<'
		end +
		tview.MX1 + ','
	from tbl_ThirdView tv
	inner join(
		Select w.PDate,d.PlanetShortDesc as MX1, w.KeyPlanet as Planet, 
			(xp.Degree / 108000) - (x3.Degree / 108000) as Dir
		from tbl_Work w
		inner join tbl_Planet xp
		on w.PDate = xp.PDate
		and w.YPlanet = xp.Planet
		and w.KeyPlanet in(3, 4, 7)
		inner join tbl_Planet x3
		on w.PDate = x3.PDate
		and (xp.Degree / 108000) - (x3.Degree / 108000) in (2,-2)
		inner join tbl_PlanetDesc d
		on d.Planet = x3.Planet) as tview
	on tview.PDate = tv.PDate and CHARINDEX(tview.MX1 ,isnull(tv.MY,'')) = 0
	and  tview.Planet = tv.Planet
	
	Update tbl_ThirdView
	set  MSub = isnull(tv.MSub,'') + tview.MX1 + ','
	from tbl_ThirdView tv
	inner join(
		Select w.PDate,d.PlanetShortDesc as MX1, w.KeyPlanet as Planet
		from tbl_Work w
		inner join tbl_Planet xp
		on w.PDate = xp.PDate
		and w.KeyPlanet = xp.Planet
		and w.KeyPlanet in(3, 4, 7)
		inner join tbl_Planet subp
		on w.PDate = subp.PDate
		and xp.Sub = subp.Planet
		inner join tbl_Planet x3
		on w.PDate = x3.PDate
		and (subp.Degree / 108000) - (x3.Degree / 108000) in (2,-2)
		inner join tbl_PlanetDesc d
		on d.Planet = x3.Planet) as tview
	on tview.PDate = tv.PDate and CHARINDEX(tview.MX1 ,isnull(tv.MSub,'')) = 0
	and  tview.Planet = tv.Planet
	
	Update tbl_ThirdView
	set  MXSub = isnull(tv.MXSub,'') + tview.MX1 + ','
	from tbl_ThirdView tv
	inner join(
		Select w.PDate,d.PlanetShortDesc as MX1, w.KeyPlanet as Planet
		from tbl_Work w
		inner join tbl_Planet xp
		on w.PDate = xp.PDate
		and w.XPlanet = xp.Planet
		and w.KeyPlanet in(3, 4, 7)
		inner join tbl_Planet subp
		on w.PDate = subp.PDate
		and xp.Sub = subp.Planet
		inner join tbl_Planet x3
		on w.PDate = x3.PDate
		and (subp.Degree / 108000) - (x3.Degree / 108000) in (2,-2)
		inner join tbl_PlanetDesc d
		on d.Planet = x3.Planet) as tview
	on tview.PDate = tv.PDate and CHARINDEX(tview.MX1 ,isnull(tv.MXSub,'')) = 0
	and  tview.Planet = tv.Planet
	
	Update tbl_ThirdView
	set  MYSub = isnull(tv.MYSub,'') + tview.MX1 + ','
	from tbl_ThirdView tv
	inner join(
		Select w.PDate,d.PlanetShortDesc as MX1, w.KeyPlanet as Planet
		from tbl_Work w
		inner join tbl_Planet xp
		on w.PDate = xp.PDate
		and w.YPlanet = xp.Planet
		and w.KeyPlanet in(3, 4, 7)
		inner join tbl_Planet subp
		on w.PDate = subp.PDate
		and xp.Sub = subp.Planet
		inner join tbl_Planet x3
		on w.PDate = x3.PDate
		and (subp.Degree / 108000) - (x3.Degree / 108000) in (2,-2)
		inner join tbl_PlanetDesc d
		on d.Planet = x3.Planet) as tview
	on tview.PDate = tv.PDate and CHARINDEX(tview.MX1 ,isnull(tv.MYSub,'')) = 0
	and  tview.Planet = tv.Planet
	
	Update tbl_ThirdView
	set  MXStar = isnull(tv.MXStar,'') + tview.MX1 + ','
	from tbl_ThirdView tv
	inner join(
		Select w.PDate,d.PlanetShortDesc as MX1, w.KeyPlanet as Planet
		from tbl_Work w
		inner join tbl_Planet xp
		on w.PDate = xp.PDate
		and w.XPlanet = xp.Planet
		and w.KeyPlanet in(3, 4, 7)
		inner join tbl_Planet subp
		on w.PDate = subp.PDate
		and xp.Star = subp.Planet
		inner join tbl_Planet x3
		on w.PDate = x3.PDate
		and (subp.Degree / 108000) - (x3.Degree / 108000) in (2,-2)
		inner join tbl_PlanetDesc d
		on d.Planet = x3.Planet) as tview
	on tview.PDate = tv.PDate and CHARINDEX(tview.MX1 ,isnull(tv.MXStar,'')) = 0
	and  tview.Planet = tv.Planet
	
	Update tbl_ThirdView
	set  MYStar = isnull(tv.MYStar,'') + tview.MX1 + ','
	from tbl_ThirdView tv
	inner join(
		Select w.PDate,d.PlanetShortDesc as MX1, w.KeyPlanet as Planet
		from tbl_Work w
		inner join tbl_Planet xp
		on w.PDate = xp.PDate
		and w.YPlanet = xp.Planet
		and w.KeyPlanet in(3, 4, 7)
		inner join tbl_Planet subp
		on w.PDate = subp.PDate
		and xp.Star = subp.Planet
		inner join tbl_Planet x3
		on w.PDate = x3.PDate
		and (subp.Degree / 108000) - (x3.Degree / 108000) in (2,-2)
		inner join tbl_PlanetDesc d
		on d.Planet = x3.Planet) as tview
	on tview.PDate = tv.PDate and CHARINDEX(tview.MX1 ,isnull(tv.MYStar,'')) = 0
	and  tview.Planet = tv.Planet
/*
	Update tbl_ThirdViewSum
	set  M = isnull(tv.M,'') + tview.MX1 + ','
	from tbl_ThirdViewSum tv
	inner join(
		Select w.PDate,d.PlanetShortDesc as MX1, w.KeyPlanet as Planet
		from tbl_Work w
		inner join tbl_Planet xp
		on w.PDate = xp.PDate
		and w.XPlanet = xp.Planet
		and w.KeyPlanet in(4)
		inner join tbl_Planet x3
		on w.PDate = x3.PDate
		and (xp.Degree / 108000) - (x3.Degree / 108000) in (2,-2)
		inner join tbl_PlanetDesc d
		on d.Planet = x3.Planet) as tview
	on tview.PDate = tv.PDate 
	and 0 = CHARINDEX(tview.MX1 ,isnull(tv.M,'')) 				
		

	Update tbl_ThirdViewSum
	set  M = isnull(tv.M,'') + tview.MX1 + ','
	from tbl_ThirdViewSum tv
	inner join(
		Select w.PDate,d.PlanetShortDesc as MX1, w.KeyPlanet as Planet
		from tbl_Work w
		inner join tbl_Planet xp
		on w.PDate = xp.PDate
		and w.YPlanet = xp.Planet
		and w.KeyPlanet in(4)
		inner join tbl_Planet x3
		on w.PDate = x3.PDate
		and (xp.Degree / 108000) - (x3.Degree / 108000) in (2,-2)
		inner join tbl_PlanetDesc d
		on d.Planet = x3.Planet) as tview
	on tview.PDate = tv.PDate 
	and 0 = CHARINDEX(tview.MX1 ,isnull(tv.M,'')) 	

	Update tbl_ThirdViewSum
	set  S = isnull(tv.S,'') + tview.MX1 + ','
	from tbl_ThirdViewSum tv
	inner join(
		Select w.PDate,d.PlanetShortDesc as MX1, w.KeyPlanet as Planet
		from tbl_Work w
		inner join tbl_Planet xp
		on w.PDate = xp.PDate
		and w.XPlanet = xp.Planet
		and w.KeyPlanet in(3)
		inner join tbl_Planet x3
		on w.PDate = x3.PDate
		and (xp.Degree / 108000) - (x3.Degree / 108000) in (2,-2)
		inner join tbl_PlanetDesc d
		on d.Planet = x3.Planet) as tview
	on tview.PDate = tv.PDate 
	and 0 = CHARINDEX(tview.MX1 ,isnull(tv.S,'')) 				
		

	Update tbl_ThirdViewSum
	set  S = isnull(tv.S,'') + tview.MX1 + ','
	from tbl_ThirdViewSum tv
	inner join(
		Select w.PDate,d.PlanetShortDesc as MX1, w.KeyPlanet as Planet
		from tbl_Work w
		inner join tbl_Planet xp
		on w.PDate = xp.PDate
		and w.YPlanet = xp.Planet
		and w.KeyPlanet in(3)
		inner join tbl_Planet x3
		on w.PDate = x3.PDate
		and (xp.Degree / 108000) - (x3.Degree / 108000) in (2,-2)
		inner join tbl_PlanetDesc d
		on d.Planet = x3.Planet) as tview
	on tview.PDate = tv.PDate 
	and 0 = CHARINDEX(tview.MX1 ,isnull(tv.S,'')) 	
	
	Update tbl_ThirdViewSum
	set  J = isnull(tv.J,'') + tview.MX1 + ','
	from tbl_ThirdViewSum tv
	inner join(
		Select w.PDate,d.PlanetShortDesc as MX1, w.KeyPlanet as Planet
		from tbl_Work w
		inner join tbl_Planet xp
		on w.PDate = xp.PDate
		and w.XPlanet = xp.Planet
		and w.KeyPlanet in(7)
		inner join tbl_Planet x3
		on w.PDate = x3.PDate
		and (xp.Degree / 108000) - (x3.Degree / 108000) in (2,-2)
		inner join tbl_PlanetDesc d
		on d.Planet = x3.Planet) as tview
	on tview.PDate = tv.PDate 
	and 0 = CHARINDEX(tview.MX1 ,isnull(tv.J,'')) 				
		

	Update tbl_ThirdViewSum
	set  J = isnull(tv.J,'') + tview.MX1 + ','
	from tbl_ThirdViewSum tv
	inner join(
		Select w.PDate,d.PlanetShortDesc as MX1, w.KeyPlanet as Planet
		from tbl_Work w
		inner join tbl_Planet xp
		on w.PDate = xp.PDate
		and w.YPlanet = xp.Planet
		and w.KeyPlanet in(7)
		inner join tbl_Planet x3
		on w.PDate = x3.PDate
		and (xp.Degree / 108000) - (x3.Degree / 108000) in (2,-2)
		inner join tbl_PlanetDesc d
		on d.Planet = x3.Planet) as tview
	on tview.PDate = tv.PDate 
	and 0 = CHARINDEX(tview.MX1 ,isnull(tv.J,'')) 	
	
		
	Update tbl_ThirdViewSum
	set  A = isnull(tv.A,'') + tview.MX1 + ','
	from tbl_ThirdViewSum tv
	inner join(
		Select w.PDate,d.PlanetShortDesc as MX1, w.KeyPlanet as Planet
		from tbl_Work w
		inner join tbl_Planet xp
		on w.PDate = xp.PDate
		and w.XPlanet = xp.Planet
		and w.KeyPlanet in(3,4,7)
		inner join tbl_Planet x3
		on w.PDate = x3.PDate
		and (xp.Degree / 108000) - (x3.Degree / 108000) in (2,-2)
		inner join tbl_PlanetDesc d
		on d.Planet = x3.Planet) as tview
	on tview.PDate = tv.PDate 
	and 0 = CHARINDEX(tview.MX1 ,isnull(tv.A,'')) 				
		

	Update tbl_ThirdViewSum
	set  A = isnull(tv.A,'') + tview.MX1 + ','
	from tbl_ThirdViewSum tv
	inner join(
		Select w.PDate,d.PlanetShortDesc as MX1, w.KeyPlanet as Planet
		from tbl_Work w
		inner join tbl_Planet xp
		on w.PDate = xp.PDate
		and w.YPlanet = xp.Planet
		and w.KeyPlanet in(3,4,7)
		inner join tbl_Planet x3
		on w.PDate = x3.PDate
		and (xp.Degree / 108000) - (x3.Degree / 108000) in (2,-2)
		inner join tbl_PlanetDesc d
		on d.Planet = x3.Planet) as tview
	on tview.PDate = tv.PDate 
	and 0 = CHARINDEX(tview.MX1 ,isnull(tv.A,'')) 
*/	
	set @cnt = @cnt + 1
	end	
	
--	truncate table  tbl_ThirdView
--truncate table tbl_ThirdViewSum
-- [load_ThirdView]
Select * from tbl_ThirdViewSum xp
where year(xp.PDate) = 2018 and month(xp.PDate) = 7
Select * from tbl_ThirdView xp
where year(xp.PDate) = 2018 and month(xp.PDate) = 7
end

GO

