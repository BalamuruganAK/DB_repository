CREATE proc [dbo].[load_Work_SunSub]
as
begin
	
	create table #date(PDate smalldatetime)
	
	insert into #date 
	Select distinct p.PDate from tbl_Planet p
	 Where p.Planet = 3
	 and p.PDate not in (Select PDate from tbl_Work Where KeyPlanet = 30)
		
		
	Insert into tbl_Work (PDate,KeyPlanet,DayLord) 
	Select PDate, 30 as KeyPlanet,
	case 
		when Datepart(Weekday, PDate) = 1 then 3
		when Datepart(Weekday, PDate) = 2 then 4
		when Datepart(Weekday, PDate) = 3 then 5
		when Datepart(Weekday, PDate) = 4 then 9
		when Datepart(Weekday, PDate) = 5 then 7
		when Datepart(Weekday, PDate) = 6 then 2
		when Datepart(Weekday, PDate) = 7 then 8
	end as DayLord
	from #date

	Update tbl_Work
	set XPlanet = p.Sub 
	From tbl_Work w
	inner join tbl_Planet p
	on p.Planet = 3
	and p.PDate = w.PDate
	and w.PDate in (Select PDate from #date)
	and w.KeyPlanet = 30

	Update tbl_Work
	set YPlanet = p.Star
	From tbl_Work w
	inner join tbl_Planet p
	on p.Planet = w.XPlanet
	and p.PDate = w.PDate
	and w.PDate in (Select PDate from #date)
	and w.KeyPlanet = 30
	
	Update tbl_Work
	set XPosition = 
			case when px.Degree >= p.Degree then
				((px.Degree - p.Degree) / 108000) + 1
			else
				((1296000 + px.Degree - p.Degree) / 108000) + 1
			end 
	From tbl_Work w
	inner join tbl_Planet p
	on p.Planet = 3
	and p.PDate = w.PDate	
	inner join tbl_Planet px
	on px.Planet = w.XPlanet
	and px.PDate = w.PDate
	where w.PDate in (Select PDate from #date)
	and w.KeyPlanet = 30
	
	Update tbl_Work
	set YPosition = 
			case when py.Degree >= p.Degree then
				((py.Degree - p.Degree) / 108000) + 1
			else
				((1296000 + py.Degree - p.Degree) / 108000) + 1
			end 
	From tbl_Work w
	inner join tbl_Planet p
	on p.Planet = 3
	and p.PDate = w.PDate	
	inner join tbl_Planet py
	on py.Planet = w.YPlanet
	and py.PDate = w.PDate
	where w.PDate in (Select PDate from #date)
	and w.KeyPlanet = 30

--- Begin X1,2,3,4
	Update tbl_Work 
	set X1Planet = x1p.Planet, X1Position = x1p.Position
	from
		(Select op.Planet, outw.PDate, --MinDegree, MinKPDegree,
		case when MinKPDegree > MinDegree
			then ((MinKPDegree - MinDegree) / 108000) + 1
			else ((1296000 + MinKPDegree - MinDegree) / 108000) + 1 end as Position,
			KeyPlanet
		From tbl_Planet op
		inner join 
		(Select
			w.PDate, min(case when kp.Degree > xp.Degree then
				xp.Degree + 1296000
			else xp.Degree
			end ) as MinDegree,
			min(kp.Degree) MinKPDegree,
			MIN(w.KeyPlanet) KeyPlanet,
			min(case when kp.Degree > xp.Degree then 1 else 0 end ) as Flag,
			min(xp.Degree) xpDegree
		From tbl_Work w
		inner join tbl_Planet xp
		on xp.Star = w.XPlanet
		and w.KeyPlanet = 30
		and xp.Planet <> 3
		and xp.Planet not in (10,11,12)
		and xp.PDate = w.PDate
		inner join tbl_Planet kp
		on kp.Planet = 3
		and kp.PDate = w.PDate
		where w.PDate in (Select PDate from #date)
		group by w.PDate) outw
		on outw.PDate = op.PDate
		and (( outw.MinDegree = op.Degree and Flag = 0) OR ( outw.xpDegree = op.Degree and Flag = 1)))as x1p
	inner join tbl_Work w1
	on w1.PDate = x1p.PDate
	and w1.KeyPlanet = x1p.KeyPlanet
	
	Update tbl_Work 
	set X2Planet = x1p.Planet, X2Position = x1p.Position
	from
		(Select op.Planet, outw.PDate, --MinDegree, MinKPDegree,
		case when MinKPDegree > MinDegree
			then ((MinKPDegree - MinDegree) / 108000) + 1
			else ((1296000 + MinKPDegree - MinDegree) / 108000) + 1 end as Position,
			KeyPlanet
		From tbl_Planet op
		inner join 
		(Select
			w.PDate, min(case when kp.Degree > xp.Degree then
				xp.Degree + 1296000
			else xp.Degree
			end ) as MinDegree,
			min(kp.Degree) MinKPDegree,
			MIN(w.KeyPlanet) KeyPlanet,
			min(case when kp.Degree > xp.Degree then 1 else 0 end ) as Flag,
			min(xp.Degree) xpDegree
		From tbl_Work w
		inner join tbl_Planet xp
		on xp.Star = w.XPlanet
		and w.KeyPlanet = 30
		and xp.Planet <> 3
		and xp.Planet <> w.X1Planet
		and xp.Planet not in (10,11,12)
		and xp.PDate = w.PDate
		inner join tbl_Planet kp
		on kp.Planet = 3
		and kp.PDate = w.PDate
		where w.PDate in (Select PDate from #date)
		group by w.PDate) outw
		on outw.PDate = op.PDate
		and (( outw.MinDegree = op.Degree and Flag = 0) OR ( outw.xpDegree = op.Degree and Flag = 1)))as x1p
	inner join tbl_Work w1
	on w1.PDate = x1p.PDate
	and w1.KeyPlanet = x1p.KeyPlanet
	
	Update tbl_Work 
	set X3Planet = x1p.Planet, X3Position = x1p.Position
	from
		(Select op.Planet, outw.PDate, --MinDegree, MinKPDegree,
		case when MinKPDegree > MinDegree
			then ((MinKPDegree - MinDegree) / 108000) + 1
			else ((1296000 + MinKPDegree - MinDegree) / 108000) + 1 end as Position,
			KeyPlanet
		From tbl_Planet op
		inner join 
		(Select
			w.PDate, min(case when kp.Degree > xp.Degree then
				xp.Degree + 1296000
			else xp.Degree
			end ) as MinDegree,
			min(kp.Degree) MinKPDegree,
			MIN(w.KeyPlanet) KeyPlanet,
			min(case when kp.Degree > xp.Degree then 1 else 0 end ) as Flag,
			min(xp.Degree) xpDegree
		From tbl_Work w
		inner join tbl_Planet xp
		on xp.Star = w.XPlanet
		and w.KeyPlanet = 30
		and xp.Planet <> 3
		and xp.Planet <> w.X1Planet
		and xp.Planet <> w.X2Planet
		and xp.Planet not in (10,11,12)
		and xp.PDate = w.PDate
		inner join tbl_Planet kp
		on kp.Planet = 3
		and kp.PDate = w.PDate
		where w.PDate in (Select PDate from #date)
		group by w.PDate) outw
		on outw.PDate = op.PDate
		and (( outw.MinDegree = op.Degree and Flag = 0) OR ( outw.xpDegree = op.Degree and Flag = 1)))as x1p
	inner join tbl_Work w1
	on w1.PDate = x1p.PDate
	and w1.KeyPlanet = x1p.KeyPlanet

	Update tbl_Work 
	set X4Planet = x1p.Planet, X4Position = x1p.Position
	from
		(Select op.Planet, outw.PDate, --MinDegree, MinKPDegree,
		case when MinKPDegree > MinDegree
			then ((MinKPDegree - MinDegree) / 108000) + 1
			else ((1296000 + MinKPDegree - MinDegree) / 108000) + 1 end as Position,
			KeyPlanet
		From tbl_Planet op
		inner join 
		(Select
			w.PDate, min(case when kp.Degree > xp.Degree then
				xp.Degree + 1296000
			else xp.Degree
			end ) as MinDegree,
			min(kp.Degree) MinKPDegree,
			MIN(w.KeyPlanet) KeyPlanet,
			min(case when kp.Degree > xp.Degree then 1 else 0 end ) as Flag,
			min(xp.Degree) xpDegree
		From tbl_Work w
		inner join tbl_Planet xp
		on xp.Star = w.XPlanet
		and w.KeyPlanet = 30
		and xp.Planet <> 3
		and xp.Planet <> w.X1Planet
		and xp.Planet <> w.X2Planet
		and xp.Planet <> w.X3Planet
		and xp.Planet not in (10,11,12)
		and xp.PDate = w.PDate
		inner join tbl_Planet kp
		on kp.Planet = 3
		and kp.PDate = w.PDate
		where w.PDate in (Select PDate from #date)
		group by w.PDate) outw
		on outw.PDate = op.PDate
		and (( outw.MinDegree = op.Degree and Flag = 0) OR ( outw.xpDegree = op.Degree and Flag = 1)))as x1p
	inner join tbl_Work w1
	on w1.PDate = x1p.PDate
	and w1.KeyPlanet = x1p.KeyPlanet
--- End X1,2,3,4

--- Begin Y1,2,3,4
	Update tbl_Work 
	set Y1Planet = x1p.Planet, Y1Position = x1p.Position
	from
		(Select op.Planet, outw.PDate, --MinDegree, MinKPDegree,
		case when MinKPDegree > MinDegree
			then ((MinKPDegree - MinDegree) / 108000) + 1
			else ((1296000 + MinKPDegree - MinDegree) / 108000) + 1 end as Position,
			KeyPlanet
		From tbl_Planet op
		inner join 
		(Select
			w.PDate, min(case when kp.Degree > xp.Degree then
				xp.Degree + 1296000
			else xp.Degree
			end ) as MinDegree,
			min(kp.Degree) MinKPDegree,
			MIN(w.KeyPlanet) KeyPlanet,
			min(case when kp.Degree > xp.Degree then 1 else 0 end ) as Flag,
			min(xp.Degree) xpDegree
		From tbl_Work w
		inner join tbl_Planet xp
		on xp.Star = w.YPlanet
		and w.KeyPlanet = 30
		and xp.Planet <> 3
		and xp.Planet <> w.YPlanet
		and xp.Planet <> w.XPlanet
		and xp.Planet not in (10,11,12)
		and xp.PDate = w.PDate
		inner join tbl_Planet kp
		on kp.Planet = 3
		and kp.PDate = w.PDate
		where w.PDate in (Select PDate from #date)
		group by w.PDate) outw
		on outw.PDate = op.PDate
		and (( outw.MinDegree = op.Degree and Flag = 0) OR ( outw.xpDegree = op.Degree and Flag = 1)))as x1p
	inner join tbl_Work w1
	on w1.PDate = x1p.PDate
	and w1.KeyPlanet = x1p.KeyPlanet
	
	Update tbl_Work 
	set Y2Planet = x1p.Planet, Y2Position = x1p.Position
	from
		(Select op.Planet, outw.PDate, --MinDegree, MinKPDegree,
		case when MinKPDegree > MinDegree
			then ((MinKPDegree - MinDegree) / 108000) + 1
			else ((1296000 + MinKPDegree - MinDegree) / 108000) + 1 end as Position,
			KeyPlanet
		From tbl_Planet op
		inner join 
		(Select
			w.PDate, min(case when kp.Degree > xp.Degree then
				xp.Degree + 1296000
			else xp.Degree
			end ) as MinDegree,
			min(kp.Degree) MinKPDegree,
			MIN(w.KeyPlanet) KeyPlanet,
			min(case when kp.Degree > xp.Degree then 1 else 0 end ) as Flag,
			min(xp.Degree) xpDegree
		From tbl_Work w
		inner join tbl_Planet xp
		on xp.Star = w.YPlanet
		and w.KeyPlanet = 30
		and xp.Planet <> 3
		and xp.Planet <> w.YPlanet
		and xp.Planet <> w.XPlanet
		and xp.Planet <> w.Y1Planet
		and xp.Planet not in (10,11,12)
		and xp.PDate = w.PDate
		inner join tbl_Planet kp
		on kp.Planet = 3
		and kp.PDate = w.PDate
		where w.PDate in (Select PDate from #date)
		group by w.PDate) outw
		on outw.PDate = op.PDate
		and (( outw.MinDegree = op.Degree and Flag = 0) OR ( outw.xpDegree = op.Degree and Flag = 1)))as x1p
	inner join tbl_Work w1
	on w1.PDate = x1p.PDate
	and w1.KeyPlanet = x1p.KeyPlanet
	
	Update tbl_Work 
	set Y3Planet = x1p.Planet, Y3Position = x1p.Position
	from
		(Select op.Planet, outw.PDate, --MinDegree, MinKPDegree,
		case when MinKPDegree > MinDegree
			then ((MinKPDegree - MinDegree) / 108000) + 1
			else ((1296000 + MinKPDegree - MinDegree) / 108000) + 1 end as Position,
			KeyPlanet
		From tbl_Planet op
		inner join 
		(Select
			w.PDate, min(case when kp.Degree > xp.Degree then
				xp.Degree + 1296000
			else xp.Degree
			end ) as MinDegree,
			min(kp.Degree) MinKPDegree,
			MIN(w.KeyPlanet) KeyPlanet,
			min(case when kp.Degree > xp.Degree then 1 else 0 end ) as Flag,
			min(xp.Degree) xpDegree
		From tbl_Work w
		inner join tbl_Planet xp
		on xp.Star = w.YPlanet
		and w.KeyPlanet = 30
		and xp.Planet <> 3
		and xp.Planet <> w.YPlanet
		and xp.Planet <> w.XPlanet
		and xp.Planet <> w.Y1Planet
		and xp.Planet <> w.Y2Planet
		and xp.Planet not in (10,11,12)
		and xp.PDate = w.PDate
		inner join tbl_Planet kp
		on kp.Planet = 3
		and kp.PDate = w.PDate
		where w.PDate in (Select PDate from #date)
		group by w.PDate) outw
		on outw.PDate = op.PDate
		and (( outw.MinDegree = op.Degree and Flag = 0) OR ( outw.xpDegree = op.Degree and Flag = 1)))as x1p
	inner join tbl_Work w1
	on w1.PDate = x1p.PDate
	and w1.KeyPlanet = x1p.KeyPlanet

	Update tbl_Work 
	set Y4Planet = x1p.Planet, Y4Position = x1p.Position
	from
		(Select op.Planet, outw.PDate, --MinDegree, MinKPDegree,
		case when MinKPDegree > MinDegree
			then ((MinKPDegree - MinDegree) / 108000) + 1
			else ((1296000 + MinKPDegree - MinDegree) / 108000) + 1 end as Position,
			KeyPlanet
		From tbl_Planet op
		inner join 
		(Select
			w.PDate, min(case when kp.Degree > xp.Degree then
				xp.Degree + 1296000
			else xp.Degree
			end ) as MinDegree,
			min(kp.Degree) MinKPDegree,
			MIN(w.KeyPlanet) KeyPlanet,
			min(case when kp.Degree > xp.Degree then 1 else 0 end ) as Flag,
			min(xp.Degree) xpDegree
		From tbl_Work w
		inner join tbl_Planet xp
		on xp.Star = w.YPlanet
		and w.KeyPlanet = 30
		and xp.Planet <> 3
		and xp.Planet <> w.YPlanet
		and xp.Planet <> w.XPlanet
		and xp.Planet <> w.Y1Planet
		and xp.Planet <> w.Y2Planet
		and xp.Planet <> w.Y3Planet
		and xp.Planet not in (10,11,12)
		and xp.PDate = w.PDate
		inner join tbl_Planet kp
		on kp.Planet = 3
		and kp.PDate = w.PDate
		where w.PDate in (Select PDate from #date)
		group by w.PDate) outw
		on outw.PDate = op.PDate
		and (( outw.MinDegree = op.Degree and Flag = 0) OR ( outw.xpDegree = op.Degree and Flag = 1)))as x1p
	inner join tbl_Work w1
	on w1.PDate = x1p.PDate
	and w1.KeyPlanet = x1p.KeyPlanet
	----- Y1,2,3,4 end
	

end

GO

