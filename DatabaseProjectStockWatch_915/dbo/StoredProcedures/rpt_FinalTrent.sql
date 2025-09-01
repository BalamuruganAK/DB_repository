CREATE proc [dbo].[rpt_FinalTrent]
as
begin
	
	create table #dateNoMoon(PDate smalldatetime)
	insert into #dateNoMoon 
	Select distinct m.PDate from tbl_Planet m
		inner join tbl_Planet s
		on m.PDate = s.PDate
		and m.Planet = 4
		and s.Planet = 3
		and m.Degree between s.Degree - 132000 and s.Degree + 132000
		and m.Star = s.Star
		
	--Select * from  #dateNoMoon
	create table #dateOHLC(PDate smalldatetime)
	insert into #dateOHLC
	Select h1.d as PDate from tbl_SummaryOHLC h1
	where ocgain > 10 and n = 'Nifty50'
	
	Select convert(varchar(10),f.PDate,11) as 'Date', f.KeyPlanet as 'K', 
		x.Symbol x,  y.Symbol y,
		isnull(convert(varchar(1),f.MoonTrent),'') as 'MR', 
		isnull(convert(varchar(1),f.DayLordTrent),'') as 'DR', 
		isnull(convert(varchar(1),f.ExchangeTrent),'') as 'ER',
		isnull(x1.Symbol,'') x1, 
		isnull(x2.Symbol,'') x2, 
		isnull(y1.Symbol,'') y1,  
		isnull(y2.Symbol,'') y2,
		isnull(cx.Symbol,'') cx, 
		isnull(cY.Symbol,'') cY,	
		isnull(cx1.Symbol,'') cx1, 
		isnull(cx2.Symbol,'') cx2, 
		isnull(cy1.Symbol,'') cy1,  
		isnull(cy2.Symbol,'') cy2, f.gap1,f.gap2,
		h1.gap, h1.chgain, h1.ccgain, h1.clgain,
		h1.ohgain, h1.ocgain, h1.olgain, h1.avg
	from 
		tbl_FinalTrent f	
	inner join tbl_XYTrent x
	on f.XTrent = x.XYTrent
	inner join tbl_XYTrent y
	on f.YTrent = y.XYTrent
	Left outer join tbl_XYTrent x1
	on f.X1Trent = x1.XYTrent
	Left outer join tbl_XYTrent y1
	on f.Y1Trent = y1.XYTrent
	Left outer join tbl_XYTrent x2
	on f.X2Trent = x2.XYTrent
	Left outer join tbl_XYTrent y2
	on f.Y2Trent = y2.XYTrent
	Left outer join tbl_XYTrent cx
	on f.CXTrent = cx.XYTrent
	Left outer join tbl_XYTrent cy
	on f.CYTrent = cy.XYTrent
	Left outer join tbl_XYTrent cx1
	on f.CX1Trent = cx1.XYTrent
	Left outer join tbl_XYTrent cy1
	on f.CY1Trent = cy1.XYTrent
	Left outer join tbl_XYTrent cx2
	on f.CX2Trent = cx2.XYTrent
	Left outer join tbl_XYTrent cy2
	on f.CY2Trent = cy2.XYTrent
	Left outer join tbl_SummaryOHLC h1
	on h1.d = f.PDate
	where datepart(weekday,f.PDate) not in (1,7)
	and f.PDate <= GETDATE()
	and f.KeyPlanet = 4
--	and f.PDate in (Select nm.PDate From #dateNoMoon nm)
--	and f.PDate in (Select nm.PDate From #dateOHLC nm)
	order by 2 ,1 desc

	Select convert(varchar(10),f.PDate,11) as 'Date', f.KeyPlanet as 'K', 
		x.Symbol x,  y.Symbol y,
		isnull(convert(varchar(1),f.MoonTrent),'') as 'MR', 
		isnull(convert(varchar(1),f.DayLordTrent),'') as 'DR', 
		isnull(convert(varchar(1),f.ExchangeTrent),'') as 'ER',
		isnull(x1.Symbol,'') x1, 
		isnull(x2.Symbol,'') x2, 
		isnull(y1.Symbol,'') y1,  
		isnull(y2.Symbol,'') y2,
		isnull(cx.Symbol,'') cx, 
		isnull(cY.Symbol,'') cY,	
		isnull(cx1.Symbol,'') cx1, 
		isnull(cx2.Symbol,'') cx2, 
		isnull(cy1.Symbol,'') cy1,  
		isnull(cy2.Symbol,'') cy2, f.gap1,f.gap2,
		h1.gap, h1.chgain, h1.ccgain, h1.clgain,
		h1.ohgain, h1.ocgain, h1.olgain, h1.avg
	from 
		tbl_FinalTrent f	
	inner join tbl_XYTrent x
	on f.XTrent = x.XYTrent
	inner join tbl_XYTrent y
	on f.YTrent = y.XYTrent
	Left outer join tbl_XYTrent x1
	on f.X1Trent = x1.XYTrent
	Left outer join tbl_XYTrent y1
	on f.Y1Trent = y1.XYTrent
	Left outer join tbl_XYTrent x2
	on f.X2Trent = x2.XYTrent
	Left outer join tbl_XYTrent y2
	on f.Y2Trent = y2.XYTrent
	Left outer join tbl_XYTrent cx
	on f.CXTrent = cx.XYTrent
	Left outer join tbl_XYTrent cy
	on f.CYTrent = cy.XYTrent
	Left outer join tbl_XYTrent cx1
	on f.CX1Trent = cx1.XYTrent
	Left outer join tbl_XYTrent cy1
	on f.CY1Trent = cy1.XYTrent
	Left outer join tbl_XYTrent cx2
	on f.CX2Trent = cx2.XYTrent
	Left outer join tbl_XYTrent cy2
	on f.CY2Trent = cy2.XYTrent
	Left outer join tbl_SummaryOHLC h1
	on h1.d = f.PDate
	where datepart(weekday,f.PDate) not in (1,7)
	and f.PDate > GETDATE()
	and f.KeyPlanet = 4
	order by 2 ,1 desc
	
	
		
	Select convert(varchar(10),f.PDate,11) as 'Date', f.KeyPlanet as 'K', 
		x.Symbol x,  y.Symbol y,
		isnull(convert(varchar(1),f.MoonTrent),'') as 'MR', 
		isnull(convert(varchar(1),f.DayLordTrent),'') as 'DR', 
		isnull(convert(varchar(1),f.ExchangeTrent),'') as 'ER',
		isnull(x1.Symbol,'') x1, 
		isnull(x2.Symbol,'') x2, 
		isnull(y1.Symbol,'') y1,  
		isnull(y2.Symbol,'') y2,
		isnull(cx.Symbol,'') cx, 
		isnull(cY.Symbol,'') cY,	
		isnull(cx1.Symbol,'') cx1, 
		isnull(cx2.Symbol,'') cx2, 
		isnull(cy1.Symbol,'') cy1,  
		isnull(cy2.Symbol,'') cy2, f.gap1,f.gap2,
		h1.gap, h1.chgain, h1.ccgain, h1.clgain,
		h1.ohgain, h1.ocgain, h1.olgain, h1.avg
	from 
		tbl_FinalTrent f	
	inner join tbl_XYTrent x
	on f.XTrent = x.XYTrent
	inner join tbl_XYTrent y
	on f.YTrent = y.XYTrent
	Left outer join tbl_XYTrent x1
	on f.X1Trent = x1.XYTrent
	Left outer join tbl_XYTrent y1
	on f.Y1Trent = y1.XYTrent
	Left outer join tbl_XYTrent x2
	on f.X2Trent = x2.XYTrent
	Left outer join tbl_XYTrent y2
	on f.Y2Trent = y2.XYTrent
	Left outer join tbl_XYTrent cx
	on f.CXTrent = cx.XYTrent
	Left outer join tbl_XYTrent cy
	on f.CYTrent = cy.XYTrent
	Left outer join tbl_XYTrent cx1
	on f.CX1Trent = cx1.XYTrent
	Left outer join tbl_XYTrent cy1
	on f.CY1Trent = cy1.XYTrent
	Left outer join tbl_XYTrent cx2
	on f.CX2Trent = cx2.XYTrent
	Left outer join tbl_XYTrent cy2
	on f.CY2Trent = cy2.XYTrent
	Left outer join tbl_SummaryOHLC h1
	on h1.d = f.PDate
--	where datepart(weekday,f.PDate) not in (1,7)
	where f.PDate <= GETDATE()
	and f.KeyPlanet in (3,7)
	order by 1 desc

	Select convert(varchar(10),f.PDate,11) as 'Date', f.KeyPlanet as 'K', 
		x.Symbol x,  y.Symbol y,
		isnull(convert(varchar(1),f.MoonTrent),'') as 'MR', 
		isnull(convert(varchar(1),f.DayLordTrent),'') as 'DR', 
		isnull(convert(varchar(1),f.ExchangeTrent),'') as 'ER',
		isnull(x1.Symbol,'') x1, 
		isnull(x2.Symbol,'') x2, 
		isnull(y1.Symbol,'') y1,  
		isnull(y2.Symbol,'') y2,
		isnull(cx.Symbol,'') cx, 
		isnull(cY.Symbol,'') cY,	
		isnull(cx1.Symbol,'') cx1, 
		isnull(cx2.Symbol,'') cx2, 
		isnull(cy1.Symbol,'') cy1,  
		isnull(cy2.Symbol,'') cy2, f.gap1,f.gap2,
		h1.gap, h1.chgain, h1.ccgain, h1.clgain,
		h1.ohgain, h1.ocgain, h1.olgain, h1.avg
	from 
		tbl_FinalTrent f	
	inner join tbl_XYTrent x
	on f.XTrent = x.XYTrent
	inner join tbl_XYTrent y
	on f.YTrent = y.XYTrent
	Left outer join tbl_XYTrent x1
	on f.X1Trent = x1.XYTrent
	Left outer join tbl_XYTrent y1
	on f.Y1Trent = y1.XYTrent
	Left outer join tbl_XYTrent x2
	on f.X2Trent = x2.XYTrent
	Left outer join tbl_XYTrent y2
	on f.Y2Trent = y2.XYTrent
	Left outer join tbl_XYTrent cx
	on f.CXTrent = cx.XYTrent
	Left outer join tbl_XYTrent cy
	on f.CYTrent = cy.XYTrent
	Left outer join tbl_XYTrent cx1
	on f.CX1Trent = cx1.XYTrent
	Left outer join tbl_XYTrent cy1
	on f.CY1Trent = cy1.XYTrent
	Left outer join tbl_XYTrent cx2
	on f.CX2Trent = cx2.XYTrent
	Left outer join tbl_XYTrent cy2
	on f.CY2Trent = cy2.XYTrent
	Left outer join tbl_SummaryOHLC h1
	on h1.d = f.PDate
--	where datepart(weekday,f.PDate) not in (1,7)
	where f.PDate > GETDATE()
	and f.KeyPlanet in (3,7)
	order by 1 desc
	
end

GO

