CREATE proc [dbo].[load_FinalTrent]
as
begin
	
	create table #date(PDate smalldatetime)
	
	insert into #date 
	Select distinct PDate from tbl_Work
		Where PDate not in (Select PDate from tbl_FinalTrent)
		
	Insert into tbl_FinalTrent (PDate,KeyPlanet) 
	Select PDate, 4 as KeyPlanet from #date

	Insert into tbl_FinalTrent (PDate,KeyPlanet) 
	Select PDate, 3 as KeyPlanet from #date

	Insert into tbl_FinalTrent (PDate,KeyPlanet) 
	Select PDate, 7 as KeyPlanet from #date
	
----Begin X Y Trend
	Update tbl_FinalTrent
	set XTrent = p.XYTrent
	From tbl_FinalTrent f
	inner join tbl_Work w
	on f.PDate = w.PDate
	and f.KeyPlanet = w.KeyPlanet
	inner join tbl_Volume v
	on v.Planet = w.XPlanet
	inner join tbl_Planet pt
	on pt.PDate = f.PDate
	and pt.Planet = w.XPlanet
	and v.Retro = 0 --pt.Retro
	inner join tbl_Trent t
	on t.Position = w.XPosition
	inner join tbl_XYTrent p
	on p.Nature = v.Nature
	and p.Trent = t.Trent
	and p.Retro = pt.Retro
	and w.PDate in (Select PDate from #date)

	Update tbl_FinalTrent
	set YTrent = p.XYTrent
	From tbl_FinalTrent f
	inner join tbl_Work w
	on f.PDate = w.PDate
	and f.KeyPlanet = w.KeyPlanet
	inner join tbl_Volume v
	on v.Planet = w.YPlanet
	inner join tbl_Planet pt
	on pt.PDate = f.PDate
	and pt.Planet = w.YPlanet
	and v.Retro = 0 --pt.Retro
	inner join tbl_Trent t
	on t.Position = w.YPosition
	inner join tbl_XYTrent p
	on p.Nature = v.Nature
	and p.Trent = t.Trent
	and p.Retro = pt.Retro
	and w.PDate in (Select PDate from #date)
---- End X Y Trent

----Begin X1 Y1 Trend
	Update tbl_FinalTrent
	set X1Trent = p.XYTrent
	From tbl_FinalTrent f
	inner join tbl_Work w
	on f.PDate = w.PDate
	and f.KeyPlanet = w.KeyPlanet
	inner join tbl_Volume v
	on v.Planet = w.X1Planet
	inner join tbl_Planet pt
	on pt.PDate = f.PDate
	and pt.Planet = w.X1Planet
	and v.Retro = 0 --pt.Retro
	inner join tbl_Trent t
	on t.Position = w.X1Position
	inner join tbl_XYTrent p
	on p.Nature = v.Nature
	and p.Trent = t.Trent
	and p.Retro = pt.Retro
	and w.PDate in (Select PDate from #date)

	Update tbl_FinalTrent
	set Y1Trent = p.XYTrent
	From tbl_FinalTrent f
	inner join tbl_Work w
	on f.PDate = w.PDate
	and f.KeyPlanet = w.KeyPlanet
	inner join tbl_Volume v
	on v.Planet = w.Y1Planet
	inner join tbl_Planet pt
	on pt.PDate = f.PDate
	and pt.Planet = w.Y1Planet
	and v.Retro = 0 --pt.Retro
	inner join tbl_Trent t
	on t.Position = w.Y1Position
	inner join tbl_XYTrent p
	on p.Nature = v.Nature
	and p.Trent = t.Trent
	and p.Retro = pt.Retro
	and w.PDate in (Select PDate from #date)
---- End X1 Y1 Trent

----Begin X2 Y2 Trend
	Update tbl_FinalTrent
	set X2Trent = p.XYTrent
	From tbl_FinalTrent f
	inner join tbl_Work w
	on f.PDate = w.PDate
	and f.KeyPlanet = w.KeyPlanet
	inner join tbl_Volume v
	on v.Planet = w.X2Planet
	inner join tbl_Planet pt
	on pt.PDate = f.PDate
	and pt.Planet = w.X2Planet
	and v.Retro = 0 --pt.Retro
	inner join tbl_Trent t
	on t.Position = w.X2Position
	inner join tbl_XYTrent p
	on p.Nature = v.Nature
	and p.Trent = t.Trent
	and p.Retro = pt.Retro
	and w.PDate in (Select PDate from #date)

	Update tbl_FinalTrent
	set Y2Trent = p.XYTrent
	From tbl_FinalTrent f
	inner join tbl_Work w
	on f.PDate = w.PDate
	and f.KeyPlanet = w.KeyPlanet
	inner join tbl_Volume v
	on v.Planet = w.Y2Planet
	inner join tbl_Planet pt
	on pt.PDate = f.PDate
	and pt.Planet = w.Y2Planet
	and v.Retro = 0 --pt.Retro
	inner join tbl_Trent t
	on t.Position = w.Y2Position
	inner join tbl_XYTrent p
	on p.Nature = v.Nature
	and p.Trent = t.Trent
	and p.Retro = pt.Retro
	and w.PDate in (Select PDate from #date)
---- End X2 Y2 Trent


	Update tbl_FinalTrent
	set DayLordTrent = 1
	From tbl_FinalTrent f
	inner join tbl_Work w
	on f.PDate = w.PDate
	and f.KeyPlanet = w.KeyPlanet
	and w.DayLord in ( w.XPlanet, w.YPlanet)
	and w.PDate in (Select PDate from #date)

	Update tbl_FinalTrent
	set MoonTrent = 2
	From tbl_FinalTrent f
	inner join tbl_Work w
	on f.PDate = w.PDate
	and f.KeyPlanet = w.KeyPlanet
	and w.KeyPlanet = w.YPlanet
	and w.PDate in (Select PDate from #date)

	Update tbl_FinalTrent
	set MoonTrent = 1
	From tbl_FinalTrent f
	inner join tbl_Work w
	on f.PDate = w.PDate
	and f.KeyPlanet = w.KeyPlanet
	and w.KeyPlanet = w.XPlanet
	and w.PDate in (Select PDate from #date)

	Update tbl_FinalTrent
	set ExchangeTrent = 1
	From tbl_FinalTrent f
	inner join tbl_Work w
	on f.PDate = w.PDate
	and f.KeyPlanet = w.KeyPlanet
	inner join tbl_Planet xp
	on xp.PDate = w.PDate
	and xp.Planet = w.XPlanet
	and xp.Star = w.YPlanet
	inner join tbl_Planet yp
	on yp.PDate = w.PDate
	and yp.Planet = w.YPlanet
	and yp.Star = w.XPlanet
	and w.PDate in (Select PDate from #date)
	
	----Begin X Y Trend tbl_Conjuction
	Update tbl_FinalTrent
	set CXTrent = p.XYTrent
	From tbl_FinalTrent f
	inner join tbl_Conjuction w
	on f.PDate = w.PDate
	and f.KeyPlanet = w.KeyPlanet
	inner join tbl_Volume v
	on v.Planet = w.XPlanet
	inner join tbl_Planet pt
	on pt.PDate = f.PDate
	and pt.Planet = w.XPlanet
	and v.Retro = 0 --pt.Retro
	inner join tbl_Trent t
	on t.Position = w.XPosition
	inner join tbl_XYTrent p
	on p.Nature = v.Nature
	and p.Trent = t.Trent
	and p.Retro = pt.Retro
	and w.PDate in (Select PDate from #date)

	Update tbl_FinalTrent
	set CYTrent = p.XYTrent
	From tbl_FinalTrent f
	inner join tbl_Conjuction w
	on f.PDate = w.PDate
	and f.KeyPlanet = w.KeyPlanet
	inner join tbl_Volume v
	on v.Planet = w.YPlanet
	inner join tbl_Planet pt
	on pt.PDate = f.PDate
	and pt.Planet = w.YPlanet
	and v.Retro = 0 --pt.Retro
	inner join tbl_Trent t
	on t.Position = w.YPosition
	inner join tbl_XYTrent p
	on p.Nature = v.Nature
	and p.Trent = t.Trent
	and p.Retro = pt.Retro
	and w.PDate in (Select PDate from #date)
---- End X Y Trent

----Begin X1 Y1 Trend
	Update tbl_FinalTrent
	set CX1Trent = p.XYTrent
	From tbl_FinalTrent f
	inner join tbl_Conjuction w
	on f.PDate = w.PDate
	and f.KeyPlanet = w.KeyPlanet
	inner join tbl_Volume v
	on v.Planet = w.X1Planet
	inner join tbl_Planet pt
	on pt.PDate = f.PDate
	and pt.Planet = w.X1Planet
	and v.Retro = 0 --pt.Retro
	inner join tbl_Trent t
	on t.Position = w.X1Position
	inner join tbl_XYTrent p
	on p.Nature = v.Nature
	and p.Trent = t.Trent
	and p.Retro = pt.Retro
	and w.PDate in (Select PDate from #date)

	Update tbl_FinalTrent
	set CY1Trent = p.XYTrent
	From tbl_FinalTrent f
	inner join tbl_Conjuction w
	on f.PDate = w.PDate
	and f.KeyPlanet = w.KeyPlanet
	inner join tbl_Volume v
	on v.Planet = w.Y1Planet
	inner join tbl_Planet pt
	on pt.PDate = f.PDate
	and pt.Planet = w.Y1Planet
	and v.Retro = 0 --pt.Retro
	inner join tbl_Trent t
	on t.Position = w.Y1Position
	inner join tbl_XYTrent p
	on p.Nature = v.Nature
	and p.Trent = t.Trent
	and p.Retro = pt.Retro
	and w.PDate in (Select PDate from #date)
---- End X1 Y1 Trent

----Begin X2 Y2 Trend
	Update tbl_FinalTrent
	set CX2Trent = p.XYTrent
	From tbl_FinalTrent f
	inner join tbl_Conjuction w
	on f.PDate = w.PDate
	and f.KeyPlanet = w.KeyPlanet
	inner join tbl_Volume v
	on v.Planet = w.X2Planet
	inner join tbl_Planet pt
	on pt.PDate = f.PDate
	and pt.Planet = w.X2Planet
	and v.Retro = 0 --pt.Retro
	inner join tbl_Trent t
	on t.Position = w.X2Position
	inner join tbl_XYTrent p
	on p.Nature = v.Nature
	and p.Trent = t.Trent
	and p.Retro = pt.Retro
	and w.PDate in (Select PDate from #date)

	Update tbl_FinalTrent
	set CY2Trent = p.XYTrent
	From tbl_FinalTrent f
	inner join tbl_Conjuction w
	on f.PDate = w.PDate
	and f.KeyPlanet = w.KeyPlanet
	inner join tbl_Volume v
	on v.Planet = w.Y2Planet
	inner join tbl_Planet pt
	on pt.PDate = f.PDate
	and pt.Planet = w.Y2Planet
	and v.Retro = 0 --pt.Retro
	inner join tbl_Trent t
	on t.Position = w.Y2Position
	inner join tbl_XYTrent p
	on p.Nature = v.Nature
	and p.Trent = t.Trent
	and p.Retro = pt.Retro
	and w.PDate in (Select PDate from #date)
---- End X2 Y2 Trent tbl_Conjuction

--Begin Gap1
	Update f
	set f.Gap1 = 
		case when(
			case when px.Degree >= p.Degree then
				((px.Degree - p.Degree) / 12000) + 1
			else
				((48000 + px.Degree - p.Degree) / 12000) + 1
			end) in (1,3,6,10,11) then 1
			when(
			case when px.Degree >= p.Degree then
				((px.Degree - p.Degree) / 12000) + 1
			else
				((48000 + px.Degree - p.Degree) / 12000) + 1
			end) in (5,8,12) then 2
			when(
			case when px.Degree >= p.Degree then
				((px.Degree - p.Degree) / 12000) + 1
			else
				((48000 + px.Degree - p.Degree) / 12000) + 1
			end) in (4,7) then 3
			when(
			case when px.Degree >= p.Degree then
				((px.Degree - p.Degree) / 12000) + 1
			else
				((48000 + px.Degree - p.Degree) / 12000) + 1
			end) in (2,9) then 4
			end			
	From tbl_FinalTrent f
	inner join tbl_Planet pt
	on pt.PDate = f.PDate
	and pt.Planet = f.KeyPlanet
	and f.KeyPlanet  = 4
	inner join tbl_Planet ppt
	on ppt.PDate = dateadd(dd,-1,f.PDate)
	and ppt.Planet = f.KeyPlanet
	and ppt.Star = pt.Sub
	inner join tbl_Planet p
	on p.Planet = f.KeyPlanet
	and p.PDate = f.PDate
	inner join tbl_Planet px
	on px.Planet = pt.Sub
	and px.PDate = f.PDate
	
	and f.PDate in (Select PDate from #date)
--End Gap1

--Begin Gap2
	Update f
	set f.Gap2 = 
		case when(
			case when px.Degree >= p.Degree then
				((px.Degree - p.Degree) / 12000) + 1
			else
				((48000 + px.Degree - p.Degree) / 12000) + 1
			end) in (1,3,6,10,11) then 1
			when(
			case when px.Degree >= p.Degree then
				((px.Degree - p.Degree) / 12000) + 1
			else
				((48000 + px.Degree - p.Degree) / 12000) + 1
			end) in (5,8,12) then 2
			when(
			case when px.Degree >= p.Degree then
				((px.Degree - p.Degree) / 12000) + 1
			else
				((48000 + px.Degree - p.Degree) / 12000) + 1
			end) in (4,7) then 3
			when(
			case when px.Degree >= p.Degree then
				((px.Degree - p.Degree) / 12000) + 1
			else
				((48000 + px.Degree - p.Degree) / 12000) + 1
			end) in (2,9) then 4
			end			
	From tbl_FinalTrent f
	inner join tbl_Planet pt
	on pt.PDate = f.PDate
	and pt.Planet = f.KeyPlanet
	and f.KeyPlanet  = 4
	inner join tbl_Planet p
	on p.Planet = f.KeyPlanet
	and p.PDate = f.PDate
	inner join tbl_Planet px
	on px.Planet = pt.Sub
	and px.PDate = f.PDate
	and f.PDate in (Select PDate from #date)
--End Gap2
end

GO

