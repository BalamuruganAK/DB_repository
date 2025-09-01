CREATE proc [dbo].[rpt_ElementMaster]
(
@Symbol VARCHAR(50) ,
@Element VARCHAR(5) ,
@ElementV VARCHAR(4)
)
as
begin
	create table #date(mPDate smalldatetime, Element varchar(4))

	if len(@ElementV) = 0 
	begin
	  if @Element = 'kSumD' 
	  begin
		  Insert into #date Select e.PDate, e.SSumD from tbl_Element e		  
	  end
	  if @Element = 'SSumD' 
	  begin
		  Insert into #date Select e.PDate, e.SSumD from tbl_Element e		  
	  end
	  if @Element = 'CSumD' 
	  begin
		  Insert into #date Select e.PDate, e.CSumD from tbl_Element e		  
	  end
	  if @Element = 'KSum' 
	  begin
		  Insert into #date Select e.PDate, e.KSum from tbl_Element e		  
	  end
	  if @Element = 'SSum' 
	  begin
		  Insert into #date Select e.PDate, e.SSum from tbl_Element e		  
	  end
	  if @Element = 'CSum' 
	  begin
		  Insert into #date Select e.PDate, e.CSum from tbl_Element e		  
	  end
	  if @Element = 'SumOr' 
	  begin
		  Insert into #date Select e.PDate, e.SumOr from tbl_Element e		  
	  end
	  if @Element = 'CSOr' 
	  begin
		  Insert into #date Select e.PDate, e.CSOr from tbl_Element e		  
	  end
/*	  if @Element = 'CKOr' 
	  begin
		  Insert into #date Select e.PDate, e.CKOr from tbl_Element e		  
	  end
*/
	  if @Element = 'CKOr' 
	  begin
		  Insert into #date Select e.PDate, substring(e.CSKOr,2,1) from tbl_Element e		  
	  end
	  if @Element = 'CSKOr' 
	  begin
		  Insert into #date Select e.PDate, e.CSKOr from tbl_Element e		  
	  end
	end
	else
	begin
		  if @Element = 'KSumD' 
	  begin
		  Insert into #date Select e.PDate, e.KSumD from tbl_Element e where e.SSumD = @ElementV		  
	  end
	  if @Element = 'SSumD' 
	  begin
		  Insert into #date Select e.PDate, e.SSumD from tbl_Element e where e.SSumD = @ElementV	  
	  end
	  if @Element = 'CSumD' 
	  begin
		  Insert into #date Select e.PDate, e.CSumD from tbl_Element e where e.CSumD = @ElementV		  
	  end
	  if @Element = 'KSum' 
	  begin
		  Insert into #date Select e.PDate, e.KSum from tbl_Element e where e.KSum = @ElementV		  
	  end
	  if @Element = 'SSum' 
	  begin
		  Insert into #date Select e.PDate, e.SSum from tbl_Element e where e.SSum = @ElementV		  
	  end
	  if @Element = 'CSum' 
	  begin
		  Insert into #date Select e.PDate, e.CSum from tbl_Element e where e.CSum = @ElementV		  
	  end
	  if @Element = 'SumOr' 
	  begin
		  Insert into #date Select e.PDate, e.SumOr from tbl_Element e where e.SumOr = @ElementV		  
	  end
	  if @Element = 'CSOr' 
	  begin
		  Insert into #date Select e.PDate, e.CSOr from tbl_Element e where e.CSOr = @ElementV		  
	  end
	  if @Element = 'CKOr' 
	  begin
		  Insert into #date Select e.PDate, e.CKOr from tbl_Element e where e.CKOr = @ElementV		  
	  end
	  if @Element = 'CSKOr' 
	  begin
		  Insert into #date Select e.PDate, e.CSKOr from tbl_Element e where e.CSKOr = @ElementV	  
	  end

	end 
	  if @Symbol = 'PLANETS'
	  begin
		Select a.Element, a.Planets, '' Symbol, 
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
		 group by a.Element, a.Planets
		 -- order by a.Element, a.Planets
		 order by (avg(PHP) / case when avg(PLP) > 0 then avg(PLP) else 0.005 end * -1) desc
	   end
	  
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
		Select a.Element, a.Planets, '' Symbol,
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
		 group by a.Element, a.Planets
		 -- order by a.Element, a.Planets
		 order by (avg(PHP) / case when avg(PLP) > 0 then avg(PLP) else 0.005 end * -1) desc
	   end

	  if @Symbol = 'ALLPS'
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
		 -- order by a.Element, a.Planets, a.Symbol
		 order by (avg(PHP) / case when avg(PLP) > 0 then avg(PLP) else 0.005 end * -1) desc
	   end
	   
	  if @Symbol = 'ALLS'
	  begin
		Select a.Element, '' Planets, a.Symbol,
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
		 group by a.Element, a.Symbol
		 -- order by a.Element, a.Symbol
		 order by (avg(PHP) / case when avg(PLP) > 0 then avg(PLP) else 0.005 end * -1) desc
	   end

	  if @Symbol not in ( 'PLANETS', 'ALL', 'ALLS', 'ALLP', 'ALLPS')
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
		 -- order by a.Element, a.Planets, a.Symbol
		 order by (avg(PHP) / case when avg(PLP) > 0 then avg(PLP) else 0.005 end * -1) desc
	   end
	     
end

GO

