create proc [dbo].[rpt_ElementNextWeek]
(
@Element VARCHAR(5)  
)
as
begin
	declare @ElementList varchar(200)
	create table #date(mPDate smalldatetime, Element varchar(4))

	  if @Element = 'KSumD' 
	  begin
		  Insert into #date Select e.PDate, e.KSumD from tbl_Element e 		  
	  end
	  if @Element = 'SSumD' 
	  begin
		  Insert into #date Select e.PDate, e.SSumD from tbl_Element e 	  
	  end
	  if @Element = 'CSumD' 
	  begin
		  Insert into #date Select e.PDate, e.CSumD from tbl_Element e 		  
	  end
	  if @Element = 'KSum' 
	  begin
		  Insert into #date Select e.PDate, e.KSum from tbl_Element e 		  
	  end
	  if @Element = 'SSum' 
	  begin
		  Insert into #date Select e.PDate, e.SSum from tbl_Element e 	  
	  end
	  if @Element = 'CSum' 
	  begin
		  Insert into #date Select e.PDate, e.CSum from tbl_Element e 		  
	  end
	  if @Element = 'SumOr' 
	  begin
		  Insert into #date Select e.PDate, e.SumOr from tbl_Element e 		  
	  end
	  if @Element = 'CSOr' 
	  begin
		  Insert into #date Select e.PDate, e.CSOr from tbl_Element e 		  
	  end
	  if @Element = 'CKOr' 
	  begin
		  Insert into #date Select e.PDate, e.CKOr from tbl_Element e 		  
	  end
	  if @Element = 'CSKOr' 
	  begin
		  Insert into #date Select e.PDate, e.CSKOr from tbl_Element e 		  
	  end

		select @ElementList = COALESCE(@ElementList + ', ', '') + CONVERT(varchar(10),d.mPDate, 112) + ':' + d.Element	
		from #date d
		where d.mPDate between GETDATE() and GETDATE() + 6
		order by d.mPDate
		
		select isnull(@ElementList, '')
	     
end

GO

