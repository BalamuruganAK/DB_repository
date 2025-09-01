CREATE proc [dbo].[rpt_Correlation]
as
begin
/*
	create table #Date ( s int IDENTITY(1,1), d1 date, d2 date, xp varchar(10), yp varchar(10))

	Insert into #Date (d1)	
	Select 
		distinct(st.Date) as d1
	from tbl_HistoryEQ st
	order by 1
	
	Update dd2 
	set dd2.d2 = dd1.d1
	from #Date dd1
	inner join #Date dd2
	on dd2.s  = dd1.s 

	Update dd2 
	set  dd2.xp = pdx.PlanetShortDesc,-- + convert(varchar(2),w.XPosition),  
		dd2.yp = pdy.PlanetShortDesc + convert(varchar(2),w.YPosition)
	from #Date dd2
	inner join tbl_Work w
	on dd2.d1 =  convert(varchar(10),w.PDate,102)
	and w.KeyPlanet = 4 
	inner join tbl_PlanetDesc pdx
	on w.XPlanet = pdx.Planet 
	inner join tbl_PlanetDesc pdy
	on w.YPlanet = pdy.Planet 
	
	--Select * from #Date 
	
	
	insert into #Corr 
	Select  
		eq1.Symbol as s1, eq2.Symbol as s2,
		eq1.PCP as x, eq2.PCP as y,
		d.xp, d.yp 
	From #Date d
	inner join tbl_HistoryEQ eq1
	on d.d1 = eq1.Date 
	full outer join tbl_HistoryEQ eq2
	on d.d2 = eq2.Date 
*/	

	create table #Corr ( d1 smalldatetime, s1 varchar(50), s2 varchar(50), x float, x1 float, y float, xp varchar(10), yp varchar(10))

	insert into #Corr 
	Select  d1.PDate as d1,
		eq1.Symbol as s1, eq2.Symbol as s2,
		eq1.PCP as x, eq3.PCP as x1, eq2.PCP as y
		, null, null
		--,	d1.xp, d2.yp 
	From tbl_CorrelationSequence d1
	inner join tbl_CorrelationSequence d2
	on d1.CSType = d2.CSType 
		and d1.Sequence = d2.Sequence + 1
	inner join tbl_CorrelationSequence d3
	on d1.CSType = d3.CSType 
		and d1.Sequence = d3.Sequence - 1
	inner join tbl_HistoryEQ eq1
	on d1.PDate = convert(varchar(10),eq1.Date,102) 
	inner join tbl_HistoryEQ eq3
	on d3.PDate = convert(varchar(10),eq3.Date,102)
	and eq1.Symbol = eq3.Symbol  
	inner join tbl_HistoryEQ eq2
	on d2.PDate = convert(varchar(10),eq2.Date,102) 
	Where d1.CSType = 1
	 and year(d1.PDate)= 2019
		and month(d1.PDate) = 2
	
		Select  s1, s2, 
		sum(case when (x > 0 and y > 0)
					or (x < 0 and y < 0)
			then 1.0 else 0 end) / COUNT(1.0) AS r, 
		sum(case when (x > 0 and y > 0)
			then 1.0 else 0 end) / sum(case when (x > 0)
				then 1.0 else 0 end) AS rp, 
		sum(case when (x < 0 and y < 0)
			then 1.0 else 0 end) / sum(case when (x < 0)
				then 1.0 else 0 end) AS rn, 
		sum(case when (x > 0)
			then 1.0 else 0 end) / COUNT(1.0) AS rp1, 
		sum(case when (y > 0)
			then 1.0 else 0 end) / COUNT(1.0) AS rp2,
		sum(case when (x < 0)
			then 1.0 else 0 end) / COUNT(1.0) AS rn1, 
		sum(case when (y < 0)
			then 1.0 else 0 end) / COUNT(1.0) AS rn2, 
		COUNT(1) as cnt
	FROM #Corr d
	where s1 <> s2
	and ((d.x > 0 and d.x1 < 0) or (d.x < 0 and d.x1 > 0))
	GROUP BY s1, s2
	order by r desc

	Select  s1, s2, x1,	x,y, d.d1
	FROM #Corr d
	where s1 <> s2
	and ((d.x > 0 and d.x1 < 0) or (d.x < 0 and d.x1 > 0))
	and s1 = 'NIFTY' and s2 = 'BAJAJFINSV'
	
/*	Select  s1, s2, 
		case when StDevP(x) = 0 OR StDevP(y) = 0
			then 
				case 
					when Avg(x) > 0 and Avg(y) > 0 then 0.01
					when Avg(x) < 0 and Avg(y) < 0 then 0.01
					else -0.01
				end
			else (Avg(x * y) - (Avg(x) * Avg(y))) / (StDevP(x) * StDevP(y)) 
		end AS r, 
		COUNT(1) as cnt,
		--d.xp, --d.yp,
		Avg(x * y) as Avgxy, Avg(x) as Avgx, Avg(y) as Avgy, StDevP(x) as stdx, StDevP(y) as stdy
	FROM #Corr d
	where s1 is not null
	and s2 is not null
	and s1 <> s2
	GROUP BY s1, s2--, d.xp--, d.yp
	having COUNT(1) > 1
	order by r desc

go
exec [rpt_Correlation]
go
*/
end

GO

