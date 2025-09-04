CREATE proc rpt_Daywise_Locker
(@fromDate varchar(10), @toDate varchar(10))
as
begin
/*
exec rpt_Daywise_Locker '20150317','20150323'
*/
	Select *
	from tbl_Cash c
	where c.CashID in 
		(select MAX(cc.CashID) 
		from tbl_Cash cc
		where convert(varchar(12),cc.CashDateTime,112) between @fromDate and @toDate 
		group by convert(varchar(12),cc.CashDateTime,112))
		
		Select SUM(c.Sales) Sales, SUM(c.Expense) Expense, SUM(c.net) net, 
			--SUM(c.SwipeCard) SwipeCard, 
			SUM(c.Locker ) Locker
			--,SUM(c.Adjustment) Adjustment
	from tbl_Cash c
	where c.CashID in 
		(select MAX(cc.CashID) 
		from tbl_Cash cc
		where convert(varchar(12),cc.CashDateTime,112) between @fromDate and @toDate 
		group by convert(varchar(12),cc.CashDateTime,112))
end

GO

