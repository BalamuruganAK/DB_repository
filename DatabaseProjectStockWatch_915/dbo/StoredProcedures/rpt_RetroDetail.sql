create proc [dbo].[rpt_RetroDetail]
( @RPlanet Varchar(100))
as
begin
	
		Select a.RPlanet, a.Planets, a.Symbol,
			COUNT(1) cnt,
			sum(case when a.PCP > 0 then 1 else 0 end) Up,
			sum(case when a.PCP <= 0 then 1 else 0 end) Down,
			convert(numeric(18,2),avg(a.OCP)) OCP, convert(numeric(18,2),avg(a.PHP)) PHP, 
			convert(numeric(18,2),avg( a.PLP)) PLP, convert(numeric(18,2),avg( a.PCP)) PCP, 
			convert(numeric(18,2),avg( a.POP )) POP
		from
		 (select 
			d.RPlanet, h.Symbol, st.Planets, h.OCP, h.PHP, h.PLP, h.PCP, h.POP			
			from tbl_DayPosition d
			  inner join tbl_HistoryEQ h
			  on Dateadd(mi,15,Dateadd(hh,9,h.date)) = d.PDate
				and d.RPlanet = @RPlanet
			  inner join tbl_Stock st
			  on st.Stock = h.Symbol) a 			 
		 where OCP < 35 and PCP > -35
		 group by a.RPlanet, a.Planets, a.Symbol
		 order by a.RPlanet, Planets, Symbol

		 --order by (avg(PHP) / case when avg(PLP) > 0 then avg(PLP) else 0.005 end * -1) desc
	 
end

GO

