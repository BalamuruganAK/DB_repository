CREATE proc [dbo].[Load_CorrelationSequence]
as
begin
	Declare @RDate smalldatetime
	Declare @PDate smalldatetime
	Declare @MaxDate smalldatetime
	Declare @RPlanet tinyint
	Declare @CPlanet tinyint
	Declare @Sequence int
	
	create table #Date ( s int IDENTITY(1,1), d1 date)

	Insert into #Date (d1)	
	Select 
		distinct(st.Date) as d1
	from tbl_HistoryEQ st
	order by 1
	
	Insert into tbl_CorrelationSequence
		(PDate, CSType, Sequence)
	Select d1, 1, s from #Date d
	where d.d1 Not in 
		(Select PDate 
		from tbl_CorrelationSequence c
		Where c.CSType = 1)
	
	Insert into tbl_CorrelationSequence
		(PDate, CSType, Sequence)
	Select d1, 13, -1 from #Date d
	where d.d1 Not in 
		(Select PDate 
		from tbl_CorrelationSequence c
		Where c.CSType = 13)
		
	Select @RDate = MIN(c.PDate), @MaxDate = MAX(c.PDate)
	from tbl_CorrelationSequence c
	Where c.CSType = 13
	
	Select @Sequence = 1
	
	Select @RPlanet = p.Star
	From tbl_Planet p
	Where convert(varchar(10),p.PDate,102) = @RDate
	and p.Planet = 3
	
	while @RDate <= @MaxDate 
	begin
		Select @CPlanet = p.Star
		From tbl_Planet p
		Where convert(varchar(10),p.PDate,102) = @RDate
		and p.Planet = 3
		
		if @RPlanet <> @CPlanet 
		begin
			Select @RPlanet = @CPlanet, @Sequence = @Sequence + 1
		end
		
		Update c
		Set c.Sequence = @Sequence,
			c.XPlanet = @RPlanet
		From tbl_CorrelationSequence c
		Where c.PDate = @RDate
		and c.CSType = 13
		
		Select @PDate = @RDate
		
		Select @RDate = MIN(c.PDate)
		From tbl_CorrelationSequence c
		Where c.PDate > @PDate
		and c.CSType = 13
		
		if @PDate = @RDate 
		begin
			break
		end
	end
	end

GO

