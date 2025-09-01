CREATE proc [dbo].[rpt_ZPlanetMaster]
(
@Symbol VARCHAR(50) ,
@Element VARCHAR(5) ,
@ElementV VARCHAR(5)
)
as
begin
	-- exec [rpt_ZPlanetMaster] 'ACC','Ket','0'
	create table #date(mPDate smalldatetime, Element varchar(5))

	Declare @YElement VARCHAR(5) 
	Declare @YElementV VARCHAR(5)
	Select @YElementV = substring(@ElementV,4,2)
	Select @YElement = LEFT(@ElementV,3)
	Select @ElementV = substring(@Element,4,2)
	Select @Element = LEFT(@Element,3)
	
	Insert into #date Select e.PDate, convert(varchar(3),d.PlanetShortDesc) + 
		convert(varchar(2),e.ZPosition) 
	from tbl_ZPlanet e
	inner join tbl_PlanetDesc d
	on d.Planet = e.ZPlanet
	inner join tbl_PlanetDesc dy
	on dy.Planet = e.YPlanet
		where d.PlanetShortDesc =
			case when @Element = 'ALL' then 
				d.PlanetShortDesc
				else  
				@Element end
		and e.ZPosition =
			case when @ElementV = 0 then 
				e.ZPosition 
				else  
				@ElementV end
		and dY.PlanetShortDesc =
			case when @YElement = 'ALL' then 
				dY.PlanetShortDesc
				else  
				@YElement end
		and e.YPosition =
			case when @YElementV = 0 then 
				e.YPosition 
				else  
				@YElementV end
		

	  if @Symbol = 'ALL'
	  begin
		Select a.Element, '' Planets, '' Symbol,
			COUNT(1) cnt,
			sum(case when a.PCP > 0 then 1 else 0 end) Up,
			sum(case when a.PCP <= 0 then 1 else 0 end) Down,
			convert(numeric(18,2),avg(a.OCP)) OCP, convert(numeric(18,2),avg(a.PHP)) PHP, 
			convert(numeric(18,2),avg( a.PLP)) PLP, convert(numeric(18,2),avg( a.PCP)) PCP, 
			convert(numeric(18,2),avg( a.POP )) POP
		from
		 (select 
			h.Symbol, st.Planets, d.Element, h.OCP, h.PHP, h.PLP, h.PCP, h.POP			
			from #date d
			  inner join tbl_HistoryEQ h
			  on Dateadd(mi,15,Dateadd(hh,9,h.date)) = d.mPDate
			  inner join tbl_Stock st
			  on st.Stock = h.Symbol) a 			 
		 where OCP < 35 and PCP > -35
		 group by a.Element
		 -- order by a.Element
		 order by (avg(PHP) / case when avg(PLP) > 0 then avg(PLP) else 0.005 end * -1) desc
	   end


	  if @Symbol = 'ALLP'
	  begin
		Select a.Element, a.Planets, a.Symbol,
			COUNT(1) cnt,
			sum(case when a.PCP > 0 then 1 else 0 end) Up,
			sum(case when a.PCP <= 0 then 1 else 0 end) Down,
			convert(numeric(18,2),avg(a.OCP)) OCP, convert(numeric(18,2),avg(a.PHP)) PHP, 
			convert(numeric(18,2),avg( a.PLP)) PLP, convert(numeric(18,2),avg( a.PCP)) PCP, 
			convert(numeric(18,2),avg( a.POP )) POP
		from
		 (select 
			h.Symbol, st.Planets, d.Element, h.OCP, h.PHP, h.PLP, h.PCP, h.POP			
			from #date d
			  inner join tbl_HistoryEQ h
			  on Dateadd(mi,15,Dateadd(hh,9,h.date)) = d.mPDate
			  inner join tbl_Stock st
			  on st.Stock = h.Symbol) a 			 
		 where OCP < 35 and PCP > -35
		 group by a.Element, a.Planets, a.Symbol
		 -- order by a.Element
		 order by (avg(PHP) / case when avg(PLP) > 0 then avg(PLP) else 0.005 end * -1) desc
	   end

	  if @Symbol not in ( 'ALL','ALLP')
	  begin
		Select a.Element, a.Planets, a.Symbol,
			COUNT(1) cnt,
			sum(case when a.PCP > 0 then 1 else 0 end) Up,
			sum(case when a.PCP <= 0 then 1 else 0 end) Down,
			convert(numeric(18,2),avg(a.OCP)) OCP, convert(numeric(18,2),avg(a.PHP)) PHP, 
			convert(numeric(18,2),avg( a.PLP)) PLP, convert(numeric(18,2),avg( a.PCP)) PCP, 
			convert(numeric(18,2),avg( a.POP )) POP
		from
		 (select 
			h.Symbol, st.Planets, d.Element, h.OCP, h.PHP, h.PLP, h.PCP, h.POP			
			from #date d
			  inner join tbl_HistoryEQ h
			  on Dateadd(mi,15,Dateadd(hh,9,h.date)) = d.mPDate
			  inner join tbl_Stock st
			  on st.Stock = h.Symbol) a 			 
		 where OCP < 35 and PCP > -35
		 and a.Symbol like @Symbol 
		 group by a.Element, a.Planets, a.Symbol
		 order by (avg(PHP) / case when avg(PLP) > 0 then avg(PLP) else 0.005 end * -1) desc
	   end
	     
end

GO

