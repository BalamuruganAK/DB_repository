
CREATE PROCEDURE rpt_PivotPoint
AS
BEGIN
	
	SET NOCOUNT ON;

	Select 
	(2 * b.pp) - b.l as '1h', b.pp + (2 * (b.pp - b.l)) as '2h', b.h + (2 * (b.pp - b.l)) as '3h',
	b.pp - b.l as '1h~', (2 * (b.pp - b.l)) as '2h~', b.h + (2 * (b.pp - b.l)) - b.pp as '3h~',
	case when a.o >= ((2 * b.pp) - b.l)  then 'True'		end AS 'open1h',
	case when b.c <=  b.o  then 'True'		end AS 'oc',
	case when a.h >= (b.pp + (2 * (b.pp - b.l))) then 'True' end AS '2hTrue',
	 a.o - ((2 * b.pp) - b.l) 'o>1h',
	 a.h - (b.pp + (2 * (b.pp - b.l))) as 'h>2h',
	 a.o - b.c 'gap',  a.c - b.c 'gain',  b.r,b.PP, a.PP - b.PP,
	a.*
	from
	(Select row_number() over (order by d.d) as r,(d.h + d.l + d.c) / 3 PP, d.*
	From tbl_DailyOHLC d) as a 
	inner join
	(Select row_number() over (order by d.d) as r,(d.h + d.l + d.c) / 3 PP, d.*
	From tbl_DailyOHLC d) as b
	on a.r = b.r +1
	
	
	
END

GO

