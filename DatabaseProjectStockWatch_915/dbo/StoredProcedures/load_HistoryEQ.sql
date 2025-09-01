CREATE proc [dbo].[load_HistoryEQ]
as
begin
	--truncate table tbl_HistoryEQ
	
	Insert into tbl_HistoryEQ
	SELECT 
			t.[Symbol]
		  ,t.[Series]
		  ,t.[Date]
		  ,t.[Open Price] as 'Open'
		  ,t.[High Price] as 'High'
		  ,t.[Low Price] as 'Low'
		  ,t.[Close Price] as 'Close'
		  ,t.[Prev Close] as 'Prev'
		  ,t.[Last Price] as 'Last'
		  ,t.[Average Price] as 'Average'
		  ,t.[Total Traded Quantity] as 'Quantity'
		  ,t.[Turnover] as 'Turnover'
		  ,t.[No. of Trades] as 'Trades'
		  ,0 as 'POP'
		  ,0 as 'PCP'
		  ,0 as 'OCP'
		  ,0 as 'OHP'
		  ,0 as 'OLP'
		  ,0 as 'PHP'
		  ,0 as 'PLP'
	  FROM tbl_HistoryEQTemp t
	  where not exists (Select 1 from tbl_HistoryEQ e 
		where e.Symbol = t.Symbol and e.Series = t.Series
			and e.Date = t.Date)
	  
	  Insert into tbl_HistoryEQ
	  SELECT 
			t.[Symbol]
		  ,t.[Series]
		  ,t.[Date]
		  ,t.[Open]
		  ,t.[High]
		  ,t.[Low]
		  ,t.[Close]
		  ,0 [Prev]
		  ,0 [Last]
		  ,0 [Average]
		  ,t.[Shares Traded] as 'Quantity'
		  ,t.[Turnover (Rs. Cr)] as 'Turnover'
		  ,0 [Trades]
		  ,0 as 'POP'
		  ,0 as 'PCP'
		  ,0 as 'OCP'
		  ,0 as 'OHP'
		  ,0 as 'OLP'
		  ,0 as 'PHP'
		  ,0 as 'PLP'
	  FROM tbl_HistoryIXTemp t
	  where not exists (Select 1 from tbl_HistoryEQ e 
		where e.Symbol = t.Symbol and e.Series = t.Series
			and e.Date = t.Date)
			
	  Update t
	  set t.Prev = e.[Close]
	  from tbl_HistoryEQ t
	  inner join tbl_HistoryEQ e
	  on e.Symbol = t.Symbol and e.Series = t.Series
			and e.Date = (Select MAX(i.Date) from tbl_HistoryEQ i 
							where e.Symbol = i.Symbol and e.Series = i.Series
							and i.Date < t.Date)
	  where t.Symbol in ('NIFTY','NIFTYBANK')
	  
		  Update t set t.Prev = t.[Open]
		from tbl_HistoryEQ t 
		where t.Prev = 0 
		and t.Symbol in ('NIFTY','NIFTYBANK')

		Update e
	  set e.POP = 100 * (e.[Open] - e.Prev) / e.Prev,
			e.PCP = 100 * (e.[Close] - e.Prev) / e.Prev,
			e.OCP = 100 * (e.[Close] - e.[Open]) / e.[Open],
			e.OHP = 100 * (e.High - e.[Open]) / e.[Open],
			e.OLP = 100 * (e.Low - e.[Open]) / e.[Open],
			e.PHP = 100 * (e.High - e.Prev) / e.Prev,
			e.PLP = 100 * (e.Low - e.Prev) / e.Prev
	  from tbl_HistoryEQ e
	   
	 -- Delete from tbl_HistoryEQ where Series not in ( 'EQ','Ix')
end

GO

