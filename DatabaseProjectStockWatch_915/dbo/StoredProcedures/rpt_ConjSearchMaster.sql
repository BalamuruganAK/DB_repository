CREATE proc [dbo].[rpt_ConjSearchMaster]
(
@MX1 VARCHAR(6) ,
@MX2 VARCHAR(6) 
)
as
begin

-- exec rpt_ConjSearchMaster 'Moo','Ket'
	Declare @X1 int 
	Declare @X2 int 
	
	Select @X1 = pd.Planet
	From tbl_PlanetDesc pd
	where pd.PlanetShortDesc = @MX1

	Select @X2 = pd.Planet
	From tbl_PlanetDesc pd
	where pd.PlanetShortDesc = @MX2
		
	create table #date(mPDate smalldatetime)
		  
		  Insert into #date
		  Select distinct x1.PDate from 
			tbl_Planet x1
			inner join tbl_Planet x2
			on x1.PDate = x2.PDate
			and (case when @MX1 <> '' then @x1 else x1.Planet end) = x1.Planet
			and (case when @MX2 <> '' then @x2 else x2.Planet end) = x2.Planet
		  Where X2.Degree - X1.Degree between 0 and 48000 
		  and X1.Star = X2.Star 
		  and x1.Planet <> x2.Planet
		  and x1.Planet < 10 and x2.Planet < 10
		  
 		Select a.Symbol, a.Planets,
			COUNT(1) cnt,
			sum(case when a.PCP > 0 then 1 else 0 end) Up,
			sum(case when a.PCP <= 0 then 1 else 0 end) Down,
			convert(numeric(18,2),avg(a.OCP)) OCP, convert(numeric(18,2),avg(a.PHP)) PHP, 
			convert(numeric(18,2),avg( a.PLP)) PLP, convert(numeric(18,2),avg( a.PCP)) PCP, 
			convert(numeric(18,2),avg( a.POP )) POP
		from
		 (select 
			h.Symbol, st.Planets , h.OCP, h.PHP, h.PLP, h.PCP, h.POP
			
			from #date d
		  	  inner join tbl_HistoryEQ h
			  on Dateadd(mi,15,Dateadd(hh,9,h.date)) = d.mPDate
			  inner join tbl_Stock st
			  on st.Stock = h.Symbol 
			) a
		 where OCP < 35 and PCP > -35
--		 and a.Symbol like 'INFY%'
		 group by a.Symbol, a.Planets
		 order by (AVG(PHP) / AVG(PLP) * -1) desc
		 --9 desc
  
end

GO

