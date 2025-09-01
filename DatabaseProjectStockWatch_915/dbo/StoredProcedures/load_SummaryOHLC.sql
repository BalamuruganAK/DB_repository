CREATE proc [dbo].[load_SummaryOHLC]
as
begin
	
	create table #date(PDate smalldatetime)
	
	insert into #date 
	Select distinct d from tbl_DailyOHLC
		Where d not in (Select d from tbl_SummaryOHLC where n='Nifty50')
		and n='Nifty50'
		
	Insert into tbl_SummaryOHLC (d,o,h,l,c,s,n,sno) 
	Select d,o,h,l,c,s,n, ROW_NUMBER() over(order by d asc) as sno from tbl_DailyOHLC daily
	where daily.d in (Select PDate from #date)
	and n='Nifty50'

	Update s
	set s.pc = s1.c
	from tbl_SummaryOHLC s
	inner join tbl_SummaryOHLC s1
	on s.n = s1.n and s.Sno = s1.Sno +1
	
	Update s
	set s.gap  = s.o - s.pc, s.ccgain = s.c - s.pc,
	s.chgain = s.h - s.pc, s.clgain = s.l - s.pc,
	s.ohgain = s.h - s.o, s.olgain = s.l - s.o,
	s.ocgain = s.c - s.o
	from tbl_SummaryOHLC s
	
	Update s4
	set s4.avg  = 100 * (s4.s - s3.avg1) / s4.s
	from tbl_SummaryOHLC s4
	inner join 
	(Select s2.Sno, s2.n, AVG(s1.s) as avg1
	from tbl_SummaryOHLC s1
	inner join tbl_SummaryOHLC s2
	on s2.n = s1.n
	and s2.Sno between s1.Sno +1 and s1.Sno +10
	group by s2.Sno, s2.n) as s3
	on s4.n = s3.n and s4.Sno = s3.Sno 
		
	Select * from tbl_SummaryOHLC

end

GO

