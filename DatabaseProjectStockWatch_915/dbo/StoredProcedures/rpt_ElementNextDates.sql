CREATE proc [dbo].[rpt_ElementNextDates]
(
@Element VARCHAR(5) ,
@ElementV VARCHAR(4) 
)
as
begin
	declare @DateList varchar(200)
	create table #date(mPDate smalldatetime, Element varchar(4))

	  if @Element = 'KSumD' 
	  begin
		  Insert into #date Select e.PDate, e.KSumD from tbl_Element e where e.SSumD = @ElementV		  
	  end
	  if @Element = 'SSumD' 
	  begin
		  Insert into #date Select e.PDate, e.SSumD from tbl_Element e where e.SSumD = @ElementV	  
	  end
	  if @Element = 'CSumD' 
	  begin
		  Insert into #date Select e.PDate, e.CSumD from tbl_Element e where e.CSumD = @ElementV		  
	  end
	  if @Element = 'KSum' 
	  begin
		  Insert into #date Select e.PDate, e.KSum from tbl_Element e where e.KSum = @ElementV		  
	  end
	  if @Element = 'SSum' 
	  begin
		  Insert into #date Select e.PDate, e.SSum from tbl_Element e where e.SSum = @ElementV		  
	  end
	  if @Element = 'CSum' 
	  begin
		  Insert into #date Select e.PDate, e.CSum from tbl_Element e where e.CSum = @ElementV		  
	  end
	  if @Element = 'SumOr' 
	  begin
		  Insert into #date Select e.PDate, e.SumOr from tbl_Element e where e.SumOr = @ElementV		  
	  end
	  if @Element = 'CSOr' 
	  begin
		  Insert into #date Select e.PDate, e.CSOr from tbl_Element e where e.CSOr = @ElementV		  
	  end
	  if @Element = 'CKOr' 
	  begin
		  Insert into #date Select e.PDate, e.CKOr from tbl_Element e where e.CKOr = @ElementV		  
	  end
	  if @Element = 'CSKOr' 
	  begin
		  Insert into #date Select e.PDate, e.CSKOr from tbl_Element e where e.CSKOr = @ElementV		  
	  end

		select top 5 @DateList = COALESCE(@DateList + ', ', '') + CONVERT(varchar(10),d.mPDate, 112) 		
		from #date d
		where d.mPDate >= GETDATE()
		order by d.mPDate
		
		select isnull(@DateList, '')
	     
end

GO

