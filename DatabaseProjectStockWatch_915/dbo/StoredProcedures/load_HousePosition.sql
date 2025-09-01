CREATE proc [dbo].[load_HousePosition]
as
begin
	declare @cnt int
	set @cnt = 0
	
	insert into tbl_HousePosition(PDate,Planet) 
	Select distinct PDate, Planet from tbl_Planet p
	Where p.Planet in(3, 4, 7)
	 and PDate not in (Select v.PDate from tbl_HousePosition v
		Where p.Planet = v.Planet)

	Update tbl_HousePosition
	set  KP = tview.hp
	from tbl_HousePosition tv
	inner join(
		Select xp.PDate, (xp.Degree / 108000) + 1 as hp, xp.Planet
		from tbl_Planet xp
		where xp.Planet in(3, 4, 7)) as tview
	on tview.PDate = tv.PDate 
	and  tview.Planet = tv.Planet

	Update tbl_HousePosition
	set  MX = tview.hp
	from tbl_HousePosition tv
	inner join(
		Select xp.PDate, (xp.Degree / 108000) + 1 as hp, w.KeyPlanet as Planet
		from tbl_Planet xp
		inner join tbl_Work w
		on w.KeyPlanet in(3, 4, 7)
		and w.PDate = xp.PDate
		where xp.Planet = w.XPlanet) as tview
	on tview.PDate = tv.PDate 
	and  tview.Planet = tv.Planet	

	Update tbl_HousePosition
	set  MY = tview.hp
	from tbl_HousePosition tv
	inner join(
		Select xp.PDate, (xp.Degree / 108000) + 1 as hp, w.KeyPlanet as Planet
		from tbl_Planet xp
		inner join tbl_Work w
		on w.KeyPlanet in(3, 4, 7)
		and w.PDate = xp.PDate
		where xp.Planet = w.YPlanet) as tview
	on tview.PDate = tv.PDate 
	and  tview.Planet = tv.Planet	
	
	Update tbl_HousePosition
	set  MXSub = tview.hp
	from tbl_HousePosition tv
	inner join(
		Select xp.PDate, (sp.Degree / 108000) + 1 as hp, xp.Planet
		from tbl_Planet xp
		inner join tbl_Planet sp
		on sp.PDate = xp.PDate 
		and xp.Sub = sp.Planet
		where xp.Planet in(3, 4, 7)) as tview
	on tview.PDate = tv.PDate 
	and  tview.Planet = tv.Planet

	Update tbl_HousePosition
	set  MYSub = tview.hp
	from tbl_HousePosition tv
	inner join(
		Select xp.PDate, (ssp.Degree / 108000) + 1 as hp, xp.Planet
		from tbl_Planet xp
		inner join tbl_Planet sp
		on sp.PDate = xp.PDate 
		and xp.Sub = sp.Planet
		inner join tbl_Planet ssp
		on ssp.PDate = xp.PDate 
		and sp.Star = ssp.Planet
		where xp.Planet in(3, 4, 7)) as tview
	on tview.PDate = tv.PDate 
	and  tview.Planet = tv.Planet
	
--	truncate table  tbl_HousePosition
-- [load_HousePosition]
Select convert(varchar(5),xp.PDate,104) as Date, 
	case 
		when xp.Planet = 3 then 'Sun'
		when xp.Planet = 4 then 'Moo'
		when xp.Planet = 7 then 'Jup'
	end as Planet, 
	case 
		when replace(xp.KP % 4,0,4) = 1 then 'Fire' 
		when replace(xp.KP % 4,0,4) = 2 then 'Earth' 
		when replace(xp.KP % 4,0,4) = 3 then 'Air' 
		when replace(xp.KP % 4,0,4) = 4 then 'Water' 
	end as KP, 
	case 
		when replace(xp.MX % 4,0,4) = 1 then 'Fire' 
		when replace(xp.MX % 4,0,4) = 2 then 'Earth' 
		when replace(xp.MX % 4,0,4) = 3 then 'Air' 
		when replace(xp.MX % 4,0,4) = 4 then 'Water' 
	end as MX,  
	case 
		when replace(xp.MY % 4,0,4) = 1 then 'Fire' 
		when replace(xp.MY % 4,0,4) = 2 then 'Earth' 
		when replace(xp.MY % 4,0,4) = 3 then 'Air' 
		when replace(xp.MY % 4,0,4) = 4 then 'Water' 
	end as MY,  
	case 
		when replace(xp.MXSub % 4,0,4) = 1 then 'Fire' 
		when replace(xp.MXSub % 4,0,4) = 2 then 'Earth' 
		when replace(xp.MXSub % 4,0,4) = 3 then 'Air' 
		when replace(xp.MXSub % 4,0,4) = 4 then 'Water' 
	end as Sub, 
	case 
		when replace(xp.MYSub % 4,0,4) = 1 then 'Fire' 
		when replace(xp.MYSub % 4,0,4) = 2 then 'Earth' 
		when replace(xp.MYSub % 4,0,4) = 3 then 'Air' 
		when replace(xp.MYSub % 4,0,4) = 4 then 'Water' 
	end as StarofSub
	from tbl_HousePosition xp
where year(xp.PDate) = 2018 and month(xp.PDate) = 7
order by 1 desc
end

GO

