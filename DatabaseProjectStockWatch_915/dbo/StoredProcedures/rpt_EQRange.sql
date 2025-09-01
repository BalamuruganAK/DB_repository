CREATE proc rpt_EQRange
AS
Begin

	Select e.Symbol,
		sum(case when e.OHP < 0.1 then 1.0 end) / sum(1.0) as p0,
		sum(case when e.OHP between 0.1 and 0.2 then 1.0 end) / sum(1.0) as pa,
		sum(case when e.OHP between 0.2 and 0.4 then 1.0 end) / sum(1.0) as p1,
		sum(case when e.OHP between 0.4 and 0.6 then 1.0 end) / sum(1.0) as p2,
		sum(case when e.OHP between 0.6 and 0.8 then 1.0 end) / sum(1.0) as p3,
		sum(case when e.OHP between 0.8 and 1.0 then 1.0 end) / sum(1.0) as p4,
		sum(case when e.OHP between 0.0 and 1.0 then 1.0 end) / sum(1.0) as p4s,
		sum(case when e.OHP between 1.0 and 2.0 then 1.0 end) / sum(1.0) as p5,
		sum(case when e.OHP between 2.0 and 3.0 then 1.0 end) / sum(1.0) as p6,
		sum(case when e.OHP between 3.0 and 4.0 then 1.0 end) / sum(1.0) as p7,
		sum(case when e.OHP between 4.0 and 30.0 then 1.0 end) / sum(1.0) as p8
		/*
		case 
			when e.OHP < 0.2 then 1
			when e.OHP < 0.4 then 2
			when e.OHP < 0.6 then 3
			when e.OHP < 0.8 then 4
			when e.OHP < 1.0 then 5
			when e.OHP > 1.0 then 6
		end as EQrange*/
	from tbl_HistoryEQ as e
	group by e.Symbol 

end

GO

