CREATE proc [dbo].[rpt_RetroMini]
( @RPlanet Varchar(100),
 @Symbol varchar(50) )
as
begin
	-- exec [rpt_RetroMini] 'Jup,  Mer', 'NIFTY'
	-- exec [rpt_RetroDetail] 'Jup,  Mer'
	select 
			 h.Symbol, convert(varchar(12),h.Date,102) as 'Date',
			 case when h.PCP > 0 then 1 else 0 end Up,
			case when h.PCP <= 0 then 1 else 0 end Down, 
			 h.OCP, h.PHP, h.PLP, h.PCP, h.POP			
			from tbl_DayPosition d
			  inner join tbl_HistoryEQ h
			  on Dateadd(mi,15,Dateadd(hh,9,h.date)) = d.PDate
				and d.RPlanet = @RPlanet
			  inner join tbl_Stock st
			  on st.Stock = h.Symbol 
			  and h.Symbol = @Symbol			 
		 where OCP < 35 and PCP > -35
		 
		-- order by (avg(PHP) / case when avg(PLP) > 0 then avg(PLP) else 0.005 end * -1) desc
	 
end

GO

