CREATE proc [dbo].[load_HistoryDayEQ]
as
begin
	
	--after Exec [load_HistoryEQDayTemp]
	
	 Update tbl_HistoryEQDayTemp
	 set Symbol = 'NIFTY'
	 Where Symbol = 'NIFTY 50'
	 
	  Insert into tbl_HistoryEQ
	  SELECT 
			t.[Symbol]
		  ,	case when t.[Symbol]= 'NIFTY'
				then 'IX'
				Else 'EQ'
				End
				as Series
		  ,t.[Date]
		  ,t.[Open]
		  ,t.[High]
		  ,t.[Low]
		  ,t.[Last Traded Price] as [Close]
		  ,0 [Prev]
		  ,0 [Last]
		  ,0 [Average]
		  ,t.[Traded Volume(lacs)] as 'Quantity'
		  ,t.[Traded Value(crs)] as 'Turnover'
		  ,0 [Trades]
		  ,0 as 'POP'
		  ,0 as 'PCP'
		  ,0 as 'OCP'
		  ,0 as 'OHP'
		  ,0 as 'OLP'
		  ,0 as 'PHP'
		  ,0 as 'PLP'
	  FROM tbl_HistoryEQDayTemp t
	  where not exists (Select 1 from tbl_HistoryEQ e 
		where e.Symbol = t.Symbol 
			and e.Date = t.Date)
			
	  Update t
	  set t.Prev = e.[Close]
	  from tbl_HistoryEQ t
	  inner join tbl_HistoryEQ e
	  on e.Symbol = t.Symbol and e.Series = t.Series
			and e.Date = (Select MAX(i.Date) from tbl_HistoryEQ i 
							where e.Symbol = i.Symbol and e.Series = i.Series
							and i.Date < t.Date)
	  where t.Date in (Select dt.Date from tbl_HistoryEQDayTemp dt)
	  
		Update t set t.Prev = t.[Open]
		from tbl_HistoryEQ t 
		where t.Prev = 0 
		and t.Date in (Select dt.Date from tbl_HistoryEQDayTemp dt)

		Update e
	  set e.POP = 100 * (e.[Open] - e.Prev) / e.Prev,
			e.PCP = 100 * (e.[Close] - e.Prev) / e.Prev,
			e.OCP = 100 * (e.[Close] - e.[Open]) / e.[Open],
			e.OHP = 100 * (e.High - e.[Open]) / e.[Open],
			e.OLP = 100 * (e.Low - e.[Open]) / e.[Open],
			e.PHP = 100 * (e.High - e.Prev) / e.Prev,
			e.PLP = 100 * (e.Low - e.Prev) / e.Prev
	  from tbl_HistoryEQ e
	  where e.Date in (Select dt.Date from tbl_HistoryEQDayTemp dt)
	 -- Delete from tbl_HistoryEQ where Series not in ( 'EQ','Ix')
end

GO

